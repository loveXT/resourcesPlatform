package com.googosoft.mess.xdjl;

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
import com.googosoft.ggs.saasManager.SaasManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;
public class XdjlManager {
	private Logger logger=Logger.getLogger(XdjlManager.class.getName());

	public PageInfo findPageInfoByxdjlb(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request,String starttime,String endtime)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.XDJL_ID AS XDJL_ID, ");
		sql.append(" T.XDJL_RIQI AS XDJL_RIQI, ");
		sql.append(" T.XDJL_XDDX AS XDJL_XDDX, ");
		sql.append(" T.XDJL_SL AS XDJL_SL, ");
		sql.append(" T.XDJL_XDFF AS XDJL_XDFF, ");
		sql.append(" T.XDJL_XDSJ AS XDJL_XDSJ, ");
		sql.append(" T.XDJL_JLR AS XDJL_JLR, ");
		sql.append(" T.XDJL_BZ AS XDJL_BZ ");
		sql.append(" FROM xdjlb T ");
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(starttime)&&Validate.noNull(endtime)){
			sql.append(" AND T.XDJL_RIQI >= TO_DATE('"+starttime+"','yyyy-mm-dd hh24:mi:ss')");
			sql.append(" AND T.XDJL_RIQI <= TO_DATE('"+endtime+"23:59:59','yyyy-mm-dd hh24:mi:ss')");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			sql.append(" order by T.XDJL_RIQI desc ");
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
	
	public PageInfo findPageInfoByxdjl_RIQI(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
			sql.append(" SELECT * from (");
		    sql.append(" SELECT ");
		    sql.append(" T.XDJL_ID AS XDJL_ID, ");
			sql.append(" T.XDJL_RIQI AS XDJL_RIQI, ");
			sql.append(" T.XDJL_XDDX AS XDJL_XDDX, ");
			sql.append(" T.XDJL_SL AS XDJL_SL, ");
			sql.append(" T.XDJL_XDFF AS XDJL_XDFF, ");
			sql.append(" T.XDJL_XDSJ AS XDJL_XDSJ, ");
			sql.append(" T.XDJL_JLR AS XDJL_JLR, ");
			sql.append(" T.XDJL_BZ AS XDJL_BZ ");
			sql.append(" FROM xdjlb T ORDER BY XDJL_RIQI DESC ) ");
			sql.append(" WHERE ROWNUM<6 ");
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

	public List findTreeByxdjlb(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.XDJL_ID AS XDJL_ID, ");
		sql.append(" T.XDJL_RIQI AS XDJL_RIQI, ");
		sql.append(" T.XDJL_XDDX AS XDJL_XDDX, ");
		sql.append(" T.XDJL_SL AS XDJL_SL, ");
		sql.append(" T.XDJL_XDFF AS XDJL_XDFF, ");
		sql.append(" T.XDJL_XDSJ AS XDJL_XDSJ, ");
		sql.append(" T.XDJL_JLR AS XDJL_JLR, ");
		sql.append(" T.XDJL_BZ AS XDJL_BZ");
		sql.append(" FROM xdjlb T ");
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

	public Map findMapByXDJL_ID(String XDJL_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.XDJL_ID AS XDJL_ID, ");
		sql.append(" T.XDJL_RIQI AS XDJL_RIQI, ");
		sql.append(" T.XDJL_XDDX AS XDJL_XDDX, ");
		sql.append(" T.XDJL_SL AS XDJL_SL, ");
		sql.append(" T.XDJL_XDFF AS XDJL_XDFF, ");
		sql.append(" T.XDJL_XDSJ AS XDJL_XDSJ, ");
		sql.append(" T.XDJL_JLR AS XDJL_JLR, ");
		sql.append(" T.XDJL_BZ AS XDJL_BZ ");
		sql.append(" FROM xdjlb T ");
		sql.append(" WHERE t.XDJL_ID= '" + XDJL_ID + "' ");
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
