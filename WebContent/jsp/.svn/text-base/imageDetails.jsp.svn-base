<%@page import="java.util.List"%>
<%@page import="com.googosoft.filesManager.netresvindicate.MajorType"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
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
	String downURL = request.getContextPath()+"/DownLoad/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=path%>/css/index.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
<title>资源信息</title>
<style type="text/css">
body{
	overflow-y: scroll;
}
.layout_line{
	width:100%;
	height:auto;
	margin-top:0px;
	float:left;
}
.layout{
	height:220px;
	width:auto;
	float:left;
	margin-left:5px;
	margin-top:5px;
	border-left:1px solid #ACDAFE;
	border-right:1px solid #ACDAFE;
	border-bottom:1px solid #ACDAFE;
}
.bg{
	background:url("<%=path%>/image/dh-11.gif") no-repeat;
}
.bgr{
	background:url("<%=path%>/image/dh-22.gif") repeat-x;
}
</style>
</head>
<%
	String userId = request.getParameter("userId");
	MajorType mt = new MajorType();
	Map map = mt.findMapByUserId(userId);
	String mzm = Validate.isNullToDefault(map.get("MZM"), "").toString();
	Map xbMap = mt.findXBMapByNormCode(mzm);
	String gwlb = "";
	if("0".equals(map.get("JZGLBM"))){
		gwlb="教学";
	}else if("1".equals(map.get("JZGLBM"))){
		gwlb="工勤";
	}else if("2".equals(map.get("JZGLBM"))){
		gwlb="管理";
	}
	String xrzw = "";
	if("0".equals(map.get("XRZW"))){
		xrzw="校级领导";
	}else if("1".equals(map.get("XRZW"))){
		xrzw="主任";
	}else if("2".equals(map.get("XRZW"))){
		xrzw="副主任";
	}else if("3".equals(map.get("XRZW"))){
		xrzw="职员";
	}else if("4".equals(map.get("XRZW"))){
		xrzw="教师";
	}
%>
<body>
	<jsp:include page="../index/head.jsp"></jsp:include>
	<div class="body_div" style="height:702px;">
		<div class="layout_line">
			<div class="layout" style="width:23%;text-align: center;">
				<div class="bg">
					<div style="padding-top:7px;height:30px;">
						<span style="font-size: 14px;margin-top: -2px;font-weight: bold;float:left;color: white;">&nbsp;<img style="margin-bottom:-2px;" src="<%=path%>/image/jt.gif">&nbsp;个人照片</span>
					</div>
				</div>
				<div style="margin-top:20px;">
					<div style="width:120px;height:120px;overflow-x:hidden;margin:0px auto">
						<img  style="width:180px;height:120px;margin-left:-30px;" src="<%=toPath%>/<%=Validate.isNullToDefault(map.get("ZP"), "") %>">
					</div>
					<div style="font-size: 10px;font-weight: bold;width:180px;text-align:center;line-height:40px;margin:0 auto;"><%=Validate.isNullToDefault(map.get("USERNAME"), "") %></div>
				</div>
			</div>
			<div class="layout" style="width:75%">
				<div  class="bgr" style="font-size: 14px;font-weight: bold;height:30px;padding-top:7px;">
					<span style="font-size: 14px;font-weight: bold;color:white;">&nbsp;<img style="margin-bottom:-2px;" src="<%=path%>/image/jt.gif">&nbsp;基本信息</span>
				</div>
				<div>
					<table style="width:100%;">
						<tr>
							<td width="38%" width="38%">
								<ul style="font-size: 13px;font-weight: bold;">
									<li style="display:block;line-height: 30px;">姓&nbsp;&nbsp;名:<span style=""><%=Validate.isNullToDefault(map.get("USERNAME"), "") %></span></li>
									<li style="display:block;line-height: 30px;">性&nbsp;&nbsp;别:<span><%=("0".equals(map.get("XBM")))?"男":"女"%></span></li>
									<li style="display:block;line-height: 30px;">民&nbsp;&nbsp;族:<span><%=Validate.isNullToDefault(xbMap.get("MC"), "") %></span></li>
									<li style="display:block;line-height: 30px;">出生年月:<span><%=Validate.isNullToDefault(map.get("CSRQ"), "") %></span></li>
								</ul>
							</td>
							<td width="38%" width="38%">
								<ul style="font-size: 13px;font-weight: bold;">
									<li style="display:block;line-height: 30px;">联系电话:<span><%=Validate.isNullToDefault(map.get("LXDH"), "") %></span></li>
									<li style="display:block;line-height: 30px;">岗位类别:<span><%=gwlb %></span></li>
									<li style="display:block;line-height: 30px;">所属部门:<span><%=Validate.isNullToDefault(map.get("UMDEPARTMENTNAME"), "") %></span></li>
									<li style="display:block;line-height: 30px;">现任职务:<span><%=xrzw %></span></li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="layout" style="width:23%;text-align: center;">
			<div>
				<div style="padding-top:7px;height:30px;">
				</div>
			</div>
			<div style="margin-top:20px;">
			</div>
		</div>
		<div class="bgr layout" style="width:75%">
			<div style="padding-top:8px;height:30px;">
				<span style="font-size: 14px;margin-top: -2px;font-weight: bold;float:left;color:white;">&nbsp;<img style="margin-bottom:-2px;" src="<%=path%>/image/jt.gif">&nbsp;上传的资源</span>
			</div>
			<div>
				<table style="margin-top:13px;">
			<%
				List list = mt.findListByFiles(userId);
				Map zmap;
				if(list.size()<1){%>
					<tr>
					</tr>
			<% 	}else if(list.size()<=6){
			%>
				<tr>
					<%
						for(int i=0;i<list.size();i++){
						zmap = (Map)list.get(i);
						String time = Validate.isNullToDefault(zmap.get("CREATETIME"), "").toString();
						time = time.substring(0, 9);
					%>
						<td style="width:120px;text-align: center;padding-top: 10px;padding-left: 8px;" title="<%=Validate.isNullToDefault(zmap.get("REALNAME"), "") %>">
							<%if("".equals(Validate.isNullToDefault(zmap.get("FILENAME2"), ""))){%>
							<a href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(zmap.get("FILEID"), "") %>">
								<img style="width:70px;height:80px;margin-left:15px;" src="<%=path%>/image/doc.jpg">
							</a><br/>
							<%}else{%>
							<a href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(zmap.get("FILEID"),"")%>">
								<img style="width:70px;height:80px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(zmap.get("FILENAME2"), "") %>">
							</a><br/>
							<%} %>
							<div style="font-size: 13px;font-weight: bold;width:120px;color: #325FFA;white-space:nowrap;text-overflow:ellipsis;overflow: hidden; ">
								<a href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(zmap.get("FILEID"),"")%>"><%=Validate.isNullToDefault(zmap.get("REALNAME"),"")%><%=Validate.isNullToDefault(zmap.get("EXTENDNAME"),"")%></a>
							</div>
							<div style="font-size: 12px;color:gray;">&nbsp;<%=time %></div>
						</td>
					<%	}%>
					</tr>
						<%}else if(list.size()>6){%>
					<tr>
						<%
						for(int i=0;i<6;i++){
						zmap = (Map)list.get(i);	
						String time = Validate.isNullToDefault(zmap.get("CREATETIME"), "").toString();
						time = time.substring(0, 10);
						%>	
						<td style="width:120px;text-align: center;padding-top: 10px;padding-left: 8px;" title="<%=Validate.isNullToDefault(zmap.get("REALNAME"), "") %>">
							<%if("".equals(Validate.isNullToDefault(zmap.get("FILENAME2"), ""))){%>
							<a href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(zmap.get("FILEID"),"")%>">
								<img style="width:70px;height:80px;margin-left:15px;" src="<%=path%>/image/doc.jpg">
							</a><br/>
							<%}else{%>
							<a href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(zmap.get("FILEID"),"")%>">
								<img style="width:70px;height:80px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(zmap.get("FILENAME2"), "") %>">
							</a><br/>
							<%} %>
							<div style="font-size: 13px;font-weight: bold;width:120px;color: #325FFA;white-space:nowrap;text-overflow:ellipsis;overflow: hidden; ">
								<a href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(zmap.get("FILEID"),"")%>"><%=Validate.isNullToDefault(zmap.get("REALNAME"),"")%><%=Validate.isNullToDefault(zmap.get("EXTENDNAME"),"")%></a>
							</div>
							<div style="font-size: 12px;color:gray;">&nbsp;<%=time%></div>
						</td>	
					<%	}%>
					</tr>
					<%
					}
					%>
			</table>
			</div>
		</div>
	</div>
	<jsp:include page="foot.jsp"></jsp:include>
	<script type="text/javascript">
	</script>
</body>
</html>