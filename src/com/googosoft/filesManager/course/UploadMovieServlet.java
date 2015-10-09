package com.googosoft.filesManager.course;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;

import com.googosoft.common.util.Validator;
import com.googosoft.common.util.VideoUtil;
import com.googosoft.file.FileBean;
import com.googosoft.zapi.FileHelper;

/**
 * Servlet implementation class UploadMovieServlet
 */
public class UploadMovieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static String contextPath;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadMovieServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * 上传文件如果是视频并转换成flv格式，并截取视频的缩略图
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FileHelper fileHelper  = new FileHelper();
		String toPath=request.getRealPath(File.separator+StringConstant.prefixPath);
		contextPath = request.getContextPath();
		FileBean fileBean =null;
		String fileName = request.getParameter("fileName");

		String CLASSID = request.getParameter("CLASSID");
		String CHAPTER_ID = request.getParameter("CHAPTER_ID");
		String COURSE_ID = request.getParameter("COURSE_ID");
		String MAJOR_ID = request.getParameter("MAJOR_ID");
		
		String extension=fileName.substring(21, fileName.lastIndexOf("."));
		String absPath = toPath+"\\"+fileName;
		//String extension=extendName.substring(extendName.lastIndexOf("."));
		//获取截屏时间
		String h =request.getParameter("h");
		String m =request.getParameter("m");
		String s =request.getParameter("s");
		if(Validator.isNull(h)) {
			h = "0";
		}
		if(Validator.isNull(m)) {
			m="0";
		}
		if(h.equals("0") && m.equals("0") && Validator.isNull(s)) {
			s = "5";
		}
		//以下代码最好封装到一个类中不要再controller中出现
		long screenshotTime = (Long.parseLong(h) * 60 + Long.parseLong(m) * 60 + Long.parseLong(s));
			extension=FilenameUtils.getExtension(fileName);
				//从视频中截图,可以设置缩略图大小220表示宽度，168表示高度
				VideoUtil.captureImage(absPath, toPath, FilenameUtils.getBaseName(fileName), 200, 200, screenshotTime);
				//将视频转换为flv格式
				boolean flag =VideoUtil.convert2Flv(absPath, toPath, FilenameUtils.getBaseName(fileName));
				response.sendRedirect(contextPath+previewPage+"?view=true&CLASSID="+CLASSID+"&CHAPTER_ID="+CHAPTER_ID+"&COURSE_ID="+COURSE_ID+"&Major_id="+MAJOR_ID);
	}
	/**
	 * 用于判断文件是否是所需的视频格式
	 * @param extension
	 * @return
	 */
	public boolean isVideoFile(String extension){
		String[] extensionArray = StringConstant.extensionArray;
		for(int i=0;i<extensionArray.length;i++){
			if(extensionArray[i].equals(extension)){
				return true;
			}
		}
		return false;
	}

	private static final String previewPage ="/filesmanager/course/addFile.jsp"; 
}
