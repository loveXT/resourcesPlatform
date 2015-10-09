package com.googosoft.resource;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
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

public class ResourceManager {
	public Logger logger = Logger.getLogger(ResourceManager.class
			.getName());
	//查询分页
	public PageInfo findPageInfoByID(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)throws ManagerException{
		String Id = request.getParameter("ID");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT");
		sql.append(" Q.ID AS ID, ");
		sql.append(" Q.NAME AS NAME, ");
		sql.append(" Q.CREATTIME AS CREATTIME, ");
		sql.append(" Q.PARENTID AS PARENTID, ");
		sql.append(" Q.NOTE AS NOTE, ");
		sql.append(" Q.PXXH AS PXXH, ");
		sql.append(" F.NAME AS NAME1 ");
		sql.append(" FROM QFRESOURCE Q ");
		sql.append(" LEFT JOIN QFRESOURCE F ON F.ID = Q.PARENTID ");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(Id)) {
			sql.append(" AND Q.ID != Q.PARENTID ");
			sql.append(" AND Q.PARENTID='"+Id+"' ");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(" ORDER BY Q.PXXH");
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
	//查询并操作结构树
	public List findTreeByID(HttpServletRequest request)throws ManagerException{
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT");
		sql.append(" Q.ID AS ID, ");
		sql.append(" Q.NAME AS NAME, ");
		sql.append(" Q.CREATTIME AS CREATTIME, ");
		sql.append(" Q.PARENTID AS PARENTID, ");
		sql.append(" Q.PXXH AS PXXH, ");
		sql.append(" Q.NOTE AS NOTE ");
		sql.append(" FROM QFRESOURCE Q ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" order by PXXH");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "ID", "PARENTID","NAME");
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
	//查询目录名称
	public List findListByID(HttpServletRequest request)throws ManagerException{
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT");
		sql.append(" Q.ID AS ID, ");
		sql.append(" Q.NAME AS NAME, ");
		sql.append(" Q.CREATTIME AS CREATTIME, ");
		sql.append(" Q.PXXH AS PXXH, ");
		sql.append(" Q.PARENTID AS PARENTID ");
		sql.append(" FROM QFRESOURCE Q ");
		sql.append(" WHERE 1 = 1 ");
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
	//查询主键ID
	public Map findMapByID(String Id)throws ManagerException{
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT");
		sql.append(" Q.ID AS ID, ");
		sql.append(" Q.NAME AS NAME, ");
		sql.append(" Q.CREATTIME AS CREATTIME, ");
		sql.append(" Q.PARENTID AS PARENTID, ");
		sql.append(" Q.NOTE AS NOTE, ");
		sql.append(" Q.PXXH AS PXXH, ");
		sql.append(" F.NAME AS NAME1 ");
		sql.append(" FROM QFRESOURCE Q ");
		sql.append(" LEFT JOIN QFRESOURCE F ON Q.PARENTID = F.ID ");
		sql.append(" WHERE Q.ID= '" + Id + "' ");
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
