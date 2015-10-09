package com.googosoft.filesManager.openClass;

import java.sql.SQLException;
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

public class OpenClassManager {

	private Logger logger = Logger.getLogger(OpenClassManager.class.getName());
	
	private StringBuffer findCommonFields(){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.FILENAME2 AS FILENAME2, ");
		sql.append(" T.EXTENDNAME2 AS EXTENDNAME2, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.UPLOADER AS UPLOADER, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.DOWNLOADTIME AS DOWNLOADTIME, ");
		sql.append(" T.BROWSETIME AS BROWSETIME, ");
		sql.append(" CONCAT(T.FALSENAME,T.EXTENDNAME) AS FULLNAME, ");
		sql.append(" UM.USERNAME AS UPLOADERNAME,"); //上传人姓名
		sql.append(" C.COURSE_NAME AS COURSE_NAME , ");
		sql.append(" T.DOWNLOAD AS DOWNLOAD ");
		sql.append(" FROM OPENCLASS T ");
		sql.append(" LEFT JOIN course C on T.COURSE_ID=C.COURSE_ID   ");
		sql.append(" LEFT JOIN UMUSER UM on UM.USERID = T.UPLOADER  ");
		sql.append(" WHERE 1 = 1 ");
		return sql;
	}
	
	public PageInfo findByPrivateAllAndVerified(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request,
			String COURSE_ID) throws ManagerException {
		String USERIDBYLOGIN = (String)request.getSession().getAttribute("USERIDBYLOGIN");
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		sql.append(" AND T.UPLOADER = '"+USERIDBYLOGIN+"' ");
		sql.append(" ORDER BY T.CREATETIME DESC ");
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
	
	public PageInfo findResourceByopenClass(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request
			) throws ManagerException {
		String buttonClass = request.getParameter("buttonClass");
		String typeId = request.getParameter("typeId");
		String contents = Validate.isNullToDefault(request.getParameter("CONTENT"), "").toString();
		String courseId = Validate.isNullToDefault(request.getParameter("courseId"), "").toString();
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		if(Validate.noNull(typeId)){
			if("1".equals(typeId)){
				sql.append(" AND T.REALNAME LIKE '%"+contents+"%' ");
			}
			if("2".equals(typeId)){
				sql.append(" AND T.COURSE_ID = '"+courseId+"' ");
			}
		}
		if(Validate.noNull(buttonClass)){
			if("2".equals(buttonClass)){
				sql.append(" ORDER BY T.CREATETIME DESC ");
			}
			if("3".equals(buttonClass)){
				sql.append(" ORDER BY TO_NUMBER(T.BROWSETIME) DESC ");
			}
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
	 * 查询课程
	 */
	public List findCourseByCourseId() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" C.COURSE_ID AS COURSE_ID, ");
		sql.append(" C.COURSE_NAME AS COURSE_NAME ");
		sql.append(" FROM COURSE C ");
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
	
	public Map findCourseByCourseId(String course_id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" C.COURSE_ID AS COURSE_ID, ");
		sql.append(" C.COURSE_NAME AS COURSE_NAME ");
		sql.append(" FROM COURSE C ");
		sql.append(" WHERE C.COURSE_ID = '"+course_id+"' ");
		DBHelper dbHelper = new DBHelper();
		Map map;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return map;
	}
	
	/**
	 * 查询所有的视频信息
	 * @return
	 */
	public List  findVedioList(){
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		sql.append(" AND T.FILENAME IS NOT NULL ");
		sql.append(" ORDER BY T.CREATETIME DESC");
		List list = null;
		DBHelper dbHelper = new DBHelper();
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 增加浏览次数
	 * @param fileId
	 * @return
	 * @throws DBException
	 * @throws SQLException
	 */
	public int updateFilesBROWSETIME(String fileId) throws DBException, SQLException{
		String sql = "UPDATE OPENCLASS T SET T.BROWSETIME= T.BROWSETIME + 1  WHERE T.FILEID='"+fileId+"'";
		DBHelper dbh = new DBHelper();
		dbh.execute(sql);
		sql = " SELECT T.BROWSETIME FROM OPENCLASS T WHERE T.FILEID='"+fileId+"' ";
		int num = Integer.valueOf(dbh.queryForSingleValue(sql).toString());
		return num;
	}
}
