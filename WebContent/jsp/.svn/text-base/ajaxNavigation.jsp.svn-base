<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.oa.navigation.NavigationManager"%>
<%
	response.setContentType("text/html;charset=UTF-8");
	Map map=null;
	StringBuffer sb=new StringBuffer("");
	NavigationManager navigationManager = new NavigationManager();
	List list = navigationManager.findAllListByNavigation();
	for(int i=0;i<list.size();i++){
		map=(Map)list.get(i);
			sb.append(map.get("ID")+"%"+map.get("NAVIGATIONNAME")+",");
		}
	if(sb.length()>0){
		sb.deleteCharAt(sb.length()-1);
	}
	out.print(sb.toString());
%>