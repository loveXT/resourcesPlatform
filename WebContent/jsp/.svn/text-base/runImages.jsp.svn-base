<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.filesManager.netresvindicate.MajorType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>滚动图片</title>
<% String path = request.getContextPath();%>
<style type="text/css">
.hotPic {
	margin: 0 0 0 0px;
	float: left;
	width: 100%;
	height: auto;
}

.hotPic .IMG_slide {
	position: relative;
	width: 100%;
	height: 147px;
	float: left;
}

.hotPic .IMG_slide .runImages {
	width: 1000px;
	height: 182px;
	overflow: hidden;
	position: relative;
	margin: 10px auto;
}

.hotPic .IMG_slide_ul {
	position: absolute;			/*必须要的元素*/
} 
.IMG_slide_ul {
	float: none;
	overflow: hidden;
	zoom: 1
}

.IMG_slide_ul li {
	width: 192px;
	margin: 0px;
	margin-left: 0px;
	float: left;
	display: inline;
	overflow: hidden;
}

.IMG_slide_ul li a {
	display: block;
}

.IMG_slide_ul li .img {
	width: 180px;
	height: 120px;
	border: 0px solid #FFFFFF;
	padding: 5px;
}

.IMG_slide_ul li .txt {
	height: 30px;
	line-height: 30px;
	text-align: center;
	overflow: hidden;
	color:#4990E6;
}

.hotPic .title {
	height: 25px;
	width: 100%;
	float: left;
	background: url('<%=path%>/image/msfc_3.jpg') left center no-repeat;
	border-bottom: 1px solid #ACDAFE;
}

.hotPic .title span {
	font-size: 14px;
	color: #FFFFFF;
	font-weight: bold;
	line-height: 30px;
	padding-left: 15px;
}
</style>
</head>
<%
String serverPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
// String imagePath = serverPath+"/image/";
String imagePath = serverPath+"/ggs/common/ggs/upload/";
%>
<body>
	<div id="hotPic" class="hotPic">
		<div class="title">
			<span>名师风采</span>
		</div>
		<div class="IMG_slide">
			<div class="runImages">
				<ul class="IMG_slide_ul imgList"
					style="margin: 0px; margin-left: -40px; height: 157px; width: 1150px;">
					<%
						MajorType mt = new MajorType();
						List list = mt.findImageList();
						for(int i=0;i<list.size();i++){
							Map map = (Map)list.get(i);
					%>
					<li><a target="_blank" href="<%=path %>/jsp/imageDetails.jsp?userId=<%=map.get("ID")%>" class="img"> <img width="180" height="120"
							src="<%=imagePath+String.valueOf(""+map.get("FILENAME"))%>" /> </a> 
							<a target="_blank" href="<%=path %>/jsp/imageDetails.jsp?userId=<%=map.get("ID")%>" class="txt"><%=Validate.isNullToDefault(map.get("USERNAME"), "") %></a>
					</li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="<%=path%>/js/jquery.slide.js"></script>
	<script type="text/javascript">
		var pos = 5;
		var $firstDiv = null, timer = null;
		function move() {
			pos = pos - 10;
			$firstDiv = $('.IMG_slide_ul').find('li:first');
			$firstDiv
					.animate({
						'marginLeft' : pos
					},
							{
								duration : 50,
								complete : function() {
									if (Math.abs(parseInt($firstDiv
											.css('margin-left'))) >= $firstDiv
											.outerWidth()) {
										$firstDiv.remove();
										$firstDiv.removeAttr('style')
												.removeClass().css(
														"margin-left", "0px");
										$('.IMG_slide_ul').append($firstDiv);
										pos = 5;
									}
								}
							});
		}
		$(document).ready(function() {
			clearInterval(timer);
			timer = setInterval(move, 500);
			$('#hotPic').find('div').hover(function() {
				clearInterval(timer);
			}, function() {
				clearInterval(timer);
				timer = setInterval(move, 500);
			});

			/* 用按钮控制图片左右滚动 */
			$(".hotPic .IMG_slide").Slide({
				effect : "scroolLoop",
				autoPlay : false,
				speed : "normal",
				timer : 1000,
				steps : 1
			});
		});
	</script>
</body>
</html>