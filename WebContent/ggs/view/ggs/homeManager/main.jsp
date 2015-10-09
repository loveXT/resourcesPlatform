<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>sm_main</title>
</head>
<body>
<%
response.sendRedirect(request.getContextPath()+"/ggs/view/ggs/homeManager/"+session.getAttribute("sm")+"/main.jsp");
%>
</body>
</html>