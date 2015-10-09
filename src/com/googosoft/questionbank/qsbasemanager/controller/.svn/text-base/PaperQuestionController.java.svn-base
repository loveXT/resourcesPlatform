package com.googosoft.questionbank.qsbasemanager.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import com.googosoft.commons.Validate;
import com.googosoft.exception.CUDException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.exception.TreeException;
import com.googosoft.ggs.saasManager.SaasManager;
import com.googosoft.jdbc.DBTransaction;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.CUDHelper;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class PaperQuestionController {

	private Logger logger = Logger.getLogger(PaperQuestionController.class
			.getName());

	public PageInfo findPageInfoByPAPER_QUESTION(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ITEM_ID AS ITEM_ID, ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.ANSWER AS ANSWER, ");
		sql.append(" T.TYPE_ID AS TYPE_ID ");
		sql.append(" FROM PAPER_QUESTION T ");
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
	
	public List findAnswerType_id(String Parper_id,String Type_id)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ITEM_ID AS ITEM_ID, ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.ANSWER AS ANSWER, ");
		sql.append(" T.TYPE_ID AS TYPE_ID ");
		sql.append(" FROM PAPER_QUESTION T ");
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(Parper_id)){			
			sql.append(" AND T.PAPER_ID = '"+Parper_id+"'");
		}
		if(Validate.noNull(Type_id)){			
			sql.append(" AND T.TYPE_ID = '"+Type_id+"'");
		}
		sql.append("order by item_id");
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
	
	public List findTreeByPAPER_QUESTION(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ITEM_ID AS ITEM_ID, ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.ANSWER AS ANSWER, ");
		sql.append(" T.TYPE_ID AS TYPE_ID ");
		sql.append(" FROM PAPER_QUESTION T ");
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

	public Map findMapByITEM_ID(String ITEM_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ITEM_ID AS ITEM_ID, ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.ANSWER AS ANSWER, ");
		sql.append(" T.TYPE_ID AS TYPE_ID ");
		sql.append(" FROM PAPER_QUESTION T ");
		sql.append(" WHERE t.ITEM_ID= '" + ITEM_ID + "' ");
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
	 * 获取需要修改试题编号和分值的试题集合
	 * @param paperId
	 * @param questionIds
	 * @return
	 * @throws ManagerException
	 */
	public List findListByQuestionId(String paperId,String questionIds) throws ManagerException {
		questionIds = questionIds.replace(",", "','");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PAPERID AS PAPERID, ");
		sql.append(" T.QUESTIONID AS QUESTIONID, ");
		sql.append(" T.QUESTIONFRACTION AS QUESTIONFRACTION, ");
		sql.append(" T.QUESTIONNUM AS QUESTIONNUM, ");
		sql.append(" T.TYPE_ID AS TYPE_ID ");
		sql.append(" FROM PAPERQUESTION T ");
		sql.append(" WHERE t.QUESTIONID in ('" + questionIds + "') ");
		sql.append(" AND t.PAPERID= '" + paperId + "' ");
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
	public List findListByPaper_ID(String PAPER_ID,String TYPE_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ITEM_ID AS ITEM_ID, ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.ANSWER AS ANSWER, ");
		sql.append(" T.TYPE_ID AS TYPE_ID ");
		sql.append(" FROM PAPER_QUESTION T ");
		sql.append(" WHERE t.PAPER_ID= '" + PAPER_ID + "' ");
		sql.append(" AND t.TYPE_ID= '" + TYPE_ID + "' ");
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
	 * 获得当前试卷所有的试题信息集合(TEST1)
	 * @param paperId
	 * @return
	 * @throws ManagerException
	 */
	public List findListByPaperId(String paperId)
	throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ITEM_ID AS ITEM_ID, ");
		sql.append(" T.PAPER_ID AS PAPER_ID, ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.ANSWER AS ANSWER, ");
		sql.append(" T.TYPE_ID AS TYPE_ID ");
		sql.append(" FROM PAPER_QUESTION T ");
		sql.append(" WHERE T.PAPER_ID = '"+paperId+"'");
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
	 * 修改试题分值
	 * @param paperId
	 * @param questionId
	 * @param sumScore
	 * @param beforeScore
	 * @param afterScore
	 * @return
	 * @throws ManagerException
	 * @throws DBException
	 * @throws SQLException
	 */
	public boolean updateScore(String paperId,String questionId,String sumScore,String beforeScore,String afterScore)
	throws ManagerException,SQLException {
		Boolean bool = false;
		Integer ss = Integer.parseInt(sumScore.trim());
		String[] beforeScores = beforeScore.split(",");
		String[] afterScores = afterScore.split(",");
		String[] questionIds = questionId.split(",");
		String singleScoresql = "";
		Integer bs;
		Integer as;
		DBHelper helper = new DBHelper();
		try {
			for (int i = 0; i < questionIds.length; i++) {
				singleScoresql = "UPDATE PAPERQUESTION SET QUESTIONFRACTION = '"+afterScores[i].trim()+"' WHERE QUESTIONID='"+questionIds[i].trim()+"'";
				helper.execute(singleScoresql);
			}
			for (int i = 0; i < afterScores.length; i++) {
				bs = Integer.parseInt(beforeScores[i].trim());
				as = Integer.parseInt(afterScores[i].trim());
				ss =ss + as -bs;
			}
			sumScore = String.valueOf(ss);
			String sumScoreSql = "UPDATE PAPER  SET PAPER_SCORE = '"+sumScore+"' WHERE  PAPER_ID ='"+paperId+"'";
			helper.execute(sumScoreSql);
			bool = true;
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bool;
	}
	/**
	 * 修改试题的编号
	 * @param paperId
	 * @param questionId
	 * @param beforeNum
	 * @param afterNum
	 * @return
	 * @throws ManagerException
	 * @throws SQLException
	 */
	public boolean updateNum(String paperId,String questionId,String beforeNum,String afterNum)
	throws ManagerException, SQLException {
		Boolean bool = false;
		String[] beforeNums = beforeNum.split(",");
		String[] afterNums = afterNum.split(",");
		String[] questionIds = questionId.split(",");
		String sql = "";
		DBHelper helper = new DBHelper();
		for (int i = 0; i < questionIds.length; i++) {
			sql = "update paperquestion set QUESTIONNUM = '"+afterNums[i].trim()+"' where questionid='"+questionIds[i].trim()+"'";
			try {
				helper.execute(sql);
				bool = true;
			} catch (DBException e) {
				logger.error("查询数据库失败\n" + e);
				throw new ManagerException("查询数据库失败\n" + e);
			}
		}
		return bool;
	}
	 /**
	  * 修改试题编号和分数
	 * @param paperId
	 * @param questionId
	 * @param afterNum
	 * @param beforeScore
	 * @param afterScore
	 * @param sumScore
	 * @return
	 * @throws ManagerException
	 * @throws SQLException
	 */
	public boolean updateScoreAndNum(String paperId,String questionId,String afterNum,String beforeScore,String afterScore,String sumScore)
	 throws ManagerException, SQLException {
		 Boolean bool = false;
		 Integer ss = Integer.parseInt(sumScore.trim());
		 String[] afterNums = afterNum.split(",");
		 String[] questionIds = questionId.split(",");
		 String[] beforeScores = beforeScore.split(",");
		 String[] afterScores = afterScore.split(",");
		 Integer bs;
		 Integer as;
		 String sql = "";
		 DBTransaction transaction = DBTransaction.getInstance();
		 DBHelper helper = new DBHelper();
			Map cudMap = new HashMap();
			cudMap.put("OPERATETYPE", "U");
				 for (int i = 1; i < questionIds.length; i++) {
					 cudMap.put("P=paperquestion-"+i+"=QUESTIONNUM=S=S", afterNums[i].trim());
					 cudMap.put("P=paperquestion-"+i+"=QUESTIONFRACTION=S=S", afterScores [i].trim());
					 cudMap.put("P=paperquestion-"+i+"=PAPERID=S=WU",paperId);
					 cudMap.put("P=paperquestion-"+i+"=QUESTIONID=S=WU", questionIds[i].trim());
				 }
				 for (int j = 1; j < afterScores.length; j++) {
						bs = Integer.parseInt(beforeScores[j].trim());
						as = Integer.parseInt(afterScores[j].trim());
						ss =ss + as -bs;
					}
					sumScore = String.valueOf(ss);
					 cudMap.put("P=PAPER-"+(questionIds.length)+"=PAPER_ID=S=WU",paperId);
					 cudMap.put("P=PAPER-"+(questionIds.length)+"=PAPER_SCORE=S=S",sumScore);
					 try {
						new CUDHelper(cudMap, "=", "-").execute();
						bool = true;
					} catch (CUDException e) {
						logger.error("修改试题分数和编号失败\n"+e);
						throw new ManagerException(e);
					}
		 return bool;
	 }
}
