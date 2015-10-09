package com.googosoft.ggs.dataManager.normCode;

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

public class NormCodeManager {
	private Logger logger = Logger.getLogger(NormCodeTypeManager.class
			.getName());

	public PageInfo findPageInfoByNORMCODE(int nowPage, int pageSize,
			String splitByQuery, String normCodeParentId,HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.DM AS DM, ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.MC AS MC, ");
		sql.append(" T.DMLXID AS DMLXID");
		sql.append(" FROM NORMCODE T ");
		sql.append(" WHERE ");
		sql.append(" T.DMLXID = '");
		sql.append(normCodeParentId);
		sql.append("'");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery, request));
			sql.append("ORDER BY T.DM");
			pageInfo = new PageHelper(nowPage, pageSize, sql.toString())
					.getPageInfo();
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (PageException e) {
			logger.error("查询分页信息失败\n" + e);
			throw new ManagerException("查询分页信息失败\n" + e);
		} catch (QueryException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return pageInfo;
	}

	public List findTreeByNORMCODE(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.DM AS DM, ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.MC AS MC, ");
		sql.append(" T.DMLXID AS DMLXID");
		sql.append(" FROM NORMCODE T ");
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

	public Map findMapByID(String ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.DM AS DM, ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.MC AS MC, ");
		sql.append(" T.DMLXID AS DMLXID");
		sql.append(" FROM NORMCODE T ");
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
}
