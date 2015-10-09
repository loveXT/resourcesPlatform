package com.googosoft.questionbank.qsbasemanager.zuJuan;

import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.exception.CUMException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.CUMHelper;
import com.googosoft.zapi.DBHelper;

public class PaperConditionManager {
	private Logger logger = Logger.getLogger(PaperConditionManager.class
			.getName());

	public Map findMapByCONDITIONID(String CONDITIONID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CONDITIONID AS CONDITIONID, ");
		sql.append(" T.CONDITIONTITLE AS CONDITIONTITLE, ");
		sql.append(" T.CONDITIONDATE AS CONDITIONDATE, ");
		sql.append(" T.CONDITIONTIME AS CONDITIONTIME, ");
		sql.append(" T.CONDITIONMARGOR AS CONDITIONMARGOR, ");
		sql.append(" T.CONDITIONCOURSE AS CONDITIONCOURSE, ");
		sql.append(" T.COURSECONTENT AS COURSECONTENT, ");
		sql.append(" T.SUBJECTRATE AS SUBJECTRATE, ");
		sql.append(" T.SAAS AS SAAS, ");
		sql.append(" T.USERIDBYLOGIN AS USERIDBYLOGIN, ");
		sql.append(" T.REMARK AS REMARK, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.CONDITIONSCORE AS CONDITIONSCORE, ");
		sql.append(" T.CONDITIONNUMBER AS CONDITIONNUMBER, ");
		sql.append(" T.CONDITIONTYPE AS CONDITIONTYPE, ");
		sql.append(" T.COURSECONSUBJECT AS COURSECONSUBJECT ");
		sql.append(" FROM PAPERCONDITION T ");
		sql.append(" WHERE t.CONDITIONID= '" + CONDITIONID + "' ");
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
	public String findPointNameById(String pointId) throws DBException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.POINT_NAME AS NAME ");
		sql.append(" FROM KNOWLEDGE_POINT T ");
		sql.append(" WHERE T.POINT_ID='"+pointId+"' ");
		DBHelper db = new DBHelper();
		Map map = db.queryForMap(sql.toString());
		return map.get("NAME")==null?"":map.get("NAME").toString();
	}
	public String findChapterNameById(String chapterId) throws DBException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.CHAPTER_NAME AS NAME ");
		sql.append(" FROM CHAPTER T ");
		sql.append(" WHERE T.CHAPTER_ID='"+chapterId+"' ");
		DBHelper db = new DBHelper();
		Map map = db.queryForMap(sql.toString());
		return map.get("NAME")==null?"":map.get("NAME").toString();
	}
	public String findDiffNameById(String diffId) throws DBException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.NDXXB_NYCD AS NAME ");
		sql.append(" FROM QUESTION_NDXXB T ");
		sql.append(" WHERE T.NDXXB_ID='"+diffId+"' ");
		DBHelper db = new DBHelper();
		Map map = db.queryForMap(sql.toString());
		return map.get("NAME")==null?"":map.get("NAME").toString();
	}
	public String findQuestionTypeNameById(String questionTypeId) throws DBException{
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TXXXB_MC AS NAME ");
		sql.append(" FROM QUESTION_TXXXB T ");
		sql.append(" WHERE T.TXXXB_ID='"+questionTypeId+"' ");
		DBHelper db = new DBHelper();
		Map map = db.queryForMap(sql.toString());
		return map.get("NAME")==null?"":map.get("NAME").toString();
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			new CUMHelper("PAPERCONDITION", "CONDITIONID")
					.getUpdateToPrintByDB();
		} catch (CUMException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
