package com.googosoft.ggs.dataManager;

import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.ISessionContants;
import com.googosoft.commons.Validate;
import com.googosoft.exception.CUDException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.CUDHelper;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;

/**
 * 数据规则管理类
 * 
 * @author xuanly
 * 
 */
public class OrganizationManager implements IOrganizationContants,ISessionContants
		 {
	private static Logger logger = Logger.getLogger(OrganizationManager.class
			.getName());

	/**
	 * 添加数据规则管理方法
	 * 
	 * @param sql
	 *            原始sql
	 * @param anotherByTableName
	 *            要添加数据规则的表的别名，空位null
	 * @return 添加数据规则后的sql语句
	 * @throws DBException
	 */
	public static String getDataSqlByInitSql(String anotherByTableName,HttpServletRequest request)
			throws DBException {
		// 获取当前登陆者
		String userIdByLogin = request.getSession().getAttribute(USERIDBYLOGIN).toString();
		StringBuffer sb = new StringBuffer();
		// 判断是否输入表的别名
		if (Validate.noNull(anotherByTableName)) {
			sb.append(anotherByTableName.toUpperCase());
			sb.append(DOT);
		}
		// 添加组装好的sql
		sb.append(MessageFormat.format(USERIDBYLOGINSQL,
				findListByumdata(userIdByLogin)));
		// 返回组装好的sql语句
		return sb.toString();
	}

	/**
	 * 查询当前管理者拥有的管理人员范围<br>
	 * 通过企事业单位进行区分用户
	 * 
	 * @param nowPage
	 *            当前页
	 * @param pageSize
	 *            每页显示条数
	 * @param managerId
	 *            管理者id
	 * @return 被管理者列表分页信息
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByumdata(int nowPage, int pageSize,
			String managerId) throws ManagerException {
		String dels = "SELECT  t.UMDATAID FROM umdata t ";
		dels += " left join umuser u on u.USERID = t.EMPLOYEEID ";
		dels += "where u.USERID is null";
		DBHelper dbHelper = new DBHelper();
		String sql = " SELECT ";
		sql += " USERID AS USERID, ";
		sql += " USERNAME AS USERNAME, ";
		sql += " LOGINNAME AS LOGINNAME, ";
		sql += " LOGINPASSWORD AS LOGINPASSWORD, ";
		sql += " UMDATAID AS UMDATAID, ";
		sql += " MANAGERID AS MANAGERID, ";
		sql += " EMPLOYEEID AS EMPLOYEEID ";
		sql += " FROM umdata t ";
		sql += " left join umuser u on u.USERID = t.EMPLOYEEID ";
		sql += " where 1 = 1 ";
		if (Validate.noNull(managerId)) {
			sql += " and t.MANAGERID = '" + managerId + "' ";
		}
		sql += " ORDER BY t.UMDATAID ";
		PageInfo pageInfo = null;
		try {
			List delList = dbHelper.queryForList(dels);
			for (int i = 0; i < delList.size(); i++) {
				dbHelper.execute(" delete from umdata where UMDATAID = '"
						+ ((Map) delList.get(i)).get("UMDATAID").toString()
						+ "' ");
			}
			pageInfo = new PageHelper(nowPage, pageSize, sql).getPageInfo();
		} catch (DBException e) {
			logger.error("查询数据库失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (PageException e) {
			logger.error("查询分页信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (SQLException e) {
			logger.error("执行数据同步失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return pageInfo;
	}

	/**
	 * 保存数据规则管理信息
	 * 
	 * @param initMap
	 *            cud格式的初始map
	 * @param split
	 *            cud格式name的分隔符
	 * @param tableFlag
	 *            cud格式单多表分隔符
	 * @return 执行成功返回true，失败false
	 * @throws ManagerException
	 */
	public boolean saveUmdataByCud(Map initMap, String split, String tableFlag)
			throws ManagerException {
		String managerId = initMap.get("MANAGERID").toString();
		String[] employeeids = initMap.get("EMPLOYEEID").toString().split(",");
		for (int i = 0; i < employeeids.length; i++) {
			initMap.put("P_UMDATA-" + i + "_MANAGERID_S_WD", managerId);
			initMap.put("P_UMDATA-" + i + "_EMPLOYEEID_S_WD", employeeids[i]);
			initMap.put("P_UMDATA-" + i + "_UMDATAID_S_P", null);
			initMap.put("P_UMDATA-" + i + "_MANAGERID_S_C", managerId);
			initMap.put("P_UMDATA-" + i + "_EMPLOYEEID_S_C", employeeids[i]);
		}
		try {
			return new CUDHelper(initMap, split, tableFlag).execute();
		} catch (CUDException e) {
			logger.error("执行cud失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
	}

	/**
	 * 根据当前管理者查询被管者列表信息
	 * 
	 * @param managerId
	 *            管理者id
	 * @return 被管理者id，多个中间用 ','分隔
	 * @throws DBException
	 */
	private static String findListByumdata(String managerId) throws DBException {
		String sql = " SELECT ";
		sql += " EMPLOYEEID AS EMPLOYEEID ";
		sql += " FROM umdata t ";
		sql += " where MANAGERID = '" + managerId + "' ";
		sql += " ORDER BY t.UMDATAID ";
		DBHelper dbHelper = new DBHelper();
		StringBuffer sb = new StringBuffer();
		Map map;
		List list;
		try {
			list = dbHelper.queryForList(sql);
			for (int i = 0; i < list.size(); i++) {
				map = (Map) list.get(i);
				sb.append(map.get("EMPLOYEEID"));
				sb.append(SPLIT);
			}
		} catch (DBException e) {
			logger.error("查询数据规则表失败");
			e.printStackTrace();
			throw new DBException(e);
		}
		sb.append(managerId);
		return sb.toString();
	}

}
