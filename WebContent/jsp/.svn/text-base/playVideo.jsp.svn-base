<%@page import="com.googosoft.commons.Validate"%>
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
	String fileName = request.getParameter("fileName");
	String playURL = basePath+"ViewVideo/"+fileName;
	request.setAttribute("path", basePath);
	String serverPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String imagePath = serverPath+"/ggs/common/ggs/upload/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>视频预览</title>
	<link href="<%=path%>/css/index.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="<%=path%>/js/index.js"></script>
	<script type="text/javascript" src="<%=basePath+ "/jwplayer/jwplayer.js" %>"></script>
	<style type="text/css">
		.liebiao{
			background-color:#E5E5E5;
			margin-left:3px;
			height:407px;
			width:270px;
			overflow-y:scroll;
			overflow-x:hidden;
		}
		.video-same-img{
			cursor: pointer;
			border:1px solid #A9A9A9;
		}
		body{
			border-left:0px;
			height:100%;
			overflow-y: scroll;
		}
		.item{
			 width:200px;
		 	 border: 1px solid gray;
	 	 	 margin: 4px;
	 	 	 list-style:none;
	 	 	 display:block;
		}
		#container_wrapper{
			float:left;
			display:inline;
			margin-top:3px;
 			border:solid 1px #A9A9A9;
 			background: #e1e1e1;
 			margin:3px;
		}
		#liebiao{
			height: 100%;
			width: 25%;
			float: left;
		}
		ul{
		  -webkit-padding-start: 8px !important;
		  margin-left: -5px;
		  padding-left: 8px;
		  margin-top:10px;
		  margin-bottom:10px;
		}
		.layout_line{
			width:100%;
			height:auto;
			margin-top:5px;
			float:left;
		}
		.layout{
			height:250px;
			width:auto;
			float:left;
			margin-left:5px;
			border-left:1px solid #ACDAFE;
			border-right:1px solid #ACDAFE;
			border-bottom:1px solid #ACDAFE;
		}
	</style>
</head>
<body>
<jsp:include page="../index/head.jsp"></jsp:include>
	<div class="body_div" style="height:712px;">
		<div id="total" style="margin-top:50px;height:665px;margin-left:120px;padding-left: 3px;">
			<div id="container" style="float:left;display:inline;height: 100%;width: 60%;">Loading the player ...</div>
			<div class="liebiao" style="float:left;display:inline;width: 240px;height:429px;margin-top:3px;border:1px solid #A9A9A9;">
				<ul class="">
			<%
			FilesManager filesManager = new FilesManager();
			List list = filesManager.findVedioList();
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
					<a  href="playVideo.jsp?fileName=<%=map.get("SWFPATH")%>.flv" title="<%=map.get("REALNAME")%>">
						<img style="margin:5px;" class="video-same-img" src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>" width="180px" height="120px" alt="<%=map.get("REALNAME")%>"/>
					</a>
					<div style="font-size:13px;color:gray;width:200px;margin-bottom:5px;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;"><%=map.get("REALNAME")%></div>
				</li>
			<%
			}
			%>
			</ul>
		</div>
	</div>	
	<div class="layout_line">
			<div class="layout" style="width:98.8%;height:50px; border:0px;">
				<jsp:include page="foot.jsp"></jsp:include>
			</div>
		</div>
</div>
	<script type="text/javascript">
// 	(function($) {
// 	$.fn.extend({
// 		addIframe : function(options) {
// 			options = $.extend({
// 				src : "src-is-null",
// 				iframeId : "iframeId"
// 			}, options);
// 			var $this = $(this);
// 			var src = options.src;
// 			var iframeId = options.iframeId;
// 			$iframe = $('<iframe id="" frameborder="0"></iframe>');
// 			$iframe.attr("id", iframeId);
// 			$iframe.attr("src", src);
// 			$this.append($iframe);
// 		}
// 	});
// 	addIframe($("#liebiao"),"total","lieBiao.jsp");
// 	})(jQuery);
// 	function addIframe($parent, iframeId, src) {
// 		$parent.addIframe({
// 			src : src,
// 			iframeId : iframeId
// 		});
// 	};
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