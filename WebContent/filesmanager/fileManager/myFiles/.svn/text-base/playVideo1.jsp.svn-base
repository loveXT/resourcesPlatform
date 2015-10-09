<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//设置编码格式"utf-8"
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	String serverPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String imagePath = serverPath+"/ggs/common/ggs/upload/";
	String fileName = request.getParameter("fileName");
	 //接受chapter_id章节编号,course_id课程编号,major_id专业编号
    String Major_Id = request.getParameter("MAJOR_ID");
	String COURSE_ID = request.getParameter("COURSE_ID");
	String CHAPTER_ID = request.getParameter("CHAPTER_ID");
	String POINT_ID = request.getParameter("POINT_ID");
	String playURL = basePath+"ViewVideo/"+fileName;
	request.setAttribute("path", basePath);
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>视频预览</title>
	<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath+ "/jwplayer/jwplayer.js" %>"></script>
	<style type="text/css">
		#container_wrapper{
			float:left;
			display:inline;
			border:1px solid #A9A9A9;
			margin-top:10px;
		}
		.liebiao{
			background-color:#E5E5E5;
			margin-left:10px;
			margin-top:10px;
		}
		.video-same-img{
			cursor: pointer;
			border:1px solid #A9A9A9;
		}
		.more{
			display: inline-block;
			height: 20px;
			width: auto;
			padding: 0px 2px 0px 16px;
			position: absolute;
			bottom: 5px;
			right: 5px;
			line-height: 20px;
			cursor: pointer;
/* 			font-color:#15428B; */
			margin-bottom:200px;
			margin-right:30px;
		}
		.back{
			display: inline-block;
			height: 20px;
			width: auto;
			padding: 0px 2px 0px 16px;
			position: absolute;
			bottom: 5px;
			right: 5px;
			line-height: 20px;
			cursor: pointer;
/* 			font-color:#15428B; */
			margin-bottom:200px;
			margin-right:180px;
		}
	</style>
</head>
<body>
	<form class="sm_edit_from" id="pageForm" style="border:0px;height:0px;" method="post" action="" >
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
	</form>
	<div id="container" style="float:left;display:inline;height: 800px;width: 68%;">Loading the player ...</div>
	<div class="liebiao" style="float:left;display:inline;height: 384px;width: 30%;border:1px solid #A9A9A9;">
		<div style="margin-top:10px;margin-left:10px;">播放列表</div>
		<%
				FilesManager filesManager = new FilesManager();
				PageInfo pageInfo = null;
				pageInfo = filesManager.findPageInfoByPlayVedioFILES(nowPage, 2, "_", request,Major_Id,COURSE_ID,CHAPTER_ID,"","");
				List list = pageInfo.getList();
				Map map;
				for(int i=0;i<list.size();i++){
					map = (Map)list.get(i);
		%>
			<div style="float:left;margin-left:15px;margin-top:10px;"  class="">
				<input type="hidden" value="playVideo1.jsp?fileName=<%=map.get("SWFPATH")%>.flv" class="palyURL"/>
				<img class="video-same-img" src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>" width="180px" height="120px"/>
				<div style="text-align:center;margin-top:10px;"><%=map.get("REALNAME")%></div>
			</div>
		<%
				}
		%>
<!-- 		<div class="back" name="返回"> -->
<!-- 			<font style="color:#15428B;">返回>></font> -->
<!-- 		</div> -->
		<div class="more" name="更多">
			<font style="color:#15428B;">更多>></font>
		</div>
	</div>
	<script type="text/javascript">
	jQuery(function(){
		var entryWidth = $('#sameContainer').width()/3 - 16;
		$('.video-same-img').width(entryWidth);
		$('.video-same-img').click(function(){
			var url=$(this).prev('input[class="palyURL"]').val();
			window.location.href=url;
		});
	});
	$(function(){
		jwplayer('container').setup({
			flashplayer: '<%= basePath+"/jwplayer/player.swf" %>',
			file: '<%=playURL%>',
			skin: '<%=basePath+"/jwplayer/glow.zip" %>',
			autostart: true,
			height: $('#container').width() * 0.75,
			width: $('#container').width()
		});
	});
	$(function(){
		$(".more").live("click",function(){
			var src = "allFile.jsp";
			window.location.href=src;
		});
		$(".back").live("click",function(){
			history.go(-1);
// 			location.href = document.referrer;
		});
	});
</script>
</body>
</html>