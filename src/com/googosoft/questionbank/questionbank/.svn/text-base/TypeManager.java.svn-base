package com.googosoft.questionbank.questionbank;

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

public class TypeManager {
	Logger logger = Logger.getLogger(TypeManager.class.getName());

	public PageInfo findPageInfoBytype(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.TYPE_NAME AS TYPE_NAME, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIMIE AS CREATETIMIE, ");
		sql.append(" T.ROWNUM AS ROWNUM ");
		sql.append(" FROM type T ");
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

	public List findTreeBytype(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.TYPE_NAME AS TYPE_NAME, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIMIE AS CREATETIMIE ");
		sql.append(" FROM type T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
				sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "TYPE_ID", "TYPE_ID", "TYPE_NAME",null,"S");
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

	public Map findMapByTYPE_ID(String TYPE_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.TYPE_NAME AS TYPE_NAME, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIMIE AS CREATETIMIE ");
		sql.append(" FROM type T ");
		sql.append(" WHERE t.TYPE_ID= '" + TYPE_ID + "' ");
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
	public Map findMapByTYPE_NAME(String TYPE_NAME) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.TYPE_NAME AS TYPE_NAME, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIMIE AS CREATETIMIE ");
		sql.append(" FROM type T ");
		sql.append(" WHERE t.TYPE_NAME= '" + TYPE_NAME + "' ");
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
