<%@page import="com.google.gson.Gson"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.filesManager.netresvindicate.ResourceManager"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	String typeId = request.getParameter("typeId");
	List typeList=new ResourceManager().findListByRESOURCEMANAGER();  
	Gson gson=new Gson();
	response.getWriter().print(gson.toJson(typeList));
%>