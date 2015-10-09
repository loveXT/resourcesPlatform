package com.googosoft.ggs.dataManager.normCode;

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

public class NormCodeTypeManager {
	private Logger logger = Logger.getLogger(NormCodeTypeManager.class.getName());

	public PageInfo findPageInfoByNORMCODETYPE(int nowPage, int pageSize,
			String splitByQuery, String normCodeParentId,HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.DMLXMC AS DMLXMC, ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.PARENTID AS PARENTID, ");
		sql.append(" T.DMLXBM AS DMLXBM");
		sql.append(" FROM NORMCODETYPE T ");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(normCodeParentId)) {
			sql.append(" and t.PARENTID != t.ID ");
			sql.append(" and t.PARENTID = '");
			sql.append(normCodeParentId);
			sql.append("' ");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery, request));
			sql.append(" ORDER BY  DMLXBM");
			pageInfo = new PageHelper(nowPage, pageSize, sql.toString())
					.getPageInfo();
		}catch (DBException e) {
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

	public List findTreeByNormcodeType()
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.DMLXMC AS DMLXMC, ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.PARENTID AS PARENTID, ");
		sql.append(" T.DMLXBM AS DMLXBM ");
		sql.append(" FROM NORMCODETYPE T ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" ORDER BY  DMLXBM");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "ID", "PARENTID", "DMLXMC","DMLXBM","T");
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
		sql.append(" T.DMLXMC AS DMLXMC, ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.PARENTID AS PARENTID, ");
		sql.append(" T.DMLXBM AS DMLXBM");
		sql.append(" FROM NORMCODETYPE T ");
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
