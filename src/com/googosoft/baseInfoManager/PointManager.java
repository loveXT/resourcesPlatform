package com.googosoft.baseInfoManager;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

public class PointManager {
	public static Logger logger = Logger.getLogger(PointManager.class.getName());
	public PageInfo findPageInfoByPointManager(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		String id = request.getParameter("id");
		sql.append(" SELECT ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.POINT_CODE AS POINT_CODE ");
		sql.append(" FROM KNOWLEDGE_POINT T ");
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(id)){
			sql.append(" and t.CHAPTER_ID='"+id+"'");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			sql.append("order by t.createtime asc ");
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
	 * 查询该课程的章节编号最大值
	 * @param courseId
	 * @return
	 * @throws ManagerException
	 */
	public String findMaxCode(String chapterId) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT MAX(T.POINT_CODE) AS POINT_CODE FROM KNOWLEDGE_POINT T WHERE 1=1 ");
		sql.append(" AND T.CHAPTER_ID='"+chapterId+"' ");
		DBHelper dbHelper=new DBHelper();
		Map map=null;
		try {
			map=dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return Validate.isNull(map.get("POINT_CODE"))?"0":(String)map.get("POINT_CODE");
	}

public Map findMapByID(String ID) throws ManagerException {
	StringBuffer sql = new StringBuffer();
	sql.append(" SELECT ");
	sql.append(" T.POINT_ID AS POINT_ID, ");
	sql.append(" T.POINT_CODE AS POINT_CODE, ");
	sql.append(" T.POINT_NAME AS POINT_NAME, ");
	sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
	sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
	sql.append(" T.COURSE_ID AS COURSE_ID, ");
	sql.append(" T.CREATETIME AS CREATETIME, ");
	sql.append(" T.REMARK AS REMARK ");
	sql.append(" FROM KNOWLEDGE_POINT T ");
	sql.append(" WHERE t.POINT_ID= '" + ID + "' ");
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
