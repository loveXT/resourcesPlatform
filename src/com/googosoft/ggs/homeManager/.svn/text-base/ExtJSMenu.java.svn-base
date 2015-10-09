package com.googosoft.ggs.homeManager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.tree.TreeInfo;
import com.googosoft.zapi.DBHelper;

public class ExtJSMenu {

	public static String initMenu(HttpServletRequest request) throws ManagerException{
		String userId = (String) request.getSession().getAttribute(
				"USERIDBYLOGIN");
		String roleIds = Power.getRoleIdsByUserId(userId);
		StringBuffer result = new StringBuffer();
		String finalString = "";
		List firstMenuList = findLv1(roleIds);
		result.append("[");
		//遍历第一级菜单集合
		for(int i=0;i<firstMenuList.size();i++){
			String aaa = initLinkMenu(((Map)firstMenuList.get(i)).get("UMRESOURCEID").toString(), roleIds,request);
			if(aaa.trim().length()==0){continue;}
			result.append("{");
			result.append("title:'"+((Map)firstMenuList.get(i)).get("UMRESOURCENAME")+"',autoScroll:true,iconCls:'MKBH"+((Map)firstMenuList.get(i)).get("UMRESOURCEID")+"',items:[");
			result.append("{xtype:'treepanel',border:false,useArrows:true,listeners:listeners,rootVisible:false,");
			result.append("root:{expanded:true,children:[");
			//调用方法查询次级菜单集合
			result.append(aaa);
			result.append("]}}]},");
		}
		if(result.length()>0){
			finalString = result.substring(0, result.length()-1);
		}
			finalString = finalString + "]";
		return finalString;
	}
	
	public static String initLinkMenu(String pid, String roleIds,HttpServletRequest request) throws ManagerException{
		StringBuffer result = new StringBuffer();
		DBHelper db = new DBHelper();
		String userId = (String) request.getSession().getAttribute("USERIDBYLOGIN");
		String finalString = "";
		List linkMenuList = findLv2(pid, roleIds);
		if(linkMenuList.isEmpty()){return "";}
		
		//遍历次级菜单集合
		for(int i=0;i<linkMenuList.size();i++){
			
			List childrenMenuList = findLv3((String)((Map)linkMenuList.get(i)).get("UMRESOURCEID"), roleIds);
			if(childrenMenuList.size()!=0){
				String bbb = initLinkMenuLv3(((Map)linkMenuList.get(i)).get("UMRESOURCEID").toString(), roleIds,request);
				if(bbb.trim().length()==0){continue;}
				result.append("{text:'"+((Map)linkMenuList.get(i)).get("UMRESOURCENAME")+"',id:'"+((Map)linkMenuList.get(i)).get("UMRESOURCEID")+"',iconCls:'',url:'',leaf:false,children:[");
				result.append(bbb);
				result.append("]},");
			}else if(iCanShow((String)((Map)linkMenuList.get(i)).get("UMRESOURCEID"), roleIds)){
				result.append("{text:'"+((Map)linkMenuList.get(i)).get("UMRESOURCENAME")+"',id:'"+((Map)linkMenuList.get(i)).get("UMRESOURCEID")+"',iconCls:'tree-icon',url:'"+((Map)linkMenuList.get(i)).get("UMRESOURCEURL")+"',leaf:true},");	
			}
		}
		if(result.length() == 0){
//						return "";
		}else{
			finalString = result.toString();
			finalString = finalString.substring(0, finalString.length()-1);
		}
		
		return finalString;
	}
	public static String initLinkMenuLv3(String pid, String roleIds,HttpServletRequest request) throws ManagerException{
		StringBuffer result = new StringBuffer();
		DBHelper db = new DBHelper();
		String userId = (String) request.getSession().getAttribute("USERIDBYLOGIN");
		String qfpt=(String)request.getAttribute("qfpt");
		String finalString = "";
		List linkMenuList = findLv3(pid, roleIds);
//		if(linkMenuList.isEmpty()){return "";}
		
		//遍历次级菜单集合
		for(int i=0;i<linkMenuList.size();i++){
			
			result.append("{text:'"+((Map)linkMenuList.get(i)).get("UMRESOURCENAME")+"',id:'"+((Map)linkMenuList.get(i)).get("UMRESOURCEID")+"',iconCls:'tree-icon',url:'"+((Map)linkMenuList.get(i)).get("UMRESOURCEURL")+"',leaf:true},");	
		}
		if(result.length() == 0){
//			return "";
		}else{
			finalString = result.toString();
			finalString = finalString.substring(0, finalString.length()-1);
		}
		
		return finalString;
	}
	/**
	 * 获取第一级菜单
	 * @param request
	 * @return
	 * @throws ManagerException
	 */
	public static List findLv1(String roleIds){
		StringBuffer sql = new StringBuffer("select distinct t.* from UMRESOURCE t ");
		sql.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		sql.append(" and t.umresourceid = t.umresourceparentid ");
		sql.append(" ORDER BY T.UMORDER ");
		DBHelper d = new DBHelper();
		List list = new ArrayList();
		try {
			list = d.queryForList(sql.toString());
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public static List findLv2(String parentId, String roleIds){
		StringBuffer sql = new StringBuffer("select distinct t.* from UMRESOURCE t ");
		sql.append(" left JOIN UMMANAGER M ");
		sql.append(" ON M.UMRESOURCEID = T.UMRESOURCEID ");
		sql.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		sql.append(" and t.umresourceparentid = '"+parentId+"'");
		sql.append(" and t.umresourceid != '"+parentId+"'");
//		sql.append(" AND M.UMROLEID IN('"+roleIds+"') ");
		sql.append(" ORDER BY T.UMORDER ");
		DBHelper d = new DBHelper();
		List list = new ArrayList();
		try {
			list = d.queryForList(sql.toString());
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public static List findLv3(String parentId, String roleIds){
		StringBuffer sql = new StringBuffer("select distinct t.* from UMRESOURCE t ");
		sql.append(" RIGHT JOIN UMMANAGER M ");
		sql.append(" ON M.UMRESOURCEID = T.UMRESOURCEID ");
		sql.append(" WHERE T.UMRESOURCEUSEABLE = 'T' ");
		sql.append(" and t.umresourceparentid = '"+parentId+"'");
		sql.append(" and t.umresourceid != '"+parentId+"'");
		sql.append(" AND M.UMROLEID IN('"+roleIds+"') ");
		sql.append(" ORDER BY T.UMORDER ");
		DBHelper d = new DBHelper();
		List list = new ArrayList();
		try {
			list = d.queryForList(sql.toString());
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	public static boolean iCanShow(String id, String roleIds){
		String sql = "select 1 from UMRESOURCE t RIGHT JOIN UMMANAGER M ON M.UMRESOURCEID = T.UMRESOURCEID WHERE T.UMRESOURCEUSEABLE = 'T' and t.umresourceid = '"+id+"' AND M.UMROLEID IN ('"+roleIds+"')";
		try {
			List list = new DBHelper().queryForList(sql);
			if(!list.isEmpty()){return true;}
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	public static void main(String[] args) throws ManagerException, DBException {
		
		//getBhFromRoleright();
	}
}
