package com.googosoft.oa.message.classes;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;

/**
 * 用户管理类
 * 
 * @author xuanly
 * 
 */
public class UserManager {
	private Logger logger = Logger.getLogger(UserManager.class.getName());

	/**
	 * 查询
	 * 
	 * @return
	 * @throws ManagerException
	 */
	public List<Map<String, Object>> findUser() {
		StringBuffer sql = new StringBuffer(" SELECT ");
		sql.append(" t.USERID AS USERID, ");
		sql.append(" t.USERNAME AS USERNAME, ");
		sql.append(" t.LOGINNAME AS LOGINNAME, ");
		sql.append(" t.LOGINPASSWORD AS LOGINPASSWORD ");
		sql.append(" FROM UmUser t ");
		sql.append(" where t.USERNAME != 'saas' ");
		try {
			return new DBHelper().queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
			return new LinkedList<Map<String,Object>>();
		}
	}

	
}
