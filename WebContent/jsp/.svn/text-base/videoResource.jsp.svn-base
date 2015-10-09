<%@page import="com.googosoft.filesManager.fileManager.FilessManager"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>视频资源</title>
<% String path = request.getContextPath();%>
<style type="text/css">
	.videoResource{
		width:100%;
		height:auto;
		margin:0px auto;
	}
	.videoResource .title{
		height:30px;
		width:100%;
		background: url('<%=path%>/image/zxzy_1.gif') repeat-x;
	}
	.videoResource .title_text {
		height: 28px;
		width: 100%;
		float: left;
		margin-left:10px;
		background: url('<%=path%>/image/zxzy_2.gif') left center no-repeat;
	}
	
	.videoResource .title_text span {
		font-size: 14px;
		color: #026ad3;
		font-weight: bold;
		line-height: 28px;
		padding-left: 16px;
	}
	.videoResource .content{
		width:100%;
		height:auto;
		float:left;
	}
	.videoResource .content ul{
		width: 100%;
  		height: auto;
  		margin-top:5px;
	}
	.videoResource .content ul li{
		height:auto;
		width:360px;
		white-space:nowrap;
		text-overflow:ellipsis;
		overflow: hidden;
		float:left;
		margin-left:-35px;
		text-align:left;
		line-height:25px;
		padding:1px 0px;
	}
	.videoResource .content ul li .text{
		float:left;
		margin-left:10px;
		white-space:nowrap;
		text-overflow:ellipsis;
		overflow: hidden;
		width:250px;
		text-align:left;
	}
/* 	.videoResource .content ul li .text a{ */
/* 		color:#26688A; */
/* 	} */
	.videoResource .title .title_text a{
		color:#084a99;
	}
</style>
<%
	String sp = File.separator;
	String spath = request.getContextPath();
	String serverPath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ spath;
	String toPath = request.getRealPath(sp)
			+ IUploadImgContants.IMGPATH;
	String imagePath = serverPath + "/ggs/common/ggs/upload/";
	FilessManager filessManager = new FilessManager();
	String typeId = filessManager.findStringByName("视频");
	
%>
</head>

<body>
<div class="videoResource">
		<div class="title">
			<div class="title_text">
				<span>视频资源</span>
				<span style="margin-left: 220px;">
				<a target="_blank" style="font-size:12px;" href="<%=path%>/filesmanager/fileManager/myFiles/mainPicture.jsp?Type_Id=01&biaoti=<%=typeId %>">更多>></a>
				</span>
				
			</div>
		</div>
		<div class="content">
			<%
				List list = filessManager.findPageInfo();
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
				%>
			<li>
				<div style="border:1px solid #ccc; float:left; width: 70px; height: 70px">
						<%
							if(Validate.noNull(map.get("FILENAME2"))){
						%> 
						<img src="<%=imagePath+String.valueOf(""+map.get("FILENAME2"))%>" width="69px" height="69px" />
						<%}else{ %>
						<img src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>" width="69px" height="69px"/>
						<%} %>
					</div>
				<div class="text">
					<a target="_blank" href="<%=path %>/jsp/content.jsp?fileId=<%=map.get("FILEID")%>"><%=map.get("REALNAME")%></a>
				</div>
<%-- 				<div style="float:left;margin-left: 10px;line-height: 20px;width:250px;height:50px;font-size:8px;color:gray;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;"><%=Validate.isNullToDefault(map.get("REMARK"),"")%></div> --%>
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
					%>
			</ul>
		</div>
	</div>
</body>
</html>