package com.googosoft.filesManager.netresvindicate;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.filesManager.fileManager.FileManager;
import com.googosoft.zapi.DBHelper;

public class MajorType {
	private static Logger logger = Logger.getLogger(FileManager.class.getName());
	/**
	 * 获取专业信息
	 * @return
	 * @throws ManagerException
	 */
	public List findMajorlist() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT T.MAJOR_ID,T.MAJOR_NAME FROM MAJOR T ");
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
	 * 获取格式信息
	 */
	public List findClassifyList(){
		String sql = "SELECT T.ID,T.NAME FROM RESOURCEMANAGER T";
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql);
		} catch (DBException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 平台统计查询
	 */
	/**
	 * 
	 */
	public Map findMapByFiles() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" COUNT(T.FILEID) as count, ");
		sql.append(" SUM(T.DOWNLOADTIME) as downloadtime, ");
		sql.append(" SUM(T.FILESIZE) as FILESIZE, ");
		sql.append(" SUM(T.BROWSETIME) as browsetime ");
		sql.append(" FROM FILES T ");
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
	/**
	 * 获取教师照片
	 * @return
	 */
	public List findImageList(){
		String sql = "SELECT t.id,T.ZP AS FILENAME,U.USERNAME,COUNT(T.ZP) AS COUNT FROM TEACHERSINFO T LEFT JOIN UMUSER U " +
				"ON T.ID=U.USERID LEFT JOIN FILES F ON F.UPLOADER=U.USERNAME WHERE T.ZP IS NOT NULL " +
				"GROUP BY t.id,T.ZP,U.USERNAME ORDER BY COUNT DESC";
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql);
		} catch (DBException e) {
			e.printStackTrace();
		}
		return list;
	}
	public Map findMapByUserId(String userId) throws ManagerException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" u.username, ");
		sql.append(" t.xbm, ");
		sql.append(" t.zp, ");
		sql.append(" t.CSRQ, ");
		sql.append(" t.MZM, ");
		sql.append(" t.LXDH, ");
		sql.append(" t.JZGLBM, ");
		sql.append(" t.ORGANIZATIONID, ");
		sql.append(" ud.umdepartmentname, ");
		sql.append(" t.xrzw ");
		sql.append(" from TEACHERSINFO t ");
		sql.append(" left join umuser u on u.userid = t.id ");
		sql.append(" left join umdepartment ud on ud.umdepartmentid=t.organizationid ");
		sql.append(" WHERE t.id='"+userId+"' ");
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
	 * 查询教师头像ID
	 * @param userId
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByZP(String userId) throws ManagerException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" U.USERNAME, ");
		sql.append(" T.XBM, ");
		sql.append(" T.ZP, ");
		sql.append(" T.CSRQ, ");
		sql.append(" T.MZM, ");
		sql.append(" T.LXDH, ");
		sql.append(" T.JZGLBM, ");
		sql.append(" T.ORGANIZATIONID, ");
		sql.append(" UD.UMDEPARTMENTNAME, ");
		sql.append(" T.XRZW ");
		sql.append(" FROM TEACHERSINFO T ");
		sql.append(" LEFT JOIN UMUSER U ON U.USERID = T.ID ");
		sql.append(" LEFT JOIN UMDEPARTMENT UD ON UD.UMDEPARTMENTID=T.ORGANIZATIONID ");
		sql.append(" WHERE T.ID='"+userId+"' ");
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
	public Map findXBMapByNormCode(String bm){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" N.DM AS DM, ");
		sql.append(" N.MC AS MC ");
		sql.append(" FROM NORMCODETYPE T ");
		sql.append(" LEFT JOIN NORMCODE N ON N.DMLXID = T.ID ");
		sql.append(" WHERE 1=1 ");
		sql.append(" AND T.DMLXBM ='ZGGMZMCDM' ");
		sql.append(" AND N.DM='"+bm+"' GROUP BY N.DM,N.MC ");
		sql.append(" ORDER BY N.DM ");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
			logger.error("查询失败!", e);
		}
		return map;
	}
	/**
	 * 根据上传人查询资源
	 */
	/**
	 * 按上传时间查询资源信息
	 */
	public List findListByFiles(String userId) throws ManagerException {
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
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.FILENAME2 AS FILENAME2, ");
		sql.append(" T.UPLOADERID AS UPLOADERID ");
		sql.append(" FROM FILES T ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.FLAG='22' ");
		sql.append(" AND T.UPLOADERID='"+userId+"' ");
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
	 * 是否是优秀资源资源
	 */
	public List findEXCELLENTListByFiles() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.REALNAME||T.EXTENDNAME AS REALNAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" CONCAT(T.FALSENAME,T.EXTENDNAME) AS FULLNAME, ");
		sql.append(" T.UPLOADER AS UPLOADER, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CLASSIFY AS CLASSIFY, ");
		sql.append(" R.NAME AS TYPENAME,");//文件类型
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.FILENAME2 AS FILENAME2, ");
		sql.append(" T.UPLOADERID AS UPLOADERID ");
		sql.append(" FROM FILES T ");
		sql.append(" LEFT JOIN RESOURCEMANAGER R ON R.ID=T.CLASSIFY ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.FLAG='22' ");
		sql.append(" AND T.ISEXCELLENT='T' ");
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
	 * 根据后缀名判断显示的缩略图片
	 */
	public String findImageByExtendName(String extendName){
		String image="";
		if(".pdf".equals(extendName)){
			image="pdf.jpg";
		}else if(".ppt".equals(extendName)||".pptx".equals(extendName)){
			image="ppt.jpg";
		}else if(".doc".equals(extendName)||".docx".equals(extendName)){
			image="doc.jpg";
		}else if(".xls".equals(extendName)||".xlsx".equals(extendName)){
			image="excel.jpg";
		}else if(".txt".equals(extendName)){
			image="txt.jpg";
		}else if(".zip".equals(extendName)||".rar".equals(extendName)){
			image="zip.jpg";
		}
		return image;
	}

}
