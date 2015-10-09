package com.googosoft.party.partyManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.googosoft.commons.CodeHelper;
import com.googosoft.commons.Validate;
import com.googosoft.exception.CUDException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.DBFormatException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.exception.TreeException;
import com.googosoft.ggs.homeManager.LoginManager;
import com.googosoft.ggs.saasManager.SaasManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.CUDHelper;
import com.googosoft.zapi.DBFormatHelper;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class ApplyManager {

	private Logger logger = Logger.getLogger(LoginManager.class.getName());

	/**
	 * 未打回的申请表分页
	 * 
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByAPPLY(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {

		Object loginId = request.getSession().getAttribute("USERIDBYLOGIN");
		// 从资源信息里获取链接地址的审核状态
		String state = request.getParameter("state");

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.APPLYID AS APPLYID, ");
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
		sql.append(" T.APPLYSTATE AS APPLYSTATE, ");
		sql.append(" T.STATE AS STATE, ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.TEACHERID AS TEACHERID, ");
		sql.append(" T.MEMBERID AS MEMBERID, ");
		sql.append(" T.INTRODUCER AS INTRODUCER, ");
		sql.append(" T.BACKREASON AS BACKREASON, ");
		sql.append(" T.INPARTYDATE AS INPARTYDATE, ");
		sql.append(" T.JOB AS JOB, ");
		sql.append(" T.AGE AS AGE, ");
		sql.append(" T.CHUSHENGDI AS CHUSHENGDI, ");
		sql.append(" T.FORCOMMITTEE AS FORCOMMITTEE, ");
		sql.append(" T.ISJOB AS ISJOB, ");
		sql.append(" T.ISJJFZDATE AS ISJJFZDATE, ");
		sql.append(" T.JOBDATE AS JOBDATE, ");
		sql.append(" T.CULDATE AS CULDATE, ");
		sql.append(" T.VOCATIONDATE AS VOCATIONDATE ");
		sql.append(" FROM APPLY T ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.APPLYSTATE = '0' ");
		if (Validate.noNull(loginId)) {
			//sql.append(" AND T.TEACHERID='" + loginId.toString() + "'");
		}
		if (Validate.noNull(state)) {
			sql.append(" AND T.STATE='" + state + "'");
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
	 * 查询所有申请表,包括被打回的申请表
	 * 
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByALLAPPLY(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		Object loginId = request.getSession().getAttribute("USERIDBYLOGIN");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.APPLYID AS APPLYID, ");
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
		sql.append(" T.APPLYSTATE AS APPLYSTATE, ");
		sql.append(" T.STATE AS STATE, ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.TEACHERID AS TEACHERID, ");
		sql.append(" T.MEMBERID AS MEMBERID, ");
		sql.append(" T.INTRODUCER AS INTRODUCER, ");
		sql.append(" T.BACKREASON AS BACKREASON, ");
		sql.append(" T.INPARTYDATE AS INPARTYDATE, ");
		sql.append(" T.JOB AS JOB, ");
		sql.append(" T.AGE AS AGE, ");
		sql.append(" T.CHUSHENGDI AS CHUSHENGDI, ");
		sql.append(" T.FORCOMMITTEE AS FORCOMMITTEE, ");
		sql.append(" T.ISJOB AS ISJOB, ");
		sql.append(" T.ISJJFZDATE AS ISJJFZDATE, ");
		sql.append(" T.JOBDATE AS JOBDATE, ");
		sql.append(" T.CULDATE AS CULDATE, ");
		sql.append(" T.VOCATIONDATE AS VOCATIONDATE ");
		sql.append(" FROM APPLY T ");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(loginId)) {
			//sql.append(" AND T.TEACHERID='" + loginId.toString() + "'");
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
	 * 查询打回申请表的打回原因
	 * @param APPLYID
	 * @return
	 * @throws ManagerException
	 * @throws DBFormatException
	 */
	public Map findPageInfoByApplyState(String APPLYSTATE) throws ManagerException,
			DBFormatException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.APPLYID AS APPLYID, ");
		sql.append(" T.NAME AS NAME, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.SEX AS SEX, ");
		sql.append(new DBFormatHelper().toCharByDate("T.BIRTHDAY") + " AS BIRTHDAY, ").toString();
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
		sql.append(" T.APPLYSTATE AS APPLYSTATE, ");
		sql.append(" T.STATE AS STATE, ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.TEACHERID AS TEACHERID, ");
		sql.append(" T.MEMBERID AS MEMBERID, ");
		sql.append(" T.INTRODUCER AS INTRODUCER, ");
		sql.append(" T.BACKREASON AS BACKREASON, ");
		sql.append(" T.INPARTYDATE AS INPARTYDATE, ");
		sql.append(" T.JOB AS JOB, ");
		sql.append(" T.AGE AS AGE, ");
		sql.append(" T.CHUSHENGDI AS CHUSHENGDI, ");
		sql.append(" T.FORCOMMITTEE AS FORCOMMITTEE, ");
		sql.append(" T.ISJOB AS ISJOB, ");
		sql.append(" T.ISJJFZDATE AS ISJJFZDATE, ");
		sql.append(" T.JOBDATE AS JOBDATE, ");
		sql.append(" T.CULDATE AS CULDATE, ");
		sql.append(" T.VOCATIONDATE AS VOCATIONDATE ");
		sql.append(" FROM APPLY T ");
		sql.append(" WHERE T.APPLYSTATE= '" + APPLYSTATE + "' ");
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
	
	public List findTreeByAPPLY(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.APPLYID AS APPLYID, ");
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
		sql.append(" T.APPLYSTATE AS APPLYSTATE, ");
		sql.append(" T.STATE AS STATE, ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.TEACHERID AS TEACHERID, ");
		sql.append(" T.MEMBERID AS MEMBERID, ");
		sql.append(" T.INTRODUCER AS INTRODUCER, ");
		sql.append(" T.BACKREASON AS BACKREASON, ");
		sql.append(" T.INPARTYDATE AS INPARTYDATE, ");
		sql.append(" T.JOB AS JOB, ");
		sql.append(" T.AGE AS AGE, ");
		sql.append(" T.CHUSHENGDI AS CHUSHENGDI, ");
		sql.append(" T.FORCOMMITTEE AS FORCOMMITTEE, ");
		sql.append(" T.ISJOB AS ISJOB, ");
		sql.append(" T.ISJJFZDATE AS ISJJFZDATE, ");
		sql.append(" T.JOBDATE AS JOBDATE, ");
		sql.append(" T.CULDATE AS CULDATE, ");
		sql.append(" T.VOCATIONDATE AS VOCATIONDATE ");
		sql.append(" FROM APPLY T ");
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

	/**
	 * 根据id查询
	 * 
	 * @param APPLYID
	 * @return
	 * @throws ManagerException
	 * @throws DBFormatException
	 */
	public Map findMapByAPPLYID(String APPLYID) throws ManagerException,
			DBFormatException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.APPLYID AS APPLYID, ");
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
		sql.append(" T.APPLYSTATE AS APPLYSTATE, ");
		sql.append(" T.STATE AS STATE, ");
		sql.append(" T.COMMITTEEID AS COMMITTEEID, ");
		sql.append(" T.TEACHERID AS TEACHERID, ");
		sql.append(" T.MEMBERID AS MEMBERID, ");
		sql.append(" T.INTRODUCER AS INTRODUCER, ");
		sql.append(" T.BACKREASON AS BACKREASON, ");
		sql.append(" T.INPARTYDATE AS INPARTYDATE, ");
		sql.append(" T.JOB AS JOB, ");
		sql.append(" T.AGE AS AGE, ");
		sql.append(" T.CHUSHENGDI AS CHUSHENGDI, ");
		sql.append(" T.FORCOMMITTEE AS FORCOMMITTEE, ");
		sql.append(" T.ISJOB AS ISJOB, ");
		sql.append(" T.ISJJFZDATE AS ISJJFZDATE, ");
		sql.append(" T.JOBDATE AS JOBDATE, ");
		sql.append(" T.CULDATE AS CULDATE, ");
		sql.append(" T.VOCATIONDATE AS VOCATIONDATE ");
		sql.append(" FROM APPLY T ");
		sql.append(" WHERE t.APPLYID= '" + APPLYID + "' ");
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

	/**
	 * 批量审批预备党员信息
	 * @param shenPiIds
	 * @param request
	 * @return
	 * @throws ManagerException
	 * @throws DBFormatException
	 */
	public boolean add(String shenPiIds, HttpServletRequest request)
			throws ManagerException, DBFormatException {
		HttpSession session = request.getSession();
		String[] shenPiIdsArray = shenPiIds.split(",");
		String memberId = CodeHelper.createUUID();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("OPERATETYPE", "U_C");
		Map<String,Object> applyMap = null;
		for (int i = 0; i < shenPiIdsArray.length; i++) {
			applyMap = findMapByAPPLYID(shenPiIdsArray[i]);
			// 同时更新apply表memberId
//			map.put("P_APPLY-" + i + "_APPLYID_S_WU", shenPiIdsArray[i]);
//			map.put("P_APPLY-" + i + "_MEMBERID_S_S", memberId);
//			map.put("P_APPLY-" + i + "_STATE_S_S", 4);
			// 更新党员信息表(member)
			map.put("P_MEMBER-" + i + "_MEMBERID_S_P", memberId);
			map.put("P_MEMBER-" + i + "_POLITICAL_S_C", 2);
			map.put("P_MEMBER-" + i + "_MARK_S_C", 1);
			map.put("P_MEMBER-" + i + "_JOB_S_C", 0);
			map.put("P_MEMBER-" + i + "_COMMITTEEID_S_C", applyMap.get("COMMITTEEID"));
			map.put("P_MEMBER-" + i + "_TEACHERID_S_C", session.getAttribute("USERIDBYLOGIN"));
			map.put("P_MEMBER-" + i + "_SAAS_S_C", session.getAttribute("SAAS"));
			map.put("P_MEMBER-" + i + "_USERIDBYLOGIN_S_C", applyMap.get("USERIDBYLOGIN"));
			map.put("P_MEMBER-" + i + "_CREATETIME_D_C", null);
			map.put("P_MEMBER-" + i + "_REMARK_S_C", applyMap.get("REMARK"));
			map.put("P_MEMBER-" + i + "_NAME_S_C", applyMap.get("NAME"));
			map.put("P_MEMBER-" + i + "_SEX_S_C", applyMap.get("SEX"));
			map.put("P_MEMBER-" + i + "_BIRTHDAY_S_C", applyMap.get("BIRTHDAY"));
			map.put("P_MEMBER-" + i + "_CARDID_S_C", applyMap.get("CARDID"));
			map.put("P_MEMBER-" + i + "_PICTURE_S_C", applyMap.get("PICTURE"));
			map.put("P_MEMBER-" + i + "_NATION_S_C", applyMap.get("NATION"));
			map.put("P_MEMBER-" + i + "_VOCATION_S_C", applyMap.get("VOCATION"));
			map.put("P_MEMBER-" + i + "_CULTURE_S_C", applyMap.get("CULTURE"));
			map.put("P_MEMBER-" + i + "_TEL_S_C", applyMap.get("TEL"));
			map.put("P_MEMBER-" + i + "_NATIVEPLACE_S_C", applyMap.get("NATIVEPLACE"));
			map.put("P_MEMBER-" + i + "_ADDRESS_S_C", applyMap.get("ADDRESS"));
			map.put("P_MEMBER-" + i + "_INTRODUCER_S_C", applyMap.get("INTRODUCER"));
			map.put("P_MEMBER-" + i + "_JOB_S_C", applyMap.get("JOB"));
			map.put("P_MEMBER-" + i + "_AGE_S_C", applyMap.get("AGE"));
			map.put("P_MEMBER-" + i + "_CHUSHENGDI_S_C", applyMap.get("CHUSHENGDI"));
			map.put("P_MEMBER-" + i + "_FORCOMMITTEE_S_C", applyMap.get("FORCOMMITTEE"));
			map.put("P_MEMBER-" + i + "_ISJOB_S_C", applyMap.get("ISJOB"));
			map.put("P_MEMBER-" + i + "_ISJJFZDATE_S_C", applyMap.get("ISJJFZDATE"));
			map.put("P_MEMBER-" + i + "_JOBDATE_S_C", applyMap.get("JOBDATE"));
			map.put("P_MEMBER-" + i + "_CULDATE_S_C", applyMap.get("CULDATE"));
			map.put("P_MEMBER-" + i + "_VOCATIONDATE_S_C", applyMap.get("VOCATIONDATE"));
			map.put("P_MEMBER-" + i + "_INPARTYDATE_D_C", null);
		}
		try {
			return new CUDHelper(map, "_", "-").execute();
		} catch (CUDException e) {
			logger.error("审批党员失败" + e);
			throw new ManagerException("审批党员失败" + e);
		}
	}

}
