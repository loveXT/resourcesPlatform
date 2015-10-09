package com.googosoft.filesManager.fileManager;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

public class SelectFilesManager {
	Logger logger = Logger.getLogger(SelectFilesManager.class.getName());
	
	/**
	 * 综合查询
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByFILES(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request) throws ManagerException {
		String greater = request.getParameter("starttime");
		String less = request.getParameter("endtime");
		String majorId = request.getParameter("T.MAJOR_ID");
		String extendname = request.getParameter("EXTENDNAME");
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" F.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" CONCAT(T.FALSENAME,T.EXTENDNAME) AS FULLNAME, ");
		sql.append(" T.UPLOADER AS UPLOADER, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" M.MAJOR_NAME AS MAJOR_NAME, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" C.KCNAME AS COURSE_NAME, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" P.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CLASSIFY AS CLASSIFY, ");
		sql.append(" T.DOWNLOAD AS DOWNLOAD, ");
		sql.append(" T.ISEXCELLENT AS ISEXCELLENT, ");
		sql.append(" T.CHECKEDID AS CHECKEDID, ");
		sql.append(" T.CHECKEDER AS CHECKEDER, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.UPLOADERID AS UPLOADERID ");
		sql.append(" FROM FILES T ");
		sql.append(" LEFT JOIN MAJOR M ON T.MAJOR_ID=M.MAJOR_ID ");
		sql.append(" LEFT JOIN NJBBXKRELATION C ON T.COURSE_ID=C.KCID ");
		sql.append(" LEFT JOIN CHAPTER P ON T.CHAPTER_ID=P.CHAPTER_ID ");
		sql.append(" LEFT JOIN KNOWLEDGE_POINT F ON T.POINT_ID=F.POINT_ID ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.FLAG='22' ");
		if("public".equals(majorId)){
			sql.append(" AND T.MAJOR_ID = 'public' ");
		}else if(Validate.noNull(majorId)){
			sql.append(" AND T.MAJOR_ID='"+majorId+"' ");
		}
			//判断查询的资源分类
			if(Validate.noNull(extendname)){
					sql.append(" AND T.CLASSIFY='"+extendname+"' ");
			}
		if(Validate.noNull(greater)){
			sql.append(" AND SUBSTR(T.CREATETIME,1,10) >= '"+greater+"'");
		}
		if(Validate.noNull(less)){
			sql.append(" AND SUBSTR(T.CREATETIME,1,10) <= '"+less+"'");
		}
		String falseName = request.getParameter("FALSENAME");
		if(Validate.noNull(falseName)){
			sql.append(" AND (T.FALSENAME LIKE '%"+falseName+"%' OR T.EXTENDNAME LIKE '%"+falseName+"%') ");
		}
		PageInfo pageInfo=null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery, request));
			sql.append(" ORDER BY CREATETIME DESC ");
//			sql.append(SaasManager.getDataSqlByInitSql("T",request));
			pageInfo=new PageHelper(nowPage,pageSize,sql.toString()).getPageInfo();
		}catch (QueryException e) {
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
	 * 按上传时间查询资源信息
	 */
	public List findListByFiles() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" CONCAT(T.FALSENAME,T.EXTENDNAME) AS FULLNAME, ");
		sql.append(" T.UPLOADER AS UPLOADER, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CLASSIFY AS CLASSIFY, ");
		sql.append(" R.NAME AS NAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.FILENAME2 AS FILENAME2, ");
		sql.append(" T.UPLOADERID AS UPLOADERID ");
		sql.append(" FROM FILES T ");
		sql.append(" LEFT JOIN RESOURCEMANAGER R ON R.ID=T.CLASSIFY ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.FLAG='22' ");
		sql.append(" ORDER BY T.CREATETIME DESC ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	/**
	 * 按浏览次数查询资源信息
	 */
	public List findListByDownLoad() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" CONCAT(T.FALSENAME,T.EXTENDNAME) AS FULLNAME, ");
		sql.append(" T.UPLOADER AS UPLOADER, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CLASSIFY AS CLASSIFY, ");
		sql.append(" R.NAME AS NAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.FILENAME2 AS FILENAME2, ");
		sql.append(" T.DOWNLOADTIME AS DOWNLOADTIME, ");
		sql.append(" T.BROWSETIME AS BROWSETIME, ");
		sql.append(" T.UPLOADERID AS UPLOADERID ");
		sql.append(" FROM FILES T ");
		sql.append(" LEFT JOIN RESOURCEMANAGER R ON R.ID=T.CLASSIFY ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.FLAG='22' ");
		sql.append(" ORDER BY T.BROWSETIME DESC ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	/**
	 * 查找所有专业
	 * @return
	 * @throws ManagerException
	 */
	public List findPageInfo() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM MAJOR ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	
	/**
	 * 查找某专业下的所有课程
	 * @param majorId
	 * @return
	 * @throws ManagerException
	 */
	public List findCourseByMajorId(String majorId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" C.COURSE_ID AS COURSE_ID, ");
		sql.append(" C.COURSE_NAME AS COURSE_NAME, ");
		if("public".equals(majorId)){
			sql.append(" '公共基础课' AS MAJOR_ID ");
		}else{
			sql.append(" M.MAJOR_ID AS MAJOR_ID ");
		}
		sql.append(" FROM COURSE C ");
		sql.append(" LEFT JOIN COURSE_MAJOR M ON C.COURSE_ID=M.COURSE_ID ");
		if(Validate.noNull(majorId)){
			if("public".equals(majorId)){
				sql.append(" WHERE C.COURSE_TYPE='公共基础课' ");
			}else if("FG".equals(majorId)){
				sql.append(" WHERE C.COURSE_TYPE !='公共基础课' ");
			}else{
				sql.append(" WHERE M.MAJOR_ID='"+majorId+"' ");
			}
		}
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	/**
	 * 查找某课程下的所有章节
	 * @param courseId
	 * @return
	 * @throws ManagerException
	 */
	public List findChapterByCourseId(String courseId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" C.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" C.CHAPTER_NAME AS CHAPTER_NAME, ");
		sql.append(" C.COURSE_ID AS COURSE_ID ");
		sql.append(" FROM CHAPTER C ");
		if(Validate.noNull(courseId)){
			sql.append(" WHERE C.COURSE_ID='"+courseId+"' ");
		}
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	/**
	 * 查找某章节下的所有分类
	 * @param chapterId
	 * @return
	 * @throws ManagerException
	 */
	public List findFolderByChapterId() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" C.FOLDERID AS FOLDERID, ");
		sql.append(" C.FOLDERNAME AS FOLDERNAME ");
		sql.append(" FROM FOLDER C ");
		sql.append(" WHERE 1=1 ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	
	/**
	 * @return
	 * @throws ManagerException
	 * 通过专业查找班级
	 */
	public List findClassByMajorId(String majorId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT T.GID AS GID,");
		sql.append(" T.BJMC AS BJMC, ");
		sql.append(" T.ZYDM AS ZYDM ");
		sql.append(" FROM BJXX T ");
		if( !"public".equals(majorId)){
			sql.append(" WHERE T.ZYDM='"+majorId+"' ");
		}
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	/**
	 * 查询单条资源详细信息
	 */
	public Map findMapByFilesID(String id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" CONCAT(T.FALSENAME,T.EXTENDNAME) AS FULLNAME, ");
		sql.append(" T.UPLOADER AS UPLOADER, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CLASSIFY AS CLASSIFY, ");
		sql.append(" R.NAME AS NAME, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.FILENAME2 AS FILENAME2, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.DOWNLOADTIME AS DOWNLOADTIME, ");
		sql.append(" T.BROWSETIME AS BROWSETIME, ");
		sql.append(" T.DOWNLOAD AS DOWNLOAD, ");
		sql.append(" T.FILESIZE AS FILESIZE, ");
		sql.append(" C.KCNAME AS KCNAME, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" M.MAJOR_NAME AS MAJORNAME, ");
		sql.append(" T.UPLOADERID AS UPLOADERID ");
		sql.append(" FROM FILES T ");
		sql.append(" LEFT JOIN NJBBXKRELATION C ON C.KCID=T.COURSE_ID ");
		sql.append(" LEFT JOIN RESOURCEMANAGER R ON R.ID=T.CLASSIFY ");
		sql.append(" LEFT JOIN MAJOR M ON M.MAJOR_ID=T.MAJOR_ID ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.FLAG='22' ");
		sql.append(" AND T.FILEID='"+id+"'");
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
	 * 增加下载次数
	 * @param fileId
	 * @return
	 * @throws DBException
	 * @throws SQLException
	 */
	public int updateFiles(String fileId) throws DBException, SQLException{
		String sql = "UPDATE FILES T SET T.DOWNLOADTIME= T.DOWNLOADTIME + 1  WHERE T.FILEID='"+fileId+"'";
		DBHelper dbh = new DBHelper();
		dbh.execute(sql);
		sql = " SELECT T.DOWNLOADTIME FROM FILES T WHERE T.FILEID='"+fileId+"' ";
		int num = Integer.valueOf(dbh.queryForSingleValue(sql).toString());
		return num;
	}
	/**
	 * 增加浏览次数
	 * @param fileId
	 * @return
	 * @throws DBException
	 * @throws SQLException
	 */
	public int updateFilesBROWSETIME(String fileId) throws DBException, SQLException{
		String sql = "UPDATE FILES T SET T.BROWSETIME= T.BROWSETIME + 1  WHERE T.FILEID='"+fileId+"'";
		DBHelper dbh = new DBHelper();
		dbh.execute(sql);
		sql = " SELECT T.BROWSETIME FROM FILES T WHERE T.FILEID='"+fileId+"' ";
		int num = Integer.valueOf(dbh.queryForSingleValue(sql).toString());
		return num;
	}
	/**
	 * 查询评论
	 * @param nowPage
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @param mid
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByCONTENT(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request,String mid)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CID AS CID, ");
		sql.append(" T.USERID AS USERID, ");
		sql.append(" T.MID AS MID, ");
		sql.append(" T.CONTENT AS CONTENT, ");
		sql.append(" to_char(T.CREATETIME,'yyyy-MM-dd hh24:mi:ss') AS CREATETIME, ");
		sql.append(" U.USERNAME AS USERNAME ");
		sql.append(" FROM CONTENT T ");
		sql.append(" LEFT JOIN UMUSER U ON T.USERID=U.USERID ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.MID = '"+mid+"' ");
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			sql.append(" ORDER BY T.CREATETIME DESC ");
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
}
