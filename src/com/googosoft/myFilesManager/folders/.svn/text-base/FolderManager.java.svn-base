package com.googosoft.myFilesManager.folders;

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

public class FolderManager {
	private Logger logger = Logger.getLogger(FolderManager.class.getName());

	/**
	 * 
	 * @param nowPage
	 * @param pageSize
	 */
	public PageInfo findPageInfoByFolder(int nowPage, int pageSize,
			String split,HttpServletRequest request) throws ManagerException {
		String sql = " SELECT ";
		sql += " FOLDERID AS FOLDERID, ";
		sql += " FOLDERNAME AS FOLDERNAME, ";
		sql += " FOLDERPARENTID AS FOLDERPARENTID ";
		sql += " FROM MYFILEFOLDER t ";
		sql += " where 1 = 1 ";
		PageInfo pageInfo = null;
		try {
			sql += new QueryHelper().getQuerySqlByRequset(split, request);
			pageInfo = new PageHelper(nowPage, pageSize, sql).getPageInfo();
		} catch (DBException e) {
			logger.error("查询数据库信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (PageException e) {
			logger.error("查询分页信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (QueryException e) {
			logger.error("查询分页信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return pageInfo;
	}
	 public PageInfo findPageInfoByFolderParentId(int nowPage, int pageSize,
				String folderParentId) throws ManagerException {
		 	String sql = " SELECT ";
			sql += " FOLDERID AS FOLDERID, ";
			sql += " FOLDERNAME AS FOLDERNAME, ";
			sql += " FOLDERPARENTID AS FOLDERPARENTID ";
			sql += " FROM folder t ";
			sql += " where 1 = 1 ";
			if (Validate.noNull(folderParentId)) {
				sql += " and t.FOLDERPARENTID != t.FOLDERID ";
				sql += " and t.FOLDERPARENTID = '" + folderParentId
						+ "' ";
			}
			sql += " ORDER BY t.FOLDERID ";
			PageInfo pageInfo = null;
			try {
				pageInfo = new PageHelper(nowPage, pageSize, sql).getPageInfo();
			} catch (DBException e) {
				logger.error("查询数据库信息失败");
				e.printStackTrace();
				throw new ManagerException(e);
			} catch (PageException e) {
				logger.error("查询分页信息失败");
				e.printStackTrace();
				throw new ManagerException(e);
			}
			return pageInfo;
		}
	/**
	 */
	public List findTreeByFolder() throws ManagerException {
		return findTreeByFolderId(null, null);
	}

	/**
	 */
	public List findTreeByFolderId(String folderId,String userId)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " FOLDERID AS FOLDERID, ";
		sql += " FOLDERNAME AS FOLDERNAME, ";
		sql += " FOLDERPARENTID AS FOLDERPARENTID ";
		sql += " FROM MYFILEFOLDER t ";
		sql += " where 1 = 1 ";
		sql += " AND T.USERID ='"+userId+"'";
		if (Validate.noNull(folderId)) {
			sql += " and t.FOLDERID != '" + folderId + "' ";
		}
		sql += " ORDER BY t.FOLDERID ";
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql);
			treeHelper.addTreeList(list, "FOLDERID", "FOLDERPARENTID",
					"FOLDERNAME");
			list = treeHelper.getTreeList();
		} catch (DBException e) {
			logger.error("查询数据库信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (TreeException e) {
			logger.error("查询树信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return list;
	}

	/**
	 */
	public Map findMapByFolderId(String folderId)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " FOLDERID AS FOLDERID, ";
		sql += " FOLDERNAME AS FOLDERNAME, ";
		sql += " FOLDERPARENTID AS FOLDERPARENTID ";
		sql += " FROM folder t ";
		sql += " WHERE t.FOLDERID= '" + folderId + "'";
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql);
		} catch (DBException e) {
			logger.error("查询数据库信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return map;
	}
	
	public Map findMapsByFolder()
			throws ManagerException {
		String sql = " SELECT ";
		sql += " FOLDERID AS FOLDERID, ";
		sql += " FOLDERNAME AS FOLDERNAME, ";
		sql += " FOLDERPARENTID AS FOLDERPARENTID ";
		sql += " FROM folder t ";
		sql += " WHERE 1=1";
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql);
		} catch (DBException e) {
			logger.error("查询数据库信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return map;
	}

	/**
	 */
	public int findFolderSizeByParentid(String folderParentIds)
			throws ManagerException {
		String sql = " SELECT count(*) ";
		sql += " FROM folder t ";
		sql += " WHERE t.FOLDERPARENTID in ('" + folderParentIds
				+ "') ";
		sql += " AND t.FOLDERID != t.FOLDERPARENTID ";
		DBHelper dbHelper = new DBHelper();
		int count = 0;
		try {
			count = Integer.valueOf(dbHelper.queryForSingleValue(sql).toString());
		} catch (DBException e) {
			logger.error("查询数据库信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return count;
	}
}