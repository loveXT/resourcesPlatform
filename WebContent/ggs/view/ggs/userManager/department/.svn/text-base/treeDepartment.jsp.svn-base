<%@page import="com.googosoft.ggs.userManager.DepartmentManager"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源树</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
//改动处begin
String umdepartmentid = request.getParameter("umdepartmentid");
DepartmentManager departmentManager = new DepartmentManager(); 
List trees = departmentManager.findTreeByumdepartment(umdepartmentid);
String checkedIds = request.getParameter("checkedIds");
String parentId = request.getParameter("parentId");
Boolean only = true;
String bottom = null;
Boolean basic = true;
//改动处end
%>
<body>
<%@include file="/ggs/include/checkTree.inc" %>
</body>
</html>