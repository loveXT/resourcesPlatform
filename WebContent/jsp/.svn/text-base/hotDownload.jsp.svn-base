<%@page import="com.googosoft.filesManager.viewManager.StringConstant"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.googosoft.filesManager.netresvindicate.MajorType"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.common.util.VideoUtil"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="com.googosoft.filesManager.fileManager.JpegTool"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.filesManager.fileManager.FileManager"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>热门下载</title>
<% String path = request.getContextPath();%>
<style type="text/css">
.hotDownload {
	width: 100%;
	height: auto;
	margin: 0px auto;
}

.hotDownload .title {
	height: 30px;
	width: 100%;
	background: url('../image/gg_1.gif') repeat-x;
}

.hotDownload .title_text {
	height: 30px;
	width: 100%;
	float: left;
	background: url('../image/msfc_3.jpg') left center no-repeat;
	border-bottom: 1px solid #ACDAFE;
}

.hotDownload .title span {
	font-size: 14px;
	color: #FFFFFF;
	font-weight: bold;
	line-height: 30px;
	padding-left: 15px;
}

.hotDownload .content {
	width: 100%;
	height: auto;
	float: left;
}
	.hotDownload{
		width:100%;
		height:auto;
		margin:0px auto;
	}
	.hotDownload .title{
		height:30px;
		width:100%;
		background: url('<%=path%>/image/gg_1.gif') repeat-x;
	}
	.hotDownload .title_text {
		height: 30px;
		width: 100%;
		float: left;
		background: url('<%=path%>/image/msfc_3.jpg') left center no-repeat;
		border-bottom: 1px solid #ACDAFE;
	}
	
	.hotDownload .title span {
		font-size: 14px;
		color: #FFFFFF;
		font-weight: bold;
		line-height: 30px;
		padding-left: 15px;
	}
	.hotDownload .content{
		width:100%;
		height:auto;
		float:left;
	}
	.hotDownload .content ul{
		width: 270px;
  		height: auto;
  		margin-top:5px;
	}
	.hotDownload .content ul li{
		height:auto;
		width:255px;
		white-space:nowrap;
		text-overflow:ellipsis;
		overflow: hidden;
		float:left;
		margin-left:-35px;
		text-align:right;
		line-height:25px;
		padding:1px 0px;
	}
	.hotDownload .content ul li .text{
		float:left;
		margin-left:5px;
		white-space:nowrap;
		text-overflow:ellipsis;
		overflow: hidden;
		width:150px;
		text-align:left;
	}
/* 	.hotDownload .content ul li .text a{ */
/* 		color:#26688A; */
/* 	} */
</style>
<%
	String sp = File.separator;
	String spath = request.getContextPath();
	String serverPath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()
			+ spath;
	String toPath = request.getRealPath(sp)+ IUploadImgContants.IMGPATH;
	String imagePath = serverPath + "/ggs/common/ggs/upload/";
%>
</head>
<body>
	<div class="hotDownload">
		<div class="title">
			<div class="title_text">
				<span>热门下载</span>
			</div>
		</div>
		<div class="content">
			<%
				FileManager fileManager = new FileManager();
				List<String> ImagesList = Arrays.asList(StringConstant.Images);
				List<String> VediosList = Arrays.asList(StringConstant.Vedios);
				List list = fileManager.findPageInfo();
				Map map;
				int num=list.size();
				if(num>6){
					num=6;
				}
			%>
		<ul>
				<%
					if(num>=1){
						map=(Map) list.get(0);
						MajorType majorType = new MajorType();
						String image=majorType.findImageByExtendName(Validate.isNullToDefault(map.get("EXTENDNAME"), "").toString());
						//图片
						if(ImagesList.contains(map.get("EXTENDNAME"))){
							%>
							<li>
							<div style="border: 1px solid #ccc; float:left; width: 70px; height: 70px">
									<%
										if(Validate.noNull(map.get("FILENAME2"))){
									%> 
									<img src="<%=imagePath+String.valueOf(""+map.get("FILENAME2"))%>" width="69px" height="69px" />
									<%}else{ %>
									<img src="<%=imagePath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"))%>" width="69px" height="69px">
									<%} %>
								</div>
							<div class="text">
								<a target="_blank" href="<%=path %>/jsp/content.jsp?fileId=<%=map.get("FILEID")%>"><%=map.get("REALNAME")%></a>
							</div><span style="color:red;"><%=Validate.isNullToDefault(map.get("DOWNLOADTIME"),"0")%></span>
							</li>
						<%
						//视频
						}else if(VediosList.contains(map.get("EXTENDNAME"))){
						%>
							<li>
							<div style="border: 1px solid #ccc;; float:left; width: 70px; height: 70px">
									<%
										if(Validate.noNull(map.get("FILENAME2"))){
									%> 
									<img src="<%=imagePath+String.valueOf(""+map.get("FILENAME2"))%>" width="69px" height="69px" />
									<%}else{ %>
									<img class="video-same-img" src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>" width="69px" height="69px"/>
									<%} %>
								</div>
							<div class="text">
								<a target="_blank" href="<%=path %>/jsp/content.jsp?fileId=<%=map.get("FILEID")%>"><%=map.get("REALNAME")%></a>
							</div><span style="color:red;"><%=Validate.isNullToDefault(map.get("DOWNLOADTIME"),"0")%></span>
							</li>
						<%}else{%>
			<li>
				<div style="border: 1px solid #ccc; float:left; width: 70px; height: 70px">
						<%
							if(Validate.noNull(map.get("FILENAME2"))){
						%> 
						<img src="<%=imagePath+String.valueOf(""+map.get("FILENAME2"))%>" width="69px" height="69px" />
						<%}else{ %>
						<img src="<%=path %>/image/<%=image %>" width="69px" height="69px" />
						<%} %>
					</div>
				<div class="text">
					<a target="_blank" href="<%=path %>/jsp/content.jsp?fileId=<%=map.get("FILEID")%>"><%=map.get("REALNAME")%></a>
				</div><span style="color:red;"><%=Validate.isNullToDefault(map.get("DOWNLOADTIME"),"0")%></span>
			</li>
				<%}
					for (int i = 1; i < num; i++) {
						map = (Map) list.get(i);
				%>
					<li>
						<div style="float:left;width: 10px;height:25px;margin-left:5px;background:url('<%=path%>/image/jt2.gif') no-repeat left center;"></div>
						<div class="text" style="width:200px;">
							<a target="_blank" href="<%=path %>/jsp/content.jsp?fileId=<%=map.get("FILEID")%>"><%=map.get("REALNAME")%></a>
						</div>
						<span style="color:red;text-align:right;float:right"><%=Validate.isNullToDefault(map.get("DOWNLOADTIME"),"0") %></span>
					</li>
					<%
						}
					}
					%>
			</ul>
		</div>
	</div>
</body>
</html>