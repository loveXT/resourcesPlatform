package com.googosoft.filesManager.fileManager;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.enterprisedt.util.debug.Logger;
import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.filesManager.openClass.OpenClassManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
public class FilesQuery {
	private Logger logger = Logger.getLogger(FilesQuery.class.getName());
	public PageInfo findPageInfoFilesQuery(int nowPage,int pageSize,String splitByQuery,HttpServletRequest request
			) throws ManagerException {
		String courseId = request.getParameter("courseId");
		String gradeId = request.getParameter("gradeId");
		String versionId = request.getParameter("versionId");
		String typeId = request.getParameter("typeId");
		String biaoti = request.getParameter("biaoti");
		String classifyId = request.getParameter("classifyId");
		String orderByTime = request.getParameter("orderByTime");
		String orderBySize = request.getParameter("orderBySize");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.REALNAME AS REALNAME, ");
		sql.append(" T.FILESIZE AS FILESIZE, ");
		sql.append(" T.EXTENDNAME AS EXTENDNAME, ");
		sql.append(" T.FILEID AS FILEID, ");
		sql.append(" T.FILENAME AS FILENAME, ");
		sql.append(" T.SWFPATH AS SWFPATH, ");
		sql.append(" T.FILENAME2 AS FILENAME2, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.BROWSETIME AS BROWSETIME, ");
		sql.append(" T.FILEPATH AS FILEPATH ");
		sql.append(" FROM FILES T ");
		sql.append(" LEFT JOIN NJBBXKRELATION C ON C.KCID=T.COURSE_ID ");
		sql.append(" WHERE 1 = 1 ");		
		sql.append(" and t.flag='22' ");
		if(Validate.noNull(courseId)){
			sql.append(" and C.COURSEID='"+courseId+"' ");
		}
		if(Validate.noNull(gradeId)){
			sql.append(" and C.GRADEID='"+gradeId+"' ");
		}
		if(Validate.noNull(versionId)){
			sql.append(" and C.VERSIONID='"+versionId+"' ");
		}
		if(Validate.noNull(typeId)){
			sql.append(" and T.ZYMAINTYPEID='"+typeId+"' ");
		}
		if(Validate.noNull(biaoti)){
			sql.append(" and T.REALNAME like '%"+biaoti+"%' ");
		}
		if(Validate.noNull(classifyId)){
			sql.append(" and T.CLASSIFY = '"+classifyId+"' ");
		}
		if(Validate.noNull(orderByTime)){
			sql.append(" ORDER BY T.CREATETIME DESC ");
		}
		if(Validate.noNull(orderBySize)){
			sql.append(" ORDER BY T.FILESIZE DESC");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			if(Validate.noNull(orderByTime)||Validate.noNull(orderBySize)){
				
			}else{
				sql.append(" ORDER BY T.CREATETIME DESC ");
				
			}
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
