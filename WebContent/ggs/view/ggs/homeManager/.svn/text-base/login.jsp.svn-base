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
%>
<body>
<%=remark==null?"":remark %>
<form action="<%=path %>/ggs/view/ggs/homeManager/loginValidate.jsp" method="post" style="margin: 0 auto; width: 300px; margin-top: 30px;">
	
	<input type="hidden" name="sm" value="blue">
	<table>
		<tr>
			<td>登录名1</td>
			<td><input type="text" name="name" value="admin">
			</td>
		</tr>
		<tr>
			<td>密码1</td>
			<td><input type="password" name="password" value="666666">
			</td>
		</tr>
<!-- 		<tr> -->
<!-- 			<td>皮肤</td> -->
<%-- 			<% --%>
<!-- 			String sm = CookieHelper.getCookie(request,"sm"); -->
<!-- 			%> -->
<!-- 			<td> -->
<!-- 			<select name="sm" style="width: 150px;"> -->
<%-- 				<option value="insipidity" <%if("insipidity".equals(sm)){%>selected="selected"<%}%>>清淡</option> --%>
<%-- 				<option value="green" <%if("green".equals(sm)){%>selected="selected"<%}%>>蓝色2</option> --%>
<%-- 				<option value="blue" <%if("blue".equals(sm)){%>selected="selected"<%}%>>蓝色1</option> --%>
<%-- 				<option value="default" <%if("default".equals(sm)){%>selected="selected"<%}%>>默认</option> --%>
<!-- 			</select> -->
<!-- 			</td> -->
<!-- 		</tr> -->
		<tr>
			<td></td>
			<td><input type="submit"></td>
		</tr>
	</table>
</form>
</body>
</html>