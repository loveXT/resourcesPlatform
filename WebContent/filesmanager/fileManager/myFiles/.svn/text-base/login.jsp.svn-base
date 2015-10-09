<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.commons.CookieHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆界面</title>
</head>
<%
String path = request.getContextPath();
Object remark = request.getAttribute("loginRemark");
String url = request.getParameter("url");
%>
<body>
<%=remark==null?"":remark %>
<form action="loginValidate.jsp?url='<%=url %>'" method="post" style="margin: 0 auto; width: 250px; margin-top: 30px;">
	
	<input type="hidden" name="sm" value="blue">
	<table>
		<tr>
			<td>登录名</td>
			<td><input type="text" name="name" value="">
			</td>
		</tr>
		<tr>
			<td>密码</td>
			<td><input type="password" name="password" value="">
			</td>
		</tr>
		<tr>
			<td></td>
			<td style="text-align:center;"><input type="submit" style="height:35px ;width: 100px;font-size: 14pt;margin-top:15px;"></td>
		</tr>
	</table>
</form>
</body>
</html>