<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.googosoft.menumanager.AllManager" %>
<%@page import="com.googosoft.menumanager.MenuManager" %>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>公告</title>
<% String path = request.getContextPath(); %>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/search.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/index.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/indexs.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/xcConfirm.css"/>
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/xcConfirm.js"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
</head>
<%
	//从上级页面接收二级页面类型为新闻或者公告
	String id=request.getParameter("id");   //id
	String flag=request.getParameter("flag");
	String nowPage=request.getParameter("nowPage");
	int startPage=Integer.parseInt(nowPage);
	System.out.println("+++++++++++"+flag);
	System.out.println("------------"+nowPage);
	AllManager am=new AllManager();
	Map map=am.findPageInfoByNotice(id);
	am.setBrowseAddOne(id);
%>
<body>
	<div style="padding: 8px;">
	<table class="listtable">
		<tr class="firsttr">
				<td>&nbsp;<img src="../image/arrow.gif" />&nbsp;<strong onclick="esc()" style="cursor: pointer;"> < < 返回 </strong></td>
		</tr>
	</table>
	
			<!-- <div style="height:25px;border-bottom: solid 1px #CCCCCC;"></div> -->
			<%
				if(map.get("NAVIGATIONNAME").equals("公告")){
			%>
				<div class="noticeImg" style="margin:0px 0px;width: 100px;"></div>
				<%
				}else{
				%>
				<div class="newsImg" style="margin:0px 0px;"></div>
				<%
				}
				%>
				
			<table style="margin:0px 0px;" cellpadding="0" cellspacing="0" border="1"; width="64%" >
				<tr >
					<td style="color:#663333;line-height:1;height:40px;padding:15px 0px 20px 10px;font: bold 16px 宋体,Arial, Helvetica, sans-serif;text-align: center;">
						<%=map.get("TITLE") %></td>
				</tr>
				<tr width="100%" >
				 <td width="100%" align="center" bgcolor="#f1f1f1" style="color:#000000;height:10px;font: 13px 宋体,Arial, Helvetica, sans-serif;">发表日期：<%=map.get("UPDATETIME") %>&nbsp;&nbsp;&nbsp; 浏览次数：<span class="vcount"><%=map.get("BROWSE") %></span></td> 
				 </tr>
				<tr height="1px"> <td width="80%" height="1px" style="border-bottom:1px solid #434240" bgcolor="#FFFFFF"> </td> </tr>
				
				<tr align="left" >
				 <td align="left" style=" font: 13px 宋体,Arial, Helvetica, sans-serif;color:#000000;padding:5px 0px 0px 5px;line-height:200%" >
				 <p><%=map.get("CONTENT") %></p> 
				 </td> 
				 </tr>
			</table>	
	</div>
	<script type="text/javascript">
		function esc(){
		location.href="<%=path %>/platform/list.jsp?flag=<%=flag%>&nowPage=<%=startPage%>";
		}
	</script>
</body>
</html>

