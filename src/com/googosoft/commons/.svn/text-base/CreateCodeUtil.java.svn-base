package com.googosoft.commons;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.CUDException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.CUDHelper;
import com.googosoft.zapi.DBHelper;

/**生成唯一单编号
 * @author xin
 *
 */
public class CreateCodeUtil {
	private Logger logger = Logger.getLogger(CreateCodeUtil.class.getName());

	/**
	 * 获取单编号
	 * 
	 * @param tableName：表名
	 * @param columnName：字段名称
	 * @param codeBefore：单编号六位流水号前面部分
	 * @return：返回单编号
	 * @throws ManagerException
	 */
	private String findCode(String tableName, String columnName,
			String codeBefore) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" MAX(" + columnName + ") AS MAXCODE");
		sql.append(" from " + tableName);
		DBHelper dBHelper = new DBHelper();
		try {
			Object obj = dBHelper.queryForSingleValue(sql.toString());
			String code = "";
			if (Validate.noNull(obj)) {
				long codeNum = Long.parseLong(obj.toString()) + 1;
				code += codeNum;
			} else {
				code = codeBefore + "000001";
			}
			return code;
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
	}

	/**
	 * 获取当前时间字符串:年月日
	 * 
	 * @return：yyyyMMdd
	 */
	private String findCurrentDate() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		return dateFormat.format(date);
	}

	/**
	 * 生成唯一单编号的插入方法
	 * 
	 * @param tableName：表名
	 * @param columnName：字段名称
	 * @param map：执行的map
	 * @param cudName：要执行的cud格式的name
	 * @param splitString：分隔串
	 * @param splitSql：多条语句执行时执行顺序分隔串
	 * @return：插入数据执行结果
	 * @throws ManagerException
	 */
	public synchronized boolean addData(String tableName, String columnName,
			Map map, String cudName, String splitString, String splitSql)
			throws ManagerException {
		String code = findCode(tableName, columnName, findCurrentDate());
		map.put(cudName, code);
		try {
			return new CUDHelper(map, splitString, splitSql).execute();
		} catch (CUDException e) {
			logger.error("生成数据失败\n" + e);
			throw new ManagerException("生成数据失败\n" + e);
		}
	}
}
