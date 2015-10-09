<%@page import="com.googosoft.filesManager.openClass.OpenClassManager"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//设置编码格式"utf-8"
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	String fileName = request.getParameter("fileName");
	String fullName = request.getParameter("fullName");
	String playURL = basePath+"/ggs/common/ggs/upload/"+fileName;
	request.setAttribute("path", basePath);
	String imagePath = basePath+"/ggs/common/ggs/upload/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>视频预览</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/journal/journal.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/openClass/playVideo.css">
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
<script type="text/javascript" src="<%=basePath+ "/jwplayer/jwplayer.js" %>"></script>
<style type="text/css">
</style>
</head>
<body>
<jsp:include page="../common/top/head.jsp"></jsp:include>
	<div class="jounalContent">
		<div  class="positionImg">
		<div class="type">
			<img src="<%=path%>/image/openClass/wz.gif">
			<span>&nbsp;首页&nbsp;>&nbsp;公开课&nbsp;>&nbsp;<%=fullName %></span>
		</div>
		</div>
		<div id="total" style="margin-left:35px;">
			<div id="container" style="float:left;display:inline;height: 100%;width: 69%;margin-top:20px;">Loading the player ...</div>
			<div class="liebiao" style="float:left;display:inline;width: 240px;height:500px;margin-top:20px;border:1px solid #A9A9A9;">
				<ul class="">
			<%
			OpenClassManager ocm = new OpenClassManager();
			List list = ocm.findVedioList();
			int listSize = list.size();
			if(listSize>20){
				listSize=20;
			}else{
				listSize=list.size();
			}
			for(int i=0;i<listSize;i++){
				Map map = (Map)list.get(i);
			%>
				<li class="item"  title="<%=map.get("REALNAME")%>">
					<a  href="playVideo.jsp?fileName=<%=map.get("SWFPATH")%>.flv&fullName=<%=map.get("FULLNAME")%>" title="<%=map.get("REALNAME")%>">
						<img style="margin:5px;" class="video-same-img" src="<%=imagePath + map.get("FILENAME2") %>" width="180px" height="120px" alt="<%=map.get("REALNAME")%>"/>
					</a>
					<div style="font-size:13px;color:gray;width:200px;margin-bottom:5px;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;"><%=map.get("REALNAME")%></div>
				</li>
			<%
			}
			%>
			</ul>
		</div>
	</div>	
</div>
	<jsp:include page="../common/bottom/footer.jsp"></jsp:include>
	<script type="text/javascript">
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
</script>
<!-- </center> -->
</body>
</html>