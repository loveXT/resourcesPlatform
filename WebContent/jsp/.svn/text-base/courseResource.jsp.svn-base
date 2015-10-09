<%@page import="com.googosoft.filesManager.fileManager.JpegTool"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.filesManager.viewManager.StringConstant"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.filesManager.netresvindicate.MajorType"%>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源推荐</title>
<% String path = request.getContextPath(); %>
<style type="text/css">
	.courseResource{
		width:100%;
		height:auto;
		margin:0px auto;
	}
	.courseResource .title{
		height:30px;
		width:100%;
		background: url('<%=path%>/image/zxzy_1.gif') repeat-x;
	}
	.courseResource .title_text {
		height: 28px;
		width: 100%;
		float: left;
		margin-left:10px;
		background: url('<%=path%>/image/zxzy_2.gif') left center no-repeat;
	}
	
	.courseResource .title_text span {
		font-size: 14px;
		color: #026ad3;
		font-weight: bold;
		line-height: 28px;
		padding-left: 17px;
	}
	.courseResource .content{
		width:100%;
		height:auto;
		float:left;
	}
	.courseResource .content ul{
		width: auto;
  		height: auto;
  		margin-top:5px;
	}
	.courseResource .content ul li{
		height:auto;
		width:auto;
		white-space:nowrap;
		text-overflow:ellipsis;
		overflow: hidden;
		/*float:left;*/
		margin-left:-35px;
		text-align:right;
		line-height:25px;
		padding:1px 0px;
	}
	.courseResource .content ul li .text{
		float:left;
		margin-left:10px;
		white-space:nowrap;
		text-overflow:ellipsis;
		overflow: hidden;
		width:250px;
		text-align:left;
	}
	.courseResource .title .title_text a{
		color:#084a99;
	}
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
<div class="courseResource">
		<div class="title">
			<div class="title_text">
				<span>资源推荐</span>
				<span style="margin-left: 220px;">
				<a target="_blank" style="font-size:12px;" href="<%=path%>/filesmanager/fileManager/myFiles/mainPicture.jsp?Type_Id=isexcellent">更多>></a>
				</span>
			</div>
		</div>
		<div class="content">
			<%
				MajorType majorType = new MajorType();
				List list = majorType.findEXCELLENTListByFiles();
				List<String> ImagesList = Arrays.asList(StringConstant.Images);
				List<String> VediosList = Arrays.asList(StringConstant.Vedios);
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
						String image=majorType.findImageByExtendName(Validate.isNullToDefault(map.get("EXTENDNAME"), "").toString());
						//图片
						if(ImagesList.contains(map.get("EXTENDNAME"))){
							String smallImageUrl = toPath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"));
							String imageUrl = Validate.isNullToDefault(map.get("FILENAME"), "").toString();
							boolean flag=ProcessFileUtil.checkFileExists(imageUrl,request);
							if(flag==false){
							}else{
								JpegTool j = new JpegTool();
								j.SetScale(0.6);
								j.SetSmallHeight(200);
								j.doFinal(toPath+Validate.isNullToDefault(map.get("FILENAME"),""),smallImageUrl);
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
					</div>
					</li>
				<%
							}
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
					</div>
					</li>
				<%}else{%>
			<li>
				<div style="border: 1px solid #ccc;; float:left; width: 70px; height: 70px">
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
				</div>
			</li>
				<%}
					for (int i = 1; i < num; i++) {
						map = (Map) list.get(i);
				%>
					<li>
						<div class="text" style="width:300px;background:url('<%=path%>/image/jt2.gif') no-repeat left center;">
							<a target="_blank" style="margin-left:15px;" href="<%=path %>/jsp/content.jsp?fileId=<%=map.get("FILEID")%>"><%=map.get("REALNAME")%></a>
						</div>
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