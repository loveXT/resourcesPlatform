package com.googosoft.ggs.userManager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.CUDException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.CUDHelper;
import com.googosoft.zapi.DBHelper;

/**
 * 用户部门关联管理类
 * 
 * @author xuanly
 * 
 */
public class UserDepartmentManager {
	private Logger logger = Logger.getLogger(UserDepartmentManager.class
			.getName());

	/**
	 * 根据用户id查询当前用户拥有的部门信息
	 * 
	 * @param userId
	 *            用户id
	 * @return 用户-部门信息列表
	 * @throws ManagerException
	 */
	public List findListByumuserdepartment(String userId)
			throws ManagerException {
		List list = new ArrayList();
		String sql = " SELECT ";
		sql += " t.UMUSERDEPARTMENTID AS UMUSERDEPARTMENTID, ";
		sql += " t.UMUSERID AS UMUSERID, ";
		sql += " t.UMDEPARTMENTID AS UMDEPARTMENTID, ";
		sql += " d.UMDEPARTMENTNAME as UMDEPARTMENTNAME ";
		sql += " FROM umuserdepartment t ";
		sql += " left join umdepartment d on d.UMDEPARTMENTID = t.UMDEPARTMENTID ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(userId)) {
			sql += " and t.UMUSERID = '" + userId + "' ";
		}
		sql += " ORDER BY t.UMUSERDEPARTMENTID ";
		DBHelper dbHelper = new DBHelper();
		try {
			list = dbHelper.queryForList(sql);
		} catch (DBException e) {
			logger.error("查询数据库失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return list;
	}

	/**
	 * 根据部门id查询当前部门下拥有的用户数量
	 * 
	 * @param departmentIds
	 *            部门id，多个中间用','分隔
	 * @return
	 * @throws ManagerException
	 */
	public int findUserSizeBydepartment(String departmentIds)
			throws ManagerException {
		int count = 0;
		String sql;
		DBHelper dbHelper = new DBHelper();
		sql = " SELECT count(*) ";
		sql += " FROM umuserdepartment t ";
		sql += " WHERE t.UMDEPARTMENTID IN ( '" + departmentIds + "') ";
		try {
			count = Integer.valueOf(dbHelper.queryForSingleValue(sql)
					.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return count;
	}

	/**
	 * 根据用户-部门id查询用户-部门关联表信息
	 * 
	 * @param UMUSERDEPARTMENTID
	 *            用户-部门关联表id
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByUMUSERDEPARTMENTID(String UMUSERDEPARTMENTID)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " UMUSERDEPARTMENTID AS UMUSERDEPARTMENTID, ";
		sql += " UMUSERID AS UMUSERID, ";
		sql += " UMDEPARTMENTID AS UMDEPARTMENTID ";
		sql += " FROM umuserdepartment t ";
		sql += " WHERE t.UMUSERDEPARTMENTID= '" + UMUSERDEPARTMENTID + "' ";
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql);
		} catch (DBException e) {
			logger.error("查询数据库失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return map;
	}

	/**
	 * 保存用户-部门信息
	 * 
	 * @param initMap
	 *            cud格式初始map
	 * @param split
	 *            cud格式分隔符
	 * @param tableFlag
	 *            cud格式表名分隔符
	 * @param userId
	 *            用户id
	 * @return
	 * @throws ManagerException
	 */
	public Boolean saveUserDepartmentByUser(Map initMap, String split,
			String tableFlag, String userId) throws ManagerException {
		try {
			String departmentids = initMap.get("DEPARTMENTIDS") == null ? ""
					: initMap.get("DEPARTMENTIDS").toString();
			List list = Arrays.asList(departmentids.split(","));
			for (int i = 0; i < list.size(); i++) {
				initMap.put("P_UMUSERDEPARTMENT-" + i
						+ "_UMUSERDEPARTMENTID_S_P", null);
				initMap.put("P_UMUSERDEPARTMENT-" + i + "_UMUSERID_S_C", userId);
				initMap.put("P_UMUSERDEPARTMENT-" + i + "_UMDEPARTMENTID_S_C",
						list.get(i));
			}
			return new CUDHelper(initMap, split, tableFlag).execute();
		} catch (CUDException e) {
			logger.error("执行cud失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
	}

}
