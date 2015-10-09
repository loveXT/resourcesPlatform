package com.googosoft.filesManager.course;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.filesManager.fileManager.FolderManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

public class CourseManager {
	private Logger logger = Logger.getLogger(FolderManager.class.getName());
	/**
	 * 我的教案查询所有的教案
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByCOURSE(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request,String state) throws ManagerException {
		String userId=request.getSession().getAttribute("USERIDBYLOGIN").toString();
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		//如果查询状态为空，则默认显示全部的，不为空则按条件查询
		if(Validate.noNull(state)){
			if("sub".equals(state)){
				//查询未提交的
				sql.append(" AND T.FLAG ='11'");
				sql.append(" AND T.COMMIT='00' ");
			}else if("ver".equals(state)){
				//查询打回的
				sql.append(" AND T.FLAG ='22' ");
				sql.append(" AND T.COMMIT='11' ");
			}else if("dver".equals(state)){
				//查询待审核的
				sql.append(" AND  ( T.FLAG='11' or T.FLAG='22' )");
				sql.append(" AND T.COMMIT='11' ");
			}else if("verd".equals(state)){
				//查询审核通过的
				sql.append(" AND T.FLAG ='44' ");
				sql.append(" AND T.COMMIT='11' ");
			}
		}
		sql.append(" AND T.UPLOADERID='"+userId+"' ");
		sql.append(" ORDER BY T.CREATETIME DESC ");
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
	 * 教案审核查询已经提交的教案
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByCOMMIT(int nowPage,int pageSize,
			String splitByQuery,HttpServletRequest request,String state,
			String beginTime,String endTime
			,String majorId,String classId,String uploader
	) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		sql.append(" AND T.COMMIT='11' ");
		//查询的开始时间
		if(Validate.noNull(beginTime)){
			sql.append(" AND substr(TO_CHAR(T.CHECKEDTIME),0,10)>='"+beginTime+"'");
		}
		//查询的结束时间
		if(Validate.noNull(endTime)){
			sql.append(" AND substr(TO_CHAR(T.CHECKEDTIME),0,10)<='"+endTime+"'");
		}
		if("sub".equals(state)){
			//待审核
			sql.append(" AND  ( T.FLAG='11' or T.FLAG='22' )");
		}else if("ver".equals(state)){
			//审核已通过
			sql.append(" AND T.FLAG='44' ");
		}else if("all".equals(state)){
			//查询全部
			sql.append(" AND ( T.FLAG='11' or T.FLAG='22' or T.FLAG='44' ) ");
		}
		if(Validate.noNull(majorId)){
			if("public".equals(majorId)){
				sql.append(" AND T.MAJOR_ID IS NULL ");
			}else{
				sql.append(" AND T.MAJOR_ID='"+majorId+"' ");
			}
		}
		if(Validate.noNull(classId)){
			sql.append(" AND T.CLASSID='"+classId+"' ");
		}
		if(Validate.noNull(uploader)){
			sql.append(" AND U.USERNAME LIKE '%"+uploader+"%' ");
		}
		sql.append(" ORDER BY T.CREATETIME DESC ");
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
	 * 下载修改为原文件名称
	 * @param REALNAME
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByFileName(String REALNAME) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PLANNAME AS PLANNAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME ");
		sql.append(" FROM TEACHPLAN T ");
		sql.append(" WHERE t.REALNAME= '" + REALNAME + "' ");
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
	
	/**
	 * 通过id得到username
	 * @param checkid
	 * @return username
	 * @throws ManagerException
	 */
	public Map findMapByChecker(String checkid) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.USERNAME AS USERNAME ");
		sql.append(" FROM UMUSER T ");
		sql.append(" WHERE t.USERID= '" + checkid + "' ");
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
	
	/**
	 * 综合查询教案信息(查询所有的审核通过的)
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findAllByChecked(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request) throws ManagerException {
		String majorId = request.getParameter("T.MAJOR_ID");
		String classId = request.getParameter("classes");
		String fileName = request.getParameter("FALSENAME");
		String uploader = request.getParameter("uploader");
		String isExcellent = request.getParameter("isExcellent");
		String startTime = request.getParameter("starttime");
		String endTime = request.getParameter("endtime");
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		sql.append(" AND T.COMMIT='11' AND T.FLAG ='44' ");

		if (Validate.noNull(majorId) && !"public".equals(majorId)) {
			sql.append(" AND T.MAJOR_ID='" + majorId + "' ");
		}
		if(Validate.noNull(majorId) && "public".equals(majorId)){
			sql.append(" AND T.MAJOR_ID IS NULL ");
		}
		if (Validate.noNull(classId)) {
			sql.append(" AND T.CLASSID='" + classId + "' ");
		}
		if(Validate.noNull(fileName)){
			sql.append(" AND T.PLANNAME LIKE '%"+fileName+"%' ");
		}
		if(Validate.noNull(uploader)){
			sql.append(" AND U.USERNAME LIKE '%"+uploader+"%' ");
		}
		if(Validate.noNull(isExcellent)){
			sql.append(" AND T.ISEXCELLENT = '"+isExcellent+"' ");
		}
		if(Validate.noNull(startTime)){
			sql.append(" AND T.CREATETIME >= '"+startTime+"' ");
		}
		if(Validate.noNull(endTime)){
			sql.append(" AND SUBSTR(T.CREATETIME,1,10) <= '"+endTime+"' ");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			sql.append(" order by T.CREATETIME desc ");
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
	 * 查询个人全部的信息和所有的审核通过的信息
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @param state
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findByPrivateAllAndVerified(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request,String state) throws ManagerException {
		String userId=request.getSession().getAttribute("USERIDBYLOGIN").toString();
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		//如果查询状态为空，则默认显示全部的，不为空则按条件查询
		if(Validate.noNull(state)){
			if("sub".equals(state)){
				//查询未提交的
				sql.append(" AND T.FLAG ='11'");
				sql.append(" AND T.COMMIT='00' ");
				sql.append(" AND T.UPLOADERID='"+userId+"' ");
			}else if("ver".equals(state)){
				//查询打回的
				sql.append(" AND T.FLAG ='22' ");
				sql.append(" AND T.COMMIT='11' ");
				sql.append(" AND T.UPLOADERID='"+userId+"' ");
			}else if("dver".equals(state)){
				//查询待审核的
				sql.append(" AND  ( T.FLAG='11' or T.FLAG='22' )");
				sql.append(" AND T.COMMIT='11' ");
				sql.append(" AND T.UPLOADERID='"+userId+"' ");
			}else if("verd".equals(state)){
				//查询审核通过的
				sql.append(" AND T.FLAG ='44' ");
				sql.append(" AND T.COMMIT='11' ");
			}
		}
		sql.append(" ORDER BY T.CREATETIME DESC ");
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
	
	private StringBuffer findCommonFields(){
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.PLANID AS PLANID, ");
		sql.append(" T.PLANNAME AS PLANNAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.UPLOADERID AS UPLOADERID, ");
		sql.append(" T.CHECKEDER AS CHECKEDER, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.DOWNLOAD AS DOWNLOAD, ");
		sql.append(" T.CLASSID AS CLASSID, ");
		sql.append(" T.COMMIT AS COMMIT, ");
		sql.append(" T.ISEXCELLENT AS ISEXCELLENT, ");
		sql.append(" T.CHECKEDTIME AS CHECKEDTIME, ");
		
		sql.append(" B.BJMC AS BJMC, ");
		
		sql.append(" M.MAJOR_NAME AS MAJOR_NAME , ");
		sql.append(" C.COURSE_NAME AS COURSE_NAME , ");
		sql.append(" CP.CHAPTER_NAME AS CHAPTER_NAME,  ");
		sql.append(" U.USERNAME AS UPLOADER ");
		
		sql.append(" FROM TEACHPLAN T LEFT JOIN major M on T.MAJOR_ID=M.MAJOR_ID ");
		sql.append(" LEFT JOIN course C on T.COURSE_ID=C.COURSE_ID ");
		sql.append(" LEFT JOIN chapter CP on T.CHAPTER_ID=CP.CHAPTER_ID ");
		sql.append(" LEFT JOIN UMUSER U ON T.UPLOADERID=U.USERID ");
		sql.append(" LEFT JOIN BJXX B ON T.CLASSID=B.GID ");
		sql.append(" WHERE 1 = 1  ");
		return sql;
	}
}
