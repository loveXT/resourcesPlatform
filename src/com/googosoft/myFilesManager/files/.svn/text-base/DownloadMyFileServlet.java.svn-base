package com.googosoft.myFilesManager.files;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googosoft.common.util.GWebUtil;
import com.googosoft.common.util.UnsyncBufferedInputStream;
import com.googosoft.exception.ManagerException;

public class DownloadMyFileServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String fileId = request.getParameter("FILEID");
		FileFolderManager ffm = new FileFolderManager();
		Map fileMap;
		try {
			fileMap = ffm.findMapByFILEID(fileId);
			String fileName = fileMap.get("FILENAME")==null?"":fileMap.get("FILENAME").toString();
			String realName = fileMap.get("REALNAME")==null?"":fileMap.get("REALNAME").toString();
			String src = request.getParameter("src");
			File f = new File(src+realName);
			InputStream is=null;
			int contentLength  = 0;
			if(f.exists()){
				//得到一个输入流
				is = new UnsyncBufferedInputStream(new FileInputStream(f));
				contentLength= is.available();
				String contentType = GWebUtil.getContentType(fileName);
				//设置HTTP请求的头部
				GWebUtil.setHeaders(request, response, fileName, contentType);
				//将文件以流的形式写给页面
				GWebUtil.write(response, is, contentLength);
			}
		} catch (ManagerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

