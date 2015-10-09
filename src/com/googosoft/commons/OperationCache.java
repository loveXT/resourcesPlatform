package com.googosoft.commons;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.ggs.homeManager.Power;
import com.googosoft.zapi.DBHelper;

public class OperationCache {
	
	private static final HashMap<String,String> map = new HashMap<String,String>();
	
	private static final HashMap<String,String> urlMap=new HashMap<String,String>();
	
	public static void setOpreation(String key,String value){
		map.put(key, value);
	}
	
	public static String getOperationValue(String key){
		return map.get(key);
	}
	/**
	 * 根据当前访问路径分获得该路径的操作
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public static  String getOperation(HttpServletRequest request) throws ManagerException{
		String operate = Power.getOperates(request);
		String userid=(String)request.getSession().getAttribute("USERIDBYLOGIN");
		String path=request.getRequestURL().toString();
		if(map.containsKey(path+userid)&&map.containsValue(operate)){
			return map.get(path+userid);
		}else{
			
			map.put(path+userid, operate);
			return map.get(path+userid);
		}
	}
	public static String getCurrentURL(HttpServletRequest request){
		String menuid =request.getParameter("menuid");
		DBHelper dh = new DBHelper();
		String sql="SELECT UMRESOURCEURL FROM UMRESOURCE T WHERE T.UMRESOURCEID ='"+menuid+"'";
		Map<String, String> map = null;
		try {
			map = dh.queryForMap(sql);
		} catch (DBException e) {
			log.error(e.getMessage()); 
		}
		String resourceURl =Validate.isNullToDefault(map.get("UMRESOURCEURL"),"").toString();
		if(urlMap.containsKey(menuid)&&urlMap.containsValue(resourceURl)){
			return urlMap.get(menuid);
		}else{
			urlMap.put(menuid, resourceURl);
			return urlMap.get(menuid);
		}
	}
	
	public static String  isAdmin(HttpServletRequest request){
		String userid=(String)request.getSession().getAttribute("USERIDBYLOGIN");
		DBHelper dh = new DBHelper();
		String sql="SELECT UNAME FROM POWERSYS.SYS_USER T WHERE T.UGID ='"+userid+"'";
		Map<String, String> map = null;
		try {
			map = dh.queryForMap(sql);
		} catch (DBException e) {
			log.error(e.getMessage()); 
		}
		String name=Validate.isNullToDefault(map.get("UNAME"),"").toString();
		if("admin".equals(name.toLowerCase())){
			return "delete";
		}else{
			return "false";
		}
	}
	
	private static Logger log= Logger.getLogger(OperationCache.class);
}
