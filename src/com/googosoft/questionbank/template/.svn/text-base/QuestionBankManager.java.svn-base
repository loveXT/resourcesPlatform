package com.googosoft.questionbank.template;

import java.util.List;

import org.apache.log4j.Logger;

import com.googosoft.exception.CUMException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.CUMHelper;
import com.googosoft.zapi.DBHelper;

public class QuestionBankManager {
	private Logger logger = Logger.getLogger(QuestionBankManager.class
			.getName());

	public List findQuestionTypeList() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TXXXB_ID AS TXXXB_ID, ");
		sql.append(" T.TXXXB_MC AS TXXXB_MC ");
		sql.append(" FROM QUESTION_TXXXB T ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" and t.txxxb_jbtxid=1 or t.txxxb_jbtxid=2 ");
		List list = null;
		try {
			list = new DBHelper().queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	
	public List findNotChoiceQuestionTypeList() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.TXXXB_ID AS TXXXB_ID, ");
		sql.append(" T.TXXXB_MC AS TXXXB_MC ");
		sql.append(" FROM QUESTION_TXXXB T ");
		sql.append(" WHERE 1 = 1 ");
		List list = null;
		try {
			list = new DBHelper().queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}

	public List findQuestionHardList() throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.NDXXB_ID AS NDXXB_ID, ");
		sql.append(" T.NDXXB_NYCD AS NDXXB_NYCD ");
		sql.append(" FROM QUESTION_NDXXB T ");
		sql.append(" WHERE 1 = 1 ");
		List list = null;
		try {
			list = new DBHelper().queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			new CUMHelper("QUESTION_NDXXB", "NDXXB_ID").getManagerToPrintByDb();
		} catch (CUMException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
