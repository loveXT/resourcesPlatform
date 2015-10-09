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
import com.googosoft.ggs.saasManager.SaasManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class Question_typeController {

	private Logger logger = Logger.getLogger(TypeController.class.getName());

	public PageInfo findPageInfoByQUESTION_TYPE(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ITEM_ID AS ITEM_ID, ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.QUESTION_SCORE AS QUESTION_SCORE, ");
		sql.append(" T.QUESTION_AMOUNT AS QUESTION_AMOUNT");
		sql.append(" FROM QUESTION_TYPE T ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			sql.append(SaasManager.getDataSqlByInitSql("T", request));
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
	
	public List findTreeByQUESTION_TYPE(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ITEM_ID AS ITEM_ID, ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.QUESTION_SCORE AS QUESTION_SCORE, ");
		sql.append(" T.QUESTION_AMOUNT AS QUESTION_AMOUNT ");
		sql.append(" FROM QUESTION_TYPE T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "ID", "PARENTID", "NAME");
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

	public Map findMapByITEM_ID(String ITEM_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ITEM_ID AS ITEM_ID, ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.QUESTION_SCORE AS QUESTION_SCORE, ");
		sql.append(" T.QUESTION_AMOUNT AS QUESTION_AMOUNT ");
		sql.append(" FROM QUESTION_TYPE T ");
		sql.append(" WHERE t.ITEM_ID= '" + ITEM_ID + "' ");
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
	public Map findMapByTypeId(String PAPER_ID,String TYPE_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ITEM_ID AS ITEM_ID, ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.QUESTION_SCORE AS QUESTION_SCORE, ");
		sql.append(" T.QUESTION_AMOUNT AS QUESTION_AMOUNT ");
		sql.append(" FROM QUESTION_TYPE T ");
		sql.append(" WHERE T.PAPER_ID= '" + PAPER_ID + "' AND T.TYPE_ID='"+TYPE_ID+"'");
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
