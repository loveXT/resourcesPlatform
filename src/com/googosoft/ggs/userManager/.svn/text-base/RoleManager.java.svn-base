package com.googosoft.ggs.userManager;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.DBFormatException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.exception.TreeException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBFormatHelper;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.TreeHelper;

/**
 * 角色管理类
 * 
 * @author xuanly
 * 
 */
public class RoleManager implements IManagerContants {
	private Logger logger = Logger.getLogger(RoleManager.class.getName());

	/**
	 * 查询角色的分页信息
	 * 
	 * @param nowPage
	 *            第几页
	 * @param pageSize
	 *            每页显示几条
	 * @param roleuseable
	 *            是否生效 T/F
	 * @return
	 * @throws ManagerException
	 * @throws DBFormatException
	 * @throws QueryException
	 */
	public PageInfo findPageInfoByUmRole(int nowPage, int pageSize,
			String roleuseable) throws ManagerException, DBFormatException {
		String sql = " SELECT ";
		sql += " ROLEID AS ROLEID, ";
		sql += " ROLENAME AS ROLENAME, ";
		sql += " ROLEUSEABLE AS ROLEUSEABLE, ";
		sql += "ROLECREATETIME"
				+ " AS ROLECREATETIME ";
		sql += " FROM UmRole t ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(roleuseable)) {
			sql += " and t.ROLEUSEABLE = '" + roleuseable + "' ";
		}
		sql += " ORDER BY t.ROLEID ";
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
	 * 查询角色树信息
	 * 
	 * @param roleuseable
	 *            是否生效 T/F
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeByUmRole(String roleuseable) throws ManagerException {
		String sql = " SELECT ";
		sql += " ROLEID AS ROLEID, ";
		sql += " ROLENAME AS ROLENAME, ";
		sql += " ROLEUSEABLE AS ROLEUSEABLE, ";
		sql += " ROLECREATETIME AS ROLECREATETIME ";
		sql += " FROM UmRole t ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(roleuseable)) {
			sql += " and t.ROLEUSEABLE = '" + roleuseable + "' ";
		}
		sql += " ORDER BY t.ROLEID ";
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql);
			treeHelper.addTreeList(list, ROLEID, ROLEPARENTID, ROLENAME);
			list = treeHelper.getTreeList();
		} catch (DBException e) {
			logger.error("查询数据库信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (TreeException e) {
			logger.error("查询分页信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return list;
	}

	/**
	 * 根据角色id查询当前角色信息
	 * 
	 * @param roleId
	 *            角色id
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByroleId(String roleId) throws ManagerException {
		String sql = " SELECT ";
		sql += " ROLEID AS ROLEID, ";
		sql += " ROLENAME AS ROLENAME, ";
		sql += " ROLEUSEABLE AS ROLEUSEABLE, ";
		sql += " ROLECREATETIME AS ROLECREATETIME ";
		sql += " FROM UmRole t ";
		sql += " WHERE t.ROLEID= '" + roleId + "' ";
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

}
