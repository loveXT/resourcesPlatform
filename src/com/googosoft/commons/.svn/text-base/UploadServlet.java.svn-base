package com.googosoft.commons;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googosoft.exception.FileException;
import com.googosoft.file.FileBean;
import com.googosoft.zapi.FileHelper;

/**
 * Servlet implementation class for Servlet: UploadServlet
 *
 */
 public class UploadServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public UploadServlet() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}  	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		FileHelper fileHelper = new FileHelper();
		String toPath = request.getParameter("TOPATH");
		FileBean fileBean = null;
		String uuid = CodeHelper.createUUID();
		try {
//			fileBean = fileHelper.upLoadFile(toPath,request,response);
			fileBean = fileHelper.upLoadFile(toPath, uuid,request,response);
			
		} catch (FileException e) {
			e.printStackTrace();
		}
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		System.out.println("----  "+uuid+fileBean.getOldName()+","+fileBean.getNewPath()+","+fileBean.getNewName());
		response.getWriter().print(uuid + fileBean.getOldName()+","+fileBean.getNewPath()+","+fileBean.getNewName());
	}   	  	    
}