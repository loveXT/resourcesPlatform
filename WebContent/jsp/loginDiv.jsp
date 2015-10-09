<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.commons.CookieHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆界面</title>
<%
	String path = request.getContextPath();
	Object remark = request.getAttribute("loginRemark");
	String url = Validate.isNullToDefault(request.getParameter("url"), path).toString();
%>
<style type="text/css">
#loginForm .submit_button {
	float: left;
	width: 320px;
	height: 40px;
	margin-top:30px;
	background: url('<%=path%>/image/anniu.png') no-repeat;
}
</style>
</head>
<body>
<div style="height:30px;width:100%;font-size:14px;font-family: 微软雅黑;color:#E02A36;font-weight:bold;">
<span>登录</span>
<span style="font-size:14px;font-family: 微软雅黑;color:red;font-weight:normal;margin-left:100px;"><%=remark == null ? "" : remark%></span>
</div>
<form id="loginForm" action="loginValidate.jsp?url=<%=url%>" method="post" style="margin-top: 10px;">
	<input type="hidden" name="sm" value="blue">
	<div style="background: url('<%=path%>/image/login_name.jpg') no-repeat 5px center;float:left;width:290px;line-height:30px;color:#999;font-size:12px;border:1px solid #d3d3d3;">
	<span style="margin-left:30px">账号</span>
		<input type="text" name="name" style="margin-left:10px;border:0px;width: 220px;height: 30px;color:#000000;" value="" placeholder="用户名">
	</div>
	<div style="background: url('<%=path%>/image/login_password.jpg') no-repeat 5px center;float:left;width:290px;line-height:30px;margin-top:10px;font-size:12px;color:#999;border:1px solid #d3d3d3;">
		<span style="margin-left:30px">密码</span>
		<input type="password" name="password" style="margin-left:10px;width: 220px;height: 30px;border:0px;color:#000000;" value="">
	</div>
	<div class="submit_button"></div>
</form>
<script type="text/javascript">
	$(function(){
		$(".submit_button").click(function(){
			$("#loginForm").submit();
		});
		$('input').keydown(function(e){
			if(e.keyCode==13){
				$("#loginForm").submit();
			}
		});
	})
</script>
</body>
</html>