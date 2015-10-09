<%@page import="java.util.List"%>
<%@page import="com.googosoft.oa.webContent.WebContentManager"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.commons.StringUtil"%>
<%@page import="com.googosoft.ggs.userManager.UserManager"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>职教动态</title>
<% String path = request.getContextPath();%>
<style type="text/css">
	.teachDynamic{
		width:100%;
		height:auto;
		margin:0px auto;
	}
	.teachDynamic .title{
		height:43px;
		width:100%;
		border-right:1px solid #E9E8E9;
		background: url('<%=path%>/image/zjdt_2.gif') repeat-x;
	}
	.teachDynamic .title_text{
		line-height:43px;
		height:43px;
		width:69px;
		margin-left:-3px;
		background: url('<%=path%>/image/zjdt_4.gif') left center no-repeat;
		float:left;
		cursor:default; 
	}
	.teachDynamic .title_text span{
		padding-left:5px;
		font-size:12px;
		color:#FFFFFF;
	}
	.teachDynamic .content{
		width:100%;
		height:auto;
		float:left;
	}
	.teachDynamic .content ul{
		margin:10px 0px;
		padding:0 0 10px;
	}
	.teachDynamic .content li{
		display:block;
		/*margin-left:-30px;*/
		line-height:30px;
		border-bottom:1px dashed #CCC;
		margin-left: 5px;
	}
	.teachDynamic .content li a{
		background:url('<%=path%>/image/jt2.gif') no-repeat left center;
		padding-left:15px;
		
	}
/* 	.teachDynamic .content li div a{ */
/* 		font-size:14px; */
/* 		letter-spacing:1px; */
/* 		color:#000000; */
/* 	} */
</style>
<%	
	String layoutName="teachDynamic";//需要修改的地方，每个页面不能重复
	/***获得本模块显示内容ID Start***/
	String flag = Validate.isNullToDefault(request.getParameter(layoutName+"Flag"), "").toString();
	WebContentManager webContentManager = new WebContentManager();
	Map map = webContentManager.findMapByLayoutName(layoutName);
	String navigationId = Validate.isNullToDefault(map.get("NAVIGATIONID"), "").toString();
	if("TRUE".equals(flag)){
		navigationId = Validate.isNullToDefault(request.getParameter(layoutName+"Select"), "").toString();
		webContentManager.updateContentConfig(layoutName, navigationId);
	}
	List list=webContentManager.findListByNAVIGATIONID(navigationId); 
	Map contentMap=null;
	if(list.size()>0){
		contentMap = (Map)list.get(0);
	}
	/***End***/
%>
</head>
<body>
	<div class="teachDynamic">
		<div class="title">
			<div class="title_text">
				<span><%=Validate.isNullToDefault(WebContentManager.findNavigationName(navigationId), "职教动态") %></span>
			</div>
			<div style="float:left;margin-left:20px;width:330px;line-height:45px;">
			<a  style="font-size:16px;color:red;font-weight:bold;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;" href="javascript:void(0)" onclick="jumpContent('<%=Validate.isNullToDefault(contentMap.get("ID"),"")%>')"><%=Validate.isNullToDefault(contentMap.get("TITLE"),"")%></a></div>
		</div>
		<div class="content">
			<ul>
			<%
				if(list.size()<6 && list.size()>0){
					for(int i=1;i<list.size();i++){
						contentMap = (Map)list.get(i);
						String title =Validate.isNullToDefault(contentMap.get("TITLE"),"").toString();
					%>
					<li>
						<%if(title.length()>22){ %>
						<a  href="javascript:void(0)" onclick="jumpContent('<%=Validate.isNullToDefault(contentMap.get("ID"),"")%>')"><%=title.substring(0,22)%>...</a>
						<%}else{ %>
						<a  href="javascript:void(0)" onclick="jumpContent('<%=Validate.isNullToDefault(contentMap.get("ID"),"")%>')"><%=title%></a>
						<%} %>
						<span style="float:right;margin-right:40px;font-size: 13px;color: gray;"><%=Validate.isNullToDefault(contentMap.get("UPDATETIME"),"")%></span>
					</li>
					<%}
			}else{ 
				for(int i=0;i<6;i++){
				contentMap = (Map)list.get(i);
				String title =Validate.isNullToDefault(contentMap.get("TITLE"),"").toString();
					%>
					<li>
						<span style="float:right;margin-right:40px;font-size: 13px;color: gray;"><%=Validate.isNullToDefault(contentMap.get("UPDATETIME"),"")%></span>
						<%if(title.length()>22){ %>
						<a  href="javascript:void(0)" onclick="jumpContent('<%=Validate.isNullToDefault(contentMap.get("ID"),"")%>')"><%=title.substring(0,22)%>...</a>
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
		$(".teachDynamic .title .title_text").dblclick(function(){
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