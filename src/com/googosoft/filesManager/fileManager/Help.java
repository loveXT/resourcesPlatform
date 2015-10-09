package com.googosoft.filesManager.fileManager;

import com.enterprisedt.util.debug.Logger;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.PageHelper;

public class Help {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		StringBuffer sb=new StringBuffer();
		sb.append(" select ");
		sb.append(" * from files ");
		PageInfo pageinfo=null;
		try{
			pageinfo=new PageHelper(2,3,sb.toString()).getPageInfo();
			System.out.println(pageinfo.getList());
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
	}

}
