package com.googosoft.ggs.homeManager.menu;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.googosoft.commons.ISessionContants;
import com.googosoft.commons.StringUtil;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.TreeException;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.TreeHelper;

public class MenuByCommon implements ISessionContants, IMenuMould {

	@Override
	public List findTreeByumresource(String userId, String userName,
			String roleIds, String parentId) throws ManagerException {
		// 由3级菜单查询到的1级菜单
		String parentSqlFor1By3 = getSqlFor1By3(roleIds, parentId);
		// 由3级菜单查询到2级菜单，再由2级菜单查询1级菜单
		String parentSqlFor1By2By3 = getSqlFor1By2By3(roleIds, parentId);
		// 由3级菜单查询到的2级菜单
		String parentSqlFor2By3 = getSqlFor2By3(roleIds);
		// 查询所有3级菜单
		String sqlFor3 = getSqlFor3(roleIds);
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = null;
		if (parentId == null) {
			treeHelper = new TreeHelper();
		} else {
			treeHelper = new TreeHelper(parentId);
		}
		List result = null;
		try {
			List listFor3 = dbHelper.queryForList(sqlFor3);
			List ListFor2By3 = dbHelper.queryForList(parentSqlFor2By3);
			List listFor1By3 = dbHelper.queryForList(parentSqlFor1By3);
			List listFor1By2By3 = dbHelper.queryForList(parentSqlFor1By2By3);
			List listFor1 = quCong(listFor1By3, listFor1By2By3);
			List list = quCong(listFor1,listFor3,ListFor2By3);
			treeHelper.addTreeList(list, "UMRESOURCEID",
					"UMRESOURCEPARENTID", "UMRESOURCENAME", "UMRESOURCEURL",
					null);
			result = treeHelper.getTreeList();
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (TreeException e) {
			logger.error("组装树失败\n" + e);
			throw new ManagerException("组装树失败\n" + e);
		}
		return result;
	}

	@Override
	public List findBasicTreeByumresource(String userId, String userName,
			String roleIds) throws ManagerException {
		// 由3级菜单查询到的1级菜单
		String parentSqlFor1By3 = getSqlFor1By3(roleIds, null);
		// 由3级菜单查询到2级菜单，再由2级菜单查询1级菜单
		String sqlFor1By2By3 = getSqlFor1By2By3(roleIds, null);
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			// 由3级菜单查询到的1级菜单
			List list1 = dbHelper.queryForList(parentSqlFor1By3);
			// 由3级菜单查询到2级菜单，再由2级菜单查询1级菜单
			List list2 = dbHelper.queryForList(sqlFor1By2By3);
			// 对两种菜单去重
			list = quCong(list1, list2);
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

	/**
	 * 获得一级菜单
	 * 
	 * @param roleIds
	 * @return
	 */
	private String getSqlFor1By2By3(String roleIds, String parentId) {
		StringBuffer parentSqlFor1By2By3 = new StringBuffer();
		parentSqlFor1By2By3.append(" SELECT ");
		parentSqlFor1By2By3.append(" T.UMRESOURCEID AS UMRESOURCEID, ");
		parentSqlFor1By2By3.append(" T.UMRESOURCENAME AS UMRESOURCENAME, ");
		parentSqlFor1By2By3
				.append(" T.UMRESOURCEPARENTID AS UMRESOURCEPARENTID, ");
		parentSqlFor1By2By3.append(" T.UMRESOURCEURL AS UMRESOURCEURL, ");
		parentSqlFor1By2By3
				.append(" T.UMRESOURCEUSEABLE AS UMRESOURCEUSEABLE, ");
		parentSqlFor1By2By3.append(" T.UMORDER AS UMORDER ");
		parentSqlFor1By2By3.append(" FROM UMRESOURCE T ");
		parentSqlFor1By2By3.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		if (parentId != null) {
			parentSqlFor1By2By3.append(" AND T.UMRESOURCEID != '" + parentId
					+ "' ");
		}
		parentSqlFor1By2By3
				.append(" AND T.UMRESOURCEID = T.UMRESOURCEPARENTID ");
		parentSqlFor1By2By3.append(" AND T.UMRESOURCEID IN(SELECT DISTINCT ");
		parentSqlFor1By2By3.append(" T.UMRESOURCEPARENTID ");
		parentSqlFor1By2By3.append(" FROM UMRESOURCE T ");
		parentSqlFor1By2By3.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		parentSqlFor1By2By3
				.append(" AND T.UMRESOURCEID != T.UMRESOURCEPARENTID ");
		parentSqlFor1By2By3.append(" AND T.UMRESOURCEID IN(SELECT DISTINCT ");
		parentSqlFor1By2By3.append(" T.UMRESOURCEPARENTID ");
		parentSqlFor1By2By3.append(" FROM UMRESOURCE T ");
		parentSqlFor1By2By3.append(" RIGHT JOIN UMMANAGER M ");
		parentSqlFor1By2By3.append(" ON M.UMRESOURCEID = T.UMRESOURCEID ");
		parentSqlFor1By2By3.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		parentSqlFor1By2By3
				.append(" AND M.UMROLEID IN('"+roleIds+"'))) ");
		parentSqlFor1By2By3.append(" ORDER BY T.UMORDER ");
		return parentSqlFor1By2By3.toString();
	}

	/**
	 * 由3级菜单查询到的1级菜单
	 * 
	 * @param roleIds
	 * @return
	 */
	private String getSqlFor1By3(String roleIds, String parentId) {
		StringBuffer parentSqlFor1By3 = new StringBuffer();
		parentSqlFor1By3.append(" SELECT ");
		parentSqlFor1By3.append(" T.UMRESOURCEID AS UMRESOURCEID, ");
		parentSqlFor1By3.append(" T.UMRESOURCENAME AS UMRESOURCENAME, ");
		parentSqlFor1By3
				.append(" T.UMRESOURCEPARENTID AS UMRESOURCEPARENTID, ");
		parentSqlFor1By3.append(" T.UMRESOURCEURL AS UMRESOURCEURL, ");
		parentSqlFor1By3.append(" T.UMRESOURCEUSEABLE AS UMRESOURCEUSEABLE, ");
		parentSqlFor1By3.append(" T.UMORDER AS UMORDER ");
		parentSqlFor1By3.append(" FROM UMRESOURCE T ");
		parentSqlFor1By3.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		if (parentId != null) {
			parentSqlFor1By3.append(" AND T.UMRESOURCEID != '" + parentId
					+ "' ");
		}
		parentSqlFor1By3.append(" AND T.UMRESOURCEID = T.UMRESOURCEPARENTID ");
		parentSqlFor1By3.append(" AND T.UMRESOURCEID IN ( ");
		parentSqlFor1By3.append(" SELECT DISTINCT T.UMRESOURCEPARENTID ");
		parentSqlFor1By3.append(" FROM UMRESOURCE T ");
		parentSqlFor1By3.append(" RIGHT JOIN UMMANAGER M ");
		parentSqlFor1By3.append(" ON M.UMRESOURCEID = T.UMRESOURCEID ");
		parentSqlFor1By3.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		parentSqlFor1By3.append(" AND M.UMROLEID IN ('" + roleIds + "') ");
		parentSqlFor1By3.append(" ) ");
		parentSqlFor1By3.append(" ORDER BY T.UMORDER ");
		return parentSqlFor1By3.toString();
	}

	/**
	 * 通过三级菜单查询二级菜单
	 * 
	 * @return
	 */
	private String getSqlFor2By3(String roleIds) {
		StringBuffer parentSqlFor2By3 = new StringBuffer();
		parentSqlFor2By3.append(" SELECT DISTINCT ");
		parentSqlFor2By3.append(" T.UMRESOURCEID AS UMRESOURCEID, ");
		parentSqlFor2By3.append(" T.UMRESOURCENAME AS UMRESOURCENAME, ");
		parentSqlFor2By3
				.append(" T.UMRESOURCEPARENTID AS UMRESOURCEPARENTID, ");
		parentSqlFor2By3.append(" T.UMRESOURCEURL AS UMRESOURCEURL, ");
		parentSqlFor2By3.append(" T.UMRESOURCEUSEABLE AS UMRESOURCEUSEABLE, ");
		parentSqlFor2By3.append(" T.UMORDER AS UMORDER ");
		parentSqlFor2By3.append(" FROM UMRESOURCE T ");
		parentSqlFor2By3.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		parentSqlFor2By3.append(" AND T.UMRESOURCEID != T.UMRESOURCEPARENTID ");
		parentSqlFor2By3.append(" AND T.UMRESOURCEID IN(SELECT DISTINCT ");
		parentSqlFor2By3.append(" T.UMRESOURCEPARENTID ");
		parentSqlFor2By3.append(" FROM UMRESOURCE T ");
		parentSqlFor2By3
				.append(" RIGHT JOIN UMMANAGER M  ON M.UMRESOURCEID = T.UMRESOURCEID ");
		parentSqlFor2By3.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		parentSqlFor2By3.append(" AND M.UMROLEID IN('" + roleIds + "')) ");
		parentSqlFor2By3.append(" ORDER BY T.UMORDER ");
		return parentSqlFor2By3.toString();
	}

	/**
	 * 通过三级菜单查询一级菜单
	 * 
	 * @param roleIds
	 * @return
	 */
	private String getSqlFor3(String roleIds) {
		StringBuffer sqlFor3 = new StringBuffer();
		sqlFor3.append(" SELECT DISTINCT ");
		sqlFor3.append(" T.UMRESOURCEID AS UMRESOURCEID, ");
		sqlFor3.append(" T.UMRESOURCENAME AS UMRESOURCENAME, ");
		sqlFor3.append(" T.UMRESOURCEPARENTID AS UMRESOURCEPARENTID, ");
		sqlFor3.append(" T.UMRESOURCEURL AS UMRESOURCEURL, ");
		sqlFor3.append(" T.UMRESOURCEUSEABLE AS UMRESOURCEUSEABLE, ");
		sqlFor3.append(" T.UMORDER AS UMORDER ");
		sqlFor3.append(" FROM UMRESOURCE T ");
		sqlFor3.append(" RIGHT JOIN UMMANAGER M ");
		sqlFor3.append(" ON M.UMRESOURCEID = T.UMRESOURCEID ");
		sqlFor3.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		sqlFor3.append(" AND M.UMROLEID IN('" + roleIds + "') ");
		sqlFor3.append(" ORDER BY T.UMORDER ");
		return sqlFor3.toString();
	}

	private List quCong(List...list) {
		List result = new ArrayList();
		Map treeMap = new TreeMap();
		Map map = null;
		List temp = null;
		for (int i = 0; i < list.length; i++) {
			temp = list[i];
			for (Iterator iterator = temp.iterator(); iterator.hasNext();) {
				map = (Map) iterator.next();
				treeMap.put(StringUtil.objToString(map.get("UMORDER"))
						+ map.get("UMRESOURCEID"), map);
			}
		}
		for (Iterator iterator = treeMap.values().iterator(); iterator
				.hasNext();) {
			map = (Map) iterator.next();
			result.add(map);
		}
		return result;
	}
}
