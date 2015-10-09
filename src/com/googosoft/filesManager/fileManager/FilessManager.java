package com.googosoft.filesManager.fileManager;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.CUMException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.CUMHelper;
import com.googosoft.zapi.DBHelper;

public class FilessManager {
	
	private Logger logger = Logger.getLogger(FolderManager.class.getName());
	
	public Map findMapByFileName(String FILEID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * ");
		sql.append(" FROM FILES T ");
		sql.append(" LEFT JOIN RESOURCEMANAGER R ON R.ID=T.CLASSIFY ");
		sql.append(" WHERE t.FILEID= '" + FILEID + "' ");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return map;
	}
	
	public List findPageInfo() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT  ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.REALNAME||T.EXTENDNAME AS REALNAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.DOWNLOAD AS DOWNLOAD, ");
		sql.append(" T.CLASSIFY AS CLASSIFY, ");
		sql.append(" T.FILESIZE AS FILESIZE, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.DOWNLOADTIME AS DOWNLOADTIME, ");
		sql.append(" T.BROWSETIME AS BROWSETIME, ");
		sql.append(" T.FILENAME2 AS FILENAME2, ");
		sql.append(" T.FILEPATH AS FILEPATH ");
		sql.append(" FROM FILES T ");
		sql.append(" LEFT JOIN RESOURCEMANAGER R ON R.ID=T.CLASSIFY ");
		sql.append(" WHERE R.NAME IN ('视频','动画','三分屏') ");
		sql.append(" AND T.FLAG='22' ");
		sql.append(" ORDER BY CREATETIME DESC ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	
	public String findStringByName(String name){
		String sql = "select t.id from RESOURCEMANAGER t where t.name like '%"+name+"%'";
		String typeid = null;
		DBHelper dbHelper = new DBHelper();
		try {
			typeid =Validate.isNullToDefault(dbHelper.queryForSingleValue(sql), "").toString();
		} catch (DBException e) {
			e.printStackTrace();
		}
		return typeid;
	}
	
	public static void main(String args[]){
		try {
			CUMHelper cumhelper=new CUMHelper("FILES","FILEID");
			cumhelper.getCreateToPrintByDB();
			cumhelper.getManagerToPrintByDb();
			cumhelper.getUpdateToPrintByDB();
		} catch (CUMException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
