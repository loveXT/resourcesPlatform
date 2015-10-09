package com.googosoft.questionbank.template;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googosoft.commons.Validate;
import com.googosoft.exception.FileException;
import com.googosoft.exception.ManagerException;
import com.googosoft.questionbank.questionbank.CourseManager;
import com.googosoft.questionbank.questionbank.MajorManager;
import com.googosoft.zapi.FileHelper;


public class DownTempleateServlet extends HttpServlet {
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
		String courseId = request.getParameter("courseId");
		String majorId = request.getParameter("majorId");
		try {
			Map majorMap = new MajorManager().findMapByMAJOR_ID(majorId);
			String majorName = Validate.isNullToDefault(majorMap.get("MAJOR_NAME"),"公共基础课").toString();
			Map courseMap = new CourseManager().findMapByCOURSE_ID(courseId);
			String courseName = Validate.isNullToDefault(courseMap.get("COURSE_NAME"),"").toString();
			String template = request.getRealPath("/")+File.separator+"notchoicequestion.xls";
			File file = new File(template);
			if(file.exists()||file.isFile()){
				file.delete();
			}
			
			//生成模板
			TemplateManager nctm = new TemplateManager();
			nctm.setMajorAndCourse(majorName, courseName, courseId);
			nctm.createExcelFile(template);
			
			File f = new File(template);
			if(f.exists()||f.isFile()){
				FileHelper fileHelper = new FileHelper();
				fileHelper.downLoad(template, request, response);
			}else{
				request.setAttribute("flag","error");
				request.getRequestDispatcher("/questionbank/question/before.jsp").forward(request,response);
			}
		} catch (ManagerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NameRepeatException e) {
			// TODO Auto-generated catch block
			request.setAttribute("flag","other");
			request.getRequestDispatcher("/questionbank/question/before.jsp").forward(request,response);
		}
	}

}
