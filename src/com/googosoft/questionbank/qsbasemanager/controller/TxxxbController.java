package com.googosoft.questionbank.qsbasemanager.controller;
import java.util.HashMap;
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
/**
 * 试题类型   
 * @author ZWH
 *
 */
public class TxxxbController {

	private Logger logger = Logger.getLogger(TxxxbController.class.getName());

	public PageInfo findPageInfoByQUESTION_TXXXB(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TXXXB_ID AS TXXXB_ID, ");
		sql.append(" T.TXXXB_MC AS TXXXB_MC, ");
		sql.append(" T.TXXXB_SSZB AS TXXXB_SSZB, ");
		sql.append(" T.TXXXB_BXXGS AS TXXXB_BXXGS, ");
		sql.append(" T.TXXXB_ZQDAGS AS TXXXB_ZQDAGS, ");
		sql.append(" T.TXXXB_DAZN AS TXXXB_DAZN, ");
		sql.append(" T.TXXXB_BZ AS TXXXB_BZ,");
		sql.append(" T.TXXXB_JBTXID AS TXXXB_JBTXID");
		sql.append(" FROM QUESTION_TXXXB T ");
		sql.append(" WHERE 1 = 1 order by T.txxxb_id ");
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

	public List findTreeByQUESTION_TXXXB(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TXXXB_ID AS TXXXB_ID, ");
		sql.append(" T.TXXXB_MC AS TXXXB_MC, ");
		sql.append(" T.TXXXB_SSZB AS TXXXB_SSZB, ");
		sql.append(" T.TXXXB_BXXGS AS TXXXB_BXXGS, ");
		sql.append(" T.TXXXB_ZQDAGS AS TXXXB_ZQDAGS, ");
		sql.append(" T.TXXXB_DAZN AS TXXXB_DAZN, ");
		sql.append(" T.TXXXB_BZ AS TXXXB_BZ,");
		sql.append(" T.TXXXB_JBTXID AS TXXXB_JBTXID");
		sql.append(" FROM QUESTION_TXXXB T ");
		sql.append(" WHERE 1 = 1  order by T.txxxb_id ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
//			sql.append(SaasManager.getDataSqlByInitSql("T", request));
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
	
	
	public List findAllQuestionType()
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TXXXB_ID AS TXXXB_ID, ");
		sql.append(" T.TXXXB_MC AS TXXXB_MC, ");
		sql.append(" T.TXXXB_SSZB AS TXXXB_SSZB, ");
		sql.append(" T.TXXXB_BXXGS AS TXXXB_BXXGS, ");
		sql.append(" T.TXXXB_ZQDAGS AS TXXXB_ZQDAGS, ");
		sql.append(" T.TXXXB_DAZN AS TXXXB_DAZN, ");
		sql.append(" T.TXXXB_BZ AS TXXXB_BZ,");
		sql.append(" T.TXXXB_JBTXID AS TXXXB_JBTXID");
		sql.append(" FROM QUESTION_TXXXB T ");
		sql.append(" WHERE 1 = 1  order by T.txxxb_id ");
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
	 * 一套题中特定题型的数量
	 * @param paperId
	 * @param typeId
	 * @return
	 * @throws ManagerException
	 */
	public int getTypeNum(String paperId,String typeName)
	throws ManagerException {
		int num = 0;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT  ");
		sql.append(" COUNT(*) ");
		sql.append(" FROM paperquestion ");
		sql.append(" WHERE PAPERID = '"+paperId+"'");
		sql.append(" AND TYPE_ID = ( ");
		sql.append(" SELECT ");
		sql.append(" TXXXB_ID ");
		sql.append(" FROM QUESTION_TXXXB ");
		sql.append(" WHERE ");
		sql.append("  TXXXB_MC = '"+typeName+"')");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			num = Integer.parseInt(dbHelper.queryForSingleValue(sql.toString()).toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} 
		return num;
	}
	/**
	 * 获得特定题型的分数和数目
	 * @param paperId
	 * @param typeId
	 * @return
	 * @throws ManagerException
	 */
	public String[] getTypeScoreAndNum(String paperId,String typeId)
	throws ManagerException {
		boolean flag = false;
		String typeScore;
		int whichOne = 0;
		String[] typeScores;
		String[] typeScoress;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" COURSECONSUBJECT ");
		sql.append(" FROM PAPERCONDITION ");
		sql.append(" WHERE CONDITIONID = ( ");
		sql.append(" SELECT ");
		sql.append(" PAPERCONDITIONID ");
		sql.append(" FROM PAPER ");
		sql.append(" WHERE PAPER_ID = '"+paperId+"')");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
			typeScore = Validate.isNullToDefault(map.get("COURSECONSUBJECT"),"").toString();
			typeScores = typeScore.split(",");
			for (int i = 0; i < typeScores.length; i++) {
				flag = typeScores[i].contains(typeId);
				if(flag==true){
					whichOne = i;
					break;
				}
			}
			typeScoress = typeScores[whichOne].split("_");
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} 
		return typeScoress;
	}
	
	public Map findAllQuestionTypeById(String id)
	throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TXXXB_ID AS TXXXB_ID, ");
		sql.append(" T.TXXXB_MC AS TXXXB_MC, ");
		sql.append(" T.TXXXB_SSZB AS TXXXB_SSZB, ");
		sql.append(" T.TXXXB_BXXGS AS TXXXB_BXXGS, ");
		sql.append(" T.TXXXB_ZQDAGS AS TXXXB_ZQDAGS, ");
		sql.append(" T.TXXXB_DAZN AS TXXXB_DAZN, ");
		sql.append(" T.TXXXB_BZ AS TXXXB_BZ,");
		sql.append(" T.TXXXB_JBTXID AS TXXXB_JBTXID");
		sql.append(" FROM QUESTION_TXXXB T ");
		sql.append(" WHERE TXXXB_ID ='"+id+"' ");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
//			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} 
		return map;
	}

	public Map findMapByTXXXB_ID(String TXXXB_ID) throws ManagerException {
		if(Validate.isNull(TXXXB_ID)){
			return new HashMap();
		}
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TXXXB_ID AS TXXXB_ID, ");
		sql.append(" T.TXXXB_MC AS TXXXB_MC, ");
		sql.append(" T.TXXXB_SSZB AS TXXXB_SSZB, ");
		sql.append(" T.TXXXB_BXXGS AS TXXXB_BXXGS, ");
		sql.append(" T.TXXXB_ZQDAGS AS TXXXB_ZQDAGS, ");
		sql.append(" T.TXXXB_DAZN AS TXXXB_DAZN, ");
		sql.append(" T.TXXXB_BZ AS TXXXB_BZ,");
		sql.append(" T.TXXXB_JBTXID AS TXXXB_JBTXID");
		sql.append(" FROM QUESTION_TXXXB T ");
		sql.append(" WHERE t.TXXXB_ID= '" + TXXXB_ID + "' ");
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
	public Map findMapByTXXXB_MC(String TXXXB_MC) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TXXXB_ID AS TXXXB_ID, ");
		sql.append(" T.TXXXB_MC AS TXXXB_MC ");
		sql.append(" FROM QUESTION_TXXXB T ");
		sql.append(" WHERE t.TXXXB_MC= '" + TXXXB_MC + "' ");
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
	public List findByTx(String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TXXXB_ID AS TXXXB_ID, ");
		sql.append(" T.TXXXB_MC AS TXXXB_MC, ");
		sql.append(" T.TXXXB_SSZB AS TXXXB_SSZB, ");
		sql.append(" T.TXXXB_BXXGS AS TXXXB_BXXGS, ");
		sql.append(" T.TXXXB_ZQDAGS AS TXXXB_ZQDAGS, ");
		sql.append(" T.TXXXB_DAZN AS TXXXB_DAZN, ");
		sql.append(" T.TXXXB_JBTXID AS TXXXB_JBTXID");
		sql.append(" FROM QUESTION_TXXXB T ");
		sql.append(" WHERE 1 = 1  order by T.txxxb_id ");
		List list;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
//			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list =new DBHelper().queryForList(sql.toString());
			} catch (QueryException e) {
			logger.error("组装查询语句where条件的and语句失败\n" + e);
			throw new ManagerException("组装查询语句where条件的and语句失败\n" + e);
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
}
