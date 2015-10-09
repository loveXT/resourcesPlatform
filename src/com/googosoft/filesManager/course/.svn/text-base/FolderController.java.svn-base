package com.googosoft.filesManager.course;

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

public class FolderController {
	
	private Logger logger = Logger.getLogger(FolderController.class.getName());



	
	
	public Map findMapByCharperId(String CharperId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" CP.CHAPTER_NAME AS CHAPTER_NAME,");//章节
		sql.append(" CP.CHAPTER_ID AS CHAPTER_ID, ");
		
		sql.append(" M.MAJOR_ID AS MAJOR_ID , ");
		
		sql.append(" C.COURSE_ID AS COURSE_ID ");
		
		sql.append(" FROM CHAPTER CP ");
		sql.append(" LEFT JOIN COURSE_MAJOR C on CP.COURSE_ID=C.COURSE_ID   ");//课程    COURSE_MAJOR 课程专业表
		sql.append(" LEFT JOIN MAJOR M on M.MAJOR_ID=C.MAJOR_ID	");//课程    COURSE_MAJOR 课程专业表
		
		sql.append(" WHERE CP.CHAPTER_ID= '" + CharperId + "' ");
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

	public PageInfo findPageInfoByFOLDER1(int nowPage,
			int pageSize, String splitByQuery, HttpServletRequest request, String Chapter_id)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
			sql.append(" SELECT ");
			sql.append(" CP.CHAPTER_ID AS CHAPTER_ID, ");
			sql.append(" CP.CHAPTER_NAME AS CHAPTER_NAME, ");
			sql.append(" C.COURSE_ID AS COURSE_ID , ");
			sql.append(" C.COURSE_NAME AS COURSE_NAME , ");
			sql.append(" M.MAJOR_ID AS MAJOR_ID , ");
			sql.append(" M.MAJOR_NAME AS MAJOR_NAME ");
			sql.append(" FROM CHAPTER CP ");
			sql.append(" LEFT JOIN course C on CP.COURSE_ID=C.COURSE_ID   ");
			sql.append(" LEFT JOIN COURSE_MAJOR CM on C.COURSE_ID=CM.COURSE_ID ");
			sql.append(" LEFT JOIN MAJOR M on CM.MAJOR_ID=M.MAJOR_ID   ");
			sql.append(" WHERE 1 = 1 ");
		if (Validate.noNull(Chapter_id)) {
			sql.append(" and CP.CHAPTER_ID ='" + Chapter_id + "'");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
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
	 * @param CharperId
	 * @return
	 * @throws ManagerException
	 * 通过id得到班级名称
	 */
	public Map findMapByClassId(String classId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.GID AS GID,");
		sql.append(" T.BJMC AS BJMC ");//章节
		sql.append(" FROM BJXX T ");
		sql.append(" WHERE T.GID= '" + classId + "' ");
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
	 * @param FILEID
	 * @return
	 * @throws ManagerException
	 * 根据id得到教案文件表的信息
	 */
	public Map findMapByPLANID(String planId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PLANID AS PLANID, ");
		sql.append(" T.PLANNAME AS PLANNAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME,");
		sql.append(" T.CLASSID AS CLASSID, ");
		sql.append(" B.GID AS GID,B.BJMC AS BJMC ");
		sql.append(" FROM TEACHPLAN T ");
		sql.append(" LEFT JOIN BJXX B ON T.CLASSID=B.GID ");
		sql.append(" WHERE t.PLANID= '" + planId + "' ");
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
	 * @param request
	 * @return
	 * @throws ManagerException
	 * 查找某专业下所有班级
	 */
	public List findListByMajor_Id(HttpServletRequest request,String Major_Id)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" B.GID AS GID, ");
		sql.append(" B.BJMC AS BJMC, ");
		sql.append(" B.ZYDM AS ZYDM ");
		sql.append(" FROM BJXX B ");
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(Major_Id)){
			sql.append(" AND ZYDM='"+Major_Id+"'");
		}
		List list = null;
		try {
			DBHelper dbHelper = new DBHelper();
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} 
		return list;
	}
	
	/**
	 * @param FILEID
	 * @return
	 * @throws ManagerException
	 * 通过planid得到专业，课程，章节，班级等详细信息
	 */
	public Map findXXMapByPLANID(String planId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PLANID AS PLANID, ");
		sql.append(" T.PLANNAME AS PLANNAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CLASSID AS CLASSID, ");
		
		sql.append(" M.MAJOR_NAME AS MAJOR_NAME, ");
		sql.append(" CU.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" CP.CHAPTER_NAME AS CHAPTER_NAME ");
		sql.append(" FROM TEACHPLAN T ");
		sql.append(" LEFT JOIN MAJOR M ON T.MAJOR_ID=M.MAJOR_ID ");
		sql.append(" LEFT JOIN COURSE CU ON CU.COURSE_ID=T.COURSE_ID ");
		sql.append(" LEFT JOIN CHAPTER CP ON T.CHAPTER_ID=CP.CHAPTER_ID ");
		sql.append(" WHERE t.PLANID= '" + planId + "' ");
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
