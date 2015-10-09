package com.googosoft.resource;

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

public class SubResourceManager {
	public Logger logger = Logger.getLogger(SubResourceManager.class
			.getName());
	public List findCourse() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" C.COURSE_NAME AS COURSE_NAME,");
		sql.append(" C.IMGPATH AS IMGPATH,");
		sql.append(" C.COURSE_ID AS COURSE_ID ");
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
	public List findSchool(String course_id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" S.SCHOOLNAME AS SCHOOLNAME, ");
		sql.append(" S.SUBJECTURL AS SUBJECTURL, ");
		sql.append(" S.LINKIMAGE AS LINKIMAGE, ");
		sql.append(" C.COURSE_NAME AS COURSE_NAME ");
		sql.append(" FROM SUBJECTLINK S ");
		sql.append(" INNER JOIN COURSE C ON S.SUBJECTID=C.COURSE_ID");
		sql.append(" WHERE C.COURSE_ID = '"+course_id+"' ");
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

