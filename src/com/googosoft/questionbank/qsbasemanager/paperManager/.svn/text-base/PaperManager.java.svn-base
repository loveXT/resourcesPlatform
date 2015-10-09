package com.googosoft.questionbank.qsbasemanager.paperManager;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

/**
 * 类描述：试卷试题管理类
 * 
 * @since 1.5
 * @version 1.0
 * @author xin_ql
 * @author 2013-9-18上午03:15:16
 */
public class PaperManager {
	private Logger logger = Logger.getLogger(PaperManager.class.getName());

	/**根据paperId查询试题
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 * @throws DBFormatException 
	 */
	public PageInfo findMapByPaperID(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)throws ManagerException, DBFormatException{
		String paperId = Validate.isNullToDefault(request.getParameter("Pid"), "").toString();
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PAPERID AS PAPERID,");
		sql.append(" T.QUESTIONID AS QUESTIONID, ");
		sql.append(" T.QUESTIONNUM AS QUESTIONNUM, ");

		//lzzbegin
		sql.append(" Q.POINT_ID AS POINTID_ID, ");
		sql.append(" Q.QUESTION_FZXX AS FZXX, ");
		//lzzend

		sql.append(" T.QUESTIONFRACTION AS QUESTIONFRACTION, ");

		sql.append(" Q.TYPE_ID AS TYPE_ID, ");
		sql.append(" Q.COMPLEXITY AS COMPLEXITY, ");
		sql.append(" Q.QUESTION_QFDXX AS QUESTION_QFDXX, ");
		sql.append(" Q.QUESTION_CONTENT AS QUESTION_CONTENT, ");
		sql.append(" Q.ANSWER AS ANSWER, ");
		sql.append(" Q.QUESTION_DAJX AS QUESTION_DAJX, ");
		sql.append(" QX.OPTION1 as OPTION1, ");
		sql.append(" K.POINT_NAME AS POINT_NAME");
		sql.append(" FROM PAPERQUESTION T ");
		sql.append(" LEFT JOIN QUESTION Q ON T.QUESTIONID = Q.QUESTION_ID ");
		sql.append(" LEFT JOIN KNOWLEDGE_POINT K ON  Q.POINT_ID = K.POINT_ID");
		sql.append(" LEFT JOIN QUESTION_XZXXB QX ON  Q.QUESTION_ID = QX.QUESTION_ID");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(paperId)) {
			sql.append(" AND T.PAPERID = '" + paperId + "' ");
		}
		sql.append(" ORDER BY Q.TYPE_ID, to_number(T.QUESTIONNUM) ");
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
	/**获取去掉p标签的内容
	 * @param map：对象map
	 * @param columnName：字段名称
	 * @return：字段内容
	 */
	public String removeRemark(Map map,String columnName){
		String columnContent = Validate.isNullToDefault(map.get(columnName),"").toString().trim();
		columnContent = columnContent.replace("<p>", "");
		columnContent = columnContent.replace("</p>", "");
		return columnContent;
	}
	/**获取试卷各种试题类型的信息
	 * @param paperId：试卷id
	 * @throws ManagerException
	 */
	public Map findConditionInfo(String paperId)throws ManagerException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" t.PAPER_TIME as PAPER_TIME, ");
		sql.append(" t.PAPER_SCORE as PAPER_SCORE, ");
		sql.append(" t.PAPER_SCORE as PAPER_SCORE, ");
		sql.append(" t.COURSECONSUBJECT as COURSECONSUBJECT ");
		sql.append(" FROM PAPER T ");
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(paperId)){
			sql.append(" AND T.PAPER_ID = '"+paperId+"' ");
		}
		DBHelper dbHelper = new DBHelper();
		try {
			return dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
	}
	/**根据试卷获取各类型题的题数和总分
	 * @param paperId：试卷id
	 * @return
	 * @throws ManagerException
	 */
	public List findQuestionInfoByType(String paperId)throws ManagerException{
		List list = new ArrayList();
		Map conditionMap = findConditionInfo(paperId);
		String typeAndScore = Validate.isNullToDefault(conditionMap.get("COURSECONSUBJECT"),"").toString().trim();
		String[] arr1 = typeAndScore.split(",");
		Map typeMap = null;
		int score ;
		int num ;
		for(int i = 0;i<arr1.length;i++){
			String[] arr2 = arr1[i].split("_");
			if(!"0".equals(arr2[arr2.length-1])){
				typeMap = new HashMap();
				typeMap.put("typeId", arr2[0]);
				score = Integer.parseInt(arr2[1]);
				num = Integer.parseInt(arr2[2]);
				typeMap.put("score", score);
				typeMap.put("num", num);
				typeMap.put("singleScore", score/num);
				list.add(typeMap);
			}
		}
		return list;
	}
	
	/**
	 * 根据试卷查询试卷中所有题型并按规则排序(liuzizhong)
	 * 
	 * @param paperId
	 * @return
	 * @throws ManagerException
	 * @throws DBFormatException
	 */
	public List findPaperTxxx(String paperId)
			throws ManagerException, DBFormatException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT DISTINCT (CC.TXID) AS TXID, ");
		sql.append(" CC.TXMC AS TXMC FROM( ");
		sql.append(" SELECT ");
		sql.append(" T.TYPE_ID AS TXID,");
		sql.append(" Q.TXXXB_MC AS TXMC ");
		sql.append(" FROM PAPERQUESTION T ");
		sql.append(" LEFT JOIN QUESTION_TXXXB Q ON T.TYPE_ID = Q.TXXXB_ID ");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(paperId)) {
			sql.append(" AND T.PAPERID = '" + paperId + "')CC ");
		}
		sql.append(" ORDER BY CASE CC.TXMC when '单选题(四选一)' then 1 when '单选题(五选一)' then 2 when '多选题(四选多)' then 3 when '多选题(五选多)' then 4 when '判断题' then 5 when '填空题' then 6 when '问答题' then 7 else 8 end ");
		List list = null;
		try {
			list = new DBHelper().queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} 
		return list;
	}
	
	public Map findScoreMapByPaperIdAndTypeId(String paperId,String typeId) throws ManagerException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" SUM(NVL(T.QUESTIONFRACTION,0)) AS SUMSCORE, ");
		sql.append(" COUNT(*) AS QUESTIONNUM ");
		sql.append(" FROM PAPERQUESTION T ");
		sql.append(" WHERE T.PAPERID= '" + paperId + "' ");
		sql.append(" AND T.TYPE_ID='"+typeId+"' ");
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
	 * 根据paperId和txId查询该题型下的所有试题并按题号排序(liuzizhong)
	 * 
	 * @param paperId
	 * @param txId
	 * @return
	 * @throws ManagerException
	 * @throws DBFormatException
	 */
	public List findQuestionListByTxxx(String paperId,String txId)
			throws ManagerException, DBFormatException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.QUESTIONID AS QUESTIONID, ");
		sql.append(" T.QUESTIONNUM AS QUESTIONNUM ");
		sql.append(" FROM PAPERQUESTION T ");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(paperId)) {
			sql.append(" AND T.PAPERID = '" + paperId + "' ");
		}
		if(Validate.noNull(txId)){
			sql.append(" AND T.TYPE_ID = '" + txId +"' ");
		}
		sql.append(" ORDER BY to_number(T.QUESTIONNUM) ");
		List list = null;
		try {
			list = new DBHelper().queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} 
		return list;
	}
	
	
	
	/**
	 * 将在线考试答案存入数据库
	 * @return
	 * @throws ManagerException 
	 */
	public boolean setOnlinePaperAnswer(String paperid,String userloginid,String questionId,String answers) throws ManagerException{
		boolean flag = false;
		String[] questionids = questionId.split(",");
		String[] onlineAnswers = answers.split(",");
		String sql ;
		DBHelper helper = new DBHelper();
			try {
				for (int i = 0; i < questionids.length; i++) {
					
					sql = ("INSERT INTO EXAMANSWER (PAPERID,USERLOGINID,QUESTIONID,ANSWER) VALUES('"+paperid+"','"+userloginid+"','"+questionids[i]+"','"+onlineAnswers[i]+"')");
					helper.execute(sql.toString());
				}
			} catch (DBException e) {
				logger.error("插入数据失败\n" + e);
				throw new ManagerException("插入数据失败\n" + e);
			} catch (SQLException e) {
				logger.error("执行失败\n" + e);
				throw new ManagerException("执行失败\n" + e);
			}
		
		
		return flag;
	} 
	public Map findMapByPAPER_ID(String PAPER_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID ");
		sql.append(" FROM PAPER T ");
		sql.append(" WHERE t.PAPER_ID= '" + PAPER_ID + "' ");
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
