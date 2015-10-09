<%@page import="com.googosoft.filesManager.fileManager.FileManager"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	.VideoName{
		background: #ddd;
		padding: 5px 8px;
		font-weight: bold;
		font-size: 14px;
		font-family: Arial, Helvetica, sans-serif;
	}
</style>
<title>视频文件列表信息</title>
<%
	//path项目路径
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("path", basePath);
	//分页设置pageSize每页显示几条数据,nowPage当前页
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	//根据operateType的类型进行cud进行处理
	Boolean bool = false;
	String operateType = request.getParameter("operateType");
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"_",null).execute();
	}
%>
<script type="text/javascript" src="<%=path %>/js/jquery.js"></script>
<script type="text/javascript" src="<%=basePath+ "/jwplayer/jwplayer.js" %>"></script>
</head>
<body>
<div class="video-same-container">
			<%
				FileManager fileManager = new FileManager();
				PageInfo pageInfo = null;
				pageInfo = fileManager.findlistByFolderId(nowPage, pageSize,"_",request,null);
				List list = pageInfo.getList();
				Map map;
				for(int i=0;i<list.size();i++){
					map = (Map)list.get(i);
			%>
				<div style="width: 200px;height: 220px;border: 1px #aaa dotted;float: left;margin: 5px;">
				<input type="hidden" value="<%=basePath +"filesmanager/fileManager/playVideo.jsp?fileName="+map.get("SWFPATH")+".flv"%>" class="palyURL"/>
				<img class="video-same-img" src="<%=basePath +"ggs/common/ggs/upload/"+map.get("SWFPATH")+".jpg"%>" />
				<div class="VideoName"><%=map.get("REALNAME") %></div>
				</div>
				<%
			}
			%>
</div>		
<script type="text/javascript" >
	jQuery(function(){
		var entryWidth = $('#sameContainer').width()/3 - 16;
		$('.video-same-img').width(entryWidth);
		$('.video-same-img').click(function(){
			var url=$(this).prev('input[class="palyURL"]').val();
			window.location.href=url;
		});
	});
</script>
</body>
</html>