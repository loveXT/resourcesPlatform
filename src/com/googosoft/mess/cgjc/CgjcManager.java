package com.googosoft.mess.cgjc;

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
public class CgjcManager {
	private Logger logger=Logger.getLogger(CgjcManager.class.getName());

	public PageInfo findPageInfoBycgjcb(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CGJC_ID AS CGJC_ID, ");
		sql.append(" T.CGJC_LB AS CGJC_LB, ");
		sql.append(" T.CGJC_MC AS CGJC_MC, ");
		sql.append(" T.CGJC_WJLJ AS CGJC_WJLJ, ");
		sql.append(" T.CGJC_SJ AS CGJC_SJ, ");
		sql.append(" T.CGJC_JJ AS CGJC_JJ ");
		sql.append(" FROM CGJCB T ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			//sql.append(SaasManager.getDataSqlByInitSql("T", request));
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
	
	public PageInfo findPageInfoBycgjc_SJ(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT *");
		sql.append(" FROM ( ");
		sql.append(" SELECT ");
		sql.append(" T.CGJC_ID AS CGJC_ID, ");
		sql.append(" T.CGJC_LB AS CGJC_LB, ");
		sql.append(" T.CGJC_MC AS CGJC_MC, ");
		sql.append(" T.CGJC_WJLJ AS CGJC_WJLJ, ");
		sql.append(" T.CGJC_SJ AS CGJC_SJ, ");
		sql.append(" T.CGJC_JJ AS CGJC_JJ ");
		sql.append(" FROM cgjcb T ORDER BY T.CGJC_SJ DESC )");
		sql.append(" WHERE ROWNUM<6");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			//sql.append(SaasManager.getDataSqlByInitSql("T", request));
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

	public List findTreeBycgjcb(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CGJC_ID AS CGJC_ID, ");
		sql.append(" T.CGJC_LB AS CGJC_LB, ");
		sql.append(" T.CGJC_MC AS CGJC_MC, ");
		sql.append(" T.CGJC_WJLJ AS CGJC_WJLJ, ");
		sql.append(" T.CGJC_SJ AS CGJC_SJ, ");
		sql.append(" T.CGJC_JJ AS CGJC_JJ ");
		sql.append(" FROM cgjcb T ");
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

	public Map findMapByCGJC_ID(String CGJC_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CGJC_ID AS CGJC_ID, ");
		sql.append(" T.CGJC_LB AS CGJC_LB, ");
		sql.append(" T.CGJC_MC AS CGJC_MC, ");
		sql.append(" T.CGJC_WJLJ AS CGJC_WJLJ, ");
		sql.append(" T.CGJC_SJ AS CGJC_SJ, ");
		sql.append(" T.CGJC_JJ AS CGJC_JJ ");
		sql.append(" FROM cgjcb T ");
		sql.append(" WHERE t.CGJC_ID= '" + CGJC_ID + "' ");
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
