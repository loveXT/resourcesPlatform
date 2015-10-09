<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>sm_main</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	
</style>
</head>
<body class="body">
<div class="sm_main_head">
	<div class="sm_main_head_logo_left"></div>
	<div class="sm_main_head_logo_right">
		<div class="sm_main_head_logo_point"></div>
	</div>
</div>

<div class="sm_main_body"></div>
<div class="sm_main_foot"><label style="color: white;font-size: 16;">版权所有：济南国子数码科技有限公司</label></div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function(){
		setPageSize();
		addIframe($(".sm_main_body"),"lead","lead.jsp");
	});
	function setPageSize(){
		setHeight($(".sm_main_body"), $("body"), [$(".sm_main_head"),$(".sm_main_foot")], 0);
	}
</script>
</body>
</html>