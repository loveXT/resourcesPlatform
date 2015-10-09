package com.googosoft.menumanager;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.myFilesManager.chain.ChainManager;
import com.googosoft.zapi.DBHelper;

/*
 * 这个类是在notice.jsp里用的，根据id查找表webcontent里的内容
 */
public class AllManager {
	private Logger logger = Logger.getLogger(ChainManager.class.getName());
	
	public Map findPageInfoByNotice(String id) throws ManagerException {
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
		sql.append(" T.SFSCSLT AS SFSCSLT, ");
		sql.append(" T.BROWSE AS BROWSE, ");
		sql.append(" N.NAVIGATIONNAME AS NAVIGATIONNAME ");
		sql.append(" FROM WEBCONTENT T ");
		sql.append(" left join NAVIGATION N ON T.NAVIGATIONID=N.ID ");
		sql.append(" WHERE T.ID='"+id+"'");
		DBHelper dbHelper = new DBHelper();
		Map map=null;
		try {
			map= dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return map;
	}
	
	/*
	 * 以下方法用作浏览次数根据id自增
	 */
	public void setBrowseAddOne(String id){
		StringBuffer sb=new StringBuffer();
		sb.append(" UPDATE WEBCONTENT T ");
		sb.append(" SET BROWSE=BROWSE+1 ");
		sb.append(" WHERE T.ID='"+id+"'");
		DBHelper dbHelper = new DBHelper();
		try {
			dbHelper.execute(sb.toString());
		} catch (DBException e) {
			logger.error("执行更新失败\n" + e);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public List findPageInfoByClassify(String id) throws ManagerException {
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
		sql.append(" T.SFSCSLT AS SFSCSLT, ");
		sql.append(" T.BROWSE AS BROWSE ");
/*		sql.append(" N.NAVIGATIONNAME AS NAVIGATIONNAME ");*/
		sql.append(" FROM WEBCONTENT T ");
/*		sql.append(" left join NAVIGATION N ON T.NAVIGATIONID=N.ID ");*/
		sql.append(" WHERE T.NAVIGATIONID='"+id+"'");
		sql.append(" order by UPDATETIME desc ");
		DBHelper dbHelper = new DBHelper();
		List list=null;
		try {
		list=dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
}
