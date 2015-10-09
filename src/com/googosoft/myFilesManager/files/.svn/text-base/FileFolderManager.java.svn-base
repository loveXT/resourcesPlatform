package com.googosoft.myFilesManager.files;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.googosoft.commons.Validate;
import com.googosoft.exception.CUMException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.CUMHelper;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

public class FileFolderManager {

	public List findMyFiles(HttpServletRequest request, String folderId)
			throws ManagerException {
		String userid = (String) request.getSession().getAttribute(
				"USERIDBYLOGIN");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT T.FILEID,T.REALNAME,T.FILENAME,T.FILESIZE,T.CREATEDATE FROM MYFILE T WHERE 1=1 ");
		sql.append(" AND T.USERID ='" + userid + "' ");
		if (Validate.noNull(folderId)) {
			sql.append(" AND T.FOLDERID='" + folderId + "' ");
		} else {
			sql.append(" AND T.FOLDERID IS NULL ");
		}
		sql.append("  ORDER BY CREATEDATE DESC ");
		try {
			List list = new DBHelper().queryForList(sql.toString());
			return list;
		} catch (DBException e) {
			e.printStackTrace();
			throw new ManagerException(e);
		}

	}

	public List findMyFolders(HttpServletRequest request, String folderId)
			throws ManagerException {
		String userid = (String) request.getSession().getAttribute(
				"USERIDBYLOGIN");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT T.FOLDERID,T.FOLDERNAME,T.FILESIZE,T.CREATEDATE FROM MYFILEFOLDER T WHERE 1=1 ");
		sql.append(" AND  T.USERID ='" + userid + "' ");
		if (Validate.noNull(folderId)) {
			sql.append(" AND T.FOLDERPARENTID='" + folderId + "' ");
		} else {
			sql.append(" AND T.FOLDERPARENTID IS NULL ");
		}
		sql.append(" ORDER BY CREATEDATE DESC ");
		try {
			List list = new DBHelper().queryForList(sql.toString());
			return list;
		} catch (DBException e) {
			e.printStackTrace();
			throw new ManagerException(e);
		}
	}

	public PageInfo findFilesAndFolders(int nowPage, int pageSize,
			String split, HttpServletRequest request) throws ManagerException {
		String userid = (String) request.getSession().getAttribute(
				"USERIDBYLOGIN");
		String sql = "SELECT T.FILEID,T.REALNAME,T.FILENAME,T.FILESIZE FILESIZE,TO_CHAR(T.CREATEDATE,'yyyy-MM-dd') CREATEDATE FROM MYFILE T WHERE T.USERID ='"
				+ userid + "' ORDER BY CREATEDATE DESC ";
		PageInfo pageInfo = null;
		try {
			sql += new QueryHelper().getQuerySqlByRequset(split, request);
			pageInfo = new PageHelper(nowPage, pageSize, sql).getPageInfo();
		} catch (DBException e) {
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (PageException e) {
			e.printStackTrace();
			throw new ManagerException(e);
		} catch (QueryException e) {
			e.printStackTrace();
			throw new ManagerException(e);
		}
		return pageInfo;
	}

	public Map findMapByFILEID(String FILEID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.USERID AS USERID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.FILESIZE AS FILESIZE, ");
		sql.append(" T.CREATEDATE AS CREATEDATE, ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.REALNAME AS REALNAME ");
		sql.append(" FROM MYFILE T ");
		sql.append(" WHERE t.FILEID= '" + FILEID + "' ");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return map;
	}
	public String canDeleteByFolderId(String folderId) throws DBException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(*) FROM MYFILEFOLDER T ");
		sql.append(" WHERE T.FOLDERPARENTID = '"+folderId+"' ");
		DBHelper db = new DBHelper();
		Object obj = db.queryForSingleValue(sql.toString());
		int count = Integer.valueOf(obj.toString());
		if(count>0){
			return "false";
		}else{
			StringBuffer query = new StringBuffer();
			query.append(" SELECT COUNT(*) FROM MYFILE T ");
			query.append(" WHERE T.FOLDERID = '"+folderId+"' ");
			Object numObj = db.queryForSingleValue(query.toString());
			int num = Integer.valueOf(numObj.toString());
			if(num>0){
				return "false";
			}else{
				return "true";
			}
		}
	}
	public static void main(String[] args) {
		try {
			new CUMHelper("MYFILE", "FILEID").getManagerToPrintByDb();
		} catch (CUMException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
