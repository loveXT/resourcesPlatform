package com.googosoft.myFilesManager;

import java.io.IOException;
import java.io.Writer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googosoft.myFilesManager.chain.ChainManager;

/**
 * Servlet implementation class AjaxOperateServlet
 */
public class AjaxOperateServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException ,IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String id = request.getParameter("urlId");
		String target = request.getParameter("target");
		
		if("deleteChain".equals(target)){
			new ChainManager().deleteChain(id);
			Writer writer = response.getWriter();
			writer.write("success");
			writer.flush();
			writer.close();
		}
		/*if("deleteFolder".equals(target)){
			DBHelper db = new DBHelper();
			db.execute("delete from myfilefolder where folderid='"+id+"'");
			String folderId = request.getParameter("folderId");
			response.sendRedirect("listFile.jsp?folderId="+folderId);
		}
		*/
	};

}
