package com.googosoft.questionbank.qsbasemanager.controller;

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

public class NdxxbController {

	private Logger logger = Logger.getLogger(NdxxbController.class.getName());

	public PageInfo findPageInfoByquestion_ndxxb(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.NDXXB_ID AS NDXXB_ID, ");
		sql.append(" T.NDXXB_NYCD AS NDXXB_NYCD, ");
		sql.append(" T.NDXXB_SSZB AS NDXXB_SSZB ");
		sql.append(" FROM question_ndxxb T ");
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

	public List findTreeByquestion_ndxxb(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.NDXXB_ID AS NDXXB_ID, ");
		sql.append(" T.NDXXB_NYCD AS NDXXB_NYCD, ");
		sql.append(" T.NDXXB_SSZB AS NDXXB_SSZB");
		sql.append(" FROM question_ndxxb T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			// sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "NDXXB_ID", "NDXXB_ID", "NDXXB_NYCD");
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

	public Map findMapByNDXXB_ID(String NDXXB_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.NDXXB_ID AS NDXXB_ID, ");
		sql.append(" T.NDXXB_NYCD AS NDXXB_NYCD, ");
		sql.append(" T.NDXXB_SSZB AS NDXXB_SSZB");
		sql.append(" FROM question_ndxxb T ");
		sql.append(" WHERE t.NDXXB_ID= '" + NDXXB_ID + "' ");
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
	public Map findMapByNDXXB_NYCD(String ndxxb_nycd) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.NDXXB_ID AS NDXXB_ID, ");
		sql.append(" T.NDXXB_NYCD AS NDXXB_NYCD, ");
		sql.append(" T.NDXXB_SSZB AS NDXXB_SSZB");
		sql.append(" FROM question_ndxxb T ");
		sql.append(" WHERE t.NDXXB_ID= '" + ndxxb_nycd + "' ");
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

	public List findByComplexity(String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.NDXXB_ID AS NDXXB_ID, ");
		sql.append(" T.NDXXB_NYCD AS NDXXB_NYCD, ");
		sql.append(" T.NDXXB_SSZB AS NDXXB_SSZB");
		sql.append(" FROM question_ndxxb T ");
		sql.append(" WHERE 1 = 1 ");
		List list;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			list = new DBHelper().queryForList(sql.toString());
		} catch (QueryException e) {
			logger.error("组装查询语句where条件的and语句失败\n" + e);
			throw new ManagerException("组装查询语句where条件的and语句失败\n" + e);
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}

}
