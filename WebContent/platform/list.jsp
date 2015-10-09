<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.googosoft.menumanager.AllManager" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>展示页面</title>
<% 
String path = request.getContextPath(); 
%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/search.css">
<style type="text/css">
.time{
position: absolute;
right: 8px;
}
</style>
</head>
<body >
	<%
		int startPage,endPage,upshow,downshow=1;
		String nowPage=request.getParameter("nowPage");
		if(Validate.isNull(nowPage)){
			nowPage="0";
		}
		String id=request.getParameter("flag");
		startPage=Integer.parseInt(nowPage);
		endPage=startPage+14;

		if(Validate.isNull(id)){
			id="8bb801332e12443db89afc227f260c33";
		}
		AllManager ams=new AllManager();
		List lists=ams.findPageInfoByClassify(id);
		if(endPage>=lists.size()){
			endPage=lists.size();
			downshow=0;  //不再显示下一页
		}
		Map map=null;
	%>
 	<table class="listtable">
		<tr class="firsttr">
				<td>&nbsp;<img src="../image/arrow.gif" />&nbsp;<strong>首页&nbsp;>&nbsp;平台资讯</strong></td>
		</tr>
		<tr>
			<td>
			<ul style="height: 370px;">
			<%
				for(int i=startPage;i<endPage;i++){
					map=(Map) lists.get(i);
					String title=map.get("TITLE").toString();
					if(title.length()>33){
						title=title.substring(0,33)+"...";
					}
			%>
				<li class="lishow" onclick="tras('<%=map.get("ID")%>')" ><%=title%><span class="time">[<%=map.get("UPDATETIME") %>]</span></li>
			<%
				}
			%>
			</ul>
			
			
			</td> 
			
		</tr>
		<tr >
		<td style="text-align: center;height:30px; float: left;">
			<div class="lastdiv">
			<%
				if(startPage!=0){
			%>
			<span class="prepage" onclick="up()"></span>
			<%
			}
			%>
			<%
				if(downshow!=0){
			%>
			<span class="nextpage" onclick="down()"></span>
			<%
				}
			%>
			<!-- <span class="yeshu">/</span> -->
			<%
				int num=lists.size()/14;
				if(lists.size()%14!=0){
					num+=1;
				}
			%>
				<span class="yeshu">第<%=startPage/14+1 %>页/共<%=num %>页</span>  
			</div>
		</td>
		</tr>	
	</table> 
	<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	function tras(ids){
		location.href="<%=path %>/notice/notice.jsp?id="+ids+"&flag=<%=id%>&nowPage=<%=nowPage%>";
	}

	function up(){
	location.href="list.jsp?flag=<%=id%>&nowPage=<%=startPage-14%>";		
	}

	function down(){
	location.href="list.jsp?flag=<%=id%>&nowPage=<%=startPage+14%>";
	}

</script>
</body>
</html>