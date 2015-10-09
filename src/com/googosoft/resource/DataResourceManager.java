package com.googosoft.resource;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

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

public class DataResourceManager {
	private static Logger logger = Logger.getLogger(DataResourceManager.class
			.getName());

	public PageInfo findPageInfoBydataresource(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException {
		String id = request.getParameter("ID");
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
		sql.append(" T.PARENTID AS PARENTID, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CHECKEDER AS CHECKEDER, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.UPLOADERID AS UPLOADERID, ");
		sql.append(" T.CHECKEDID AS CHECKEDID, ");
		sql.append(" T.ISEXCELLENT AS ISEXCELLENT, ");
		sql.append(" T.ISCONVERTSUCESS AS ISCONVERTSUCESS, ");
		sql.append(" T.CONVERTFAILREASON AS CONVERTFAILREASON, ");
		sql.append(" T.CLASSIFY AS CLASSIFY");
		sql.append(" FROM dataresource T ");
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(id)){
			sql.append(" AND T.PARENTID ='"+id+"'");
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

	public List findTreeBydataresource(HttpServletRequest request)
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
		sql.append(" T.PARENTID AS PARENTID, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CHECKEDER AS CHECKEDER, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.UPLOADERID AS UPLOADERID, ");
		sql.append(" T.CHECKEDID AS CHECKEDID, ");
		sql.append(" T.ISEXCELLENT AS ISEXCELLENT, ");
		sql.append(" T.ISCONVERTSUCESS AS ISCONVERTSUCESS, ");
		sql.append(" T.CONVERTFAILREASON AS CONVERTFAILREASON, ");
		sql.append(" T.CLASSIFY AS CLASSIFY");
		sql.append(" FROM dataresource T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
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

	public Map findMapByFILEID(String FILEID) throws ManagerException {
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
		sql.append(" T.PARENTID AS PARENTID, ");
		sql.append(" T.FLAG AS FLAG, ");
		sql.append(" T.CHECKEDER AS CHECKEDER, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.UPLOADERID AS UPLOADERID, ");
		sql.append(" T.CHECKEDID AS CHECKEDID, ");
		sql.append(" T.ISEXCELLENT AS ISEXCELLENT, ");
		sql.append(" T.ISCONVERTSUCESS AS ISCONVERTSUCESS, ");
		sql.append(" T.CONVERTFAILREASON AS CONVERTFAILREASON, ");
		sql.append(" T.CLASSIFY AS CLASSIFY ");
		sql.append(" FROM dataresource T ");
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
		sql.append(" FROM dataresource T ");
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
	/**判断所选分类是否为最末级(只有最末级才允许上传)
	 * @author guo
	 * @param Id
	 * @return
	 * @throws ManagerException
	 */
	public boolean findparentIdById(String Id)throws ManagerException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" count(*) AS SL ");
		sql.append(" FROM QFRESOURCE T ");
		sql.append(" WHERE 1=1 ");
		if(Validate.noNull(Id)){
			sql.append(" AND '"+Validate.isNullToDefault(Id, "").toString()+"' in ( select PARENTID from qfresource )" );
		}else{
			return false;
		}
		DBHelper db = new DBHelper();
		Map m;
		int i=0;
		try {
			m = db.queryForMap(sql.toString());
			i = Integer.parseInt(Validate.isNullToDefault(m.get("SL"), "").toString());
		} catch (DBException e) {
			e.printStackTrace();
		}
		if(i>0){
			return false;
		}
		return true;
	}
	/**查询所选分类下是否有下级文件
	 * @author guo
	 * @param Id
	 * @return
	 * @throws DBException
	 */
	public boolean isHaveChild(String Id) throws DBException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT COUNT(*) AS SL ");
		sql.append(" FROM QFRESOURCE Q ");
		sql.append(" WHERE 1=1 ");
		if(Validate.noNull(Id)){
			sql.append(" AND '"+Validate.isNullToDefault(Id, "").toString()+"'IN ( SELECT PARENTID FROM QFRESOURCE ) ");
			sql.append(" OR '"+Validate.isNullToDefault(Id, "").toString()+"'IN ( SELECT PARENTID FROM DATARESOURCE ) ");
		}else{
			return false;
		}
		DBHelper db = new DBHelper();
		Map m;
		int i = 0;
		try{
			m = db.queryForMap(sql.toString());
			i = Integer.parseInt(Validate.isNullToDefault(m.get("SL"), "").toString());
		}catch(DBException e){
			e.printStackTrace();
		}
		if(i>0){
			return true;
		}
		return false;
	}
}
