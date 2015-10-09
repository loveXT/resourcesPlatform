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
 * 资源管理类
 * 
 * @author xuanly
 * 
 */
public class ResourceManager implements IManagerContants {
	private Logger logger = Logger.getLogger(ResourceManager.class.getName());

	/**
	 * 查询资源分页信息
	 * 
	 * @param nowPage
	 *            第几页
	 * @param pageSize
	 *            每页显示条数
	 * @param resourceParentId
	 *            资源父节点
	 * @param resourceuseable
	 *            是否生效 T/F
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByumresource(int nowPage, int pageSize,
			String resourceParentId, String resourceuseable)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " UMRESOURCEID AS UMRESOURCEID, ";
		sql += " UMRESOURCENAME AS UMRESOURCENAME, ";
		sql += " UMRESOURCEPARENTID AS UMRESOURCEPARENTID, ";
		sql += " UMRESOURCEURL AS UMRESOURCEURL, ";
		sql += " UMORDER AS UMORDER, ";
		sql += " UMRESOURCEUSEABLE AS UMRESOURCEUSEABLE ";
		sql += " FROM umresource t ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(resourceParentId)) {
			if ("ROLEUSE".equals(resourceParentId)) {
				sql += " and t.UMRESOURCEPARENTID != t.UMRESOURCEID ";
			} else {
				sql += " and t.UMRESOURCEPARENTID = '" + resourceParentId
						+ "' ";
				sql += " and t.UMRESOURCEPARENTID != t.UMRESOURCEID ";
			}
		} else {
			sql += " and t.UMRESOURCEPARENTID = t.UMRESOURCEID ";
		}
		if (Validate.noNull(resourceuseable)) {
			sql += " and t.UMRESOURCEUSEABLE = '" + resourceuseable + "' ";
		}
		sql += " ORDER BY ";
		if (Validate.noNull(resourceParentId)) {
			sql += " t.UMRESOURCEPARENTID, ";
		}
		sql += " t.UMORDER ";
		PageInfo pageInfo = null;
		try {
			pageInfo = new PageHelper(nowPage, pageSize, sql).getPageInfo();
		} catch (DBException e) {
			logger.error("查询资源信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (PageException e) {
			logger.error("查询资源信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return pageInfo;
	}

	/**
	 * 查询含有所有资源信息的资源树信息
	 * 
	 * @param resourceuseable
	 *            是否生效T/F
	 * @return 所有资源信息的资源树信息
	 * @throws ManagerException
	 */
	public List findTreeByumresource(String resourceuseable)
			throws ManagerException {
		return findTreeByumresource(resourceuseable, null);
	}

	/**
	 * 查询不包括当前资源再内的资源树信息
	 * 
	 * @param resourceuseable
	 *            是否生效，T/F
	 * @param resourceId
	 *            当前资源id
	 * @return 不包括当前资源再内的资源树信息
	 * @throws ManagerException
	 */
	public List findTreeByumresource(String resourceuseable, String resourceId)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " UMRESOURCEID AS UMRESOURCEID, ";
		sql += " UMRESOURCENAME AS UMRESOURCENAME, ";
		sql += " UMRESOURCEPARENTID AS UMRESOURCEPARENTID, ";
		sql += " UMRESOURCEURL AS UMRESOURCEURL, ";
		sql += " UMORDER AS UMORDER, ";
		sql += " UMRESOURCEUSEABLE AS UMRESOURCEUSEABLE ";
		sql += " FROM umresource t ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(resourceuseable)) {
			sql += " and t.UMRESOURCEUSEABLE = '" + resourceuseable + "' ";
		}
		if (Validate.noNull(resourceId)) {
			sql += " and t.UMRESOURCEID != '" + resourceId + "' ";
		}
		sql += " ORDER BY t.UMORDER ";
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql);
			treeHelper.addTreeList(list, UMRESOURCEID, UMRESOURCEPARENTID,
					UMRESOURCENAME);
			list = treeHelper.getTreeList();
		} catch (DBException e) {
			logger.error("查询资源信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (TreeException e) {
			logger.error("查询资源信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return list;
	}

	/**
	 * 根据资源id查询资源信息
	 * 
	 * @param umResourceId
	 *            资源id
	 * @return 资源信息
	 * @throws ManagerException
	 */
	public Map findMapByumResourceId(String umResourceId)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " UMRESOURCEID AS UMRESOURCEID, ";
		sql += " UMRESOURCENAME AS UMRESOURCENAME, ";
		sql += " UMRESOURCEPARENTID AS UMRESOURCEPARENTID, ";
		sql += " UMRESOURCEURL AS UMRESOURCEURL, ";
		sql += " UMORDER AS UMORDER, ";
		sql += " UMRESOURCEUSEABLE AS UMRESOURCEUSEABLE ";
		sql += " FROM umresource t ";
		sql += " WHERE t.UMRESOURCEID= '" + umResourceId + "' ";
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql);
		} catch (DBException e) {
			logger.error("查询资源信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return map;
	}

	/**
	 * 根据资源url和生效标识查询资源信息
	 * 
	 * @param resourceuseable
	 *            生效标识T/F
	 * @param umResourceUrl
	 *            资源url
	 * @return 资源信息map
	 * @throws ManagerException
	 */
	public Map findMapByumResourceUrl(String resourceuseable,
			String umResourceUrl) throws ManagerException {
		String sql = " SELECT ";
		sql += " UMRESOURCEID AS UMRESOURCEID, ";
		sql += " UMRESOURCENAME AS UMRESOURCENAME, ";
		sql += " UMRESOURCEPARENTID AS UMRESOURCEPARENTID, ";
		sql += " UMRESOURCEURL AS UMRESOURCEURL, ";
		sql += " UMORDER AS UMORDER, ";
		sql += " UMRESOURCEUSEABLE AS UMRESOURCEUSEABLE ";
		sql += " FROM umresource t ";
		sql += " WHERE 1 = 1 ";
		if (Validate.noNull(resourceuseable)) {
			sql += " AND T.UMRESOURCEUSEABLE = '" + resourceuseable + "' ";
		}
		if (Validate.noNull(umResourceUrl)) {
			sql += " AND t.UMRESOURCEURL= '" + umResourceUrl + "' ";
		}
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql);
		} catch (DBException e) {
			logger.error("查询资源信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return map;
	}

	/**
	 * 查询当前资源节点下子节点的数量
	 * 
	 * @param resourceParentIds
	 *            当前资源id
	 * @return 子资源的数量
	 * @throws ManagerException
	 */
	public int findResourceSizeByResourceParentId(String resourceParentIds)
			throws ManagerException {
		int count = 0;
		String sql;
		DBHelper dbHelper = new DBHelper();
		for (int i = 0; i < resourceParentIds.split("','").length; i++) {
			sql = " SELECT count(*) ";
			sql += " FROM umresource t ";
			sql += " where t.UMRESOURCEPARENTID = '"
					+ resourceParentIds.split("','")[i] + "' ";
			sql += " and t.UMRESOURCEID != t.UMRESOURCEPARENTID ";
			try {
				count = Integer.valueOf(dbHelper.queryForSingleValue(sql)
						.toString());
			} catch (DBException e) {
				logger.error("查询数据库失败");
				e.printStackTrace();
				throw new ManagerException(e);
			}
			if (count > 0) {
				break;
			}
		}
		return count;
	}

}
