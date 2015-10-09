<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>sm_main</title>
<%@include file="/ggs/include/css.inc" %>
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
<style type="text/css">
	.body{
		background:#1775A9;
	}
	.sm_main_head_logo_left {
		background:url('<%=path%>/image/logo.gif') no-repeat;
		width:100%;
		float:left;
		height:65px;
		margin:0px;
	}
	.sm_main_head_logo_right {
		width:100%;
		height:26px;
		float:left;
		border-top:1px solid #8FD1F4;
		border-left:4px solid #1775A9;
		background:url('<%=path%>/image/ht_dh-2.gif') repeat-x;
	}
	.sm_main_head_logo_right_dqdl{
		float:left;
		width:183px;
		height:26px;
		line-height:26px;
		background:url('<%=path%>/image/ht_dh-1.gif') no-repeat left top;
	}
	.sm_main_head_logo_right_dqdl span{
		margin-left:33px;
		font-size:12px;
		color:#FFF;
	}
	a{
		text-decoration: none;
	}
/* 	.sm_main_foot { */
<%-- 		background:url('<%=path%>/image/ht_dt.gif') no-repeat; --%>
/* 		color:#FFF; */
/* 	} */
</style>
</head>
<body class="body">
<div class="sm_main_head">
	<div class="sm_main_head_logo_left">
		<div id="sys-datetime" style="float:right;margin-right:20px;margin-top:10px;color:#FFF;"">
   			<div id="date_time" style="float:left;">2015年05月11日</div>
   			<div id="tool_time" style="margin-left:10px;float:left;">11:11:11</div>
		</div>
		<div class="sm_main_head_logo_point"  style="float:right;margin-right:20px;margin-top:10px;">
<!-- 			<a id="skinButtonSecond" class="iconA direction"></a> -->
<!-- 			<a id="skinButtonFirst" class="iconA direction"></a> -->
			<a href="<%=path%>/" class="lableA direction">主页</a>
			<a class="iconA direction" style="background:url('<%=path%>/image/ht_home.png') no-repeat;"></a>
			<a id="logout" class="lableA direction">注销</a>
			<a id="loginOut" class="iconA direction"></a>
			<a id="updatePassword" class="lableA direction">修改密码</a>
<%-- 			<label class="direction welcome">当前登录：<%=((Map) session.getAttribute("USERMAP")).get("USERNAME")%></label> --%>
		</div>
	</div>
	<div class="sm_main_head_logo_right">
		<div class="sm_main_head_logo_right_dqdl">
			<span>当前登录：<%=((Map) session.getAttribute("USERMAP")).get("USERNAME")%></span>
		</div>
	</div>
</div>

<div class="sm_main_body"></div>
<div class="sm_main_foot"><label>为 创 业 做 准 备</label></div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function(){
		setPageSize();
		addIframe($(".sm_main_body"),"lead","lead.jsp");
// 		$(".sm_main_head_logo_left").click(function(){
// 			location.reload();
// 		});
		$("#logout").click(function(){
			$.ajax({
				type : "post",
				url : "<%=path%>/jsp/logout.jsp",
				dataType : "text",
				data : {logout : "yes"},
				success : function() {
					window.location.href="<%=path%>";
				}
			});
		});
		$("#updatePassword").click(function(){
			var src = "<%=path%>/jsp/updatePassword.jsp";
			jumpWindow("修改密码", "350px", "200px", src);
		});
	});
	function setPageSize(){
		setHeight($(".sm_main_body"), $("body"), [$(".sm_main_head"),$(".sm_main_foot")], 24);
	}
</script>
</body>
</html>