<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%  String path = request.getContextPath(); 
	String pathSkinTool = request.getContextPath()+"/ggs/skin/blue"; 
	String flag=request.getParameter("flag");
	if(Validate.isNull(flag)){
		flag="8bb801332e12443db89afc227f260c33";
	}
	System.out.println("++++++++++++search.jsp"+flag);
%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/search.css">

<style type="text/css">
</style>
</head>
<body>
<!-- 
	<div style="height:auto;width:100%;float:left;">


	</div> -->
	<div class="fenlei">	
		<table style="width: 230px;border: 1px solid #e7e7e7;padding: 5px;">
			<tr class="selected" id="noticetr" onclick="clicknotice()">
			<td class="selfont" id="noticetd">集团公告</td>
			</tr>
			<tr class="unselected" id="newstr" onclick="clicknews()">
			<td class="unselfont" id="newstd">集团新闻</td>
			</tr>
		</table>
	</div>
	<div class="rights">

		</div>
	<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="<%=path%>/js/searchFunction.js"></script>
	<script type="text/javascript" src="<%=pathSkinTool%>/tool/addIframe.js"></script>
	<script type="text/javascript">
		
		$(function(){
			addIframe($(".rights"),"list","list.jsp?nowPage=0&flag=<%=flag%>");
			<%
				if(flag.equals("fe5ccf7fb99342e6a3032df2841e6dca")){
			%>	
			$("#noticetr").removeClass("selected");
			$("#noticetr").addClass("unselected");
			$("#noticetd").removeClass("selfont");
			$("#noticetd").addClass("unselfont");
			$("#newstr").removeClass("unselected");
			$("#newstr").addClass("selected");
			$("#newstd").removeClass("unselfont");
			$("#newstd").addClass("selfont");
			<%
				}
			%>
		});
		function clicknotice(){
			$("#noticetr").removeClass("unselected");
			$("#noticetr").addClass("selected");
			$("#noticetd").removeClass("unselfont");
			$("#noticetd").addClass("selfont");
			$("#newstr").removeClass("selected");
			$("#newstr").addClass("unselected");
			$("#newstd").removeClass("selfont");
			$("#newstd").addClass("unselfont");
			var src = "list.jsp?flag=8bb801332e12443db89afc227f260c33&nowPage=0";
			$("#list").attr("src",src);
		}
		
		function clicknews(){
			$("#noticetr").removeClass("selected");
			$("#noticetr").addClass("unselected");
			$("#noticetd").removeClass("selfont");
			$("#noticetd").addClass("unselfont");
			$("#newstr").removeClass("unselected");
			$("#newstr").addClass("selected");
			$("#newstd").removeClass("unselfont");
			$("#newstd").addClass("selfont");
			var src = "list.jsp?flag=fe5ccf7fb99342e6a3032df2841e6dca&nowPage=0";
			$("#list").attr("src",src);	
		}
	</script>
</body>
</html>