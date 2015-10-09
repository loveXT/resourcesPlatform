package com.googosoft.newstudents;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;


public class ExportXlsOfPaper {
	private Logger logger = Logger.getLogger(ExportXlsOfPaper.class.getName());
	
	/**
	 * 在内存生成excel表格映像
	 * @param directory 临时文件路径
	 * @param list		   条件查询获得的数据集合用于生成excel表内数据
	 */
	public void exportExcel(HttpServletRequest request,String directory,List list) {
		FileOutputStream fOut;
		try {
			logger.info("生成EXCEL表格......");
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("招生批次表");
			sheet.setColumnWidth(0, 3000);
			sheet.setColumnWidth(1, 2000);
			sheet.setColumnWidth(2, 5000);
			sheet.setColumnWidth(3, 5000);//
			sheet.setColumnWidth(4, 5000);//
			sheet.setColumnWidth(5, 5000);//
			HSSFRow row = null;
			HSSFCell cell = null;
			PaperApplyXlsFormat format = new PaperApplyXlsFormat();
			format.newXLSForListPaper(request,sheet, row, cell, list,workbook);
			logger.info("写入到临时文件" + directory);
			fOut = new FileOutputStream(new File(directory));
			workbook.write(fOut);
			fOut.flush();
			fOut.close();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("导出excel失败!", e);
		} 
	}
	/**
	 * 导出excel表格
	 * @param response
	 * @param application
	 * @param str
	 */
	public void toExportExcel(HttpServletRequest request, HttpServletResponse response,ServletContext application,String idSet)
		{
		String file = application.getRealPath("\\")+"\\linshi.xls"; 
		response.setContentType("application/x-download");
		String filedisplay = "招生批次表.xls";
		try {
			filedisplay = URLEncoder.encode(filedisplay,"UTF-8");
		} catch (UnsupportedEncodingException e3) {
			e3.printStackTrace();
		}
		response.addHeader("Content-Disposition","attachment;filename=" + filedisplay);
		OutputStream outp = null;
		FileInputStream in = null;
		try
		{
			//导出文印统计excel
			List list = new NewStudentsManager().findListByExport(request);
			exportExcel(request,file, list);
		    outp = response.getOutputStream();
		    in = new FileInputStream(file);

		    byte[] b = new byte[1024];
		    int i = 0;

		    while((i = in.read(b)) > 0)
		    {
		        outp.write(b, 0, i);
		    }
		    outp.flush();
		}
		catch(Exception e)
		{
		    System.out.println("Error!");
		    e.printStackTrace();
		}
		finally
		{
		    if(in != null)
		    {
		        try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		        in = null;
		    }
		    if(outp != null)
		    {
		    	 try {
					outp.flush();
				} catch (IOException e2) {
					e2.printStackTrace();
				}
		    	 try {
					outp.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
		    	    outp=null;
		    	    try {
						response.flushBuffer();
					} catch (IOException e) {
						e.printStackTrace();
					}
		    }
		    File dir = new File(file);
		    if(dir.exists()){
		    	dir.delete();
		    }
		}
	}
}
