package com.googosoft.filesManager.fileManager;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googosoft.common.util.GWebUtil;
import com.googosoft.common.util.StringPool;
import com.googosoft.common.util.UnsyncBufferedInputStream;
import com.googosoft.common.util.Validator;
import com.googosoft.commons.IUploadImgContants;
import com.googosoft.exception.ManagerException;

public class DownLoad extends HttpServlet{
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
				//获得文件所在路径
				String basePath = request.getRealPath("/");  
				String downFilePath =basePath + IUploadImgContants.IMGPATH;
				String fileName1 = request.getParameter("fileName");
				if(Validator.isNull(fileName1)){
					return ;
				}
				request.setCharacterEncoding("utf-8");
				response.setContentType("text/html;charset=utf-8");
				File f = new File(downFilePath+fileName1);
				FilesManager fileManger = new FilesManager();
				String fileName ="";
				try {
					Map<String, String> map =fileManger.findMapByFileName(fileName1);
					fileName=map.get("FALSENAME")+ map.get("EXTENDNAME");
				} catch (ManagerException e) {
					e.printStackTrace();
				}
				
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
	}
}
