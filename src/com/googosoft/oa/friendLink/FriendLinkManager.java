package com.googosoft.oa.friendLink;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;


public class FriendLinkManager {
	private Logger logger = Logger.getLogger(FriendLinkManager.class.getName());
	/**
	 * 查询友情链接列表
	 * @param nowPage
	 * @param pageSize
	 */
	public PageInfo findPageInfoByFriendLink(int nowPage, int pageSize,
			String split,HttpServletRequest request) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.TITLE AS TITLE, ");
		sql.append(" T.URL AS URL, ");
		sql.append(" T.IMAGE AS IMAGE, ");
		sql.append(" T.IMAGENAME AS IMAGENAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.PLSX AS PLSX ");
		sql.append(" FROM FRIENDLINK T ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" ORDER BY to_number(T.PLSX) ");
		PageInfo pageInfo = null;
		try {
			sql.append( new QueryHelper().getQuerySqlByRequset(split, request));
			pageInfo = new PageHelper(nowPage, pageSize, sql.toString()).getPageInfo();
		} catch (DBException e) {
			logger.error("查询数据库信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (PageException e) {
			logger.error("查询分页信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (QueryException e) {
			logger.error("查询分页信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return pageInfo;
	}
	/**
	 * 按顺序查出前6条友情链接
	 * @throws ManagerException
	 */
	public List findListByFriendLink() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.TITLE AS TITLE, ");
		sql.append(" T.URL AS URL, ");
		sql.append(" T.IMAGE AS IMAGE, ");
		sql.append(" T.IMAGENAME AS IMAGENAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.PLSX AS PLSX ");
		sql.append(" FROM FRIENDLINK T ");
		sql.append(" WHERE 1 = 1 AND ROWNUM <=6 ");
		sql.append(" ORDER BY to_number(T.PLSX) ");
		List list = null;
		DBHelper dbHelper = new DBHelper();
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} 
		return list;
	}
	/**
	 * 按ID查出友情链接信息
	 * @throws ManagerException
	 */
	public Map findMapByID(String ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.TITLE AS TITLE, ");
		sql.append(" T.URL AS URL, ");
		sql.append(" T.IMAGE AS IMAGE, ");
		sql.append(" T.IMAGENAME AS IMAGENAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.PLSX AS PLSX ");
		sql.append(" FROM FRIENDLINK T ");
		sql.append(" WHERE  T.ID = '"+ID+"'");
		Map map = null;
		DBHelper dbHelper = new DBHelper();
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库信息失败");
			e.printStackTrace();
			throw new ManagerException(e);
		} 
		return map;
	}
}
