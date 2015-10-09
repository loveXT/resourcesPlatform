package com.googosoft.menumanager;

import java.util.List;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.myFilesManager.chain.ChainManager;
import com.googosoft.zapi.DBHelper;

public class NewsManager {
	private Logger logger = Logger.getLogger(ChainManager.class.getName());
	public List findPageInfoByNews() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.TITLE AS TITLE, ");
		sql.append(" T.CONTENT AS CONTENT, ");
		sql.append(" T.NAVIGATIONID AS NAVIGATIONID, ");
		sql.append(" T.USERID AS USERID, ");
		sql.append(" T.DESCRIPTION AS DESCRIPTION, ");
		sql.append(" T.PICTURE AS PICTURE, ");
		sql.append(" T.PICTURENAME AS PICTURENAME, ");
		sql.append(" T.SMALLPICTURE AS SMALLPICTURE, ");
		sql.append(" T.UPDATETIME AS UPDATETIME, ");
		sql.append(" T.SFSCSLT AS SFSCSLT ");
		sql.append(" FROM WEBCONTENT T ");
		sql.append(" left join NAVIGATION N ON T.NAVIGATIONID=N.ID ");
		sql.append(" WHERE N.NAVIGATIONNAME ='新闻' ");
		sql.append("  order by UPDATETIME desc ");
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
}
