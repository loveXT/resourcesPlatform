package com.googosoft.questionbank.qsbasemanager.controller;

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

public class PointController {
	
	private Logger logger = Logger.getLogger(TypeController.class.getName());
	
	public PageInfo findPageInfoByknowledge_point(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM knowledge_point T ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo=null;
		try {sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery, request));
		sql.append(SaasManager.getDataSqlByInitSql("T",request));
		pageInfo=new PageHelper(nowPage,pageSize,sql.toString()).getPageInfo();
		}catch (QueryException e) {logger.error("组装查询语句where条件的and语句失败\n" + e);
		throw new ManagerException("组装查询语句where条件的and语句失败\n" + e);
		} catch (DBException e) {logger.error("查询数据库失败\n" + e);
		throw new ManagerException("查询数据库失败\n" + e);
		} catch (PageException e) {logger.error("查询分页信息失败\n" + e);
		throw new ManagerException("查询分页信息失败\n" + e);
		}return pageInfo;
		}
		public List findTreeByknowledge_point(HttpServletRequest request) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM knowledge_point T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper=new DBHelper();
		TreeHelper treeHelper=new TreeHelper();
		List list=null;
		try {sql.append(SaasManager.getDataSqlByInitSql("T", request));
		list=dbHelper.queryForList(sql.toString());
		treeHelper.addTreeList(list, "ID", "PARENTID", "NAME");
		list=treeHelper.getTreeList();
		} catch (DBException e) {logger.error("查询数据库失败\n" + e);
		throw new ManagerException("查询数据库失败\n" + e);
		} catch (TreeException e) {logger.error("组装树失败\n" + e);
		throw new ManagerException("组装树失败\n" + e);
		}return list;
		}
		public Map findMapByPOINT_ID(String POINT_ID) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM knowledge_point T ");
		sql.append(" WHERE t.POINT_ID= '"+POINT_ID+"' ");
		DBHelper dbHelper=new DBHelper();
		Map map=null;
		try {map=dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {logger.error("查询数据库失败\n" + e);
		throw new ManagerException("查询数据库失败\n" + e);
		}return map;
		}
		
		public PageInfo findPageInfoBychapterId(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request,String chapterId) throws ManagerException {
			StringBuffer sql=new StringBuffer();
			sql.append(" SELECT ");
			sql.append(" T.POINT_ID AS POINT_ID, ");
			sql.append(" T.POINT_NAME AS POINT_NAME, ");
			sql.append(" T.POINT_CONTENT AS POINT_CONTENT, ");
			sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
			sql.append(" T.COURSE_ID AS COURSE_ID, ");
			sql.append(" T.SAAS AS SAAS, ");
			sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
			sql.append(" T.REMARK AS REMARK, ");
			sql.append(" T.CREATETIME AS CREATETIME ");
			sql.append(" FROM knowledge_point T ");
			sql.append(" WHERE CHAPTER_ID = '"+chapterId+"'");
			PageInfo pageInfo=null;
			try {sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery, request));
			sql.append(SaasManager.getDataSqlByInitSql("T",request));
			pageInfo=new PageHelper(nowPage,pageSize,sql.toString()).getPageInfo();
			}catch (QueryException e) {logger.error("组装查询语句where条件的and语句失败\n" + e);
			throw new ManagerException("组装查询语句where条件的and语句失败\n" + e);
			} catch (DBException e) {logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
			} catch (PageException e) {logger.error("查询分页信息失败\n" + e);
			throw new ManagerException("查询分页信息失败\n" + e);
			}return pageInfo;
			}
		
		/**
		 * 通过节IDS来查询在试题中所存在的分值数
		 * @param pointIds
		 * @return
		 * @throws ManagerException
		 */
		public Map findPageInfoByPointIds(String pointIds) throws ManagerException {
			StringBuffer sql = new StringBuffer();
			sql.append(" SELECT ");
			sql.append(" T.QUESTION_FZXX AS QUESTION_FZXX ");
			sql.append(" FROM question T ");
			sql.append(" WHERE 1 = 1 ");
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
}
