package com.googosoft.ggs.homeManager;

import java.security.MessageDigest;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.googosoft.common.util.Validator;
import com.googosoft.commons.ISessionContants;
import com.googosoft.commons.MD5;
import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.DBHelper;

/**
 * 登陆管理类
 * 
 * @author xuanly
 * 
 */
public class LoginManager implements ISessionContants {
	private Logger logger = Logger.getLogger(LoginManager.class.getName());

	/**
	 * 登陆
	 * 
	 * @param loginName
	 *            登陆名称
	 * @param loginPassword
	 *            登陆密码
	 * @param request
	 * @return 登陆成功返回true；失败返回false。
	 */
	public boolean loginUser(String loginName, String loginPassword,
			HttpServletRequest request) {
		if(Validator.isNull(loginPassword)){
			return false;
		}
		String sql = " SELECT ";
		sql += " USERID ";
		sql += " FROM UmUser t ";
		sql += " where t.LOGINNAME = '" + loginName + "' ";
			loginPassword = md5(loginPassword).toUpperCase();
			sql += " and t.LOGINPASSWORD = '" + loginPassword + "' ";
		DBHelper dbHelper = new DBHelper();
		Object object = null;
		Map map = null;
		HttpSession session = request.getSession();
		try {
			object = dbHelper.queryForSingleValue(sql);
			map = findMapByuserId(object.toString());
			session.setAttribute(USERIDBYLOGIN, map.get("USERID"));
			session.setAttribute(SAAS, map.get("SAAS").toString().trim());
			if (map.get("USERSKIN") != null) {
				session.setAttribute(SM, map.get("USERSKIN"));
			}
			session.setAttribute(USERMAP, map);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	/**
	 * 登陆成功后，查询要保存在session中的数据
	 * 
	 * @param userId
	 *            登陆者id
	 * @return 登陆者信息
	 * @throws ManagerException
	 */
	public Map findMapByuserId(String userId) throws ManagerException {
		try {
			String sql = " SELECT * ";
			sql += " FROM UmUser t ";
			sql += " WHERE t.USERID= '" + userId + "' ";
			DBHelper dbHelper = new DBHelper();
			Map map = null;
			map = dbHelper.queryForMap(sql);
			if (Validate.noNull(map.get("RELATETABLE"))
					&& Validate.noNull("RELATEID")) {
				String[] relateTable = map.get("RELATETABLE").toString().split(
						",");
				if (relateTable.length != 2) {
					logger.error("RELATETABLE不符合规范");
					throw new ManagerException("RELATETABLE不符合规范");
				}
				String tableName = relateTable[0];
				String tableId = relateTable[1];
				String s = " SELECT ";
				s += " t.USERID,t.USERNAME,t.LOGINNAME, ";
				s += " R.* FROM UMUSER T ";
				s += " LEFT JOIN " + tableName + " R ON T.RELATEID = R."
						+ tableId;
				s += " WHERE t.USERID= '" + userId + "' ";
				map = dbHelper.queryForMap(s);
			}
			return map;
		} catch (DBException e) {
			e.printStackTrace();
			throw new ManagerException(e);
		}
	}
	public  String md5(String str) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte b[] = md.digest();

			int i;

			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			str = buf.toString();
		} catch (Exception e) {
			e.printStackTrace();

		}
		return str;
	}
}
