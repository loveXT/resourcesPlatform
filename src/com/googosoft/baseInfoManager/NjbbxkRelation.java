package com.googosoft.baseInfoManager;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

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

public class NjbbxkRelation {
	public static Logger logger = Logger.getLogger(NjbbxkRelation.class.getName());
	public PageInfo findPageInfoByNjbbxkRelation(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.KCID AS KCID, ");
		sql.append(" T.GRADEID AS GRADEID, ");
		sql.append(" G.NJMC AS NJMC, ");
		sql.append(" T.VERSIONID AS VERSIONID, ");
		sql.append(" V.VERSIONNAME AS VERSIONNAME, ");
		sql.append(" T.COURSEID AS COURSEID, ");
		sql.append(" C.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM NJBBXKRELATION T ");
		sql.append(" LEFT JOIN COURSE C ON C.COURSE_ID=T.COURSEID ");
		sql.append(" LEFT JOIN GRADE G ON G.ID=T.GRADEID ");
		sql.append(" LEFT JOIN VERSION V ON V.ID=T.VERSIONID ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			sql.append("order by t.createtime asc ");
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
	public Map findMapByID(String ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.KCID AS KCID, ");
		sql.append(" T.GRADEID AS GRADEID, ");
		sql.append(" G.NJMC AS NJMC, ");
		sql.append(" T.VERSIONID AS VERSIONID, ");
		sql.append(" V.VERSIONNAME AS VERSIONNAME, ");
		sql.append(" T.COURSEID AS COURSEID, ");
		sql.append(" C.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM NJBBXKRELATION T ");
		sql.append(" LEFT JOIN COURSE C ON C.COURSE_ID=T.COURSEID ");
		sql.append(" LEFT JOIN GRADE G ON G.ID=T.GRADEID ");
		sql.append(" LEFT JOIN VERSION V ON V.ID=T.VERSIONID ");		
		sql.append(" WHERE t.KCID= '" + ID + "' ");
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
	public List findListNjbbxkRelation(){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.KCID AS KCID, ");
		sql.append(" T.GRADEID AS GRADEID, ");
		sql.append(" G.NJMC AS NJMC, ");
		sql.append(" T.VERSIONID AS VERSIONID, ");
		sql.append(" V.VERSIONNAME AS VERSIONNAME, ");
		sql.append(" T.COURSEID AS COURSEID, ");
		sql.append(" C.COURSE_NAME AS COURSE_NAME, ");
		sql.append(" G.NJMC||C.COURSE_NAME||V.VERSIONNAME AS COURSENAME,");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.REMARK AS REMARK ");
		sql.append(" FROM NJBBXKRELATION T ");
		sql.append(" LEFT JOIN COURSE C ON C.COURSE_ID=T.COURSEID ");
		sql.append(" LEFT JOIN GRADE G ON G.ID=T.GRADEID ");
		sql.append(" LEFT JOIN VERSION V ON V.ID=T.VERSIONID ");
		sql.append(" WHERE 1=1 ");
		sql.append(" order by t.createtime ");
		List list = null;
		DBHelper dbHelper = new DBHelper();
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List findTreeByNjbbxkRelation()
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.KCID AS KCID, ");
		sql.append(" T.KCNAME AS COURSENAME,");
		sql.append(" T.CREATETIME AS CREATETIME ");
		sql.append(" FROM NJBBXKRELATION T ");
		sql.append(" WHERE 1=1 ");		
		sql.append(" order by t.createtime ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "KCID", "KCID", "COURSENAME", "", "K");
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
}

