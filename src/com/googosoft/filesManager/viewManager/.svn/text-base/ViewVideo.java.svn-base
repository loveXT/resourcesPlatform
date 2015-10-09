package com.googosoft.filesManager.viewManager;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googosoft.common.util.GWebUtil;
import com.googosoft.common.util.StringPool;
import com.googosoft.common.util.StringUtil;
import com.googosoft.common.util.UnsyncBufferedInputStream;

/**
 * Servlet implementation class ViewVideo
 */
public class ViewVideo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewVideo() {
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
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path =GWebUtil.fixPath(request.getPathInfo()) ;
		//String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
		String[] pathArray = StringUtil.split(path, StringPool.SLASH);
		/**
		 * 根据请求路径得到文件名称例如：java代码如下
		 * basePath+"/ViewVideo/"+fileName;则文件名为pathArray[0]
		 * 如果是basePath+"/ViewVideo/"+fileName+"/ddd"
		 *那么得到ddd的值即为pathArray[1],要保证万无一失最好先把pathArray这个数组
		 *遍历下查看想要的参数到底是在数组中的什么位置
		 */
		String fileName = pathArray[0];
		String filePath = request.getRealPath(File.separator+StringConstant.prefixPath+File.separator+fileName);
		File file =new File(filePath);
		System.out.println(file.length());
		InputStream is=null;
		int contentLength  = 0;
		if(file.exists()){
			//得到一个输入流
			is = new UnsyncBufferedInputStream(new FileInputStream(file));
			contentLength= is.available();
			String contentType = GWebUtil.getContentType(fileName);
			//设置HTTP请求的头部
			GWebUtil.setHeaders(request, response, fileName, contentType);
			//将文件以流的形式写给页面
			GWebUtil.write(response, is, contentLength);
		}else{
			response.sendRedirect("preview.jsp");
		}
		
	}
	
}
