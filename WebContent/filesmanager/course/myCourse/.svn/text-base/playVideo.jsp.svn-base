<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	String fileName = request.getParameter("fileName");
	//String playURL = basePath+"ViewVideo/"+fileName;
	String playURL = basePath+"ViewVideo/"+fileName;
	request.setAttribute("path", basePath);
	System.out.println("end end end end end end end end end end end end end end end end");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=basePath%>ggs/common/js/jquery-1.5.1.js"></script>
<script type="text/javascript" src="<%=basePath+ "/jwplayer/jwplayer.js" %>"></script>
</head>
<body>
	<div id="container" style="height: 800px;width: 600px;">Loading the player ...</div>
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
</body>
</html>