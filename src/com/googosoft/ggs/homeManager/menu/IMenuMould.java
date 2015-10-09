package com.googosoft.ggs.homeManager.menu;

import java.util.List;

import org.apache.log4j.Logger;

import com.googosoft.exception.ManagerException;

public interface IMenuMould {
	Logger logger = Logger.getLogger(MenuByCommon.class.getName());
	public List findTreeByumresource(String userId,String userName,String roleIds,String parentId)
			throws ManagerException;
	/**
	 * 获取根节点信息
	 * 
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public List findBasicTreeByumresource(String userId,String userName,String roleIds)
			throws ManagerException;
}
