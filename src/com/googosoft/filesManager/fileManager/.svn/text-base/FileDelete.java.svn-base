package com.googosoft.filesManager.fileManager;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileDelete
 */
public class FileDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FileDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String filename = request.getParameter("filename");
		String sp = File.separator;  
		String toPathreal = request.getRealPath(sp)+"ggs\\common\\ggs\\upload";
		System.out.println("toPathReal"+toPathreal+"^^^^^^^^^^^^"+"filename"+filename);//输出为图片实际物理路径
		File file = new File(toPathreal+"\\"+filename); 
		if(file.exists()){
			file.delete();  
		}
		System.out.println("AAAAAAAAA");
	}

}
