package com.googosoft.questionbank.qsbasemanager.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.DBFormatException;
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

public class PaperController {

	private Logger logger = Logger.getLogger(PaperController.class.getName());

	public PageInfo findPapersPageInfo(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" P.CONDITIONID AS CONDITIONID, ");
		sql.append(" P.CONDITIONTITLE AS CONDITIONTITLE, ");
		sql.append(" P.CONDITIONTIME AS CONDITIONTIME, ");
		sql.append(" P.CONDITIONSCORE AS CONDITIONSCORE, ");
		sql.append(" P.CONDITIONNUMBER AS CONDITIONNUMBER, ");
		sql.append(" C.COURSE_NAME as COURSE_NAME");
		sql.append(" FROM PAPERCONDITION P  ");
		sql.append(" LEFT JOIN COURSE C ON C.COURSE_ID = CONDITIONCOURSE ");
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
	 * 查询组卷内容
	 * 
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByPAPERCombination(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.PAPER_TITLE AS PAPER_TITLE, ");
		sql.append(" T.PAPER_TIME AS PAPER_TIME, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.PAPER_SCORE AS PAPER_SCORE, ");
		sql.append(" T.PAPER_STATUS AS PAPER_STATUS, ");
		sql.append(" C_P.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" CH.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" CO.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" Q_T.TYPE_ID AS TYPE_ID, ");
		sql.append(" Q_T.QUESTION_AMOUNT AS QUESTION_AMOUNT, ");
		sql.append(" Q_T.QUESTION_SCORE AS QUESTION_SCORE, ");
		sql.append(" TY.TYPE_NAME AS TYPE_NAME, ");

		sql.append(" M.MAJOR_NAME AS MAJOR_NAME ");

		// sql.append(" C.QUESTION_AMOUNT AS QUESTION_AMOUNT ");

		sql.append(" FROM PAPER T ");
		sql.append(" LEFT JOIN CHAPTER_POINT C_P ON C_P.PAPER_ID = T.PAPER_ID ");
		sql.append(" LEFT JOIN CHAPTER CH ON CH.CHAPTER_ID = C_P.CHAPTER_ID ");
		sql.append(" LEFT JOIN COURSE CO ON CO.COURSE_ID = CH.COURSE_ID ");

		sql.append(" LEFT JOIN QUESTION_TYPE Q_T ON Q_T.PAPER_ID = T.PAPER_ID ");
		sql.append(" LEFT JOIN TYPE TY ON TY.TYPE_ID = Q_T.TYPE_ID ");

		sql.append(" LEFT JOIN Major M ON M.MAJOR_ID = T.MAJOR_ID ");

		// sql.append(" LEFT JOIN COMPLEXITY C ON C.PAPER_ID = T.PAPER_ID ");

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
	 * 查询试卷内容
	 * 
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByPAPERAndMajor_id(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request, String Major_id,
			String Course_id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.PAPER_TITLE AS PAPER_TITLE, ");
		sql.append(" T.PAPER_TIME AS PAPER_TIME, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" CO.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" M.MAJOR_NAME AS MAJOR_NAME, ");
		sql.append(" T.PAPER_SCORE AS PAPER_SCORE");
		sql.append(" FROM PAPER T ");
		sql.append(" LEFT JOIN COURSE CO ON CO.COURSE_ID = T.COURSE_ID ");
		sql.append(" LEFT JOIN MAJOR M ON M.MAJOR_ID = T.MAJOR_ID ");
		sql.append(" WHERE 1=1 ");
		//sql.append(" WHERE 1 = 1 AND T.ISSUCCESS=1 ");
		if (Validate.noNull(Major_id)) {
			sql.append(" AND T.MAJOR_ID ='" + Major_id + "' ");
		}
		if (Validate.noNull(Course_id)) {
			sql.append(" AND T.COURSE_ID ='" + Course_id + "' ");
		}
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
	 * 查询试卷内容
	 * 
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByPAPER(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.PAPER_TITLE AS PAPER_TITLE, ");
		sql.append(" T.PAPER_TIME AS PAPER_TIME, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" CO.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" M.MAJOR_NAME AS MAJOR_NAME, ");
		sql.append(" T.PAPER_SCORE AS PAPER_SCORE");
		sql.append(" FROM PAPER T ");
		sql.append(" LEFT JOIN COURSE CO ON CO.COURSE_ID = T.COURSE_ID ");
		sql.append(" LEFT JOIN MAJOR M ON M.MAJOR_ID = T.MAJOR_ID ");
		sql.append(" WHERE 1 = 1 ");
		
		//sql.append(" WHERE 1 = 1 AND T.ISSUCCESS=1 ");
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

	public List findTreeByPAPER(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.PAPER_TITLE AS PAPER_TITLE, ");
		sql.append(" T.PAPER_TIME AS PAPER_TIME, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.PAPER_SCORE AS PAPER_SCORE ");
		sql.append(" T.ROWNUM AS ROWNUM ");
		sql.append(" FROM PAPER T ");
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

	public Map findMapByPAPER_ID(String PAPER_ID) throws ManagerException,
			DBFormatException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.PAPER_TITLE AS PAPER_TITLE, ");
		sql.append(" T.PAPER_TIME AS PAPER_TIME, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.PAPER_SCORE AS PAPER_SCORE, ");
		sql.append(" CO.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" M.MAJOR_NAME AS MAJOR_NAME ");
		sql.append(" FROM PAPER T ");
		sql.append(" LEFT JOIN COURSE CO ON CO.COURSE_ID = T.COURSE_ID ");
		sql.append(" LEFT JOIN MAJOR M ON M.MAJOR_ID = T.MAJOR_ID ");
		sql.append(" WHERE t.PAPER_ID= '" + PAPER_ID + "'");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询试卷失败\n" + e);
			throw new ManagerException("查询试卷失败\n" + e);
		}
		return map;
	}

	public Map findMapCS(String PAPER_ID,String TYPE_ID) throws ManagerException,
			DBFormatException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT  COUNT(ITEM_ID) AS CS ");
		sql.append(" FROM paper_question T ");
		if(Validate.noNull(PAPER_ID)){
			sql.append(" WHERE t.PAPER_ID= '" + PAPER_ID +"'" );
		}
		if(Validate.noNull(TYPE_ID)){
			sql.append(" AND t.TYPE_ID= '" + TYPE_ID +"'");
		}else{
			sql.append(" AND t.TYPE_ID='20130802'");
		}
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
	 * 打印试卷所要用的list
	 * @param paperId
	 * @return
	 * @throws ManagerException
	 */
	public List findPaperList(String paperId) throws ManagerException{
		StringBuffer sql = new StringBuffer();
		sql.append(" select ");
		sql.append(" p.paper_id as paper_id , ");
		sql.append(" p.paperconditionid as paperconditionid, ");
		sql.append(" pq.questionid as questionid, ");
		sql.append(" p.createtime as createtime, ");
		sql.append(" p.paper_title as paper_title, ");
		sql.append(" p.major_id as major_id, ");
		sql.append(" p.course_id as course_id, ");
		sql.append(" p.paper_time as paper_time, ");
		sql.append(" p.paper_score as paper_score, ");
		sql.append(" p.paper_score as paper_score, ");
		sql.append(" qt.txxxb_mc as txxxb_mc, ");
		sql.append(" qt.txxxb_dazn as txxxb_dazn, ");
		sql.append(" q.question_content as question_content, ");
		sql.append(" qx.option1 as option1, ");
		sql.append(" qx.option2 as option2, ");
		sql.append(" qx.option3 as option3, ");
		sql.append(" qx.option4 as option4, ");
		sql.append(" q.answer as answer, ");
		sql.append(" pq.questionfraction as questionfraction, ");
		sql.append(" pq.questionnum as questionnum ");
		sql.append(" from paper p ");
		sql.append(" left join papercondition pd ");
		sql.append(" on p.paperconditionid = pd.conditionid ");
		sql.append(" left join paperquestion pq ");
		sql.append(" on p.paper_id = pq.paperid ");
		sql.append(" left join question q ");
		sql.append(" on pq.questionid = q.question_id ");
		sql.append(" left join question_xzxxb qx ");
		sql.append(" on pq.questionid = qx.question_id ");
		sql.append(" left join question_txxxb qt ");
		sql.append(" on pq.type_id = qt.txxxb_id ");
		sql.append(" where p.paper_id = '"+paperId+"'");
		DBHelper helper = new DBHelper();
		List list = null;
		try {
			list = helper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	
	/**
	 * 获取试卷的题型个数并返回数组
	 * @param paperId
	 * @return
	 * @throws ManagerException
	 */
	public List getTypeNum(String paperId) throws ManagerException{
		String[] types = null;
		String type ;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" qt.TXXXB_MC ");
		sql.append(" FROM PAPER P ");
		sql.append(" LEFT JOIN paperquestion PQ ON ");
		sql.append(" p.PAPER_ID = pq.PAPERID  ");
		sql.append(" LEFT JOIN QUESTION_TXXXB QT ON ");
		sql.append(" pq.TYPE_ID = qt.TXXXB_ID ");
		sql.append(" WHERE ");
		sql.append(" p.PAPER_ID = '"+paperId+"'");
		List list = null ;
		DBHelper helper = new DBHelper();
		try {
			list = helper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
}
