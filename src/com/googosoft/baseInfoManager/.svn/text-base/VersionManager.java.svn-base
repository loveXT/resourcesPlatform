package com.googosoft.baseInfoManager;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

public class VersionManager {
	public static Logger logger = Logger.getLogger(VersionManager.class.getName());
	public PageInfo findPageInfoByVersionManager(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.VERSIONNAME AS VERSIONNAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM VERSION T ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			sql.append("order by t.createtime asc ");
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
	public Map findMapByID(String ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.VERSIONNAME AS VERSIONNAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM VERSION T ");
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
	public List findListVersionManager(){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.VERSIONNAME AS VERSIONNAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM VERSION T ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" order by t.createtime ");
		List list = null;
		DBHelper dbHelper = new DBHelper();
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
