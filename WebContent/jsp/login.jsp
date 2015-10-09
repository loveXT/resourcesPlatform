<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.commons.CookieHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String path = request.getContextPath();
%>
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<title>登陆界面</title>
<style type="text/css">
	.login{
		width:1000px;
		height:386px;
		margin:0px auto;
		margin-top: -5px;
  		position: relative;
		background:url('<%=path%>/image/bjt3.jpg') no-repeat top center;
	}
	.login .login_div{
		float:left;
		width: 350px;
		height: 260px;
		margin-left:60%;
		margin-top:70px;
		background:white;
		border:1px solid #d3d3d3;
		border-top:4px solid #D31E25;
	}
</style>
</head>
<body>
	<jsp:include page="../common/top/head.jsp"></jsp:include>
	<div class="login" >
			<div class="login_div">
				<div style="padding:30px;padding-top:20px;">
					<jsp:include page="loginDiv.jsp"></jsp:include>
				</div>
			</div>
	</div>
	<jsp:include page="../common/bottom/footer.jsp"></jsp:include>
</body>
</html>