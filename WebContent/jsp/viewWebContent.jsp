<%@page import="com.googosoft.filesManager.netresvindicate.MajorType"%>
<%@page import="com.googosoft.ggs.userManager.UserManager"%>
<%@page import="com.googosoft.oa.webContent.WebContentManager"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String toPath = request.getContextPath()+"/"+ IUploadImgContants.IMGPATH;
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=path%>/css/index.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
<title>网页内容信息</title>
<style type="text/css">
body{
	overflow-y: scroll;
}
.layout_line{
	width:100%;
	height:auto;
	margin-top:5px;
	float:left;
}
.layout{
	height:auto;
	width:auto;
	float:left;
	margin-left:6px;
	border-left:1px solid #ACDAFE;
	border-right:1px solid #ACDAFE;
	border-bottom:1px solid #ACDAFE;
}
</style>
</head>
<%
	String webContentId = request.getParameter("webContentId");
	WebContentManager wcm = new WebContentManager();
	Map map = wcm.findMapByID(webContentId);
	String userId = Validate.isNullToDefault(map.get("USERID"), "").toString();
	Map userMap = new UserManager().findUserInfoById(userId);
	String username = Validate.isNullToDefault(userMap.get("USERNAME"), "").toString();
	MajorType mt = new MajorType();
	Map zpMap = mt.findMapByZP(userId);
%>
<body>
	<jsp:include page="../index/head.jsp"></jsp:include>
	<div class="body_div" style="height:712px;">
		<div class="layout_line">
			<div class="layout" style="width:23%;border:0px;">
				<div style="width:100%;height:auto;float:left;overflow-x:hidden;border:1px solid #ACDAFE;border-top:0px solid #ACDAFE;">
					<div style="width:262px;height:27px;background:url('<%=path%>/image/dh-11.gif') no-repeat;">
						<img style="width:14px;height:14px;margin-left:10px;margin-top:6px;float:left;" src="<%=path%>/image/jt.gif">
							<span style="font-size: 14px;color:white;font-weight: bold;float:left;margin-top:5px;margin-left:10px;">教师</span>
					</div>
					<div style="width:100px;height:100px;overflow-x:hidden;margin-top:20px;margin-left:auto;margin-right:auto;">
						<img  style="width:150px;height:100px;margin-left:-25px;" src="<%=toPath%>/<%=Validate.isNullToDefault(zpMap.get("ZP"), "") %>">
					</div>
					<div style="font-size: 10px;font-weight: bold;width:150px;text-align:center;line-height:40px;margin:0 auto;"><%=username %></div>
				</div>
				<div style="width:100%;height:auto;float:left;overflow-x:hidden;margin-top:5px;border:1px solid #ACDAFE;border-top:0px solid #ACDAFE;">
					<div style="width:262px;height:27px;background:url('<%=path%>/image/dh-11.gif') no-repeat;">
						<img style="width:14px;height:14px;margin-left:10px;margin-top:6px;float:left;" src="<%=path%>/image/jt.gif">
							<span style="font-size: 14px;color:white;font-weight: bold;float:left;margin-top:5px;margin-left:10px;">教师信息</span>
					</div>
					<div style="margin-top:40px;margin-left:0px;height:180px;">
						<ul style="font-size: 13px;font-weight: bold;">
							<li style="display:block;line-height: 30px;">所属部门:<span style="font-weight: none;">&nbsp;<%=Validate.isNullToDefault(zpMap.get("UMDEPARTMENTNAME"), "") %></span></li>
							<li style="display:block;line-height: 30px;">联系电话:<span style="font-weight: none;">&nbsp;<%=Validate.isNullToDefault(zpMap.get("LXDH"), "") %></span></li>
							<li style="display:block;line-height: 30px;">岗位类别:<span style="font-weight: none;">&nbsp;<%if("0".equals(zpMap.get("JZGLBM"))){%>教学<%}if("1".equals(zpMap.get("JZGLBM"))){%>工勤<%}if("2".equals(zpMap.get("JZGLBM"))){%>管理<%}%></span></li>
							<li style="display:block;line-height: 30px;">现任职务:<span style="font-weight: none;">&nbsp;<%if("0".equals(zpMap.get("XRZW"))){%>校级领导<%}if("1".equals(zpMap.get("XRZW"))){%>主任<%}if("2".equals(zpMap.get("XRZW"))){%>副主任<%}if("3".equals(zpMap.get("XRZW"))){%>职员<%}if("4".equals(zpMap.get("XRZW"))){%>教师<%}%></span></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="layout" style="width:75%">
				<div style="height:27px;background:url('<%=path%>/image/dh-22.gif') repeat-x;height:30px;">
				<img style="width:14px;height:14px;margin-left:10px;margin-top:6px;float:left;" src="<%=path%>/image/jt.gif">
					<span style="font-size: 14px;font-weight: bold;color:white;float:left;margin-top:5px;margin-left:10px;">内容</span>
				</div>
				<div style="padding:10px;width:785px;height:auto;min-height:390px;">
					<div style="margin:0 auto;width:90%;height:30px;text-align:center;"><%=Validate.isNullToDefault(map.get("TITLE"),"")%></div>
					<div><%=Validate.isNullToDefault(map.get("CONTENT"),"")%></div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>