package com.googosoft.filesManager.fileManager;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.DBHelper;

public class DelfolderManager {
	private Logger logger = Logger.getLogger(DelfolderManager.class.getName());
	/**
	 * 单例模式（懒汉）
	 * @param args
	 */
	private static DelfolderManager instance;

	private DelfolderManager() {

	}

	public static DelfolderManager getInstance() {
		if (instance == null) {
			instance = new DelfolderManager();
		}
		return instance;
	}
	public boolean judge(String folderId) throws ManagerException{
		String str = findFileIdById(folderId);
		boolean flag = false ;
		if(!str.equals("false")){
			flag = true;
		}
		return flag;
	}
	public String findFileIdById(String Id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID");
		sql.append(" FROM files T ");
		sql.append(" WHERE T.FOLDERID= '" + Id + "' ");
		DBHelper dbHelper = new DBHelper();
		String fileId = null;
		try {
			fileId = (String)dbHelper.queryForSingleValue(sql.toString());
			if(fileId==null){
				fileId = "false";
			}
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return fileId;
	}
}
