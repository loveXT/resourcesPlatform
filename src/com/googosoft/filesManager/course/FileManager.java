package com.googosoft.filesManager.course;

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

public class FileManager {
	private static Logger logger = Logger
			.getLogger(FileManager.class.getName());

	public Object findFileNameById(String Id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.SWFPATH AS SWFPATH");
		sql.append(" FROM TEACHPLAN T ");
		sql.append(" WHERE T.PLANID= '" + Id + "' ");
		DBHelper dbHelper = new DBHelper();
		Object fileName = null;
		try {
			fileName = dbHelper.queryForSingleValue(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return fileName;
	}
	public Object findExtendNameById(String Id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME");
		sql.append(" FROM TEACHPLAN T ");
		sql.append(" WHERE T.PLANID= '" + Id + "' ");
		DBHelper dbHelper = new DBHelper();
		Object extendName = null;
		try {
			extendName = dbHelper.queryForSingleValue(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return extendName;
	}
	
	

}
