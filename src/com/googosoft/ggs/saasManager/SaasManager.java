package com.googosoft.ggs.saasManager;

import java.text.MessageFormat;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.ISessionContants;
import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;

/**
 * 企事业单位查询管理类
 * 
 * @author xuanly
 * 
 */
public class SaasManager implements ISaasContants ,ISessionContants{
	private Logger logger = Logger.getLogger(SaasManager.class.getName());

	/**
	 * 执行saas查询
	 * 
	 * @param anotherByTableName
	 *            表名别称 空为null
	 * @return 组装后的sql
	 */
	public static String getDataSqlByInitSql(String anotherByTableName,HttpServletRequest request) {
		// 获取当前登录企事业编号
		String saas = request.getSession().getAttribute(SAAS).toString();
		// 添加企事业规则
		StringBuffer sb = new StringBuffer(AND);
		// 验证表的别名
		if (Validate.noNull(anotherByTableName)) {
			sb.append(anotherByTableName.toUpperCase());
			sb.append(DOT);
		}
		// 添加sql语句
		sb.append(MessageFormat.format(SAASSQL, saas));
		// 返回sql语句
		return sb.toString();
	}

	/**
	 * 获取企事业单位的分页信息
	 * 
	 * @param nowPage
	 *            第几页
	 * @param pageSize
	 *            每页显示条数
	 * @return 企事业单位的分页信息
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByumsaas(int nowPage, int pageSize)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" UMSAASID AS UMSAASID, ");
		sql.append(" UMSAASCOOD AS UMSAASCOOD, ");
		sql.append(" UMSAASNAME AS UMSAASNAME, ");
		sql.append(" UMUSERID AS UMUSERID ");
		sql.append(" FROM umsaas t ");
		sql.append(" ORDER BY t.UMSAASID ");
		PageInfo pageInfo = null;
		try {
			pageInfo = new PageHelper(nowPage, pageSize, sql.toString())
					.getPageInfo();
		} catch (DBException e) {
			logger.error("查询数据库失败");
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
	 * 根据企事业单位id查询企事业信息
	 * 
	 * @param UMSAASID
	 *            企事业id
	 * @return 单个企事业信息
	 * @throws ManagerException
	 */
	public Map findMapByUMSAASID(String UMSAASID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" UMSAASID AS UMSAASID, ");
		sql.append(" UMSAASCOOD AS UMSAASCOOD, ");
		sql.append(" UMSAASNAME AS UMSAASNAME, ");
		sql.append(" UMUSERID AS UMUSERID ");
		sql.append(" FROM umsaas t ");
		sql.append(" WHERE t.UMSAASID= '" + UMSAASID + "' ");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询企事业信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return map;
	}

}
