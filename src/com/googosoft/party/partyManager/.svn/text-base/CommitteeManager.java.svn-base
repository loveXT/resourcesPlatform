package com.googosoft.party.partyManager;

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
import com.googosoft.ggs.homeManager.LoginManager;
import com.googosoft.ggs.saasManager.SaasManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class CommitteeManager {

	private Logger logger = Logger.getLogger(LoginManager.class.getName());

	/**
	 * 查询分页
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByCOMMITTEE(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException{
		//获取左侧树的id，根据id不同显示不同的组织信息
		String committeeId = request.getParameter("committeeId");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.COMMITTEENAME AS COMMITTEENAME, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.ORGPARENTID AS ORGPARENTID, ");
		sql.append(" T.DZZJLRQ AS DZZJLRQ, ");
		sql.append(" T.DZZDZ AS DZZDZ, ");
		sql.append(" T.DZZFZR AS DZZFZR, ");
		sql.append(" T.DZZYZBM AS DZZYZBM, ");
		sql.append(" T.DZZLXDH AS DZZLXDH, ");
		sql.append(" T.DZZCHZ AS DZZCHZ, ");
		sql.append(" F.COMMITTEENAME AS NAME ");
		sql.append(" FROM COMMITTEE T ");
		sql.append(" LEFT JOIN COMMITTEE F ON T.ORGPARENTID=F.COMMITTEEID ");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(committeeId)) {
			sql.append(" AND T.COMMITTEEID != T.ORGPARENTID ");
			sql.append(" AND T.ORGPARENTID='"+committeeId+"' ");
		}else{
			sql.append(" AND T.COMMITTEEID = T.ORGPARENTID ");
		}
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

	/**
	 * 查询并操作组织树
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeByCOMMITTEE(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.COMMITTEENAME AS COMMITTEENAME, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.ORGPARENTID AS ORGPARENTID, ");
		sql.append(" T.DZZJLRQ AS DZZJLRQ, ");
		sql.append(" T.DZZDZ AS DZZDZ, ");
		sql.append(" T.DZZFZR AS DZZFZR, ");
		sql.append(" T.DZZYZBM AS DZZYZBM, ");
		sql.append(" T.DZZLXDH AS DZZLXDH, ");
		sql.append(" T.DZZCHZ AS DZZCHZ ");
		sql.append(" FROM COMMITTEE T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "COMMITTEEID", "ORGPARENTID","COMMITTEENAME");
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
	
	/**
	 * 查询组织名称
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findListByCOMMITTEE(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.COMMITTEENAME AS COMMITTEENAME, ");
		sql.append(" T.ORGPARENTID AS ORGPARENTID ");
		sql.append(" FROM COMMITTEE T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}

	/**
	 * 查询主键id
	 * @param COMMITTEEID
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByCOMMITTEEID(String COMMITTEEID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.COMMITTEENAME AS COMMITTEENAME, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.ORGPARENTID AS ORGPARENTID, ");
		sql.append(" T.DZZJLRQ AS DZZJLRQ, ");
		sql.append(" T.DZZDZ AS DZZDZ, ");
		sql.append(" T.DZZFZR AS DZZFZR, ");
		sql.append(" T.DZZYZBM AS DZZYZBM, ");
		sql.append(" T.DZZLXDH AS DZZLXDH, ");
		sql.append(" T.DZZCHZ AS DZZCHZ, ");
		sql.append(" F.COMMITTEENAME AS NAME ");
		sql.append(" FROM COMMITTEE T ");
		sql.append(" LEFT JOIN COMMITTEE F ON T.ORGPARENTID=F.COMMITTEEID ");
		sql.append(" WHERE t.COMMITTEEID= '" + COMMITTEEID + "' ");
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
