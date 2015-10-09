<%@page import="com.sun.star.resource.StringResource"%>
<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.commons.ObtainOperationUtil"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="com.googosoft.commons.CookieHelper"%>
<%@page import="com.googosoft.ggs.homeManager.LoginManager"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆跳转</title>
</head>
<body>
<%
String name = request.getParameter("name");
String password = request.getParameter("password");
String sm = "blue";
session.setAttribute("sm",sm);
CookieHelper.addCookie("sm",sm,1000,response);

String menuid = request.getParameter("menuid");
String userId= request.getParameter("userid");
if(menuid!=null&&!"".equals(menuid)){
	if(session.getAttribute(menuid)!=null){
		session.setAttribute("power", "");
		session.setAttribute("RESOURCEID", "");
	}
	String resourceURL=OperationCache.getCurrentURL(request);
	session.setAttribute("resourceURl",resourceURL);
	session.setAttribute(ISessionContants.USERIDBYLOGIN,userId);
	session.setAttribute(ISessionContants.SAAS,"system   ");
	String str=ObtainOperationUtil.getOpreations(menuid,userId);
	LoginManager loginManager = new LoginManager();
	Map map=loginManager.findMapByuserId(userId);
	session.setAttribute(ISessionContants.USERMAP,map);
	session.setAttribute("power",str);
	response.sendRedirect("blue/common.jsp?menuid="+menuid);
	return;
}else{
	LoginManager loginManager = new LoginManager();
	Boolean bool = loginManager.loginUser(name,password,request);
	if(bool){
		response.sendRedirect("blue/main.jsp");
	}else{
		request.setAttribute("loginRemark","登录失败");
		request.getRequestDispatcher("login.jsp").forward(request,response);
	}
}

%>
</body>
</html>