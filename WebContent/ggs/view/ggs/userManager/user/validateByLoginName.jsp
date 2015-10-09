<%@page import="com.googosoft.ggs.userManager.UserManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String loginName = request.getParameter("LOGINNAME");
UserManager userManager = new UserManager();
boolean b = userManager.validateByLoginName(loginName);
out.print(b);
%>