<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>系统错误页面</title>
    <style type="text/css">
        html,body,div{
            margin:0px;
            padding:0px;
            border:0px;
        }
        html,body
        {
            width:100%;
            height:100%;
            overflow:hidden;
        }
        .d_body
        {
            width:100%; 
            height:100%;
            background: url("nologin.png") no-repeat no-repeat;
            background-position: 50% 50%;
            background-color: rgb(255, 255, 255);
        }
    </style>
</head>
<%
String path = request.getContextPath();
%>
<body>
	<div class="d_body"></div>
</body>
</html>