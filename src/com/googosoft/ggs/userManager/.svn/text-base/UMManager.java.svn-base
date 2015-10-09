package com.googosoft.ggs.userManager;

import java.util.List;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.DBHelper;

/**
 * 资源-操作-角色管理类
 * 
 * @author xuanly
 * 
 */
public class UMManager {
	private Logger logger = Logger.getLogger(UMManager.class.getName());

	/**
	 * 根据角色、资源信息查看操作列表
	 * 
	 * @param roleIds
	 *            角色ids 多个id，中间用,分隔
	 * @param resourceId
	 *            资源id
	 * @return 角色-资源-操作列表信息
	 * @throws ManagerException
	 */
	public List findListByUmManager(String roleIds, String resourceId)
			throws ManagerException {
		StringBuffer sql = new StringBuffer(" SELECT ");
		sql.append(" T.UMMANAGERID AS UMMANAGERID, ");
		sql.append(" T.UMROLEID AS UMROLEID, ");
		sql.append(" T.UMRESOURCEID AS UMRESOURCEID, ");
		sql.append(" T.UMOPERATEID AS UMOPERATEID, ");
		sql.append(" O.UMOPERATENAME AS UMOPERATENAME, ");
		sql.append(" O.UMOPERATEUSEABLE AS UMOPERATEUSEABLE ");
		sql.append(" FROM UmManager T ");
		sql.append(" LEFT JOIN UMOPERATE O ON O.UMOPERATEID = T.UMOPERATEID ");
		sql.append(" where 1 = 1 ");
		sql.append(" AND O.UMOPERATEUSEABLE = 'T' ");
		if (Validate.noNull(roleIds)) {
			sql.append(" and t.UMROLEID IN ('" + roleIds + "') ");
		}
		if (Validate.noNull(resourceId)) {
			sql.append(" and t.UMRESOURCEID = '" + resourceId + "' ");
		}
		sql.append(" ORDER BY t.UMOPERATEID ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询资源角色操作表失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return list;
	}

}
