<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.commons.StringUtil"%>
<%@page import="com.googosoft.ggs.userManager.UserManager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.oa.webContent.WebContentManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告</title>
<% String path = request.getContextPath(); %>
<style type="text/css">
	.announcement{
		width:100%;
		height:auto;
		margin:0px auto;
	}
	.announcement .title{
		height:33px;
		width:100%;
		background: url('<%=path%>/image/gg_1.gif') repeat-x;
	}
	.announcement .title_text{
		line-height:34px;
		width:100px;
		margin-left:15px;
		background: url('<%=path%>/image/jt3.gif') no-repeat left center;
		cursor:default;
	}
	.announcement .title_text span{
		padding-left:10px;
		font-size:14px;
		color:#4990E6;
		font-weight:bold;
	}
	.announcement .content{
		width:100%;
		height:auto;
		float:left;
	}
	.announcement .content ul{
		margin:10px 0px;
		padding: 0 0 10px;
	}
	.announcement .content li{
		display:block;
		line-height:30px;
		border-bottom:1px dashed #CCC;
		margin-right:10px;
	}
	.announcement .content li a{
		background:url('<%=path%>/image/jt2.gif') no-repeat 8px center;
		padding-left:15px;
	}
	
/* 	.announcement .content li div a{ */
/* 		font-size:14px; */
/* 		letter-spacing:1px; */
/* 		color:#000000; */
/* 	} */
</style>
<%	

	String layoutName="announcement";//需要修改的地方，每个页面不能重复
	/***获得本模块显示内容ID Start***/
	String flag = Validate.isNullToDefault(request.getParameter(layoutName+"Flag"), "").toString();
	WebContentManager webContentManager = new WebContentManager();
	Map map = webContentManager.findMapByLayoutName(layoutName);
	String navigationId = Validate.isNullToDefault(map.get("NAVIGATIONID"), "").toString();
	if("TRUE".equals(flag)){
		navigationId = Validate.isNullToDefault(request.getParameter(layoutName+"Select"), "").toString();
		webContentManager.updateContentConfig(layoutName, navigationId);
	}
	/***End***/
%>
</head>
<body>
	<div class="announcement">
		<div class="title">
			<div class="title_text">
				<span><%=Validate.isNullToDefault(WebContentManager.findNavigationName(navigationId), "公告") %></span>
			</div>
		</div>
		<div class="content">
			<ul>
			<%
				List list=webContentManager.findListByNAVIGATIONID(navigationId); 
				Map contentMap=null;
				if(list.size()<6){
					for(int i=0;i<list.size();i++){
						contentMap = (Map)list.get(i);
						String time = Validate.isNullToDefault(contentMap.get("UPDATETIME"),"").toString();
						String month = String.valueOf(Integer.parseInt(time.substring(5,7)));
						String day = String.valueOf(Integer.parseInt(time.substring(8)));
						String title = Validate.isNullToDefault(contentMap.get("TITLE"),"").toString();
					%>
					<li>
						<span style="float:right;font-size:14px;font-size: 13px;color: gray;"><%=month%>月<%=day%>日</span>
						<%if(title.length()>14){ %>
						<a  href="javascript:void(0)" onclick="jumpContent('<%=Validate.isNullToDefault(contentMap.get("ID"),"")%>')"><%=title.substring(0,14)%>...</a>
						<%}else{ %>
						<a  href="javascript:void(0)" onclick="jumpContent('<%=Validate.isNullToDefault(contentMap.get("ID"),"")%>')"><%=title%></a>
						<%} %>
					</li>
					<%}
			}else{ 
				for(int i=0;i<6;i++){
						contentMap = (Map)list.get(i);
						String time = Validate.isNullToDefault(contentMap.get("UPDATETIME"),"").toString();
						String month = String.valueOf(Integer.parseInt(time.substring(5,7)));
						String day = String.valueOf(Integer.parseInt(time.substring(8)));
						String title = Validate.isNullToDefault(contentMap.get("TITLE"),"").toString();
					%>
					<li>
						<span style="float:right;font-size:14px;font-size: 13px;color: gray;"><%=month%>月<%=day%>日</span>
						<%if(title.length()>14){ %>
						<a  href="javascript:void(0)" onclick="jumpContent('<%=Validate.isNullToDefault(contentMap.get("ID"),"")%>')"><%=title.substring(0,14)%>...</a>
						<%}else{ %>
						<a  href="javascript:void(0)" onclick="jumpContent('<%=Validate.isNullToDefault(contentMap.get("ID"),"")%>')"><%=title%></a>
						<%} %>
					</li>
					<%}
			}%>
			</ul>
		</div>
	</div>
<% 
	Map userMap = new UserManager().findUserInfoById(StringUtil.objToString(session.getAttribute(ISessionContants.USERIDBYLOGIN)));
	String loginName = Validate.isNullToDefault(userMap.get("LOGINNAME"), "").toString();
	if(Validate.noNull(loginName)&&"admin".equals(loginName)){
%>
<script type="text/javascript">
	$(function(){
		$(".announcement .title .title_text").dblclick(function(){
			var txt=  "选择类别";
			var option = {
				title: "配置",
				btn: parseInt("0011",2),
				onOk: function(){
					console.log("确认");
				}
			}
			window.wxc.xcConfirm(txt, "custom", option,"<%=layoutName%>");
			getNavigation("<%=layoutName%>","<%=path%>","<%=navigationId%>");
		});
	})
	</script>
<% } %>
<script type="text/javascript">
	function jumpContent(ID){
		var url = "<%=path%>/jsp/viewWebContent.jsp?webContentId="+ID;
		window.open(url);
	}
</script>
</body>
</html>