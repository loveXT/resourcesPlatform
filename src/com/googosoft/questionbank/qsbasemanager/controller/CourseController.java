package com.googosoft.questionbank.qsbasemanager.controller;

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

public class CourseController {

	private Logger logger = Logger.getLogger(TypeController.class.getName());

	public PageInfo findPageInfoBycourse(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.COURSE_TYPE AS COURSE_TYPE,");
		sql.append(" T.COURSE_CODE AS COURSE_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM course T ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
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
	 * 通过专业ID查找
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoById(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request,String mid)
	throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.COURSE_TYPE AS COURSE_TYPE,");
		sql.append(" T.COURSE_CODE AS COURSE_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM course T ");
		sql.append(" WHERE ");
		sql.append(" COURSE_ID in (");
		sql.append(" SELECT ");
		sql.append(" COURSE_ID ");
		sql.append(" from course_major ");
		sql.append(" where ");
		sql.append(" MAJOR_ID = '"+mid+"'");
		sql.append(" OR MAJOR_ID IS NULL )");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
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

	public List findTreeBycourse(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.COURSE_TYPE AS COURSE_TYPE,");
		sql.append(" T.COURSE_CODE AS COURSE_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM course T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
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

	public Map findMapByCOURSE_ID(String COURSE_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.COURSE_TYPE AS COURSE_TYPE,");
		sql.append(" T.COURSE_CODE AS COURSE_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM course T ");
		sql.append(" WHERE t.COURSE_ID= '" + COURSE_ID + "' ");
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
	public Map findMapByMajor_ID(String COURSE_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID ");
		sql.append(" FROM COURSE_MAJOR T ");
		sql.append(" WHERE t.COURSE_ID= '" + COURSE_ID + "' ");
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
	public PageInfo findPageInfoBycourseIDS(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request, List ids)
			throws ManagerException {
		String major_Id = request.getParameter("MId");
		String course_name = request.getParameter("COURSE_NAME");
		String course_type = request.getParameter("COURSE_TYPE");
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < ids.size(); i++) {
			sb.append("','" + ids.get(i));
		}
		String str_ids = sb.toString().substring(3, sb.toString().length());
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.COURSE_TYPE AS COURSE_TYPE,");
		sql.append(" T.COURSE_CODE AS COURSE_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" CM.MAJOR_ID AS MAJOR_ID ");
		sql.append(" FROM course T ");
		sql.append(" LEFT JOIN COURSE_MAJOR CM ON T.COURSE_ID=CM.COURSE_ID ");
		sql.append(" WHERE T.COURSE_ID IN ('" + str_ids + "')");
		if("00".equals(course_type)){
			sql.append(" AND T.COURSE_TYPE LIKE '%公共基础课%' ");
		}
		if("11".equals(course_type)){
			sql.append(" AND T.COURSE_TYPE LIKE '%专业课%' ");
		}
		if(Validate.noNull(major_Id)){
			sql.append(" AND CM.MAJOR_ID LIKE '%"+major_Id+"%' ");
		}
		if(Validate.noNull(course_name)){
			sql.append(" AND T.COURSE_NAME LIKE '%"+course_name+"%' ");
		}
		sql.append(" ORDER BY CM.MAJOR_ID,T.COURSE_CODE ");
		System.out.println("WWWWWWWWWWWWWWWW+"+sql.toString());
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
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
	 * 查询所有的公共基础课
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @param ids
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoBycourseIdForCommon(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
	throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM course T ");
		sql.append(" WHERE COURSE_TYPE ='公共基础课' ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
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
	 * 当为选择专业时，查询所有的专业课
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findListBycourse(HttpServletRequest request)
			throws ManagerException {
		String type = "专业课";
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM course T ");
		sql.append(" WHERE COURSE_TYPE ='"+type+"' ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	/**
	 * 查询所有的公共基础课
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findListBycourseForCommon(HttpServletRequest request)
	throws ManagerException {
		String type = "公共基础课";
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" T.ISPUBLIC AS ISPUBLIC, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM course T ");
		sql.append(" WHERE COURSE_TYPE ='"+type+"' ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}

	public boolean checkChapter(String CourseId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID ");
		sql.append(" FROM CHAPTER T ");
		sql.append(" WHERE t.COURSE_ID= '" + CourseId + "'");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			List list1 = dbHelper.queryForList(sql.toString());
			if (list1.size() == 0) {
				return true;
			} else {
				return false;
			}
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
	}

}
