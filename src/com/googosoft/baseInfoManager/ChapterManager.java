package com.googosoft.baseInfoManager;

import java.util.List;
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

public class ChapterManager {
	public static Logger logger = Logger.getLogger(ChapterManager.class.getName());
	public PageInfo findPageInfoByChapterManager(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		String id = request.getParameter("id");
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_CODE AS CHAPTER_CODE, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM CHAPTER T ");
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(id)){
			sql.append(" and t.course_id='"+id+"'");
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
	public Map findMapByID(String ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_CODE AS CHAPTER_CODE, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM CHAPTER T ");
		sql.append(" WHERE t.CHAPTER_ID= '" + ID + "' ");
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
	public List findListChapterManager(){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CHAPTER_CODE AS CHAPTER_CODE, ");
		sql.append(" T.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.CHAPTER_CONTENT AS CHAPTER_CONTENT, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM CHAPTER T ");
		sql.append(" WHERE 1=1 ");
		sql.append(" order by t.createtime ");
		List list = null;
		DBHelper dbHelper = new DBHelper();
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 查询该课程的章节编号最大值
	 * @param courseId
	 * @return
	 * @throws ManagerException
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

