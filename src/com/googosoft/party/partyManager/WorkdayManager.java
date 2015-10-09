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

public class WorkdayManager {
	Logger logger = Logger.getLogger(WorkdayManager.class.getName());
	public PageInfo findPageInfoByWORKDAY(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.WORKDAYID AS WORKDAYID, ");
		sql.append(" T.WORKDAYNAME AS WORKDAYNAME, ");
		sql.append(" T.WORKDAYDD AS WORKDAYDD, ");
		sql.append(" to_char(T.STARTTIIME,'yyyy-MM-dd hh24:mi:ss') AS STARTTIIME, ");
		sql.append(" to_char(T.ENDTIME,'yyyy-MM-dd hh24:mi:ss') AS ENDTIME, ");
		sql.append(" T.WORKDAYFZR AS WORKDAYFZR, ");
		sql.append(" T.CONTENT AS CONTENT, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.WORKLEVEL AS WORKLEVEL ");
		sql.append(" FROM WORKDAY T ");
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
	public List findTreeByWORKDAY(HttpServletRequest request) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.WORKDAYID AS WORKDAYID, ");
		sql.append(" T.WORKDAYNAME AS WORKDAYNAME, ");
		sql.append(" T.WORKDAYDD AS WORKDAYDD, ");
		sql.append(" T.STARTTIIME AS STARTTIIME, ");
		sql.append(" T.ENDTIME AS ENDTIME, ");
		sql.append(" T.WORKDAYFZR AS WORKDAYFZR, ");
		sql.append(" T.CONTENT AS CONTENT, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.WORKLEVEL AS WORKLEVEL ");
		sql.append(" FROM WORKDAY T ");
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
	public Map findMapByWORKDAYID(String WORKDAYID) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.WORKDAYID AS WORKDAYID, ");
		sql.append(" T.WORKDAYNAME AS WORKDAYNAME, ");
		sql.append(" T.WORKDAYDD AS WORKDAYDD, ");
		sql.append(" to_char(T.STARTTIIME,'yyyy-MM-dd hh24:mi:ss') AS STARTTIIME, ");
		sql.append(" to_char(T.ENDTIME,'yyyy-MM-dd hh24:mi:ss') AS ENDTIME, ");
		sql.append(" T.WORKDAYFZR AS WORKDAYFZR, ");
		sql.append(" T.CONTENT AS CONTENT, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.WORKLEVEL AS WORKLEVEL ");
		sql.append(" FROM WORKDAY T ");
		sql.append(" WHERE t.WORKDAYID= '"+WORKDAYID+"' ");
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
