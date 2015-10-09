package com.googosoft.oa.navigation;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

public class NavigationManager {
	private Logger logger = Logger.getLogger(NavigationManager.class.getName());
	/**
	 * 查询菜单栏分类
	 * @param nowPage
	 * @param pageSize
	 */
	public PageInfo findPageInfoByNavigation(int nowPage, int pageSize,
			String split,HttpServletRequest request) throws ManagerException {
		String sql = " SELECT ";
		sql += " ID AS ID, ";
		sql += " PLSX AS PLSX, ";
		sql += " DESCRIPTION AS DESCRIPTION, ";
		sql += " NAVIGATIONNAME AS NAVIGATIONNAME, ";
		sql += " ADDRESS AS ADDRESS, ";
		sql += " STATE AS STATE ";
		sql += " FROM NAVIGATION t ";
		sql += " WHERE 1 = 1 ";
		sql += " ORDER BY to_number(PLSX) ";
		PageInfo pageInfo = null;
		try {
			sql += new QueryHelper().getQuerySqlByRequset(split, request);
			pageInfo = new PageHelper(nowPage, pageSize, sql).getPageInfo();
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
	 * 按照ID查询导航栏信息
	 * @param ID
	 */
	public Map findMapByID(String ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" PLSX AS PLSX, ");
		sql.append(" DESCRIPTION AS DESCRIPTION, ");
		sql.append(" NAVIGATIONNAME AS NAVIGATIONNAME, ");
		sql.append(" ADDRESS AS ADDRESS, ");
		sql.append(" STATE AS STATE ");
		sql.append(" FROM NAVIGATION T ");
		sql.append(" WHERE t.ID= '" + ID + "' ");
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
	 * 查询导航栏状态为显示的菜单栏
	 */
	public List findListByNavigation() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" PLSX AS PLSX, ");
		sql.append(" DESCRIPTION AS DESCRIPTION, ");
		sql.append(" NAVIGATIONNAME AS NAVIGATIONNAME, ");
		sql.append(" ADDRESS AS ADDRESS, ");
		sql.append(" STATE AS STATE ");
		sql.append(" FROM NAVIGATION T ");
		sql.append(" WHERE T.STATE = 1 ");
		sql.append(" ORDER BY to_number(PLSX) ");
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
	 * 查询所有菜单
	 */
	public List findAllListByNavigation() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" PLSX AS PLSX, ");
		sql.append(" DESCRIPTION AS DESCRIPTION, ");
		sql.append(" NAVIGATIONNAME AS NAVIGATIONNAME, ");
		sql.append(" ADDRESS AS ADDRESS, ");
		sql.append(" STATE AS STATE ");
		sql.append(" FROM NAVIGATION T ");
		sql.append(" ORDER BY to_number(PLSX) ");
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
