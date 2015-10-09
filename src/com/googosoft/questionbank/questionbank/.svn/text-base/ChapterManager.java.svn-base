package com.googosoft.questionbank.questionbank;

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

public class ChapterManager {
	Logger logger = Logger.getLogger(ChapterManager.class.getName());

	/**
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoBychapter(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID ");
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

	/**
	 * @param request
	 * @param COURSE_ID
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeBychapter(HttpServletRequest request ,String COURSE_ID)
			throws ManagerException {
		StringBuffer sql1 = new StringBuffer();
		sql1.append(" SELECT ");
		sql1.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql1.append(" T.CHAPTER_NAME AS CHAPTER_NAME");
		sql1.append(" FROM chapter T ");
		sql1.append(" WHERE 1 = 1 ");
		if(Validate.noNull(COURSE_ID)){
			sql1.append("AND T.COURSE_ID ='"+COURSE_ID+"'");
		}
		//StringBuffer sql2 = new StringBuffer();
		//sql2.append("select * from KNOWLEDGE_POINT K");
		//sql2.append(" LEFT JOIN CHAPTER C ON C.CHAPTER_ID = K.CHAPTER_ID ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list1 = null;
		//list2= null
		try {
			sql1.append(SaasManager.getDataSqlByInitSql("T", request));
			///sql2.append(SaasManager.getDataSqlByInitSql("K", request));
			list1 = dbHelper.queryForList(sql1.toString());
			//list2 = dbHelper.queryForList(sql2.toString());
			treeHelper.addTreeList(list1, "CHAPTER_ID", "CHAPTER_ID", "CHAPTER_NAME",null,"S");
			//treeHelper.addTreeList(list2, "POINT_ID", "CHAPTER_ID", "POINT_NAME",null,"C");
			list1 = treeHelper.getTreeList();
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (TreeException e) {
			logger.error("组装树失败\n" + e);
			throw new ManagerException("组装树失败\n" + e);
		}
		return list1;
	}

	/**
	 * @param CHAPTER_ID
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByCHAPTER_ID(String CHAPTER_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID ");
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
	 * @param CHAPTER_NAME
	 * @param COURSE_ID
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByCHAPTER_NAME(String CHAPTER_NAME,String COURSE_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID ");
		sql.append(" FROM chapter T ");
		sql.append(" WHERE replace(t.CHAPTER_NAME,chr(32),null)= '" + CHAPTER_NAME + "' ");
		if(COURSE_ID!=null){
			sql.append("AND T.COURSE_ID = '"+COURSE_ID+"'");
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
	 * @return
	 * @throws ManagerException
	 * @author csh
	 */
	public String findMaxCode(String courseId) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT MAX(T.CHAPTER_CODE) AS CHAPTER_CODE FROM CHAPTER T WHERE 1=1 ");
		sql.append(" AND T.COURSE_ID='"+courseId+"' ");
		DBHelper dbHelper=new DBHelper();
		Map map=null;
		try {
			map=dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return Validate.isNull(map.get("CHAPTER_CODE"))?"0":(String)map.get("CHAPTER_CODE");
	}
}
