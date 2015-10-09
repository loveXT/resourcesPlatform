<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.ResourceByDisplay"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.tree.TreeInfo"%>
<%@page import="java.util.Map"%>
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
		<%
			ResourceByDisplay resourceByDisplay = new ResourceByDisplay();
			List list = resourceByDisplay.findBasicTreeByumresource(request);
			TreeInfo info = null;
			Map resourceMap = null;
			for (int i = 0; i < list.size(); i++) {
				info = (TreeInfo) list.get(i);
				%>
				<div class="sm_main_head_logo_point" id="<%=info.getId()%>" style="background: url('<%=info.getName()+".png"%>') center top no-repeat;">
					<%=info.getName()%>
				</div>
				<%
			}
		%>
	</div>
</div>

<div class="sm_main_body"></div>
<div class="sm_main_foot"><label style="color: white;font-size: 16;">版权所有：济南国子数码科技有限公司</label></div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function(){
		setPageSize();
		addIframe($(".sm_main_body"),"lead","lead.jsp");
		$(".sm_main_head_logo_point").click(function(){
			var $this = $(this);
			var id = $this.attr("id");
			var src = "lead.jsp";
			src += "?parentId="+id;
			$("#lead").attr("src",src);
		});
		$(".sm_main_head_logo_point").first().trigger("click");
	});
	function setPageSize(){
		var num = $(".sm_main_head_logo_point").length;
		$(".sm_main_head_logo_point").width($(".sm_main_head_logo_right").width()/num);
		setHeight($(".sm_main_body"), $("body"), [$(".sm_main_head"),$(".sm_main_foot")], 0);
	}
</script>
</body>
</html>