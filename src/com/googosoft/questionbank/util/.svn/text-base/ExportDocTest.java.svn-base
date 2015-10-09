package com.googosoft.questionbank.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Range;

import com.googosoft.exception.ManagerException;

public class ExportDocTest {
	private Logger logger = Logger.getLogger(ExportDocTest.class.getName());

	public static void main(String[] args) {
		String destFile = "D:\\biyezheng_moban.doc";
		// ##################根据Word模板导出单个Word文档###################################################
		Map<String, String> map = new HashMap<String, String>();
		map.put("name", "Zues");
		map.put("sex", "男");
		map.put("idCard", "200010");
		map.put("year1", "2000");
		map.put("month1", "07");
		map.put("year2", "2008");
		map.put("month2", "07");
		map.put("gap", "2");
		map.put("zhuanye", "计算机科学与技术");
		map.put("type", "研究生");
		map.put("bianhao", "2011020301");
		map.put("nowy", "2011");
		map.put("nowm", "01");
		map.put("nowd", "20220301");
		// 注意biyezheng_moban.doc文档位置,此例中为应用根目录
		HWPFDocument document = new ExportDocTest().replaceDoc("biyezheng_moban.doc", map);
		ByteArrayOutputStream ostream = new ByteArrayOutputStream();
		try {
			document.write(ostream);
			// 输出word文件
			OutputStream outs = new FileOutputStream(destFile);
			outs.write(ostream.toByteArray());
			outs.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取试卷内容
	 * @param request
	 * @param content
	 * @throws ManagerException
	 */
	public void getContent(HttpServletRequest request, String content) throws ManagerException {
		
		String destFile = "D:\\shiti.doc";
		Map<String, String> maps = new HashMap<String, String>();
		//获取试卷内容
		maps.put("PAPER_CONTENT", content);
		System.out.println(">>>>获取试卷内容>>>>" + maps);
		//把试卷内容存到模板
		HWPFDocument document = new ExportDocTest().replaceDoc(request.getRealPath(File.separator) + "shiti_moban.doc", maps);
		System.out.println(">>>>内容存到试卷模板>>>>" + document);
		
		ByteArrayOutputStream ostream = new ByteArrayOutputStream();
		try {
			document.write(ostream);
			// 输出word文件
			OutputStream outs = new FileOutputStream(destFile);
			outs.write(ostream.toByteArray());
			outs.close();
		} catch (IOException e) {
			logger.error(e);
			throw new ManagerException(e);
		}
	}

	/**
	 * 读取word模板并替换变量
	 * 
	 * @param srcPath
	 * @param map
	 * @return
	 * 
	 *试卷的内容 <html><head></head><body>
	 *FileInputStream （a.html---》a.doc）
	 *</body></html>
	 */
	public HWPFDocument replaceDoc(String srcPath, Map<String, String> map) {
		try {
			
			// 读取word模板
			FileInputStream fis = new FileInputStream(new File(srcPath));
			System.out.println(">>>>fis(java.io.FileInputStream)>>>>" + fis);
			HWPFDocument doc = new HWPFDocument(fis);
			System.out.println(">>>>>读word模板(org.apache.poi.hwpf.HWPFDocument)>>>>>" + doc);
			// 读取word文本内容
			Range bodyRange = doc.getRange();
			System.out.println(">>>>>读word模板内容>>>>>" + bodyRange);
			// 替换文本内容
			for (Map.Entry<String, String> entry : map.entrySet()) {
				bodyRange.replaceText("${" + entry.getKey() + "}",
						entry.getValue());
			}
			return doc;
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
			return null;
		}
	}

	
}