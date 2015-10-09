package com.googosoft.questionbank.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;

import com.googosoft.exception.DBException;
import com.googosoft.exception.DBFormatException;
import com.googosoft.exception.ManagerException;
import com.sun.star.util.Time;

public class HtmlToWord {

	public boolean getContent(HttpServletRequest request, String content,
			String title,String filepath,String filename) throws ManagerException, DBFormatException,
			DBException, IOException {
		boolean flag;
		String path = filepath;
		String file_h = filename;

		StringBuilder sb = new StringBuilder();
		sb.append("<html><head></head><title></title><body>");
		sb.append("<div style='text-align:center;'>");
		sb.append(title);
		sb.append("</div>");
		sb.append(content);
		sb.append("</body></html>");
		byte strby[] = sb.toString().getBytes();
		FileOutputStream fos = new FileOutputStream(path+file_h);
		fos.write(strby, 0, strby.length);
		fos.close();

		File file = new File(path+file_h);
		System.out.println(file.exists() + "******************"
				+ FilenameUtils.getBaseName(file.getName()));
		FileInputStream fis = new FileInputStream(file);
		String destPaht = path + FilenameUtils.getBaseName(file.getName())
				+ ".doc";
		System.out.println(destPaht + "***************");
		FileOutputStream outStream = new FileOutputStream(destPaht);
		int data;
		while ((data = fis.read()) != -1) {
			outStream.write(data);
		}
		flag=true;
		fis.close();
		file.deleteOnExit();
		outStream.close();
		return true;
	}
}
