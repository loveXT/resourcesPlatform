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

public class HonourBranchManager {

	private Logger logger = Logger.getLogger(LoginManager.class.getName());
	
	public PageInfo findPageInfoByHONOURBRANCH(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request) throws ManagerException {
		
		//获取左侧树的id，根据id不同显示不同的人员信息
		String committeeId = request.getParameter("committeeId");
		
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.HONOURID AS HONOURID, ");
		sql.append(" T.HONOURTIME AS HONOURTIME, ");
		sql.append(" T.DEED AS DEED, ");
		sql.append(" T.PICTURE AS PICTURE, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.JCDY AS JCDY, ");
		sql.append(" T.JCMC AS JCMC, ");
		sql.append(" T.PZRQ AS PZRQ, ");
		sql.append(" T.PZJG AS PZJG ");
		sql.append(" FROM HONOURBRANCH T ");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(committeeId)) {
			sql.append(" AND T.COMMITTEEID='"+committeeId+"' ");
		}
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
	public List findTreeByHONOURBRANCH(HttpServletRequest request) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.HONOURID AS HONOURID, ");
		sql.append(" T.HONOURTIME AS HONOURTIME, ");
		sql.append(" T.DEED AS DEED, ");
		sql.append(" T.PICTURE AS PICTURE, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.JCDY AS JCDY, ");
		sql.append(" T.JCMC AS JCMC, ");
		sql.append(" T.PZRQ AS PZRQ, ");
		sql.append(" T.PZJG AS PZJG ");
		sql.append(" FROM HONOURBRANCH T ");
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
	public Map findMapByHONOURID(String HONOURID) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.HONOURID AS HONOURID, ");
		sql.append(" T.HONOURTIME AS HONOURTIME, ");
		sql.append(" T.DEED AS DEED, ");
		sql.append(" T.PICTURE AS PICTURE, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.JCDY AS JCDY, ");
		sql.append(" T.JCMC AS JCMC, ");
		sql.append(" T.PZRQ AS PZRQ, ");
		sql.append(" T.PZJG AS PZJG ");
		sql.append(" FROM HONOURBRANCH T ");
		sql.append(" WHERE t.HONOURID= '"+HONOURID+"' ");
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
