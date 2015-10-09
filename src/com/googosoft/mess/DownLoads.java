package com.googosoft.mess;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.googosoft.exception.FileException;
import com.googosoft.zapi.FileHelper;


public class DownLoads extends HttpServlet {
	private Logger logger = Logger.getLogger(DownLoads.class.getName());
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String filePath = request.getParameter("FILEPATH");
		System.out.println(filePath);
		FileHelper fileHelper = new FileHelper();
		try {
			fileHelper.downLoad(filePath, request, response);
		} catch (FileException e) {
			logger.error("下载失败"+e);
			e.printStackTrace();
		}
	}

}
