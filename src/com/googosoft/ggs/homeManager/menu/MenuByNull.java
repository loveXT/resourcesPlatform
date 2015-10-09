package com.googosoft.ggs.homeManager.menu;

import java.util.List;

import com.googosoft.commons.ISessionContants;
import com.googosoft.exception.ManagerException;

public class MenuByNull implements ISessionContants,IMenuMould{

	@Override
	public List findTreeByumresource(String userId, String userName,
			String roleIds, String parentId) throws ManagerException {
		return null;
	}

	@Override
	public List findBasicTreeByumresource(String userId, String userName,
			String roleIds) throws ManagerException {
		return null;
	}


}
