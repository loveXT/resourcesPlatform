package com.googosoft.questionbank.questionbank;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.DBHelper;

public class ValidateNameManager {
	/**
	 * 验证课程、章节、知识点名称不重复的类
	 */
	private Logger logger = Logger.getLogger(ValidateNameManager.class
			.getName());

	/**
	 * 查询专业下是否已经存在该课程
	 * 
	 * @param courseName：课程名称
	 * @param majorId：专业名称
	 * @return：true：存在，false：不存在
	 * @throws ManagerException
	 */
	public boolean findIfExistByCourseName(String courseName, String majorId)
			throws ManagerException {
		String sql = getSql("COURSE", "COURSE_NAME", courseName,
				"COURSE_MAJOR", "COURSE_ID", "COURSE_ID", "MAJOR_ID", majorId,
				null);
		return ifExist(sql);
	}

	/**
	 * 查询课程下是否存在章节
	 * 
	 * @param chapterName：章节名称
	 * @param courseId：课程id
	 * @return：true：存在，false：不存在
	 * @throws ManagerException
	 */
	public boolean findIfExistByChapterName(String chapterName, String courseId)
			throws ManagerException {
		String sql = getSql("chapter", "CHAPTER_NAME", chapterName, null, null,
				null, "COURSE_ID", courseId, "T");
		return ifExist(sql);
	}

	/**
	 * 查询章节下是否已经存在知识点
	 * 
	 * @param pointName：知识点名称
	 * @param chapterId：章节id
	 * @return：true：存在,false：不存在
	 * @throws ManagerException
	 */
	public boolean findIfExistByPointName(String pointName, String chapterId)
			throws ManagerException {
		String sql = getSql("KNOWLEDGE_POINT", "POINT_NAME", pointName, null,
				null, null, "CHAPTER_ID", chapterId, "T");
		return ifExist(sql);
	}

	/**
	 * @param tableName：查询的表
	 * @param columnName：条件字段名
	 * @param columnValue：条件字段值
	 * @param linkedTableName：关联的表
	 * @param linkedColumnOne：查询表中的字段
	 * @param linkedColumnTwo：关联表中的字段
	 * @param tname：关联表重新定义别名
	 * @param value2：重新定义别名的值
	 * @return
	 */
	private String getSql(String tableName, String columnName,
			String columnValue, String linkedTableName, String linkedColumnOne,
			String linkedColumnTwo, String column2, String value2, String tname) {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(*) ");
		sql.append(" FROM " + tableName + " T ");
		if (Validate.noNull(linkedColumnTwo)) {
			sql.append(" left join  " + linkedTableName + " LT on t."
					+ linkedColumnOne + "= LT." + linkedColumnTwo);
			tname = "LT";
		}
		sql.append(" WHERE t." + columnName + "= '" + columnValue + "' ");
		sql.append("  and " + tname + "." + column2 + " = '" + value2 + "'");
		return sql.toString();
	}

	/**
	 * 根据sql查询数据个数并将字符串类型数据转换为int类型
	 * 
	 * @param sql：查询个数的sql
	 * @return：个数
	 * @throws ManagerException
	 */
	private int findNameCount(String sql) throws ManagerException {
		DBHelper dbHelper = new DBHelper();
		try {
			return Integer.parseInt(dbHelper.queryForSingleValue(sql)
					.toString());
		} catch (NumberFormatException e) {
			logger.error("数据类型转换失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
	}

	/**
	 * @param sql：查询个数的sql
	 * @return：是否存在数据：true 存在，false 不存在
	 */
	private boolean ifExist(String sql) {
		boolean bool = false;
		try {
			int num = findNameCount(sql);
			if (num > 0) {
				bool = true;
			}
		} catch (ManagerException e) {
			logger.error("查询数据库失败\n" + e);
			bool = false;
		}
		return bool;
	}
}
