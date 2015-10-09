<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("path", basePath);
	String swfFile = request.getParameter("swfFile");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=path %>/js/jquery.js"></script>
<script type="text/javascript" src="<%=basePath+ "/jwplayer/jwplayer.js" %>"></script>
</head>
<body>
<center>
			<ul id="sameContainer" class="video-same-container">
				<li class="video-same-entry">
						<input type="hidden" value="playVideo.jsp?fileName=<%=swfFile%>.flv" class="palyURL"/>
						<img class="video-same-img" src="<%=basePath +"ggs/common/ggs/upload/"+swfFile+".jpg"%>" />
				</li>
			</ul>
</center>
<script type="text/javascript" >
	jQuery(function(){
		var entryWidth = $('#sameContainer').width()/3 - 16;
		$('.video-same-img').width(entryWidth);
		$('.video-same-img').click(function(){
			var url=$(this).prev('input[class="palyURL"]').val();
			window.location.href=url;
		});
	});
	function setPageSize(){
	}
</script>
</body>
</html>