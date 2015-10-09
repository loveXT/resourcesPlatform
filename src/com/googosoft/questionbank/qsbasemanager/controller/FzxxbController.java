package com.googosoft.questionbank.qsbasemanager.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.DBFormatException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.exception.TreeException;
import com.googosoft.ggs.saasManager.SaasManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBFormatHelper;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class FzxxbController {

	private Logger logger = Logger.getLogger(FzxxbController.class.getName());

	public PageInfo findPageInfoByquestion_fzxxb(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FZXXB_ID AS FZXXB_ID, ");
		sql.append(" T.FZXXB_FZDJ AS FZXXB_FZDJ, ");
		sql.append(" T.FZXXB_ZDZ AS FZXXB_ZDZ, ");
		sql.append(" T.FZXXB_ZXZ AS FZXXB_ZXZ, ");
		sql.append(" T.FZXXB_SSZB AS FZXXB_SSZB");
		sql.append(" FROM question_fzxxb T ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
//			sql.append(SaasManager.getDataSqlByInitSql("T", request));
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

	public List findTreeByquestion_fzxxb(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FZXXB_ID AS FZXXB_ID, ");
		sql.append(" T.FZXXB_FZDJ AS FZXXB_FZDJ, ");
		sql.append(" T.FZXXB_ZDZ AS FZXXB_ZDZ, ");
		sql.append(" T.FZXXB_ZXZ AS FZXXB_ZXZ, ");
		sql.append(" T.FZXXB_SSZB AS FZXXB_SSZB ");
		sql.append(" FROM question_fzxxb T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
//			sql.append(SaasManager.getDataSqlByInitSql("T", request));
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

	public Map findMapByFZXXB_ID(String FZXXB_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FZXXB_ID AS FZXXB_ID, ");
		sql.append(" T.FZXXB_FZDJ AS FZXXB_FZDJ, ");
		sql.append(" T.FZXXB_ZDZ AS FZXXB_ZDZ, ");
		sql.append(" T.FZXXB_ZXZ AS FZXXB_ZXZ, ");
		sql.append(" T.FZXXB_SSZB AS FZXXB_SSZB");
		sql.append(" FROM question_fzxxb T ");
		sql.append(" WHERE t.FZXXB_ID= '" + FZXXB_ID + "' ");
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
	public List findByFZXX(String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FZXXB_ID AS FZXXB_ID, ");
		sql.append(" T.FZXXB_FZDJ AS FZXXB_FZDJ, ");
		sql.append(" T.FZXXB_ZDZ AS FZXXB_ZDZ, ");
		sql.append(" T.FZXXB_ZXZ AS FZXXB_ZXZ, ");
		sql.append(" T.FZXXB_SSZB AS FZXXB_SSZB ");
		sql.append(" FROM question_fzxxb T ");
		sql.append(" WHERE 1 = 1 ");
		List list;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
//			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list =new DBHelper().queryForList(sql.toString());
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
