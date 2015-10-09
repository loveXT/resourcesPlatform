
package com.googosoft.questionbank.questionbank;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import com.googosoft.filesManager.fileManager.*;
import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.DBFormatException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.exception.TreeException;
import com.googosoft.ggs.saasManager.SaasManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBFormatHelper;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class QuestionManager {

	Logger logger = Logger.getLogger(QuestionManager.class.getName());

	public PageInfo findPageInfoByquestion(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request)
			throws ManagerException, DBFormatException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.QUESTION_CODE AS QUESTION_CODE, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COMPLEXITY AS COMPLEXITY, ");
		sql.append(new DBFormatHelper().toCharByCommon("T.QUESTION_CONTENT")+"  AS QUESTION_CONTENT, ");
		sql.append(new DBFormatHelper().toCharByDate("T.CREATE_TIME")+"  AS CREATE_TIME, ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.ANSWER AS ANSWER, ");		
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" PQ.count AS count, ");
		sql.append(" T.QUESTION_FZXX AS QUESTION_FZXX,");
		sql.append(" T.QUESTION_QFDXX AS QUESTION_QFDXX,");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN,");
		sql.append(" T.QUESTION_DAJX AS QUESTION_DAJX");
		sql.append(" FROM question T ");
		sql.append(" LEFT JOIN (select s.questionid, count(1) as count from paperquestion s group by s.questionid ) PQ ON PQ.QUESTIONID=T.QUESTION_ID ");
		sql.append(" WHERE 1 = 1 ");
		if(Validate.noNull(request.getParameter("tflag"))){
			String treeFlag = Validate.isNullToDefault(request.getParameter("tflag"),"").toString().trim();
			String treeId = Validate.isNullToDefault(request.getParameter("treeId"),"").toString().trim();
			if("M".equals(treeFlag)){//专业
				sql.append(" AND T.MAJOR_ID = '"+treeId+"' ");
			}
			if("C".equals(treeFlag)){//课程
				sql.append(" AND T.COURSE_ID = '"+treeId+"' ");
			}
			if("CP".equals(treeFlag)){//章节
				sql.append(" AND T.CHAPTER_ID = '"+treeId+"' ");
			}
			if("P".equals(treeFlag)){//知识点
				sql.append(" AND T.POINT_ID = '"+treeId+"' ");
			}
		}
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+sql.toString());
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			//sql.append(SaasManager.getDataSqlByInitSql("T", request));
			sql.append(" ORDER BY to_number(QUESTION_CODE)  ");
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
	 * 无分页查询
	 * @return
	 * @throws ManagerException
	 * @throws DBFormatException
	 */
	public List findList()throws ManagerException, DBFormatException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.QUESTION_CODE AS QUESTION_CODE, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COMPLEXITY AS COMPLEXITY, ");
		sql.append(new DBFormatHelper().toCharByCommon("T.QUESTION_CONTENT")+"  AS QUESTION_CONTENT, ");
		sql.append(new DBFormatHelper().toCharByDate("T.CREATE_TIME")+"  AS CREATE_TIME, ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.ANSWER AS ANSWER, ");		
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.QUESTION_FZXX AS QUESTION_FZXX,");
		sql.append(" T.QUESTION_QFDXX AS QUESTION_QFDXX,");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN,");
		sql.append(" T.QUESTION_DAJX AS QUESTION_DAJX");
		sql.append(" FROM question T ");
		sql.append(" WHERE 1 = 1 ");
		List list = null ;
		DBHelper helper = new DBHelper();
		try {
			list = helper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}

	public List findTreeByquestion(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COMPLEXITY AS COMPLEXITY, ");
		sql.append(" T.QUESTION_CONTENT AS QUESTION_CONTENT, ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.ANSWER AS ANSWER, ");
		sql.append(" T.QUESTION_FZXX AS QUESTION_FZXX,");
		sql.append(" T.QUESTION_QFDXX AS QUESTION_QFDXX,");
		sql.append(" T.QUESTION_DAJX AS QUESTION_DAJX");
		sql.append(" FROM question T ");
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

	public Map findMapByQUESTION_ID(String QUESTION_ID) throws ManagerException, DBFormatException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.QUESTION_ID AS QUESTION_ID, ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.COURSE_ID AS COURSE_ID, ");
		sql.append(" T.CHAPTER_ID AS CHAPTER_ID, ");
		sql.append(" T.COMPLEXITY AS COMPLEXITY, ");
		sql.append(new DBFormatHelper().toCharByCommon("T.QUESTION_CONTENT")+"  AS QUESTION_CONTENT, ");
		sql.append(" T.TYPE_ID AS TYPE_ID, ");
		sql.append(" T.POINT_ID AS POINT_ID, ");
		sql.append(" T.ANSWER AS ANSWER,");
		sql.append(" T.QUESTION_FZXX AS QUESTION_FZXX,");
		sql.append(" T.QUESTION_QFDXX AS QUESTION_QFDXX,");
		sql.append(" T.QUESTION_DAJX AS QUESTION_DAJX");
		sql.append(" FROM question T ");
		sql.append(" WHERE t.QUESTION_ID= '" + QUESTION_ID + "' ");
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
	/**将专业、课程、章节和知识点整合为一棵树
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findTreeForUpLoadQuestion(HttpServletRequest request) throws ManagerException {
		SelectFilesManager selectFiles = new SelectFilesManager();
		//专业集合
		Map map = new HashMap();
		map.put("MAJOR_ID","公共基础课");
		map.put("MAJOR_NAME","公共基础课");
		List majorList = selectFiles.findPageInfo();
		majorList.add(map);
		//课程集合
		
		List courseListT = selectFiles.findCourseByMajorId("public");
		List courseListF = selectFiles.findCourseByMajorId("FG");
		//章节集合
		List chapterList = selectFiles.findChapterByCourseId(null);
		//知识点集合
//		List pointList = new PointManager().findPointByChapterId(null);
		TreeHelper treeHelper = new TreeHelper();
		try {
			treeHelper.addTreeList(majorList, "MAJOR_ID", "MAJOR_ID", "MAJOR_NAME","","M");//专业
			treeHelper.addTreeList(courseListT, "COURSE_ID", "MAJOR_ID", "COURSE_NAME","","C");//公共基础课
			treeHelper.addTreeList(courseListF, "COURSE_ID", "MAJOR_ID", "COURSE_NAME","","C");//专业课
			treeHelper.addTreeList(chapterList, "CHAPTER_ID", "COURSE_ID", "CHAPTER_NAME","","CP");//章节
//			treeHelper.addTreeList(pointList, "POINT_ID", "CHAPTER_ID", "POINT_NAME","","P");//知识点
			return  treeHelper.getTreeList();
		} catch (TreeException e) {
			logger.error("组装树失败\n" + e);
			throw new ManagerException("组装树失败\n" + e);
		}
	}
	/**查询最大编号
	 * @return
	 * @throws ManagerException
	 */
	public Map findMaxCode()throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT max(to_number(QUESTION_CODE)) AS MAXCODE FROM QUESTION ");
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
