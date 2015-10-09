package com.googosoft.myFilesManager.chain;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

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

public class ChainManager {
	private Logger logger = Logger.getLogger(ChainManager.class.getName());

	public List findListInfoBychain(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		String userId = (String)request.getSession().getAttribute("USERIDBYLOGIN");
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.NAME AS NAME, ");
		sql.append(" T.HREF AS HREF ");
		sql.append(" FROM chain T ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.USERIDBYLOGIN='"+userId+"' ");
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

	public List findTreeBychain(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.NAME AS NAME, ");
		sql.append(" T.HREF AS HREF ");
		sql.append(" FROM chain T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
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

	public Map findMapByid(String id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.NAME AS NAME, ");
		sql.append(" T.HREF AS HREF ");
		sql.append(" FROM chain T ");
		sql.append(" WHERE t.ID= '" + id + "' ");
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
	
	public void deleteChain(String id){
		try {
			new DBHelper().execute(new StringBuffer("delete from chain where id = '"+id+"'").toString());
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
