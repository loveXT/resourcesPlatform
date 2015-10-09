package com.googosoft.ggs.userManager;

import java.util.HashMap;
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

/**
 * 操作管理类
 * 
 * @author xuanly
 * 
 */
public class OperateManager implements IManagerContants {
	private Logger logger = Logger.getLogger(OperateManager.class.getName());

	/**
	 * 查询操作分页信息
	 * 
	 * @param nowPage
	 * @param pageSize
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByUmOperate(int nowPage, int pageSize,String querySplit,HttpServletRequest request)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " UMOPERATEID AS UMOPERATEID, ";
		sql += " UMOPERATENAME AS UMOPERATENAME, ";
		sql += " UMOPERATECN AS UMOPERATECN, ";
		sql += " UMOPERATEUSEABLE AS UMOPERATEUSEABLE ";
		sql += " FROM UmOperate t ";
		sql += " where 1=1 ";
		PageInfo pageInfo = null;
		try {
			sql += new QueryHelper().getQuerySqlByRequset(querySplit, request);
			pageInfo = new PageHelper(nowPage, pageSize, sql).getPageInfo();
		} catch (DBException e) {
			logger.error("查询操作信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (PageException e) {
			logger.error("查询操作信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (QueryException e) {
			logger.error("组装查询失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return pageInfo;
	}

	/**
	 * 查询操作树信息
	 * 
	 * @param operateuseable
	 *            是否生效；T/F
	 * 
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeByUmOperate(String operateuseable)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " UMOPERATEID AS UMOPERATEID, ";
		sql += " UMOPERATENAME AS UMOPERATENAME, ";
		sql += " UMOPERATECN AS UMOPERATECN, ";
		sql += " UMOPERATEUSEABLE AS UMOPERATEUSEABLE ";
		sql += " FROM UmOperate t ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(operateuseable)) {
			sql += " and t.UMOPERATEUSEABLE = '" + operateuseable + "' ";
		}
		sql += " ORDER BY t.UMOPERATEID ";
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql);
			treeHelper.addTreeList(list, UMOPERATEID, UMOPERATEPARENTID,
					UMOPERATECN);
			list = treeHelper.getTreeList();
		} catch (DBException e) {
			logger.error("查询操作信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (TreeException e) {
			logger.error("查询操作信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return list;
	}

	/**
	 * 根据是否生效查询本类别的id和name值，组装成map返回
	 * 
	 * @param operateuseable
	 *            是否生效T/F
	 * @return
	 * @throws ManagerException
	 */
	public Map findIdAndNameMapByUmOperate(String operateuseable)
			throws ManagerException {
		String sql = " SELECT ";
		sql += " UMOPERATEID AS UMOPERATEID, ";
		sql += " UMOPERATECN AS UMOPERATECN ";
		sql += " FROM UmOperate t ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(operateuseable)) {
			sql += " and t.UMOPERATEUSEABLE = '" + operateuseable + "' ";
		}
		sql += " ORDER BY t.UMOPERATEID ";
		DBHelper dbHelper = new DBHelper();
		List list = null;
		Map rsMap = new HashMap(), map;
		try {
			list = dbHelper.queryForList(sql);
			for (int i = 0; i < list.size(); i++) {
				map = (Map) list.get(i);
				rsMap.put(map.get("UMOPERATEID").toString(),
						map.get("UMOPERATECN"));
			}
		} catch (DBException e) {
			logger.error("查询操作信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return rsMap;
	}

	/**
	 * 根据操作id查询当前操作的信息
	 * 
	 * @param umOperateId
	 *            操作id
	 * @return 操作信息
	 * @throws ManagerException
	 */
	public Map findMapByumOperateId(String umOperateId) throws ManagerException {
		String sql = " SELECT ";
		sql += " UMOPERATEID AS UMOPERATEID, ";
		sql += " UMOPERATENAME AS UMOPERATENAME, ";
		sql += " UMOPERATECN AS UMOPERATECN, ";
		sql += " UMOPERATEUSEABLE AS UMOPERATEUSEABLE ";
		sql += " FROM UmOperate t ";
		sql += " WHERE t.UMOPERATEID= '" + umOperateId + "' ";
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql);
		} catch (DBException e) {
			logger.error("查询操作信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return map;
	}

}
