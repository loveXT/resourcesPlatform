package com.googosoft.filesManager.fileManager;

import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.print.attribute.standard.PageRanges;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

import com.googosoft.common.util.Validator;
import com.googosoft.commons.CodeHelper;
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

/**
 * @author csh
 *
 */
public class FilesManager {
	private Logger logger = Logger.getLogger(FolderManager.class.getName());
	
	/**
	 * 查询个人的资源
	 * @param nowPage 
	 * @param pageSize
	 * @param splitByQuery
	 * @param request
	 * @param Major_id
	 * @param COURSE_ID
	 * @param CHAPTER_ID
	 * @throws ManagerException
	 * @author gc
	 */
	public PageInfo findPageInfoByFILES(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request,
			String Major_id, String COURSE_ID, String CHAPTER_ID,String Flag) throws ManagerException {
		String USERIDBYLOGIN = (String)request.getSession().getAttribute("USERIDBYLOGIN");
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		sql.append(" AND T.UPLOADERID = '"+USERIDBYLOGIN+"' ");
		if(Validate.noNull(Flag)){
			sql.append(" AND T.FLAG='"+Flag+"'");
		}
		//判断查询的资源分类
				String extendname = request.getParameter("EXTENDNAME");
				if(Validate.noNull(extendname)){
						sql.append(" AND T.CLASSIFY='"+extendname+"' ");
				}
		sql.append(" ORDER BY case T.FLAG when '33' then 1 when '00' then 2 when '11' then 3 when '22' then 4 else 5 end  , T.CREATETIME DESC");
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

	
	/**
	 * 查询文件树
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeByFILES(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.UPLOADER AS UPLOADER, ");
		sql.append(" T.UPLOADERID AS UPLOADERID, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.ISEXCELLENT AS ISEXCELLENT, ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.DOWNLOAD AS DOWNLOAD, ");
		sql.append(" T.CHECKEDER AS CHECKEDER, ");
		sql.append(" FROM FILES T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			sql.append(SaasManager.getDataSqlByInitSql("T", request));
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
	 * 查询文件详细信息
	 * @param FILEID
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByFILEID(String FILEID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" F.POINT_NAME AS POINT_NAME, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" CONCAT(T.FALSENAME,T.EXTENDNAME) AS FULLNAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.UPLOADER AS UPLOADER, ");
		sql.append(" T.UPLOADERID AS UPLOADERID, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.CLASSIFY AS CLASSIFY, ");
		sql.append(" CP.CHAPTER_NAME AS CHAPTER_NAME,");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.DOWNLOAD AS DOWNLOAD, ");
		sql.append(" T.CHECKEDER AS CHECKEDER, ");
		sql.append(" T.ISEXCELLENT AS ISEXCELLENT, ");
		sql.append(" T.CHECKEDID AS CHECKEDID");
		sql.append(" FROM FILES T ");
		sql.append(" LEFT JOIN KNOWLEDGE_POINT F ON T.POINT_ID=F.POINT_ID ");
		sql.append(" LEFT JOIN CHAPTER CP ON T.CHAPTER_ID=CP.CHAPTER_ID ");
		sql.append(" WHERE t.FILEID= '" + FILEID + "' ");
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
	 * 根据文件Id查找文件
	 * @param FILEID
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByFileName(String FILEID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME");
		sql.append(" FROM FILES T ");
		sql.append(" WHERE t.FILENAME= '" + FILEID + "' ");
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
	 * 复制文件
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public boolean copyFiles(HttpServletRequest request) throws ManagerException{
		String filename =request.getParameter("P=FILES=FILENAME=S=C");
		String extendname =request.getParameter("P=FILES=EXTENDNAME=S=C");
		String swfpath =request.getParameter("P=FILES=SWFPATH=S=C");
		String realname =request.getParameter("P=FILES=REALNAME=S=C");
		String falsename =request.getParameter("P=FILES=FALSENAME=S=C");
		String uploader =request.getParameter("P=FILES=UPLOADER=S=C");
		String flag =request.getParameter("P=FILES=FLAG=S=C");
		String download =request.getParameter("P=FILES=DOWNLOAD=S=C");
		String checkeder =request.getParameter("P=FILES=CHECKEDER=S=C");
		String uploaderid =request.getParameter("P=FILES=UPLOADERID=S=C");
		String checkedid =request.getParameter("P=FILES=CHECKEDID=S=C");
		String folderid =request.getParameter("P=FILES=FOLDERID=S=C");
		Map map = new FolderController().findMapByFOLDERID(folderid);
		String majorId = (String)map.get("MAJOR_ID");
		String courseId = (String)map.get("COURSE_ID");
		String chapterId = (String)map.get("CHAPTER_ID");
		String fileId = CodeHelper.createUUID();
		String sql = "insert into FILES values('"+fileId+"','"+folderid+"','"+filename+"','"+extendname+
				"','"+swfpath+"','"+realname+"','"+falsename+"','"+uploader+"','"+majorId+"','"+courseId+
				"','"+chapterId+"','"+flag+"','"+download+"','"+checkeder+"',sysdate,'"+uploaderid+"','"+checkedid+"')";
		try {
			new DBHelper().execute(sql);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	/**
	 * 移动文件
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public boolean moveFile(HttpServletRequest request) throws ManagerException{
		String fileId = request.getParameter("fileId");
		String POINT_ID =request.getParameter("P_FILES_POINT_ID_S_S");
		
		Map map = new FolderController().findMapByPOINT_ID(POINT_ID);
		
		String majorId = (String)map.get("MAJOR_ID");
		String courseId = (String)map.get("COURSE_ID");
		String chapterId = (String)map.get("CHAPTER_ID");
		StringBuffer sql = new StringBuffer();
		sql.append(" update FILES set ");
		sql.append(" MAJOR_ID='"+majorId+"', ");
		sql.append(" COURSE_ID='"+courseId+"', ");
		sql.append(" CHAPTER_ID='"+chapterId+"', ");
		sql.append(" POINT_ID='"+POINT_ID+"'");
		sql.append(" where FILEID='"+fileId+"' ");
		try {
			new DBHelper().execute(sql.toString());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public PageInfo findPageInfoByFILES(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request) 
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		String flag = request.getParameter("FLAG");
		String courseId = request.getParameter("COURSE_ID");
//		String chapterId = request.getParameter("CHAPTER_ID");
//		String pointId = request.getParameter("POINT_ID");
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" CONCAT(T.FALSENAME,T.EXTENDNAME) AS FULLNAME, ");
		sql.append(" T.UPLOADER AS UPLOADER, ");
		sql.append(" T.UPLOADERID AS UPLOADERID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CLASSIFY AS CLASSIFY, ");
		sql.append(" T.ISEXCELLENT AS ISEXCELLENT, ");
		sql.append(" UM.USERNAME AS UPLOADERNAME,"); //上传人姓名
		sql.append(" US.USERNAME AS CHECKERNAME,"); //审核人姓名
		sql.append(" C.kcname AS COURSE_NAME , ");
		sql.append(" CP.CHAPTER_NAME AS CHAPTER_NAME , ");
		sql.append(" T.DOWNLOAD AS DOWNLOAD, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.CHECKEDER AS CHECKEDER ");
		sql.append(" FROM FILES T");
		sql.append(" LEFT JOIN njbbxkrelation C on T.COURSE_ID=C.kcid   ");
		sql.append(" LEFT JOIN chapter CP on T.CHAPTER_ID=CP.CHAPTER_ID   ");
		sql.append(" LEFT JOIN UMUSER UM on UM.USERID = T.UPLOADERID  ");
		sql.append(" LEFT JOIN UMUSER US on US.USERID = T.CHECKEDID  ");
		sql.append(" WHERE 1 = 1");
		if(Validate.noNull(flag)){
				sql.append(" AND T.FLAG='"+flag+"' ");
		}else{
			sql.append(" AND (T.FLAG='22' OR T.FLAG='11' ) ");
		}
		if(Validate.noNull(courseId)){
			sql.append(" AND T.COURSE_ID='"+courseId+"' ");
		}
//		if(Validate.noNull(chapterId)){
//			sql.append(" AND T.CHAPTER_ID='"+chapterId+"' ");
//		}
//		if(Validate.noNull(pointId)){
//			sql.append(" AND T.POINT_ID='"+pointId+"' ");
//		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			sql.append(" ORDER BY T.FLAG ,T.CREATETIME DESC ");
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
	
	public PageInfo findByPrivateAllAndVerified(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request,
			 String COURSE_ID, String CHAPTER_ID,String Flag) throws ManagerException {
		String USERIDBYLOGIN = (String)request.getSession().getAttribute("USERIDBYLOGIN");
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		// 如果查询的是非审核通过的，则查询条件加上按上传人查询 22 审核通过的
		if(Validate.noNull(Flag) && !"22".equals(Flag)){
			sql.append(" AND T.UPLOADERID = '"+USERIDBYLOGIN+"' ");
			sql.append(" AND T.FLAG='"+Flag+"'");
		}else if(Validate.noNull(Flag) && "22".equals(Flag)){
			sql.append(" AND T.FLAG='"+Flag+"'");
		}else if(Validate.isNull(Flag)){
			sql.append(" AND (T.UPLOADERID = '"+USERIDBYLOGIN+"' ");
			sql.append(" or T.FLAG='22') ");
		}
		//判断查询的资源分类
		String extendname = request.getParameter("EXTENDNAME");
		if(Validate.noNull(extendname)){
				sql.append(" AND T.CLASSIFY='"+extendname+"' ");
		}
		sql.append(" ORDER BY case T.FLAG when '33' then 1 when '00' then 2 when '11' then 3 when '22' then 4 else 5 end  , T.CREATETIME DESC");
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
	
	private StringBuffer findCommonFields(){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.FILENAME2 AS FILENAME2, ");
		sql.append(" T.EXTENDNAME2 AS EXTENDNAME2, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.UPLOADER AS UPLOADER, ");
		sql.append(" T.UPLOADERID AS UPLOADERID, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.ISEXCELLENT AS ISEXCELLENT, ");
		sql.append(" CONCAT(T.FALSENAME,T.EXTENDNAME) AS FULLNAME, ");
		sql.append(" UM.USERNAME AS UPLOADERNAME,"); //上传人姓名
		sql.append(" US.USERNAME AS CHECKERNAME,"); //审核人姓名
		sql.append(" M.MAJOR_NAME AS MAJOR_NAME , ");
		sql.append(" C.KCNAME AS COURSE_NAME , ");
		sql.append(" CP.CHAPTER_NAME AS CHAPTER_NAME , ");
		sql.append(" R.NAME AS TYPENAME,");//文件类型
		sql.append(" T.CLASSIFY AS CLASSIFY , ");
		sql.append(" T.DOWNLOAD AS DOWNLOAD, ");
		sql.append(" T.CHECKEDER AS CHECKEDER ");
		sql.append(" FROM FILES T LEFT JOIN major M on T.MAJOR_ID=M.MAJOR_ID   ");
		sql.append(" LEFT JOIN major_BM  Mb on mb.MAJOR_ID=M.MAJOR_ID   ");
		sql.append(" LEFT JOIN RESOURCEMANAGER R ON R.ID=T.CLASSIFY ");
		sql.append(" LEFT JOIN chapter CP on T.CHAPTER_ID=CP.CHAPTER_ID   ");
		sql.append(" LEFT JOIN njbbxkrelation C on cp.course_id = C.KCID   ");
		sql.append(" LEFT JOIN UMUSER UM on UM.USERID = T.UPLOADERID  ");
		sql.append(" LEFT JOIN UMUSER US on US.USERID = T.CHECKEDID  ");
		sql.append(" WHERE 1 = 1 ");
		return sql;
	}
	/**
	 * 根据classify分别查询图片和视频资源,01是图片,02是视频
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByVedioFILES(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request,
			String flag, String id, String typeId,String biaoti) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		String majorid = request.getParameter("majorid");
		String classify = request.getParameter("classify");
		sql = findCommonFields();
		sql.append(" AND T.FLAG='22' ");
		sql.append(" AND T.FILENAME IS NOT NULL ");
		
		if(Validate.noNull(classify)){
			sql.append("AND R.ID='"+classify+"'");
		}
		if(Validate.noNull(majorid)){
			sql.append("AND T.MAJOR_ID='"+majorid+"'");
		}
		if("B".equals(flag)&&!"public".equals(id)){
			sql.append(" AND MB.BM_ID='"+id+"' ");
		}
		if("B".equals(flag)&&"public".equals(id)){
			sql.append(" AND T.MAJOR_ID='"+id+"' ");
		}
		if("Z".equals(flag)){
			sql.append(" AND T.MAJOR_ID='"+id+"' ");
		}
		if("S".equals(flag)){
			sql.append(" AND T.COURSE_ID='"+id+"' ");
		}
		if("C".equals(flag)){
			sql.append(" AND T.CHAPTER_ID='"+id+"' ");
		}
		if("01".equals(typeId)&&Validate.noNull(biaoti)){
			sql.append(" and r.id = '"+biaoti+"'");
		}else if("02".equals(typeId)&&Validate.noNull(biaoti)){
			sql.append(" and t.realname like '%"+biaoti+"%'");
		}else if("03".equals(typeId)&&Validate.noNull(biaoti)){
			sql.append(" and t.extendname like '%"+biaoti+"%'");
		}else if("04".equals(typeId)&&Validate.noNull(biaoti)){
			sql.append(" and m.major_name like '%"+biaoti+"%'");
		}
		if("isexcellent".equals(typeId)){
			sql.append(" and t.ISEXCELLENT='T'");
		}
		
		sql.append(" ORDER BY T.CREATETIME DESC");
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
	public PageInfo findPageInfoByPlayVedioFILES(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request,
			String Major_id, String COURSE_ID, String CHAPTER_ID,String typeId,String biaoti) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		sql.append(" AND T.FILENAME IS NOT NULL ");
		sql.append(" AND r.name like '%视频%'");
		sql.append(" AND t.flag ='22' ");
		if(Validate.noNull(Major_id)){
			sql.append(" AND T.MAJOR_ID='"+Major_id+"' ");
		}
		if(Validate.noNull(COURSE_ID)){
			sql.append(" AND T.COURSE_ID='"+COURSE_ID+"' ");
		}
		if(Validate.noNull(CHAPTER_ID)){
			sql.append(" AND T.CHAPTER_ID='"+CHAPTER_ID+"' ");
		}
		
		sql.append(" ORDER BY T.CREATETIME DESC");
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
	public String findNameById(String biaoti){
		String sql = "select r.name from resourcemanager r where r.id = '"+biaoti+"'";
		DBHelper dbHelper = new DBHelper();
		String typeId = null;
		try {
			typeId = dbHelper.queryForSingleValue(sql).toString();
		} catch (DBException e) {
			e.printStackTrace();
		}
		return typeId;
	}
	/**
	 * 查询所有的视频信息
	 * @return
	 */
	public List  findVedioList(){
		StringBuffer sql = new StringBuffer();
		sql = findCommonFields();
		sql.append(" AND T.FILENAME IS NOT NULL ");
		sql.append(" AND r.name like '%视频%'");
		sql.append(" AND t.flag ='22' ");
		sql.append(" ORDER BY T.CREATETIME DESC");
		List list = null;
		DBHelper dbHelper = new DBHelper();
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
		}
		return list;
	}
}
