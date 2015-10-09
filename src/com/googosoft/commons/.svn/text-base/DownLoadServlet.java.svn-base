package com.googosoft.commons;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.FileException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.FileHelper;

/**
 * 下载
 * 
 */
public class DownLoadServlet extends javax.servlet.http.HttpServlet implements
		javax.servlet.Servlet {
	private Logger logger = Logger.getLogger(DownLoadServlet.class.getName());
	static final long serialVersionUID = 1L;

	public DownLoadServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String fileId = request.getParameter("FILEID");
		Map documentMap = null;
		try {
			documentMap = getMapAttachs(fileId);
		} catch (ManagerException e1) {
			e1.printStackTrace();
		}
		String newFileName = (String)documentMap.get("FILENAME");
		System.out.println("newFileName"+newFileName);
		String fromPath = (String)documentMap.get("FILEPATH");
		System.out.println("XXXXXXXXx"+fromPath);
		FileHelper fileHelper = new FileHelper();
		try {
			if(StringUtil.isNotNull(fromPath)){
				if(StringUtil.isNull(newFileName)){
					fileHelper.downLoad(fromPath, request, response);
				}else{
					fileHelper.downLoad(fromPath, newFileName, request, response);
				}
			}
		} catch (FileException e) {
			logger.error(e + "下载文件失败，FILEPATH=" + fromPath);
			throw new IOException(e);
		}
	}
	
	
	public void downLoadFile(String filePath,HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		FileHelper fileHelper = new FileHelper();
		try {
			fileHelper.downLoad(filePath, request, response);
		} catch (FileException e) {
			logger.error(e + "下载文件失败，FILEPATH=" + filePath);
			throw new IOException(e);
		}
	}
	/**
	 * @param fileId
	 * @return
	 * @throws ManagerException
	 */
	public Map getMapAttachs(String fileId) throws ManagerException {
		DBHelper dbHelper = new DBHelper();
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.FILEPATH AS FILEPATH ");
		sql.append(" FROM zcdocument_v T ");
		sql.append(" WHERE T.FILEID= '" + fileId + "' ");
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return map;
	}
}