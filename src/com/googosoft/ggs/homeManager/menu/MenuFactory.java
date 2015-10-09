package com.googosoft.ggs.homeManager.menu;

import com.googosoft.commons.ISessionContants;
import com.googosoft.commons.Validate;

public class MenuFactory implements ISessionContants {
	/**
	 * 单例模式（懒汉）
	 * 
	 * @param args
	 */
	private static IMenuMould instance;

	private MenuFactory() {

	}

	public static IMenuMould getInstance(String userName) {
		if(Validate.isNull(userName)){
			instance = new MenuByNull();
		}else if(SAAS.equals(userName.toUpperCase())){
			instance = new MenuBySaas();
		}else{
			instance = new MenuByCommon();
		}
		return instance;
	}
}
