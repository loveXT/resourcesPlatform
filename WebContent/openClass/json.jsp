<%@page import="com.googosoft.filesManager.openClass.OpenClassManager"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.List"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	String typeId = request.getParameter("typeId");
	List typeList=new OpenClassManager().findCourseByCourseId();  
	Gson gson=new Gson();
	response.getWriter().print(gson.toJson(typeList));
%>