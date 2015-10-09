package com.googosoft.party.uploadServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googosoft.exception.FileException;
import com.googosoft.file.FileBean;
import com.googosoft.zapi.FileHelper;

/**
 * Servlet implementation class UploadServlet
 */
public class UploadServlet extends HttpServlet {
	static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FileHelper fileHelper = new FileHelper();
		String toPath = request.getParameter("TOPATH");
		FileBean fileBean = null;
		try {
			fileBean = fileHelper.upLoadFile(toPath,request,response);
		} catch (FileException e) {
			e.printStackTrace();
		}
		request.setCharacterEncoding("UTF-8"); 
		response.setCharacterEncoding("UTF-8");
		// System.out.println(fileBean.getName());
		response.getWriter().print(fileBean.getOldName()+","+fileBean.getNewPath()+","+fileBean.getNewName());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
