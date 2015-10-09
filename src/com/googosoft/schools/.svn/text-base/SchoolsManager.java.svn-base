package com.googosoft.schools;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.exception.TreeException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class SchoolsManager {

	public static Logger logger = Logger.getLogger(SchoolsManager.class
			.getName());
	
	public List findListBySCHOOL(){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.SCHOOLNAME AS SCHOOLNAME, ");
		sql.append(" T.CREATTIME AS CREATTIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM SCHOOLS T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
			logger.error("查询失败!", e);
		}
		return list;
	}

	public PageInfo findPageInfoBySCHOOL(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.SCHOOLNAME AS SCHOOLNAME, ");
		sql.append(" T.CREATTIME AS CREATTIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM SCHOOLS T ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			pageInfo = new PageHelper(nowPage, pageSize, sql.toString())
					.getPageInfo();
		} catch (QueryException e) {
			logger.error("组装查询语句where条件的and语句失败\n" + e);
			throw new ManagerException("组装查询语句where条件的and语句失败\n" + e);
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (PageException e) {
			logger.error("查询分页信息失败\n" + e);
			throw new ManagerException("查询分页信息失败\n" + e);
		}
		return pageInfo;
	}

	public List findTreeBySCHOOL(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.SCHOOLNAME AS SCHOOLNAME, ");
		sql.append(" T.CREATTIME AS CREATTIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM SCHOOLS T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "ID", "PARENTID", "SCHOOLNAME");
			list = treeHelper.getTreeList();
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (TreeException e) {
			logger.error("组装树失败\n" + e);
			throw new ManagerException("组装树失败\n" + e);
		}
		return list;
	}

	public Map findMapByID(String ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.SCHOOLNAME AS SCHOOLNAME, ");
		sql.append(" T.CREATTIME AS CREATTIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM SCHOOLS T ");
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
}
