package com.googosoft.party.uploadServlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googosoft.commons.CodeHelper;
import com.googosoft.commons.Validate;
import com.googosoft.exception.FileException;
import com.googosoft.file.FileBean;
import com.googosoft.party.util.IUploadImgContants;
import com.googosoft.zapi.FileHelper;

/**
 * Servlet implementation class UploadImgServlet
 */
public class UploadImgServlet extends HttpServlet implements IUploadImgContants {
	private static final long serialVersionUID = 1L;
      
	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String trans =request.getParameter("TRANS");
		String uploadPath =trans.split("!")[1];
		System.out.println("=======" + uploadPath);
		String objectId = trans.split("!")[0];
		FileHelper fileHelper = new FileHelper();
		FileBean fileBean = null;
		try {
			List list = fileHelper.findDirectoryByfolder(uploadPath);
			if (Validate.noNull(list)) {
				String deletePath = null;
				for (int i = 0; i < list.size(); i++) {
					deletePath = list.get(i).toString();
					if (deletePath.startsWith(objectId)) {
						fileHelper.deleteFolder(uploadPath + deletePath);
						break;
					}
				}
			}
			fileBean = fileHelper.upLoadFile(uploadPath,
					objectId + CodeHelper.createTimeID(), request, response);
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().println(fileBean.getOldName()+","+fileBean.getNewPath()+","+fileBean.getNewName());
		} catch (FileException e) {
			e.printStackTrace();
		}
	}
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadImgServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
