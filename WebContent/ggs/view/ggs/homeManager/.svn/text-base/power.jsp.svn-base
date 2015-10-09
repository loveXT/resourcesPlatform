<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.userManager.ResourceManager"%>
<%@page import="java.util.Map"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>power</title>
<%@include file="/ggs/include/css.inc"%>
<style type="text/css">
	body{
<!--		background: white;-->
	}
</style>
</head>
<%
	String resourceId = request.getParameter("resourceId");
	ResourceManager resourceManager = new ResourceManager();
	Map resourceMap = resourceManager.findMapByumResourceId(resourceId);
	String resourceUrl = resourceMap.get("UMRESOURCEURL")+"";
	if(Validate.isNull(resourceUrl)){
		resourceUrl = request.getParameter("resourceUrl");
	}else{
		resourceUrl = request.getContextPath()+"/"+resourceUrl;
	}
	if (resourceId != null) {
		session.setAttribute("RESOURCEID", resourceId);
	}
%>
<body>
	<iframe frameborder="0" src="<%=resourceUrl%>"></iframe>
<%@include file="/ggs/include/js.inc"%>
	<script type="text/javascript">
	$(function(){
		setPageSize();
	});
	function setPageSize(){
	}
	</script>
</body>
</html>