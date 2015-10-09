package com.googosoft.party.partyManager;

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

public class ActivityManager {
	private Logger logger = Logger.getLogger(ActivityManager.class.getName());
	public PageInfo findPageInfoByPARTYACTIVITY(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ACTIVITYID AS ACTIVITYID, ");
		sql.append(" T.ACTIVITYCODE AS ACTIVITYCODE, ");
		sql.append(" T.ACTIVITYFZR AS ACTIVITYFZR, ");
		sql.append(" T.ACTIVITYZZDW AS ACTIVITYZZDW, ");
		sql.append(" T.ACTIVITYZZDWID AS ACTIVITYZZDWID, ");
		sql.append(" T.ACTIVITYNAME AS ACTIVITYNAME, ");
		sql.append(" T.ACTIVITYTIME AS ACTIVITYTIME, ");
		sql.append(" T.ACTIVITYDD AS ACTIVITYDD, ");
		sql.append(" T.ACTIVITYCJRS AS ACTIVITYCJRS, ");
		sql.append(" T.ACTIVITYNR AS ACTIVITYNR, ");
		sql.append(" T.ACTIVITYBZ AS ACTIVITYBZ, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM PARTYACTIVITY T ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo=null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery, request));
			sql.append(SaasManager.getDataSqlByInitSql("T",request));
			pageInfo=new PageHelper(nowPage,pageSize,sql.toString()).getPageInfo();
		}catch (QueryException e) {
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
	public List findTreeByPARTYACTIVITY(HttpServletRequest request) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ACTIVITYID AS ACTIVITYID, ");
		sql.append(" T.ACTIVITYCODE AS ACTIVITYCODE, ");
		sql.append(" T.ACTIVITYFZR AS ACTIVITYFZR, ");
		sql.append(" T.ACTIVITYZZDW AS ACTIVITYZZDW, ");
		sql.append(" T.ACTIVITYZZDWID AS ACTIVITYZZDWID, ");
		sql.append(" T.ACTIVITYNAME AS ACTIVITYNAME, ");
		sql.append(" T.ACTIVITYTIME AS ACTIVITYTIME, ");
		sql.append(" T.ACTIVITYDD AS ACTIVITYDD, ");
		sql.append(" T.ACTIVITYCJRS AS ACTIVITYCJRS, ");
		sql.append(" T.ACTIVITYNR AS ACTIVITYNR, ");
		sql.append(" T.ACTIVITYBZ AS ACTIVITYBZ, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM PARTYACTIVITY T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper=new DBHelper();
		TreeHelper treeHelper=new TreeHelper();
		List list=null;
		try {
			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list=dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "ID", "PARENTID", "NAME");
			list=treeHelper.getTreeList();
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (TreeException e) {
			logger.error("组装树失败\n" + e);
			throw new ManagerException("组装树失败\n" + e);
		}
		return list;
	}
	public Map findMapByACTIVITYID(String ACTIVITYID) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ACTIVITYID AS ACTIVITYID, ");
		sql.append(" T.ACTIVITYCODE AS ACTIVITYCODE, ");
		sql.append(" T.ACTIVITYFZR AS ACTIVITYFZR, ");
		sql.append(" T.ACTIVITYZZDW AS ACTIVITYZZDW, ");
		sql.append(" T.ACTIVITYZZDWID AS ACTIVITYZZDWID, ");
		sql.append(" T.ACTIVITYNAME AS ACTIVITYNAME, ");
		sql.append(" T.ACTIVITYTIME AS ACTIVITYTIME, ");
		sql.append(" T.ACTIVITYDD AS ACTIVITYDD, ");
		sql.append(" T.ACTIVITYCJRS AS ACTIVITYCJRS, ");
		sql.append(" T.ACTIVITYNR AS ACTIVITYNR, ");
		sql.append(" T.ACTIVITYBZ AS ACTIVITYBZ, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM PARTYACTIVITY T ");
		sql.append(" WHERE t.ACTIVITYID= '"+ACTIVITYID+"' ");
		DBHelper dbHelper=new DBHelper();
		Map map=null;
		try {
			map=dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return map;
	}
}
