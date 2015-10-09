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
import com.googosoft.ggs.saasManager.SaasManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class ChapterController {

	private Logger logger = Logger.getLogger(TypeController.class.getName());

	public PageInfo findPageInfoBychapter(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CHAPTER_CODE AS CHAPTER_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM chapter T ");
		sql.append(" WHERE 1 = 1 ");
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

	public List findTreeBychapter(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CHAPTER_CODE AS CHAPTER_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM chapter T ");
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

	public Map findPageInfoByChapterIds(String CHAPTER_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CHAPTER_CODE AS CHAPTER_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM chapter T ");
		sql.append(" WHERE t.CHAPTER_ID= '" + CHAPTER_ID + "' ");
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
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @param cid
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByCHAPTER_ID(String chapterIds) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CHAPTER_CODE AS CHAPTER_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM chapter T ");
		sql.append(" WHERE CHAPTER_ID ='"+chapterIds+"'");
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

	public PageInfo findPageInfoByCId(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request, String cid)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		String chapter_name = request.getParameter("CHAPTER_NAME");
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CHAPTER_CODE AS CHAPTER_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM chapter T ");
		sql.append(" WHERE COURSE_ID ='" + cid + "'");
		if (Validate.noNull(chapter_name)) {
			sql.append(" AND CHAPTER_NAME LIKE '%" + chapter_name + "%' ");
		}
		sql.append(" ORDER BY T.CHAPTER_CODE");
		PageInfo pageInfo = null;
		try {
			
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
//			sql.append(SaasManager.getDataSqlByInitSql("T", request));
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
	 * 查询章节信息
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfo(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
	throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CHAPTER_CODE AS CHAPTER_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM chapter T ");
		sql.append(" WHERE 1 = 1");
		sql.append(" ORDER BY T.CHAPTER_CODE");
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
	 * 无分页查询章节信息
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findList()throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CHAPTER_CODE AS CHAPTER_CODE,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM chapter T ");
		sql.append(" WHERE 1 = 1");
		sql.append(" ORDER BY T.CHAPTER_CODE");
		DBHelper helper = new DBHelper();
		List list;
		try {
			list = helper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}

	public boolean checkChapter(String ChapterId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.POINT_ID AS POINT_ID ");
		sql.append(" FROM KNOWLEDGE_POINT T ");
		sql.append(" WHERE t.CHAPTER_ID= '" + ChapterId + "'");
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
	
	
	/**
	 * 获取问题数目
	 * @param chapterId
	 * @return
	 * @throws ManagerException
	 */
	public String getQuestionByChaperIdsForQuestionNum(String chapterId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from question where ");
		sql.append(" CHAPTER_ID ='"+chapterId+"'");
		DBHelper dbHelper = new DBHelper();
		try {
			return String.valueOf(dbHelper.queryForSingleValue(sql.toString()).toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
	}
	/**
	 * 获取分值总和
	 * @param chapterId
	 * @return
	 * @throws ManagerException
	 */
	public String getQuestionByChaperIdsForQuestionSum(String chapterId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" select sum(QUESTION_FZXX) from question where ");
		sql.append(" CHAPTER_ID ='"+chapterId+"'");
		DBHelper dbHelper = new DBHelper();
		try {
			Object sum = dbHelper.queryForSingleValue(sql.toString());
			return Validate.isNullToDefault(sum, "0").toString();
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
	}
	
	
}
