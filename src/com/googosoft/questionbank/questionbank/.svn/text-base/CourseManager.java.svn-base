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

public class CourseManager {
	Logger logger = Logger.getLogger(CourseManager.class.getName());

	public PageInfo findPageInfoBycourse(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME");
		sql.append(" FROM course T ");
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

	public List findTreeBycourse(HttpServletRequest request,String MAJOR_ID)
			throws ManagerException {
		StringBuffer sql1 = new StringBuffer();
		sql1.append(" SELECT ");
		sql1.append(" T.COURSE_ID AS COURSE_ID, ");
		sql1.append(" T.COURSE_NAME AS COURSE_NAME");
		sql1.append(" FROM course T ");
		sql1.append(" WHERE 1 = 1 ");
		if(Validate.noNull(MAJOR_ID)){
			sql1.append(" AND T.COURSE_ID IN (SELECT COURSE_ID FROM COURSE_MAJOR WHERE MAJOR_ID = '"+MAJOR_ID+"'　)");
		}
		StringBuffer sql2 = new StringBuffer();
		sql2.append(" SELECT ");
		sql2.append(" K.CHAPTER_ID AS CHAPTER_ID, ");
		sql2.append(" K.CHAPTER_NAME AS CHAPTER_NAME,");
		sql2.append(" K.COURSE_ID AS COURSE_ID");
		sql2.append(" FROM chapter K ");
		sql2.append(" LEFT JOIN COURSE C ON C.COURSE_ID = K.COURSE_ID ");
		StringBuffer sql3 = new StringBuffer();
		sql3.append("select * from KNOWLEDGE_POINT K");
		sql3.append(" LEFT JOIN CHAPTER C ON C.CHAPTER_ID = K.CHAPTER_ID ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list1 = null;
		List list2 = null;
		List list3 = null;
		try {
			//sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list1 = dbHelper.queryForList(sql1.toString());
			list2 = dbHelper.queryForList(sql2.toString());
			list3 = dbHelper.queryForList(sql3.toString());
			treeHelper.addTreeList(list1, "COURSE_ID", "COURSE_ID", "COURSE_NAME",null,"S");
			treeHelper.addTreeList(list2, "CHAPTER_ID", "COURSE_ID", "CHAPTER_NAME",null,"C");
			treeHelper.addTreeList(list3, "POINT_ID", "CHAPTER_ID", "POINT_NAME",null,"U");
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
	
	public List findfileTreeBycourse(HttpServletRequest request,String MAJOR_ID)
			throws ManagerException {
		StringBuffer sql1 = new StringBuffer();
		//课程
		sql1.append(" SELECT ");
		sql1.append(" T.COURSE_ID AS COURSE_ID, ");
		sql1.append(" T.COURSE_NAME AS COURSE_NAME");
		sql1.append(" FROM course T ");
		sql1.append(" WHERE 1 = 1 ");
		if(Validate.noNull(MAJOR_ID)){
			sql1.append(" AND T.COURSE_ID IN (SELECT COURSE_ID FROM COURSE_MAJOR WHERE MAJOR_ID = '"+MAJOR_ID+"'　)");
		}
		StringBuffer sql2 = new StringBuffer();
		//章节
		sql2.append(" SELECT ");
		sql2.append(" K.CHAPTER_ID AS CHAPTER_ID, ");
		sql2.append(" K.CHAPTER_NAME AS CHAPTER_NAME,");
		sql2.append(" K.COURSE_ID AS COURSE_ID");
		sql2.append(" FROM chapter K ");
		sql2.append(" LEFT JOIN COURSE C ON C.COURSE_ID = K.COURSE_ID ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list1 = null;
		List list2 = null;
		try {
			//sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list1 = dbHelper.queryForList(sql1.toString());
			list2 = dbHelper.queryForList(sql2.toString());
			treeHelper.addTreeList(list1, "COURSE_ID", "COURSE_ID", "COURSE_NAME",null,"S");
			treeHelper.addTreeList(list2, "CHAPTER_ID", "COURSE_ID", "CHAPTER_NAME",null,"C");
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
	public Map findMapByCOURSE_ID(String COURSE_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME");
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
	public Map findMapByCOURSE_NAME(String COURSE_NAME,String MAJOR_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.COURSE_NAME AS COURSE_NAME");
		sql.append(" FROM course T ");
		sql.append(" WHERE t.COURSE_NAME= '" + COURSE_NAME + "' ");
		if(MAJOR_ID!=null){
			sql.append("AND T.COURSE_ID IN (SELECT COURSE_ID FROM COURSE_MAJOR WHERE MAJOR_ID='"+MAJOR_ID+"')");
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
	
	public Map findMapMAJOR_ID(String COURSE_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT *");
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
	/**
	 * @return
	 * @throws ManagerException
	 * @author csh
	 */
	public String findMaxCode(String majorId) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT MAX(T.COURSE_CODE) AS COURSE_CODE ");
		sql.append(" FROM COURSE T ");
		sql.append(" LEFT JOIN COURSE_MAJOR CM ON T.COURSE_ID=CM.COURSE_ID ");
		sql.append(" WHERE 1=1 ");
		if(Validate.noNull(majorId)){
			sql.append(" AND CM.MAJOR_ID='"+majorId+"' ");
		}else{
			sql.append(" AND CM.MAJOR_ID IS NULL ");
		}
		DBHelper dbHelper=new DBHelper();
		Map map=null;
		try {
			map=dbHelper.queryForMap(sql.toString());
		} catch (DBException e){
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return Validate.isNull(map.get("COURSE_CODE"))?"1":(String)map.get("COURSE_CODE");
	}
}
