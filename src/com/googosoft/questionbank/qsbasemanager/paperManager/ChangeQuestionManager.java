package com.googosoft.questionbank.qsbasemanager.paperManager;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.jdbc.DBTransaction;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

public class ChangeQuestionManager {
	private Logger logger = Logger.getLogger(ChangeQuestionManager.class
			.getName());

	/**
	 * 根据条件查询试题集
	 * 
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByQUESTION(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request, String course,
			String type, String questionId, String paperId)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" Q.QUESTION_ID AS QUESTIONID, ");
		sql.append(" Q.QUESTION_CONTENT AS CONTENT ");
		sql.append(" FROM QUESTION Q ");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(course)) {
			sql.append(" AND Q.COURSE_ID = '" + course + "' ");
		}
		if (Validate.noNull(type)) {
			sql.append(" AND Q.TYPE_ID = '" + type + "' ");
		}
		if (Validate.noNull(questionId)) {
			sql.append(" AND Q.QUESTION_ID <> '" + questionId + "' ");
		}
		if (Validate.noNull(paperId)) {
			sql.append(" AND Q.QUESTION_ID NOT IN (SELECT QUESTIONID FROM PAPERQUESTION WHERE PAPERID='"
					+ paperId + "' ) ");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			pageInfo = new PageHelper(nowPage, pageSize, sql.toString())
					.getPageInfo();
		} catch (QueryException e) {
			logger.error("查询试卷试题sql错误\n" + e);
			throw new ManagerException("查询试卷试题sql错误\n" + e);
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
	 * @param QUESTION_ID
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByQUESTION_ID(String QUESTION_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COMPLEXITY AS COMPLEXITY, ");
		sql.append(" T.QUESTION_CONTENT AS QUESTION_CONTENT, ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIMIE AS CREATETIMIE, ");
		sql.append(" T.ANSWER AS ANSWER, ");
		sql.append(" T.QUESTION_FZXX AS QUESTION_FZXX, ");
		sql.append(" T.QUESTION_QFDXX AS QUESTION_QFDXX, ");
		sql.append(" T.QUESTION_DAJX AS QUESTION_DAJX, ");
		sql.append(" T.CREATE_TIME AS CREATE_TIME, ");
		sql.append(" T.QUESTION_CODE AS QUESTION_CODE ");
		sql.append(" FROM QUESTION T ");
		sql.append(" WHERE t.QUESTION_ID= '" + QUESTION_ID + "' ");
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

	public boolean moveQuestion(String thisId, String otherId, String paperId)
			throws ManagerException {
		Map thisMap = findMapByPaperQuestion(thisId, paperId);
		Map otherMap = findMapByPaperQuestion(otherId, paperId);
		String thisNum = thisMap.get("QUESTIONNUM") + "";
		String otherNum = otherMap.get("QUESTIONNUM") + "";
		StringBuffer updateThis = new StringBuffer();
		updateThis.append(" update paperquestion t ");
		updateThis.append(" set t.questionnum='" + otherNum + "' ");
		updateThis.append(" where t.paperid = '" + paperId + "' ");
		updateThis.append(" and t.questionid = '" + thisId + "' ");
		StringBuffer updateOther = new StringBuffer();
		updateOther.append(" update paperquestion t ");
		updateOther.append(" set t.questionnum='" + thisNum + "' ");
		updateOther.append(" where t.paperid = '" + paperId + "' ");
		updateOther.append(" and t.questionid = '" + otherId + "' ");
		DBTransaction transaction = DBTransaction.getInstance();
		try {
			transaction.addBatch(updateThis.toString());
			transaction.addBatch(updateOther.toString());
			transaction.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (DBException e) {
			return false;
		}
		return true;
	}

	/**
	 * @param QUESTION_ID
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByPaperQuestion(String questionId, String paperId)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.QUESTIONFRACTION AS SCORE, ");
		sql.append(" T.QUESTIONNUM AS QUESTIONNUM ");
		sql.append(" FROM PAPERQUESTION T ");
		sql.append(" WHERE 1=1 ");
		sql.append(" AND T.PAPERID = '" + paperId + "'");
		sql.append(" AND T.QUESTIONID = '" + questionId + "'");
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

	public PageInfo findQuestionInfoToAdd(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request, String course,
			String type, String paperId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" Q.QUESTION_ID AS QUESTIONID, ");
		sql.append(" Q.QUESTION_CONTENT AS CONTENT, ");
		sql.append(" Q.QUESTION_FZXX AS FZXX ");
		sql.append(" FROM QUESTION Q ");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(course)) {
			sql.append(" AND Q.COURSE_ID = '" + course + "' ");
		}
		if (Validate.noNull(type)) {
			sql.append(" AND Q.TYPE_ID = '" + type + "' ");
		}
		sql.append(" AND Q.QUESTION_ID NOT IN (SELECT T.QUESTIONID FROM PAPERQUESTION T WHERE T.PAPERID='"
				+ paperId + "') ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			pageInfo = new PageHelper(nowPage, pageSize, sql.toString())
					.getPageInfo();
		} catch (QueryException e) {
			logger.error("查询试卷试题sql错误\n" + e);
			throw new ManagerException("查询试卷试题sql错误\n" + e);
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
	 * 根据paperId将总分加上score
	 * 
	 * @param paperId
	 * @param score
	 * @return
	 */
	public boolean plusPageScoreByPaperId(String paperId, String score) {
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE PAPER T ");
		sql.append(" SET T.PAPER_SCORE = ( ");
		sql.append(" SELECT PAPER_SCORE+" + score + " FROM PAPER ");
		sql.append(" WHERE PAPER_ID = '" + paperId + "') ");
		sql.append(" WHERE T.PAPER_ID = '" + paperId + "' ");
		try {
			new DBHelper().execute(sql.toString());
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}

	/**
	 * 根据paperId和questionId查询到该题的分数 并在paper表中根据paperId将总分减去该分数
	 * 
	 * @param paperId
	 * @param score
	 * @return
	 */
	public boolean minusPageScoreByPaperId(String paperId, String questionId) {
		try {
			DBHelper db = new DBHelper();
			String[] idSet = questionId.split("','");
			String id = "";
			String score = "";
			int totalScore = 0;
			for(int i=0;i<idSet.length;i++){
				id = idSet[i].trim();
				score = this.findScore(paperId, id);
				totalScore += Integer.valueOf(score.trim());
			}
			
			StringBuffer sql = new StringBuffer();
			sql.append(" UPDATE PAPER T ");
			sql.append(" SET T.PAPER_SCORE = ( ");
			sql.append(" SELECT PAPER_SCORE-" + totalScore + " FROM PAPER ");
			sql.append(" WHERE PAPER_ID = '" + paperId + "') ");
			sql.append(" WHERE T.PAPER_ID = '" + paperId + "' ");
			db.execute(sql.toString());
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}
	
	/**
	 * 根据paperId和typeId查询该题型下最大的序号
	 * 
	 * @param paperId
	 * @param typeId
	 * @return
	 */
	public String findNumByPaperIdAndTypeId(String paperId,String typeId){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" MAX(NVL(T.QUESTIONNUM,'0')) AS NUM ");
		sql.append(" FROM PAPERQUESTION T ");
		sql.append(" WHERE T.PAPERID='"+paperId+"' ");
		sql.append(" AND T.TYPE_ID='"+typeId+"' ");
		try {
			Object obj = null;
			if(Validate.noNull(typeId)){
				Map map = new DBHelper().queryForMap(sql.toString());
				obj = map.get("NUM");
			}
			return obj==null?"0":obj.toString();
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "0";
		}
	}
	
	/**
	 * 查询试题的分数，如果paperquestion表中有数据返回该数据否则从question表中查数据
	 * 
	 * @param paperId
	 * @param questionId
	 * @return
	 * @throws DBException
	 */
	public String findScore(String paperId,String questionId) throws DBException{
		DBHelper db = new DBHelper();
		StringBuffer query = new StringBuffer();
		query.append(" SELECT ");
		query.append(" S.QUESTIONFRACTION AS SCORE ");
		query.append(" FROM PAPERQUESTION S ");
		query.append(" WHERE S.PAPERID='" + paperId + "' ");
		query.append(" AND S.QUESTIONID='" + questionId + "'");
		Map scoreMap = db.queryForMap(query.toString());
		Object obj = scoreMap.get("SCORE");
		String score = "0";
		if(Validate.isNull(obj)){
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT ");
			sb.append(" T.QUESTION_FZXX AS FZXX ");
			sb.append(" FROM QUESTION T ");
			sb.append(" WHERE T.QUESTION_ID='"+questionId+"' ");
			Object fz = db.queryForSingleValue(sb.toString());
			score = fz==null?"0":fz.toString();
		}else{
			score = obj.toString();
		}
		return score;
	}
	
	public boolean addQuestionToPaper(String ids,String paperId,String typeId){
		String[] idSet = ids.trim().split(",");
		DBTransaction db = DBTransaction.getInstance();
		String maxNum = this.findNumByPaperIdAndTypeId(paperId, typeId);
		int num = Integer.valueOf(maxNum.trim());
		String id = "";
		int totalScore = 0;
		try{
			for(int i=0;i<idSet.length;i++){
				id = idSet[i];
				String score = this.findScore(paperId, id);
				totalScore += Integer.valueOf(score.trim());
				StringBuffer sql = new StringBuffer();
				sql.append(" INSERT INTO PAPERQUESTION ");
				sql.append(" (PAPERID,QUESTIONID,QUESTIONNUM,QUESTIONFRACTION,TYPE_ID) ");
				sql.append(" VALUES ");
				sql.append(" ('"+paperId+"','"+id+"','"+(++num)+"','"+score+"','"+typeId+"') ");
				db.addBatch(sql.toString());
			}
			db.commit();
			this.plusPageScoreByPaperId(paperId, totalScore+"");
		}catch(SQLException e){
			e.printStackTrace();
		} catch (DBException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
}
