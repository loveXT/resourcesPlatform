package com.googosoft.filesManager.fileManager;

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

public class FolderController {
	
	private Logger logger = Logger.getLogger(FolderController.class.getName());

	/**
	 * 查询分类
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @param Major_id
	 * @param Chapter_id
	 * @param Course_id
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByFOLDER(int nowPage, int pageSize,
		String splitByQuery, HttpServletRequest request, String Major_id,
		String Chapter_id, String Course_id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.FOLDERNAME AS FOLDERNAME, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.FLMS AS FLMS, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.FOLDERCODE AS FOLDERCODE ");
		sql.append(" FROM FOLDER T ");
		sql.append(" WHERE 1 = 1 ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			sql.append(" ORDER BY FOLDERCODE ");
			// sql.append(SaasManager.getDataSqlByInitSql("T",request));
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
	 * 查询分类树
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeByFOLDER(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.FOLDERNAME AS FOLDERNAME, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.FLMS AS FLMS, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.FOLDERCODE AS FOLDERCODE ");
		sql.append(" FROM FOLDER T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			// sql.append(SaasManager.getDataSqlByInitSql("T", request));
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

	/**
	 * 根据分类Id查找分类信息
	 * @param FOLDERID
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByFOLDERID(String FOLDERID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.FOLDERNAME AS FOLDERNAME, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.FLMS AS FLMS, ");
		sql.append(" T.FOLDERCODE AS FOLDERCODE, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID");
		sql.append(" FROM FOLDER T ");
		sql.append(" WHERE t.FOLDERID= '" + FOLDERID + "' ");
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
	 * 根据知识点Id查找知识点信息
	 * @param POINT_ID
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByPOINT_ID(String POINT_ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" CP.CHAPTER_NAME AS CHAPTER_NAME,");//章节
		sql.append(" CP.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" M.MAJOR_ID AS MAJOR_ID , ");
		sql.append(" C.COURSE_ID AS COURSE_ID ");
		sql.append(" FROM KNOWLEDGE_POINT KP ");
		sql.append(" LEFT JOIN CHAPTER CP on KP.CHAPTER_ID=CP.CHAPTER_ID   ");
		sql.append(" LEFT JOIN COURSE_MAJOR C on CP.COURSE_ID=C.COURSE_ID   ");//课程    COURSE_MAJOR 课程专业表
		sql.append(" LEFT JOIN MAJOR M on M.MAJOR_ID=C.MAJOR_ID	");//课程    COURSE_MAJOR 课程专业表
		sql.append(" WHERE KP.POINT_ID= '" + POINT_ID + "' ");
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
	 * 查询章节
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @param Major_id
	 * @param Chapter_id
	 * @param Course_id
	 * @param POINT_ID
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByFOLDER1(int nowPage,
			int pageSize, // --------------------
			String splitByQuery, HttpServletRequest request, 
			String Chapter_id, String Course_id, String POINT_ID)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" CP.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" CP.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" C.KCID AS COURSE_ID , ");
		sql.append(" C.KCNAME AS COURSE_NAME ");
		sql.append(" FROM CHAPTER CP ");
		sql.append(" LEFT JOIN njbbxkrelation C on cp.course_id = C.KCID ");
		sql.append("WHERE 1 = 1");
		if (Chapter_id != null && !"".equals(Chapter_id)
				&& !"null".equals(Chapter_id)) {
			sql.append("and CP.CHAPTER_ID ='" + Chapter_id + "'");
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

}
