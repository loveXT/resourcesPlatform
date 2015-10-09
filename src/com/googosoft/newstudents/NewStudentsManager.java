package com.googosoft.newstudents;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.ISessionContants;
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


public class NewStudentsManager {
	Logger logger = Logger.getLogger(NewStudentsManager.class.getName());
	/**
	 * 部门，专业，班级树
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeByDeptMajorClass(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" t.nodeid as deptid, " );
		sql.append(" t.nodename AS deptname " );
		sql.append(" FROM departmentmajorclass T ");
		sql.append(" where t.topjd = '0' ");
		StringBuffer sql1 = new StringBuffer();
		sql1.append(" SELECT ");
		sql1.append(" t.nodeid as majorid, " );
		sql1.append(" t.nodename AS majorname, " );
		sql1.append(" t.sjjd AS deptid " );
		sql1.append(" FROM departmentmajorclass T ");
		sql1.append(" where t.topjd = 'zy' ");
		StringBuffer sql2 = new StringBuffer();
		sql2.append(" SELECT ");
		sql2.append(" t.nodeid as classid, " );
		sql2.append(" t.nodename AS classname, " );
		sql2.append(" t.sjjd AS majorid " );
		sql2.append(" FROM departmentmajorclass T ");
		sql2.append(" where t.topjd = 'bj' ");
		
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list=null;
		List listDept = null;
		List listMajor = null;
		List listClasses = null;
		try {
			listDept=dbHelper.queryForList(sql.toString());
			listMajor=dbHelper.queryForList(sql1.toString());
			listClasses=dbHelper.queryForList(sql2.toString());
			treeHelper.addTreeList(listDept, "deptid", "deptid", "deptname","","D");
			treeHelper.addTreeList(listMajor, "majorid", "deptid", "majorname","","M");
			treeHelper.addTreeList(listClasses, "classid", "majorid", "classname","","C");
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
	/**
	 * 学生列表
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByStudent(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		String flag = request.getParameter("flag");
		String sid = request.getParameter("sid");
		String pc = request.getParameter("pc");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.XSBH AS XSBH, ");//学生id
		sql.append(" T.XSXM AS XSXM, ");//学生姓名
		sql.append(" T.XB AS XB, ");//性别
		sql.append(" T.XXZY AS XXZY, ");//专业id
		sql.append(" T.ZYMC AS ZYMC,");//专业名称
		sql.append(" T.SSBJ AS SSBJ, ");//学生班级id
		sql.append(" T.BJMC AS BJMC, ");//班级名称
		sql.append(" T.BYXX AS BYXX, ");//毕业学校
		sql.append(" T.ZSPC AS ZSPC, ");//批次id
		sql.append(" T.PCMC AS PCMC, ");//批次名称
		sql.append(" T.BMBH AS BMBH ");//部门id
//		sql.append(" D.SJJD AS BMBH ");
		sql.append(" FROM ZCSTUDENT T ");
//		sql.append( "LEFT JOIN DEPARTMENTMAJORCLASS D ON D.NODEID = T.XXZY" );
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(pc)){
			sql.append(" AND T.ZSPC ='"+pc+"' ");
		}
		if(Validate.noNull(flag)&&Validate.noNull(sid)){
			if("D".endsWith(flag)){
				sql.append(" AND T.BMBH = '"+sid+"' ");
			}else if("M".endsWith(flag)){
				sql.append(" AND T.XXZY = '"+sid+"' ");
			}else if("C".endsWith(flag)){
				sql.append(" AND T.SSBJ = '"+sid+"' ");
			}
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
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
	
	/**
	 * 导出专用方法
	 * @param ids
	 * @return
	 * @throws ManagerException
	 */
	public List findListByExport(HttpServletRequest request) throws ManagerException {
		String flag = request.getParameter("flag");
		String sid = request.getParameter("sid");
		String pc = request.getParameter("pc");
		String ids = request.getParameter("idSet");
		String xm = request.getParameter("P_Q_LIKE_T.XSXM");
		String xb = request.getParameter("P_Q_LIKE_T.XB");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.XSBH AS XSBH, ");//学生id
		sql.append(" T.XSXM AS XSXM, ");//学生姓名
		sql.append(" T.XB AS XB, ");//性别
		sql.append(" T.XXZY AS XXZY, ");//专业id
		sql.append(" T.ZYMC AS ZYMC,");//专业名称
		sql.append(" T.SSBJ AS SSBJ, ");//学生班级id
		sql.append(" T.BJMC AS BJMC, ");//班级名称
		sql.append(" T.BYXX AS BYXX, ");//毕业学校
		sql.append(" T.ZSPC AS ZSPC, ");//批次id
		sql.append(" T.PCMC AS PCMC, ");//批次名称
		sql.append(" T.BMBH AS BMBH ");//部门id
		sql.append(" FROM ZCSTUDENT T ");
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(pc)){
			sql.append(" AND T.ZSPC ='"+pc+"' ");
		}
		if(Validate.noNull(ids)){
			sql.append(" AND T.XSBH in('"+ids+"') ");
		}
		if(Validate.noNull(xm)){
			sql.append(" AND T.XSXM like '%"+xm+"%' ");
		}
		if(Validate.noNull(xb)){
			sql.append(" AND T.XB = '"+xb+"' ");
		}
		if(Validate.noNull(flag)&&Validate.noNull(sid)){
			if("D".endsWith(flag)){
				sql.append(" AND T.BMBH = '"+sid+"' ");
			}else if("M".endsWith(flag)){
				sql.append(" AND T.XXZY = '"+sid+"' ");
			}else if("C".endsWith(flag)){
				sql.append(" AND T.SSBJ = '"+sid+"' ");
			}
		}
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
			logger.error("查询失败!", e);
		}
		return list;
	}
	
	/**
	 * 获得当前批次
	 */
	public Map findPcMap(){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PCID AS PCID, ");
		sql.append(" T.PCMC AS PCMC ");
		sql.append(" FROM zspc T ");
		sql.append(" WHERE T.SFDQ ='1'");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 获取批次（非当前）
	 * @return
	 * @throws ManagerException
	 */
	public List findListByPc() throws ManagerException {
		List list = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PCID AS PCID, ");
		sql.append(" T.PCMC AS PCMC ");
		sql.append(" FROM zspc T ");
		sql.append(" WHERE T.SFDQ ='0'");
		DBHelper dbHelper = new DBHelper();
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
}
