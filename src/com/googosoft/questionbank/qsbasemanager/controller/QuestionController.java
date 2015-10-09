package com.googosoft.questionbank.qsbasemanager.controller;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.DBHelper;

/**
 * @author wy
 */
public class QuestionController {
	private Logger logger = Logger
			.getLogger(QuestionController.class.getName());

	/**
	 * 根据试卷ID和题型ID得到试卷题目内容list集合
	 * @param paperId
	 * @param typeId
	 * @return
	 * @throws ManagerException
	 */
	public List getListByPaperidForQuestion(String paperId,String typeId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" Q.QUESTION_CONTENT AS QUESTION_CONTENT ,");
		sql.append(" Q.QUESTION_CODE AS QUESTION_CODE ");
		sql.append(" FROM question Q");
		sql.append(" WHERE TYPE_ID ='"+typeId+"'");
		sql.append(" AND QUESTION_ID IN");
		sql.append(" ( SELECT QUESTIONID ");
		sql.append(" FROM PAPERQUESTION ");
		sql.append(" WHERE PAPERID = '"+paperId+"')");
		DBHelper dbHelper = new DBHelper();
		List list;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询题目内容失败\n" + e);
			throw new ManagerException("查寻题目内容失败\n" + e);
		}
		return list;
		
	}
	/**
	 * 通过试卷id和试题类型获取list，通过list来判断在该类型试题下是否含有试题
	 * @param paperId
	 * @param typeId
	 * @return
	 * @throws ManagerException
	 */
	public List judgeByPaperidNndTypeid(String paperId,String typeId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" Q.QUESTION_ID AS QUESTION_ID ,");
		sql.append(" Q.QUESTION_CONTENT AS QUESTION_CONTENT ,");
		sql.append(" Q.QUESTION_CODE AS QUESTION_CODE ");
		sql.append(" FROM question Q");
		sql.append(" WHERE Q.QUESTION_ID IN(");
		sql.append(" SELECT QUESTIONID");
		sql.append(" FROM PAPERQUESTION P");
		sql.append(" WHERE P.PAPERID ='"+paperId+"')");
		sql.append(" AND Q.TYPE_ID ='"+typeId+"'");
		DBHelper dbHelper = new DBHelper();
		List list;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询题目内容失败\n" + e);
			throw new ManagerException("查寻题目内容失败\n" + e);
		}
		return list;
		
	}
	
	public Map getMap(String questionId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" Q.QUESTION_ID AS QUESTION_ID ,");
		sql.append(" Q.QUESTION_CONTENT AS QUESTION_CONTENT ,");
		sql.append(" Q.QUESTION_CODE AS QUESTION_CODE, ");
		sql.append(" Q.ANSWER AS ANSWER, ");
		sql.append(" Q.QUESTION_DAJX AS QUESTION_DAJX, ");
		sql.append(" Q.QUESTION_FZXX AS QUESTION_FZXX ");
		sql.append(" FROM question Q ");
		sql.append(" WHERE Q.QUESTION_ID ='"+questionId+"'");
		DBHelper dbHelper = new DBHelper();
		Map map;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询题目内容失败\n" + e);
			throw new ManagerException("查寻题目内容失败\n" + e);
		}
		return map;
		
	}
	         
}
