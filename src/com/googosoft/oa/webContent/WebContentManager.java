package com.googosoft.oa.webContent;

import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.IUploadImgContants;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

public class WebContentManager {
	private Logger logger = Logger.getLogger(WebContentManager.class.getName());
	
	/**
	 * 查询网页内容
	 * @param nowPage
	 * @param pageSize
	 */
	public PageInfo findPageInfoByWebContent(int nowPage, int pageSize,
			String split,HttpServletRequest request) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.TITLE AS TITLE, ");
		sql.append(" T.CONTENT AS CONTENT, ");
		sql.append(" T.NAVIGATIONID AS NAVIGATIONID, ");
		sql.append(" N.NAVIGATIONNAME AS NAVIGATIONNAME, ");
		sql.append(" T.USERID AS USERID, ");
		sql.append(" U.USERNAME AS USERNAME, ");
		sql.append(" T.DESCRIPTION AS DESCRIPTION, ");
		sql.append(" T.PICTURE AS PICTURE, ");
		sql.append(" T.PICTURENAME AS PICTURENAME, ");
		sql.append(" T.SMALLPICTURE AS SMALLPICTURE, ");
		sql.append(" T.UPDATETIME AS UPDATETIME, ");
		sql.append(" T.SFSCSLT AS SFSCSLT ");
		sql.append(" FROM WEBCONTENT T ");
		sql.append(" INNER JOIN UMUSER U ON U.USERID=T.USERID ");
		sql.append(" LEFT JOIN NAVIGATION N ON T.NAVIGATIONID=N.ID ");
		sql.append(" where 1=1");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(split, request));
			sql.append(" ORDER BY T.UPDATETIME DESC ");
			pageInfo = new PageHelper(nowPage, pageSize, sql.toString()).getPageInfo();
		} catch (DBException e) {
			logger.error("查询数据库信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (PageException e) {
			logger.error("查询分页信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (QueryException e) {
			logger.error("查询分页信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return pageInfo;
	}
	/**
	 * 按照ID查询网页内容
	 * @param ID
	 */
	public Map findMapByID(String ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.TITLE AS TITLE, ");
		sql.append(" T.CONTENT AS CONTENT, ");
		sql.append(" T.NAVIGATIONID AS NAVIGATIONID, ");
		sql.append(" T.USERID AS USERID, ");
		sql.append(" U.USERNAME AS USERNAME, ");
		sql.append(" T.DESCRIPTION AS DESCRIPTION, ");
		sql.append(" T.PICTURE AS PICTURE, ");
		sql.append(" T.PICTURENAME AS PICTURENAME, ");
		sql.append(" T.SMALLPICTURE AS SMALLPICTURE, ");
		sql.append(" T.UPDATETIME AS UPDATETIME, ");
		sql.append(" T.SFSCSLT AS SFSCSLT ");
		sql.append(" FROM WEBCONTENT T ");
		sql.append(" INNER JOIN UMUSER U ON U.USERID=T.USERID ");
		sql.append(" WHERE T.ID= '" + ID + "' ");
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
	/**
	 * 按照导航菜单 NAVIGATIONID查询网页内容
	 * @param ID
	 */
	public List findListByNAVIGATIONID(String NAVIGATIONID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" ID AS ID, ");
		sql.append(" TITLE AS TITLE, ");
		sql.append(" CONTENT AS CONTENT, ");
		sql.append(" NAVIGATIONID AS NAVIGATIONID, ");
		sql.append(" USERID AS USERID, ");
		sql.append(" DESCRIPTION AS DESCRIPTION, ");
		sql.append(" PICTURE AS PICTURE, ");
		sql.append(" T.PICTURENAME AS PICTURENAME, ");
		sql.append(" SMALLPICTURE AS SMALLPICTURE, ");
		sql.append(" UPDATETIME AS UPDATETIME, ");
		sql.append(" SFSCSLT AS SFSCSLT ");
		sql.append(" FROM WEBCONTENT T ");
		sql.append(" WHERE t.NAVIGATIONID= '" + NAVIGATIONID + "' ");
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
	/**
	 * 按照模板名得到导航菜单ID
	 * @param layoutName
	 */
	public Map findMapByLayoutName(String layoutName) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.NAVIGATIONID AS NAVIGATIONID, ");
		sql.append(" N.NAVIGATIONNAME AS NAVIGATIONNAME, ");
		sql.append(" T.LAYOUTNAME AS LAYOUTNAME ");
		sql.append(" FROM CONTENTCONFIG T ");
		sql.append(" LEFT JOIN NAVIGATION N ON T.NAVIGATIONID=N.ID " );
		sql.append(" WHERE T.LAYOUTNAME= '" + layoutName + "' ");
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
	/**
	 * 修改模块和内容ID对应信息
	 * @param layoutName
	 */
	public void updateContentConfig(String layoutName,String navigationId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE CONTENTCONFIG SET ");
		sql.append(" NAVIGATIONID = '"+navigationId+"'");
		sql.append(" WHERE LAYOUTNAME='"+layoutName+"'");
		DBHelper dbHelper = new DBHelper();
		try {
			dbHelper.execute(sql.toString());
		}catch (SQLException e) {
			e.printStackTrace();
		}catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
	}
	/**
	 * 检测文件是否存在
	 * 
	 * @param path
	 * @return
	 */
	public boolean checkPictureExists(String filename,
			HttpServletRequest request) {
		String sp = File.separator;
		String toPath = request.getRealPath(sp) + IUploadImgContants.IMGPATH;
		toPath = toPath.replace(sp, sp + sp);
		File file = new File(toPath + filename);
		if (file.exists())
			return true;
		return false;
	}
	/**
	 * 通过ID查询导航菜单名
	 * 
	 * @param path
	 * @return
	 */
	public static String findNavigationName(String ID) throws ManagerException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT NAVIGATIONNAME FROM NAVIGATION ");
		sql.append(" WHERE ID='"+ID+"'");
		String name="";
		DBHelper dbHelper = new DBHelper();
		try {
			name = (String)dbHelper.queryForSingleValue(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
		}
		return name;
	}
}
