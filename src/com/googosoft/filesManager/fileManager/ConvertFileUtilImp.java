package com.googosoft.filesManager.fileManager;


import java.awt.Color;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;
import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

public class ConvertFileUtilImp implements ConvertFileUtil {
	private static Logger logger = Logger.getLogger(ConvertFileUtilImp.class
			.getName());
	// 引用OfficeManager对象
	private OfficeManager officeManager;
	// OpenOffice的安装目录
	private static String  OFFICE_HOME = ResourceBundle.getBundle("path").getString("OFFICE_HOME");
	private static String  swftools = ResourceBundle.getBundle("path").getString("swftools");
	private static String  FONTPATH = ResourceBundle.getBundle("path").getString("fontpath");
	// 默认端口号
	private static int port[] = { 8084};
	@Override
	public String doc2PDF(String docFile) {
		// 得到文件名
		String pdfFile = getFilePrefix(docFile) + ".pdf";
		return doc2PDF(docFile, pdfFile);
	}

	@Override
	public String doc2PDF(String docFile, String pdfFile) {
		// 对于txt文件先转换成ODT文件
		if (docFile.endsWith(".txt") || docFile.endsWith(".TXT")) {
			pdfFile =getFilePrefix(docFile) + ".pdf";
			if (new File(pdfFile).exists()) {
				logger.warn(pdfFile + "is already exsits");
				docFile = pdfFile;
			} else {
				text2PDF(docFile, pdfFile);
			}
		}
		// 对于非office文件的其他文件,如ppt,doc,xls等直接转换
		// 1：开启服务
		startOpenOfficeService();
		// 2：进行转换
		logger.info("Transforming:" + docFile + "---------" + pdfFile);
		OfficeDocumentConverter convert = new OfficeDocumentConverter(officeManager);
		//设置目标文件的位置以及文件的名称
		convert.convert(new File(docFile),new File(pdfFile));
		// 3：结束OpenOffice服务
		stopOpenOfficeService();
		return new File(pdfFile).getAbsolutePath();

	}

	@Override
	public boolean pdf2SWF(String pdfFile,String extension) {
		String pdfLocate=getFilePrefix(pdfFile)+".pdf";
		//得到SWF文件
		String swfLocate=getFilePrefix(pdfFile)+".swf";
		return pdf2SWF(pdfLocate, swfLocate,extension);
	}

	@Override
	public boolean pdf2SWF(String pdfFile, String swfFile,String extension) {
		
		File pdf=new File(pdfFile);
		File swf=new File(swfFile);
		if(!(pdfFile.endsWith(".pdf"))){
			logger.warn(pdfFile+"con not be tranformed......");
			return false;
		}
		if(!(pdf.exists())){
			logger.warn("this file is not exsits.....");
			return false;
		}
		if(swf.exists()){
			logger.warn("this file is already exsits......");
			return false;
		}
		//调用SWFTools工具
		//组装转换命令，可以设置目标文件的位置以及名称
		String command=swftools+" "+pdfFile+" -o "+swfFile+" -s flashversion=9 ";
		String complexCommand=swftools+" "+pdfFile+" -o "+swfFile+" -s flashversion=9 -G -s poly2bitmap";
		
		try {
			System.out.println(extension);
			if(extension.toLowerCase().indexOf("ppt")!=-1&&extension.toLowerCase().indexOf("pptx")!=-1){
				System.out.println("======================1");
				logger.info(pdfFile+"ing......");
				Runtime.getRuntime().exec(command);
				logger.info(pdfFile+"transTo"+swfFile+"successful......");
				return true;
			}else{
				System.out.println("======================2");
				logger.info(pdfFile+"ing......");
				Runtime.getRuntime().exec(complexCommand);
				logger.info(pdfFile+"transTo"+swfFile+"successful......");
				return true;
			}
		} catch (IOException e) {
			logger.error(pdfFile+"transTo"+swfFile+"fail......");
			e.printStackTrace();
			return false;
		}
	}
	public  String getFilePrefix(String fileName){
		int splitIndex=fileName.lastIndexOf(".");
		return fileName.substring(0,splitIndex);
		
	}
	public  void copyFile(String inputFile,String outputFile){
		File input=new File(inputFile);
		File output=new File(outputFile);
		InputStream inputStream = null;
		OutputStream outputStream=null;
		try {
			inputStream = new FileInputStream(input);
			outputStream=new FileOutputStream(output);
			
			BufferedReader read = new BufferedReader(new InputStreamReader(inputStream));
			StringBuffer sb = new StringBuffer();
			String str;
			while ((str = read.readLine()) != null) {
				sb.append(str);
			}
			outputStream.write(sb.toString().getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
				if(outputStream!=null){
					try {
						outputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
			
			}
	}
	/**
	 * 功能：关闭OpenOffice服务
	 */
	private void stopOpenOfficeService() {
		if (officeManager != null) {
			officeManager.stop();
			logger.info("close OpenOffice services.....");
		}
	}

	/**
	 * 功能：启动OpenOffice服务
	 */
	private void startOpenOfficeService() {
		
		try {
			// 开始转换:
			// 1、openoffice开启服务
			DefaultOfficeManagerConfiguration configuration = new DefaultOfficeManagerConfiguration();
			logger.info("prepare  starting OpenOffice service......");
			configuration.setOfficeHome(OFFICE_HOME);
			configuration.setPortNumbers(port);
			// 设置任务执行超市为5分钟。
			configuration.setTaskExecutionTimeout(1000 * 60 * 5L);
			// 设置任务队列超时未24小时
			configuration.setTaskQueueTimeout(1000 * 60 * 60 * 24L);
			officeManager = configuration.buildOfficeManager();
			officeManager.start();
			logger.info("OpenOffice services started successful");
		} catch (Exception e) {
			logger.error("OpenOffice services started failed......");
		}

	}
	 public void text2PDF(String inputFile,String outputFile){
		  // 创建一个Document对象
		  Document document = new Document();
		  try {
		      // 生成名为 HelloWorld.pdf 的文档
		      PdfWriter.getInstance(document, new FileOutputStream(outputFile));
		     //BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "UniGB-UCS2-H", false);
		     BaseFont bfChinese = BaseFont.createFont(FONTPATH, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		      Font fontChinese = new Font(bfChinese, 12, Font.NORMAL, Color.black); 
		
		      //添加PDF文档的一些信息
		      //document.addTitle("Hello World example");
		      document.addAuthor("Googole YHF");
		      //document.addSubject("This example explains how to add metadata.");
		      //document.addKeywords("iText, Hello World, step 3, metadata");
		      //document.addCreator("My program using iText");
		      // 打开文档，将要写入内容
		      document.open();
		      StringBuffer strB = new StringBuffer();
		      BufferedReader in;
		      in = new BufferedReader(new InputStreamReader(new FileInputStream(inputFile),"GB18030"));
		      String str;
		      StringBuffer strB2 = strB;
		      while ((str = in.readLine()) != null) {
				strB2.append(str).append("\n");
		      }
		      in.close();
		      // 插入一个段落
		      document.add(new Paragraph(strB2.toString(),fontChinese));
		
		    } catch (DocumentException de) {
		    	logger.error(de.getMessage());
		    } catch (IOException ioe) {
		    	logger.error(ioe.getMessage());
		    }
		    // 关闭打开的文档
		    document.close();
	  }

}
