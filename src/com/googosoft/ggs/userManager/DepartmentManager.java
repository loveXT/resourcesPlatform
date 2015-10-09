package com.googosoft.ggs.userManager;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.TreeException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.TreeHelper;

/**
 * 部门管理类
 * 
 * @author xuanly
 * 
 */
public class DepartmentManager implements IManagerContants {
	private Logger logger = Logger.getLogger(DepartmentManager.class.getName());

	/**
	 * 查询父节点部门的子节点分页信息
	 * 
	 * @param nowPage
	 * @param pageSize
	 * @param departmentParentId
	 *            父节点
	 * @return
	 * @throws ManagerException
	 *             子节点分页信息
	 */
	public PageInfo findPageInfoByumdepartment(int nowPage, int pageSize,
			String departmentParentId) throws ManagerException {
		String sql = " SELECT ";
		sql += " UMDEPARTMENTID AS UMDEPARTMENTID, ";
		sql += " UMDEPARTMENTNAME AS UMDEPARTMENTNAME, ";
		sql += " UMDEPARTMENTPARENTID AS UMDEPARTMENTPARENTID ";
		sql += " FROM umdepartment t ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(departmentParentId)) {
			sql += " and t.UMDEPARTMENTPARENTID != t.UMDEPARTMENTID ";
			sql += " and t.UMDEPARTMENTPARENTID = '" + departmentParentId
					+ "' ";
		}
		sql += " ORDER BY t.UMDEPARTMENTID ";
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
	 * 查询所有的部门，组装树信息
	 * 
	 * @return 所有部门组装的树信息
	 * @throws ManagerException
	 */
	public List findTreeByumdepartment() throws ManagerException {
		return findTreeByumdepartment(null);
	}
	/**
	 * 根据部门名称进行排序，查询所有的部门，组装树信息
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeByumdepartmentOrderByName() throws ManagerException {
		return findTreeByumdepartmentOrderByName(null);
	}

	/**
	 * 查询不包括当前节点在内的其他节点部门树信息
	 * 
	 * @param departmentParentId
	 *            当前隶属的节点
	 * @return 不包含此节点的部门树信息
	 * @throws ManagerException
	 */
	public List findTreeByumdepartment(String departmentId)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " UMDEPARTMENTID AS UMDEPARTMENTID, ";
		sql += " UMDEPARTMENTNAME AS UMDEPARTMENTNAME, ";
		sql += " UMDEPARTMENTPARENTID AS UMDEPARTMENTPARENTID ";
		sql += " FROM umdepartment t ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(departmentId)) {
			sql += " and t.UMDEPARTMENTID != '" + departmentId + "' ";
		}
		sql += " ORDER BY t.RTXBH ";
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql);
			treeHelper.addTreeList(list, UMDEPARTMENTID, UMDEPARTMENTPARENTID,
					UMDEPARTMENTNAME);
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
	 * 通过部门名称进行排序
	 * @param departmentId
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeByumdepartmentOrderByName(String departmentId)
	throws ManagerException {
		String sql = " SELECT ";
		sql += " UMDEPARTMENTID AS UMDEPARTMENTID, ";
		sql += " UMDEPARTMENTNAME AS UMDEPARTMENTNAME, ";
		sql += " UMDEPARTMENTPARENTID AS UMDEPARTMENTPARENTID ";
		sql += " FROM umdepartment t ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(departmentId)) {
			sql += " and t.UMDEPARTMENTID != '" + departmentId + "' ";
		}
		sql += " ORDER BY t.UMDEPARTMENTNAME ";
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql);
			treeHelper.addTreeList(list, UMDEPARTMENTID, UMDEPARTMENTPARENTID,
					UMDEPARTMENTNAME);
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
	 * 根据当前部门id查询部门信息
	 * 
	 * @param umdepartmentid
	 *            当前部门id
	 * @return 当前部门id对应的部门信息
	 * @throws ManagerException
	 */
	public Map findMapByUmdepartmentid(String umdepartmentid)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " UMDEPARTMENTID AS UMDEPARTMENTID, ";
		sql += " UMDEPARTMENTNAME AS UMDEPARTMENTNAME, ";
		sql += " UMDEPARTMENTPARENTID AS UMDEPARTMENTPARENTID ";
		sql += " FROM umdepartment t ";
		sql += " WHERE t.UMDEPARTMENTID= '" + umdepartmentid + "'";
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
	 * 查询当前父节点部门含有的子节点部门个数
	 * 
	 * @param departmentParentIds
	 *            父节点部门id,多个id中间用','隔开
	 * @return 子节点部门个数
	 * @throws ManagerException
	 */
	public int findDepartmentSizeByParentid(String departmentParentIds)
			throws ManagerException {
		String sql = " SELECT count(*) ";
		sql += " FROM umdepartment t ";
		sql += " WHERE t.UMDEPARTMENTPARENTID in ('" + departmentParentIds
				+ "') ";
		sql += " AND t.UMDEPARTMENTID != t.UMDEPARTMENTPARENTID ";
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
	public List findListByDepartment(){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.UMDEPARTMENTNAME AS UMDEPARTMENTNAME, ");
		sql.append(" T.UMDEPARTMENTID AS UMDEPARTMENTID ");
		sql.append(" FROM UMDEPARTMENT T ");
		sql.append(" WHERE 1=1 ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
			logger.error("查询失败!", e);
		}
		return list;
	}
	public List findListByDepartment(String Id){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.UMDEPARTMENTNAME AS UMDEPARTMENTNAME, ");
		sql.append(" T.UMDEPARTMENTID AS UMDEPARTMENTID ");
		sql.append(" FROM UMDEPARTMENT T ");
		sql.append(" WHERE 1=1 ");
		if(Validate.noNull(Id)){
			sql.append(" AND T.UMDEPARTMENTID = '"+Id+"' ");
		}
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
			logger.error("查询失败!", e);
		}
		return list;
	}
}
