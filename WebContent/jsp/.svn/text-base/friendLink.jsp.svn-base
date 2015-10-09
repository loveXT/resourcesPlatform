<%@page import="java.io.File"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.oa.friendLink.FriendLinkManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>友情链接</title>
<% 
	String path = request.getContextPath();
	String sp = File.separator; 
%>
<style type="text/css">
	.friendLink{
		width:100%;
		height:auto;
		margin:0px auto;
	}
	.friendLink .title{
		height:26px;
		width:100%;
		background: url('<%=path%>/image/yqlj_2.gif') repeat-x;
	}
	.friendLink .title_text {
		height: 26px;
		width: 100%;
		float: left;
		margin-left:10px;
		background: url('<%=path%>/image/yqlj_1.gif') left center no-repeat;
	}
	
	.friendLink .title_text span {
		font-size: 14px;
		color: #026ad3;
		font-weight: bold;
		line-height: 26px;
		padding-left: 25px;
	}
	.friendLink .content{
		width:100%;
		height:auto;
		float:left;
	}
	.friendLink ul.link_ul{
		width:1052px;
		background:#FFFFFF;
		margin-top:0px;
		display:block;
		height:30px;
		margin:0px;
		padding:0px;
	}
	.friendLink .link_ul li{
		display:block;
		float:left;
		height:70px;
		width:150px;
		text-align:center;
		padding:15px 8px 0px 16px;
	}
	.friendLink .link_ul li a img{
	  width: 120px;
	  height: 40px;
	  border:0px;
	}
	.friendLink .link_ul li .text{
	  font-size:12px;
	  color:#4990E6;
	  text-align:center;
	  line-height: 25px;
	  display:none;
	}
</style>
</head>
<body>
	<div class="friendLink">
		<div class="title">
			<div class="title_text">
				<span>友情链接</span>
			</div>
		</div>
		<div class="content">
			<ul class="link_ul">
			<%
			FriendLinkManager friendLinkManager = new FriendLinkManager(); 
			List list = friendLinkManager.findListByFriendLink();
			String src="";
			for(int i=0;i<list.size();i++){
				Map map = (Map)list.get(i);
				src = path +"/"+IUploadImgContants.IMGPATH + Validate.isNullToDefault(map.get("IMAGE"),"");
			%>
				<li>
					<a href="<%=Validate.isNullToDefault(map.get("URL"),"")%>" target="_blank">
					<img src="<%=src%>"></a>
					<a class="text" href="<%=Validate.isNullToDefault(map.get("URL"),"")%>" target="_blank">
					<%=Validate.isNullToDefault(map.get("TITLE"),"")%></a>
				</li>
			<%
			}
			%>
			</ul>
		</div>
	</div>
</body>
</html>