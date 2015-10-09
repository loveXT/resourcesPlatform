package com.googosoft.ggs.homeManager;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.googosoft.commons.ISessionContants;
import com.googosoft.exception.ManagerException;
import com.googosoft.ggs.userManager.UMManager;
import com.googosoft.ggs.userManager.UserRoleManager;

/**
 * 类描述：
 * 
 * @since 1.5
 * @version 1.0
 * @author xuanly
 * 
 */
public class Power {
	private static Logger logger = Logger.getLogger(Power.class
			.getName());

	public static String getOperates(HttpServletRequest request)
			throws ManagerException {
		try {
			HttpSession session = request.getSession();
			String loginId = session.getAttribute(ISessionContants.USERIDBYLOGIN).toString();
			
			String operate = (String) session.getAttribute("power");
			if(operate!=null&&!"".equals(operate)){
				return operate;
			}else{
				String resourceId = session.getAttribute("RESOURCEID").toString();
				String roleIds = getRoleIdsByUserId(loginId);
				return getOperateIdsByRoleAndResource(roleIds, resourceId);
			}
		} catch (ManagerException e) {
			logger.error("获取该用户的操作名称失败" + e);
			throw new ManagerException("获取该用户的操作名称失败" + e);
		}
	}

	/**
	 * 获取用户拥有的角色ids
	 * 
	 * @param userId
	 * @return
	 * @throws ManagerException
	 */
	static String getRoleIdsByUserId(String userId) throws ManagerException {
		StringBuffer roles = new StringBuffer();
		UserRoleManager userRoleManager = new UserRoleManager();
		List roleList = userRoleManager.findListByUmUserRole(userId);
		Map roleMap = null;
		for (int i = 0; i < roleList.size(); i++) {
			roleMap = (Map) roleList.get(i);
			roles.append(roleMap.get("UMROLEID"));
			roles.append("','");
		}
		return roles.toString();
	}

	/**
	 * 获取角色拥有的此资源的操作ids
	 * 
	 * @param roleIds
	 * @param resourceId
	 * @return
	 * @throws ManagerException
	 */
	private static String getOperateIdsByRoleAndResource(String roleIds,
			String resourceId) throws ManagerException {
		UMManager umManager = new UMManager();
		StringBuffer sb = new StringBuffer();
		List umList = umManager.findListByUmManager(roleIds, resourceId);
		Map umMap = null;
		for (int i = 0; i < umList.size(); i++) {
			umMap = (Map) umList.get(i);
			sb.append(umMap.get("UMOPERATENAME"));
			sb.append(",");
		}
		return sb.toString();
	}

}
