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

public class PointManager {
	Logger logger = Logger.getLogger(PointManager.class.getName());

	/*public PageInfo findPageInfoByknowledge_point(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID ");
		sql.append(" FROM knowledge_point T ");
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

	public List findTreeByknowledge_point(HttpServletRequest request,String CHAPTER_ID,String COURSE_ID)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID ");
		sql.append(" FROM knowledge_point T ");
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(CHAPTER_ID)){
			sql.append(" AND T.CHAPTER_ID IN ('"+CHAPTER_ID.replaceAll(",", "','")+"')");
		}
		if(Validate.noNull(COURSE_ID)){
			sql.append(" AND T.COURSE_ID = '"+COURSE_ID+"'");
		}
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "POINT_ID", "POINT_ID", "POINT_NAME",null,"S");
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
	
	public List findTreeByknowledge_pointForCom(HttpServletRequest request,
			String CHAPTER_ID, String COURSE_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID||T.POINT_ID AS POINT_ID, ");
		sql.append(" T.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID ");
		sql.append(" FROM knowledge_point T ");
		sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(CHAPTER_ID)) {
			sql.append(" AND T.CHAPTER_ID IN ('"
					+ CHAPTER_ID.replaceAll(",", "','") + "')");
		}
		if (Validate.noNull(COURSE_ID)) {
			sql.append(" AND T.COURSE_ID = '" + COURSE_ID + "'");
		}
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "POINT_ID", "POINT_ID", "POINT_NAME",
					null, "S");
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
*/
	public Map findMapByPOINT_ID(String POINT_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID ");
		sql.append(" FROM knowledge_point T ");
		sql.append(" WHERE t.POINT_ID= '" + POINT_ID + "' ");
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
/*	
	public Map findMapByPOINT_NAME(String POINT_NAME,String COURSE_ID,String CHAPTER_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID ");
		sql.append(" FROM knowledge_point T ");
		sql.append(" WHERE t.POINT_NAME= '" + POINT_NAME + "' ");
		if(COURSE_ID!=null){
			sql.append("AND T.COURSE_ID ='"+COURSE_ID+"'");
		}
		if(CHAPTER_ID!=null){
			sql.append("AND T.CHAPTER_ID ='"+CHAPTER_ID+"'");
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
	*/
	public List findPointByChapterId(String chapterId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" C.POINT_ID AS POINT_ID, ");
		sql.append(" C.POINT_NAME AS POINT_NAME, ");
		sql.append(" C.CHAPTER_ID AS CHAPTER_ID ");
		sql.append(" FROM KNOWLEDGE_POINT C ");
		if(Validate.noNull(chapterId)){
			sql.append(" WHERE C.CHAPTER_ID='"+chapterId+"' ");
		}
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

}
