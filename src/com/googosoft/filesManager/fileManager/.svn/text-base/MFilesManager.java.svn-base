package com.googosoft.filesManager.fileManager;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import mondrian.olap.MondrianDef.SQL;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
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

	public class MFilesManager {
		Logger logger = Logger.getLogger(MFilesManager.class.getName());

		public PageInfo findPageInfoBycourse(int nowPage, int pageSize,
				String splitByQuery, HttpServletRequest request)
				throws ManagerException {
			StringBuffer sql = new StringBuffer();
			sql.append(" SELECT ");
			sql.append(" T.COURSE_ID AS COURSE_ID, ");
			sql.append(" T.COURSE_NAME AS COURSE_NAME");
			sql.append(" FROM course T ");
			sql.append(" WHERE 1 = 1 ");
			PageInfo pageInfo = null;
			try {
				sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
						request));
				sql.append(SaasManager.getDataSqlByInitSql("T", request));
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

		public List findTreeBycourse(HttpServletRequest request,String MAJOR_ID)
				throws ManagerException {
			StringBuffer sql1 = new StringBuffer();
			sql1.append(" SELECT ");
			sql1.append(" T.COURSE_ID AS COURSE_ID, ");
			sql1.append(" T.COURSE_NAME AS COURSE_NAME");
			sql1.append(" FROM course T ");
			sql1.append(" WHERE 1 = 1 ");
			if(Validate.noNull(MAJOR_ID)){
				sql1.append(" AND T.COURSE_ID IN (SELECT COURSE_ID FROM COURSE_MAJOR WHERE MAJOR_ID = '"+MAJOR_ID+"'　)");
			}
			StringBuffer sql2 = new StringBuffer();
			sql2.append(" SELECT ");
			sql2.append(" K.CHAPTER_ID AS CHAPTER_ID, ");
			sql2.append(" K.CHAPTER_NAME AS CHAPTER_NAME,");
			sql2.append(" K.COURSE_ID AS COURSE_ID");
			sql2.append(" FROM chapter K ");
			sql2.append(" LEFT JOIN COURSE C ON C.COURSE_ID = K.COURSE_ID ");
			StringBuffer sql3 = new StringBuffer();
			sql3.append("select * from KNOWLEDGE_POINT K");
			sql3.append(" LEFT JOIN CHAPTER C ON C.CHAPTER_ID = K.CHAPTER_ID ");
			DBHelper dbHelper = new DBHelper();
			TreeHelper treeHelper = new TreeHelper();
			List list1 = null;
			List list2 = null;
			List list3 = null;
			try {
				//sql.append(SaasManager.getDataSqlByInitSql("T", request));
				list1 = dbHelper.queryForList(sql1.toString());
				list2 = dbHelper.queryForList(sql2.toString());
				list3 = dbHelper.queryForList(sql3.toString());
				treeHelper.addTreeList(list1, "COURSE_ID", "COURSE_ID", "COURSE_NAME",null,"S");
				treeHelper.addTreeList(list2, "CHAPTER_ID", "COURSE_ID", "CHAPTER_NAME",null,"C");
				treeHelper.addTreeList(list3, "POINT_ID", "CHAPTER_ID", "POINT_NAME",null,"U");
				list1 = treeHelper.getTreeList();
			} catch (DBException e) {
				logger.error("查询数据库失败\n" + e);
				throw new ManagerException("查询数据库失败\n" + e);
			} catch (TreeException e) {
				logger.error("组装树失败\n" + e);
				throw new ManagerException("组装树失败\n" + e);
			}
			return list1;
		}
		/**
		 * 部系专业课程章节树
		 * @param request
		 * @param MAJOR_ID
		 * @return
		 * @throws ManagerException
		 */
		public List findfileTreeBycourse(HttpServletRequest request,String MAJOR_ID)//修改章节 类别
				throws ManagerException {
			//部系
			StringBuffer sqlb = new StringBuffer();
			sqlb.append(" SELECT  ");
			sqlb.append(" T.UMDEPARTMENTID AS DEPTID, ");
			sqlb.append(" T.UMDEPARTMENTNAME AS DEPTNAME ");
			sqlb.append(" FROM UMDEPARTMENT T  ");
			sqlb.append(" LEFT JOIN MAJOR_BM MB ");
			sqlb.append(" ON MB.BM_ID = T.UMDEPARTMENTID ");
			sqlb.append(" WHERE 1=1");
			sqlb.append(" and MB.MAJOR_ID IS NOT NULL");
			sqlb.append(" GROUP BY T.UMDEPARTMENTID,T.UMDEPARTMENTNAME");
			sqlb.append(" UNION SELECT 'public' AS DEPTID,'公共基础课' AS DEPTNAME FROM DUAL");
			//专业
			StringBuffer sqlz = new StringBuffer();
			sqlz.append(" SELECT ");
			sqlz.append(" T.MAJOR_ID AS MAJOR_ID, ");
			sqlz.append(" T.MAJOR_NAME AS MAJOR_NAME, ");
//			sqlz.append(" decode(t.Major_id,'public','public',mb.bm_id) as deptid");
			sqlz.append(" mb.BM_ID as DEPTID");
			sqlz.append(" FROM major T ");
			sqlz.append(" LEFT JOIN MAJOR_BM MB ");
			sqlz.append(" ON MB.MAJOR_ID=T.MAJOR_ID ");
			sqlz.append(" WHERE 1 = 1 ");
			//课程
			StringBuffer sql1 = new StringBuffer();
			sql1.append(" SELECT ");
			sql1.append(" T.COURSE_ID AS COURSE_ID, ");
			sql1.append(" T.COURSE_NAME AS COURSE_NAME,");
			sql1.append(" CM.MAJOR_ID AS MAJOR_ID ");
			sql1.append(" FROM COURSE T ");
			sql1.append(" LEFT JOIN COURSE_MAJOR CM ");
			sql1.append(" ON CM.COURSE_ID=T.COURSE_ID");
			sql1.append(" WHERE 1 = 1 ");
//			if(Validate.noNull(MAJOR_ID)){
//				sql1.append(" AND T.COURSE_ID IN (SELECT COURSE_ID FROM COURSE_MAJOR WHERE MAJOR_ID = '"+MAJOR_ID+"'　)");
//			}
			//章节
			StringBuffer sql2 = new StringBuffer();
			sql2.append(" SELECT ");
			sql2.append(" K.CHAPTER_ID AS CHAPTER_ID, ");
			sql2.append(" K.CHAPTER_NAME AS CHAPTER_NAME,");
			sql2.append(" K.COURSE_ID AS COURSE_ID");
			sql2.append(" FROM chapter K ");
			sql2.append(" LEFT JOIN COURSE C ON C.COURSE_ID = K.COURSE_ID ");
//			//知识点
			StringBuffer sql3 = new StringBuffer();
			sql3.append(" SELECT POINT_ID,POINT_NAME,CHAPTER_ID FROM KNOWLEDGE_POINT");
			DBHelper dbHelper = new DBHelper();
			TreeHelper treeHelper = new TreeHelper();
			List listb = null;
			List listz = null;
			List list1 = null;
			List list2 = null;
//			List list3 = null;
			try {
				listb = dbHelper.queryForList(sqlb.toString());
				listz = dbHelper.queryForList(sqlz.toString());
				list1 = dbHelper.queryForList(sql1.toString());
				list2 = dbHelper.queryForList(sql2.toString());
//				list3 = dbHelper.queryForList(sql.toString());
				treeHelper.addTreeList(listb, "DEPTID", "DEPTID", "DEPTNAME", null, "B");
				treeHelper.addTreeList(listz, "MAJOR_ID", "DEPTID", "MAJOR_NAME", null, "Z");
				treeHelper.addTreeList(list1, "COURSE_ID", "MAJOR_ID", "COURSE_NAME",null,"S");
				treeHelper.addTreeList(list2, "CHAPTER_ID", "COURSE_ID", "CHAPTER_NAME",null,"C");
//				treeHelper.addTreeList(list3, "POINT_ID", "CHAPTER_ID", "POINT_NAME",null,"C");// id， 父id， 该id的name
				list1 = treeHelper.getTreeList();
			} catch (DBException e) {
				logger.error("查询数据库失败\n" + e);
				throw new ManagerException("查询数据库失败\n" + e);
			} catch (TreeException e) {
				logger.error("组装树失败\n" + e);
				throw new ManagerException("组装树失败\n" + e);
			}
			return list1;
		}
		/**
		 * 课程章节知识点树
		 * @param request
		 * @param MAJOR_ID
		 * @return
		 * @throws ManagerException
		 */
		public List findfileTreeByPoint(HttpServletRequest request,String MAJOR_ID)//修改章节 类别
				throws ManagerException {
			StringBuffer sql1 = new StringBuffer();
			//课程
			sql1.append(" SELECT ");
			sql1.append(" T.COURSE_ID AS COURSE_ID, ");
			sql1.append(" T.COURSE_NAME AS COURSE_NAME");
			sql1.append(" FROM course T ");
			sql1.append(" WHERE 1 = 1 ");
			if(Validate.noNull(MAJOR_ID)){
//				if("public".equals(MAJOR_ID)){
//					sql1.append(" AND T.COURSE_ID IN (SELECT COURSE_ID FROM COURSE_MAJOR WHERE MAJOR_ID IS NULL　)");
//				}else{
					sql1.append(" AND T.COURSE_ID IN (SELECT COURSE_ID FROM COURSE_MAJOR WHERE MAJOR_ID = '"+MAJOR_ID+"'　)");
//				}
			}
			StringBuffer sql2 = new StringBuffer();
			//章节
			sql2.append(" SELECT ");
			sql2.append(" K.CHAPTER_ID AS CHAPTER_ID, ");
			sql2.append(" K.CHAPTER_NAME AS CHAPTER_NAME,");
			sql2.append(" K.COURSE_ID AS COURSE_ID");
			sql2.append(" FROM chapter K ");
			sql2.append(" LEFT JOIN COURSE C ON C.COURSE_ID = K.COURSE_ID ");
			StringBuffer sql3 = new StringBuffer();
			
			//知识点
			sql3.append(" SELECT POINT_ID,POINT_NAME,CHAPTER_ID FROM KNOWLEDGE_POINT");
			DBHelper dbHelper = new DBHelper();
			TreeHelper treeHelper = new TreeHelper();
			List list1 = null;
			List list2 = null;
			List list3 = null;
			try {
				list1 = dbHelper.queryForList(sql1.toString());
				list2 = dbHelper.queryForList(sql2.toString());
				list3 = dbHelper.queryForList(sql3.toString());
				treeHelper.addTreeList(list1, "COURSE_ID", "COURSE_ID", "COURSE_NAME",null,"S");
				treeHelper.addTreeList(list2, "CHAPTER_ID", "COURSE_ID", "CHAPTER_NAME",null,"C");
				treeHelper.addTreeList(list3, "POINT_ID", "CHAPTER_ID", "POINT_NAME",null,"C");// id， 父id， 该id的name
				list1 = treeHelper.getTreeList();
			} catch (DBException e) {
				logger.error("查询数据库失败\n" + e);
				throw new ManagerException("查询数据库失败\n" + e);
			} catch (TreeException e) {
				logger.error("组装树失败\n" + e);
				throw new ManagerException("组装树失败\n" + e);
			}
			return list1;
		}
		public Map findMapByCOURSE_ID(String COURSE_ID) throws ManagerException {
			StringBuffer sql = new StringBuffer();
			sql.append(" SELECT ");
			sql.append(" T.COURSE_ID AS COURSE_ID, ");
			sql.append(" T.COURSE_NAME AS COURSE_NAME");
			sql.append(" FROM course T ");
			sql.append(" WHERE t.COURSE_ID= '" + COURSE_ID + "' ");
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
		public Map findMapByCOURSE_NAME(String COURSE_NAME,String MAJOR_ID) throws ManagerException {
			StringBuffer sql = new StringBuffer();
			sql.append(" SELECT ");
			sql.append(" T.COURSE_ID AS COURSE_ID, ");
			sql.append(" T.COURSE_NAME AS COURSE_NAME");
			sql.append(" FROM course T ");
			sql.append(" WHERE t.COURSE_NAME= '" + COURSE_NAME + "' ");
			if(MAJOR_ID!=null){
				sql.append("AND T.COURSE_ID IN (SELECT COURSE_ID FROM COURSE_MAJOR WHERE MAJOR_ID='"+MAJOR_ID+"')");
			}
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
		
		public Map findMapMAJOR_ID(String COURSE_ID) throws ManagerException {
			StringBuffer sql = new StringBuffer();
			sql.append(" SELECT *");
			sql.append(" FROM COURSE_MAJOR T ");
			sql.append(" WHERE t.COURSE_ID= '" + COURSE_ID + "' ");
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
