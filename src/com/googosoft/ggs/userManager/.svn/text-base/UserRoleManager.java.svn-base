package com.googosoft.ggs.userManager;

import java.util.List;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.DBHelper;

/**
 * 用户角色关联管理类
 * 
 * @author xuanly
 * 
 */
public class UserRoleManager {
	private Logger logger = Logger.getLogger(UserRoleManager.class.getName());

	/**
	 * 当前用户与当前角色是否关联
	 * 
	 * @param userId
	 *            用户id
	 * @param roleId
	 *            角色id
	 * @return
	 * @throws ManagerException
	 */
	public Boolean isUseableByUserAndRole(String userId, String roleId)
			throws ManagerException {
		String sql = " SELECT count(*) ";
		sql += " FROM UmUserRole t ";
		sql += " WHERE t.UMUSERID = '" + userId + "' and t.UMROLEID ='"
				+ roleId + "' ";
		DBHelper dbHelper = new DBHelper();
		int count = 0;
		try {
			count = Integer.valueOf(dbHelper.queryForSingleValue(sql)
					.toString());
		} catch (DBException e) {
			logger.error("查询用户角色表失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return count > 0;
	}

	/**
	 * 根据用户id查询用户-角色关联表的角色信息
	 * 
	 * @param userId
	 *            用户id
	 * @return
	 * @throws ManagerException
	 */
	public List findListByUmUserRole(String userId) throws ManagerException {
		String sql = " SELECT ";
		sql += " UMUSERROLEID AS UMUSERROLEID, ";
		sql += " UMUSERID AS UMUSERID, ";
		sql += " UMROLEID AS UMROLEID, ";
		sql += " ROLENAME AS ROLENAME ";
		sql += " FROM UmUserRole t ";
		sql += " left join UmRole r on r.ROLEID = t.UMROLEID ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(userId)) {
			sql += " and t.UMUSERID = '" + userId + "' ";
		}
		sql += " ORDER BY t.UMUSERROLEID ";
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql);
		} catch (DBException e) {
			logger.error("查询用户角色表失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return list;
	}

}
