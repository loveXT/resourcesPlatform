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

public class MemberManager {

	private Logger logger = Logger.getLogger(LoginManager.class.getName());

	/**
	 * 分页
	 * 
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByMEMBER(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		// 获取左侧树的id，根据id不同显示不同的人员信息
		String committeeId = request.getParameter("committeeId");

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TEACHERID AS TEACHERID, ");
		sql.append(" C.XM AS XM, ");
		sql.append(" C.UMDEPARTMENTNAME AS UMDEPARTMENTNAME, ");
		sql.append(" C.LXDH AS LXDH, ");
		sql.append(" C.XBM AS XBM, ");
		sql.append(" C.CSRQ AS CSRQ ");
		sql.append(" FROM MEMBERCOMMITTEEMIDDLE T ");
		sql.append(" LEFT JOIN TEACHERINFO C ON T.TEACHERID=C.GID ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.COMMITTEEID='" + committeeId + "' ");
		// if (Validate.noNull(committeeId)) {
		// }
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			// sql.append(SaasManager.getDataSqlByInitSql("T",request));
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
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByTEACHERINFO(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		// 查询没有分配党支部的教师信息

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.GID AS GID, ");
		sql.append(" T.XM AS XM, ");
		sql.append(" T.UMDEPARTMENTNAME AS UMDEPARTMENTNAME, ");
		sql.append(" T.LXDH AS LXDH, ");
		sql.append(" T.XBM AS XBM, ");
		sql.append(" T.CSRQ AS CSRQ ");
		sql.append(" FROM TEACHERINFO T ");
		sql.append(" WHERE NOT EXISTS (SELECT TEACHERID FROM MEMBERCOMMITTEEMIDDLE WHERE TEACHERID=T.GID)");
		sql.append(" AND T.ZZMM='01'");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			// sql.append(SaasManager.getDataSqlByInitSql("T",request));
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

	public List findTreeByMEMBER(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.MEMBERID AS MEMBERID, ");
		sql.append(" T.NAME AS NAME, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.SEX AS SEX, ");
		sql.append(" T.BIRTHDAY AS BIRTHDAY, ");
		sql.append(" T.CARDID AS CARDID, ");
		sql.append(" T.PICTURE AS PICTURE, ");
		sql.append(" T.NATION AS NATION, ");
		sql.append(" T.VOCATION AS VOCATION, ");
		sql.append(" T.POLITICAL AS POLITICAL, ");
		sql.append(" T.CULTURE AS CULTURE, ");
		sql.append(" T.EMAIL AS EMAIL, ");
		sql.append(" T.MOBILE AS MOBILE, ");
		sql.append(" T.TEL AS TEL, ");
		sql.append(" T.NATIVEPLACE AS NATIVEPLACE, ");
		sql.append(" T.ADDRESS AS ADDRESS, ");
		sql.append(" T.INTRODUCER AS INTRODUCER, ");
		sql.append(" T.INPARTYDATE AS INPARTYDATE, ");
		sql.append(" T.JOB AS JOB, ");
		sql.append(" T.OUTPARTYDATE AS OUTPARTYDATE, ");
		sql.append(" T.MARK AS MARK, ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.TEACHERID AS TEACHERID, ");
		sql.append(" T.AGE AS AGE, ");
		sql.append(" T.CHUSHENGDI AS CHUSHENGDI, ");
		sql.append(" T.FORCOMMITTEE AS FORCOMMITTEE, ");
		sql.append(" T.ISJOB AS ISJOB, ");
		sql.append(" T.ISJJFZDATE AS ISJJFZDATE, ");
		sql.append(" T.JOBDATE AS JOBDATE, ");
		sql.append(" T.CULDATE AS CULDATE, ");
		sql.append(" T.VOCATIONDATE AS VOCATIONDATE ");
		sql.append(" FROM MEMBER T ");
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

	public Map findMapByMEMBERID(String MEMBERID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.MEMBERID AS MEMBERID, ");
		sql.append(" T.NAME AS NAME, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.SEX AS SEX, ");
		sql.append(" T.BIRTHDAY AS BIRTHDAY, ");
		sql.append(" T.CARDID AS CARDID, ");
		sql.append(" T.PICTURE AS PICTURE, ");
		sql.append(" T.NATION AS NATION, ");
		sql.append(" T.VOCATION AS VOCATION, ");
		sql.append(" T.POLITICAL AS POLITICAL, ");
		sql.append(" T.CULTURE AS CULTURE, ");
		sql.append(" T.EMAIL AS EMAIL, ");
		sql.append(" T.MOBILE AS MOBILE, ");
		sql.append(" T.TEL AS TEL, ");
		sql.append(" T.NATIVEPLACE AS NATIVEPLACE, ");
		sql.append(" T.ADDRESS AS ADDRESS, ");
		sql.append(" T.INTRODUCER AS INTRODUCER, ");
		sql.append(" T.INPARTYDATE AS INPARTYDATE, ");
		sql.append(" T.JOB AS JOB, ");
		sql.append(" T.OUTPARTYDATE AS OUTPARTYDATE, ");
		sql.append(" T.MARK AS MARK, ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.TEACHERID AS TEACHERID, ");
		sql.append(" T.AGE AS AGE, ");
		sql.append(" T.CHUSHENGDI AS CHUSHENGDI, ");
		sql.append(" T.FORCOMMITTEE AS FORCOMMITTEE, ");
		sql.append(" T.ISJOB AS ISJOB, ");
		sql.append(" T.ISJJFZDATE AS ISJJFZDATE, ");
		sql.append(" T.JOBDATE AS JOBDATE, ");
		sql.append(" T.CULDATE AS CULDATE, ");
		sql.append(" T.VOCATIONDATE AS VOCATIONDATE ");
		sql.append(" FROM MEMBER T ");
		sql.append(" WHERE t.MEMBERID= '" + MEMBERID + "' ");
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
