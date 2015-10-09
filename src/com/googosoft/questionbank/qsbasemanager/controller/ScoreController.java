package com.googosoft.questionbank.qsbasemanager.controller;

import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.DBHelper;



public class ScoreController {
	private Logger logger = Logger.getLogger(ScoreController.class.getName());
	public boolean InsertScore(String Score_id,String Major_id,String course_id,String Paper_id
			,String paper_title,float score,String useridbylogin){
		DBHelper db = new DBHelper();
		boolean falg = false;
		String sql="insert into score(score_id,major_id,course_id,paper_id,paper_title,score,useridbylogin)" +
				" values('"+Score_id+"','"+Major_id+"','"+course_id+"','"+Paper_id+"','"+paper_title+"',"+score+",'"+useridbylogin+"')";
		try {
			db.execute(sql);
			logger.info("更新记录成功...");
			return true;//OK取书
		} catch (DBException e) {
			// TODO Auto-generated catch block
			logger.error("查询数据库失败\n" + e);
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return falg;
	}
}
