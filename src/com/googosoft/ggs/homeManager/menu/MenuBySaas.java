package com.googosoft.ggs.homeManager.menu;

import java.util.List;

import com.googosoft.commons.ISessionContants;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.TreeException;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.TreeHelper;

public class MenuBySaas implements ISessionContants, IMenuMould {

	@Override
	public List findTreeByumresource(String userId, String userName,
			String roleIds, String parentId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT DISTINCT ");
		sql.append(" T.UMRESOURCEID AS UMRESOURCEID, ");
		sql.append(" T.UMRESOURCENAME AS UMRESOURCENAME, ");
		sql.append(" T.UMRESOURCEPARENTID AS UMRESOURCEPARENTID, ");
		sql.append(" T.UMRESOURCEURL AS UMRESOURCEURL, ");
		sql.append(" T.UMRESOURCEUSEABLE AS UMRESOURCEUSEABLE, ");
		sql.append(" T.UMORDER AS UMORDER ");
		sql.append(" FROM UMRESOURCE T ");
		sql.append(" ORDER BY T.UMORDER ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = null;
		if (parentId == null) {
			treeHelper = new TreeHelper();
		} else {
			treeHelper = new TreeHelper(parentId);
		}
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "UMRESOURCEID", "UMRESOURCEPARENTID",
					"UMRESOURCENAME", "UMRESOURCEURL", null);
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

	@Override
	public List findBasicTreeByumresource(String userId, String userName,
			String roleIds) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT DISTINCT ");
		sql.append(" T.UMRESOURCEID AS UMRESOURCEID, ");
		sql.append(" T.UMRESOURCENAME AS UMRESOURCENAME, ");
		sql.append(" T.UMRESOURCEPARENTID AS UMRESOURCEPARENTID, ");
		sql.append(" T.UMRESOURCEURL AS UMRESOURCEURL, ");
		sql.append(" T.UMRESOURCEUSEABLE AS UMRESOURCEUSEABLE, ");
		sql.append(" T.UMORDER AS UMORDER ");
		sql.append(" FROM UMRESOURCE T ");
		sql.append(" WHERE T.UMRESOURCEID = T.UMRESOURCEPARENTID ");
		sql.append(" ORDER BY T.UMORDER ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = null;
		treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "UMRESOURCEID", "UMRESOURCEPARENTID",
					"UMRESOURCENAME", "UMRESOURCEURL", null);
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
}
