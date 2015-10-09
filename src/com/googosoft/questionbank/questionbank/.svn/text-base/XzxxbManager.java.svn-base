package com.googosoft.questionbank.questionbank;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.exception.TreeException;
import com.googosoft.ggs.saasManager.SaasManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class XzxxbManager {
	/*Logger logger = Logger.getLogger(XzxxbManager.class.getName());

	public PageInfo findPageInfoByQUESTION_XZXXB(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.XZXXB_ID AS XZXXB_ID, ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.OPTION1 AS OPTION1, ");
		sql.append(" T.OPTION2 AS OPTION2, ");
		sql.append(" T.OPTION3 AS OPTION3, ");
		sql.append(" T.OPTION4 AS OPTION4, ");
		sql.append(" T.OPTION5 AS OPTION5, ");
		sql.append(" T.OPTION6 AS OPTION6 ");
		sql.append(" FROM QUESTION_XZXXB T ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
//			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			pageInfo = new PageHelper(nowPage, pageSize, sql.toString())
					.getPageInfo();
		} catch (QueryException e) {
			logger.error("组装查询语句where条件的and语句失败\n" + e);
			throw new ManagerException("组装查询语句where条件的and语句失败\n" + e);
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (PageException e) {
			logger.error("查询分页信息失败\n" + e);
			throw new ManagerException("查询分页信息失败\n" + e);
		}
		return pageInfo;
	}

	public List findTreeByQUESTION_XZXXB(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.XZXXB_ID AS XZXXB_ID, ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.OPTION1 AS OPTION1, ");
		sql.append(" T.OPTION2 AS OPTION2, ");
		sql.append(" T.OPTION3 AS OPTION3, ");
		sql.append(" T.OPTION4 AS OPTION4, ");
		sql.append(" T.OPTION5 AS OPTION5, ");
		sql.append(" T.OPTION6 AS OPTION6");
		sql.append(" FROM QUESTION_XZXXB T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
//			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "ID", "PARENTID", "NAME");
			list = treeHelper.getTreeList();
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (TreeException e) {
			logger.error("组装树失败\n" + e);
			throw new ManagerException("组装树失败\n" + e);
		}
		return list;
	}

	public Map findMapByXZXXB_ID(String question_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.XZXXB_ID AS XZXXB_ID, ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.OPTION1 AS OPTION1, ");
		sql.append(" T.OPTION2 AS OPTION2, ");
		sql.append(" T.OPTION3 AS OPTION3, ");
		sql.append(" T.OPTION4 AS OPTION4, ");
		sql.append(" T.OPTION5 AS OPTION5, ");
		sql.append(" T.OPTION6 AS OPTION6 ");
		sql.append(" FROM QUESTION_XZXXB T ");
		sql.append(" WHERE t.QUESTION_ID= '" + question_ID + "' ");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return map;
	}
	
	public Map findMap(String question_id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.OPTION1 AS OPTION1, ");
		sql.append(" T.OPTION2 AS OPTION2, ");
		sql.append(" T.OPTION3 AS OPTION3, ");
		sql.append(" T.OPTION4 AS OPTION4  ");
		sql.append(" FROM QUESTION_XZXXB T ");
		sql.append(" WHERE QUESTION_ID = '" + question_id + "'");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return map;
	}
	
	*//**
	 * 将从数据库中获取的试题内容去掉<p>标签
	 * @param str
	 * @return
	 *//*
	public String getString(String str){
		str = str.replace("<p>","");
		str = str.replace("</p>","<br/>");
		return str;
	}*/
}
