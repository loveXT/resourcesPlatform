package com.googosoft.filesManager.fileManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.CUMException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.exception.TreeException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.CUMHelper;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class FileManager {
	private static Logger logger = Logger
			.getLogger(FileManager.class.getName());
	/**
	 * 
	 * @param nowPage 当前页
	 * @param pageSize 每页显示条数
	 * @param querySplit 分隔符
	 * @param request 
	 * @param Fid 文件id
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findPageInfoByFolderId(int nowPage, int pageSize,
			String querySplit, HttpServletRequest request,String Fid)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME");
		sql.append(" FROM files T  ");
		sql.append(" where 1= 1 ");
		if(Validate.noNull(Fid)){
			sql.append(" and t.FOLDERID = '" + Fid + "' ");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(querySplit,
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
	 * 
	 * @param nowPage 当前页
	 * @param pageSize 每页显示条数
	 * @param querySplit 分隔符
	 * @param request
	 * @param Fid 文件编号
	 * @return
	 * @throws ManagerException
	 */
	public PageInfo findlistByFolderId(int nowPage, int pageSize,
			String querySplit, HttpServletRequest request,String Fid)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME");
		sql.append(" FROM files T ");
		sql.append(" where T.EXTENDNAME='.mp4' ");
		sql.append(" OR T.EXTENDNAME='.rm' ");
		sql.append(" OR T.EXTENDNAME='.rmvb' ");
		sql.append(" OR T.EXTENDNAME='.flv' ");
		sql.append(" OR T.EXTENDNAME='.FLV' ");
		sql.append(" OR T.EXTENDNAME='.MP4' ");
		sql.append(" OR T.EXTENDNAME='.RMVB' ");
		sql.append(" OR T.EXTENDNAME='.RM' ");
		if(Validate.noNull(Fid)){
			sql.append(" and t.FOLDERID = '" + Fid + "' ");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(querySplit,
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
	 * 
	 * @param Id 文件编号
	 * @return
	 * @throws ManagerException
	 */
	public Object findFileNameById(String Id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.SWFPATH AS SWFPATH");
		sql.append(" FROM files T ");
		sql.append(" WHERE T.FILEID= '" + Id + "' ");
		DBHelper dbHelper = new DBHelper();
		Object fileName = null;
		try {
			fileName = dbHelper.queryForSingleValue(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return fileName;
	}
	/**
	 * 
	 * @param Id 文件编号
	 * @return
	 * @throws ManagerException
	 */
	public Object findExtendNameById(String Id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME");
		sql.append(" FROM files T ");
		sql.append(" WHERE T.FILEID= '" + Id + "' ");
		DBHelper dbHelper = new DBHelper();
		Object extendName = null;
		try {
			extendName = dbHelper.queryForSingleValue(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return extendName;
	}
	/**
	 * 
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeByfile() throws ManagerException {
		return findTreeByfile(null);
	}
	/**
	 * 
	 * @param fileId 文件编号
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeByfile(String fileId) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME");
		sql.append(" FROM files T ");
		sql.append(" where 1= 1");
		if (Validate.noNull(fileId)) {
			sql.append(" and t.FILEID != '" + fileId + "' ");
		}
		sql.append(" ORDER BY t.ID ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "FILEID", "FOLDERID", "FILENAME","FOLDERID","");
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
	 * 
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapsByfile() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME");
		sql.append(" FROM files T ");
		sql.append(" where 1= 1");
		sql.append(" ORDER BY t.FILEID ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		Map reslustMap = new HashMap();
		Map map = null;
		try {
			list = dbHelper.queryForList(sql.toString());
			for (int i = 0; i < list.size(); i++) {
				map = (Map) list.get(i);
				reslustMap.put(map.get("ID"), map);
			}
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return reslustMap;
	}
	/**
	 * 
	 * @param Id
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapById(String Id) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME");
		sql.append(" FROM files T ");
		sql.append(" WHERE t.FILEID= '" + Id + "' ");
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
	 * 
	 * @param Fid 文件编号
	 * @return
	 * @throws ManagerException
	 */
	public Map findMapByFid(String Fid) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FALSENAME AS FALSENAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.FOLDERID AS FOLDERID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME");
		sql.append(" FROM files T ");
		sql.append(" WHERE t.FOLDERID= '" + Fid + "' ");
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
	
	public List findPageInfo() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.DOWNLOADTIME AS DOWNLOADTIME, ");
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
		sql.append(" AND T.DOWNLOADTIME is not null ");
		sql.append(" ORDER BY T.DOWNLOADTIME DESC ");
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
}
