package com.googosoft.ggs.homeManager;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.ISessionContants;
import com.googosoft.commons.Validate;
import com.googosoft.exception.ManagerException;
import com.googosoft.ggs.homeManager.menu.MenuFactory;

/**
 * 类描述：
 * 
 * @since 1.5
 * @version 1.0
 * @author xuanly
 * 
 */
public class ResourceByDisplay implements ISessionContants {
	private Logger logger = Logger.getLogger(ResourceByDisplay.class.getName());

	public List findTreeByumresource(HttpServletRequest request, String parentId)
			throws ManagerException {
		Map userMap = (Map) request.getSession().getAttribute(USERMAP);
		String userId = (String) request.getSession().getAttribute(
				USERIDBYLOGIN);
		String roleIds = Power.getRoleIdsByUserId(userId);
		String userName = Validate.isNullToDefault(userMap.get("USERNAME"), "")
				.toString();
		return MenuFactory.getInstance(userName).findTreeByumresource(userId,
				userName, roleIds, parentId);
	}

	/**
	 * 获取根节点信息
	 * 
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findBasicTreeByumresource(HttpServletRequest request)
			throws ManagerException {
		Map userMap = (Map) request.getSession().getAttribute(USERMAP);
		String userId = (String) request.getSession().getAttribute(
				USERIDBYLOGIN);
		String roleIds = Power.getRoleIdsByUserId(userId);
		String userName = Validate.isNullToDefault(userMap.get("USERNAME"), "")
				.toString();
		return MenuFactory.getInstance(userName).findBasicTreeByumresource(
				userId, userName, roleIds);
	}

}
