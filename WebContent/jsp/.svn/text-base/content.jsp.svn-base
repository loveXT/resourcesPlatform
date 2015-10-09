<%@page import="java.text.DecimalFormat"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.commons.StringUtil"%>
<%@page import="com.googosoft.filesManager.viewManager.StringConstant"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.filesManager.netresvindicate.MajorType"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%-- <%@include file="/ggs/include/css.inc" %> --%>
<head>
<%
// 	String pathSkin = request.getContextPath()+"/ggs";
// 	String pathSkinTool = request.getContextPath()+"/ggs/skin/blue"; 
	String path = request.getContextPath();
	String toPath = request.getContextPath()+"/"+ IUploadImgContants.IMGPATH;
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/journal/journal.css">
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
<title>资源信息</title>
<style type="text/css">
body{
	overflow-y: scroll;
}
.layout_line{
	width:100%;
	height:auto;
	margin-top:0px;
	float:left;
}
.layout{
	height:180px;
	width:auto;
	float:left;
	margin-top:5px;
	border-left:1px solid #CFCFCF;
	border-right:1px solid #CFCFCF;
	border-bottom:1px solid #CFCFCF;                                
}
.bg{
	background:url("<%=path%>/image/4-1.gif") repeat-x;
}
.bgr{
	background:url("<%=path%>/image/4-1.gif") repeat-x;
}
.category_top {
		color: #026ad3;
		top: auto;
		float: left;
		width: 100%;
		height: 31px;
		clear: both;
		background:url('<%=path%>/image/zylb_1.gif') repeat-x;
	}
	.category{
		height:26px;
		width:104px;
		float:left;
		border-right:1px solid #CFCFCF;
		cursor: pointer;
	}
	.category_show{
		height:26px;
		width:104px;
		float:left;
		border-top:1px solid #CFCFCF;
		border-right:1px solid #CFCFCF;
		background:url(<%=path%>/image/jt5-red.gif) no-repeat center bottom;
		cursor: pointer;
	}
	.category .category_text {
		font-size: 14px;
		font-weight:bold;
		color:black;
		line-height: 30px;
		padding-left: 22px;
	}
	.category_show .category_text {
		font-size: 14px;
 		color: black;
 		font-weight: bold;
		line-height: 31px;
		padding-left: 22px;
	}
	#comment{
		width: 1000px;
  		height: 240px;
	}
	 #imgFrame{ 
		 position:absolute; 
		 top:15%; 
		 left:25%; 
		 width:700px;
		 height:550px;
		 display:none;
	 }
	 #imgbox{
		 width:700px;
		 height:500px;
	 }
	 #imgbox img{
	 	width:100%;
	 	height:100%;
	 	border:1px solid #ccc;
	 }
</style>
</head>
<%
	String url = request.getScheme()+"://"; 
	url+=request.getHeader("host"); 
	url+=request.getRequestURI(); 
	if(request.getQueryString()!=null) //去掉这两行注销就好使了
	url+="?"+request.getQueryString();	

	String fileId = request.getParameter("fileId");
	String userId = StringUtil.objToString(session.getAttribute(ISessionContants.USERIDBYLOGIN));
	SelectFilesManager sm = new SelectFilesManager();
	Map map = sm.findMapByFilesID(fileId);
	String filesize = Validate.isNullToDefault(map.get("FILESIZE"), "0").toString();
	double size = Double.parseDouble(filesize);
	DecimalFormat    df   = new DecimalFormat("0.00");  
	String danwei = "KB";
	if(size/1024>=1&&size/1024<1000){
		size = size/1024;
		danwei = "MB";
	}else if(size/1024/1024>=1&&size/1024/1024<1000){
		size = size/1024/1024;
		danwei = "GB";
	}else if(size/1024/1024/1024>=1&&size/1024/1024/1024<1000){
		size = size/1024/1024/1024;
		danwei = "TB";
	}
	String download = Validate.isNullToDefault(map.get("DOWNLOAD"), "").toString();
	String spath = request.getContextPath();
	String serverPath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()
			+ spath;
	String imagePath = serverPath + "/ggs/common/ggs/upload/";
%>
<body>
<!--top  -->
	<jsp:include page="../common/top/head.jsp"></jsp:include>
	<div class="jounalContent" >
	<div class="body_div">
				<%
					MajorType mt = new MajorType();
					Map zpMap = mt.findMapByZP(map.get("UPLOADERID")+"");
					List<String> ImagesList = Arrays.asList(StringConstant.Images);
					List<String> VediosList = Arrays.asList(StringConstant.Vedios);
					MajorType majorType = new MajorType();
					String image=majorType.findImageByExtendName(Validate.isNullToDefault(map.get("EXTENDNAME"), "").toString());
				%>
			<div class="layout" style="width:100%">
				<div  class="bgr" style="font-size: 14px;font-weight: bold;height:30px;padding-top:7px;">
					<span style="font-size: 14px;font-weight: bold;margin-top:-3px;color: black;">&nbsp;<img style="margin-bottom:-2px;" src="<%=path%>/image/iecool_arrow_085.gif">&nbsp;资源详细信息</span>
				</div>
				<div>
					<table style="width:100%;margin-top:-10px;border:0px;">
						<tr>
							<td style="border:0px;" valign="middle" align="center" width="24%" rowspan="4">
								<%
								//图片
								if(ImagesList.contains(map.get("EXTENDNAME"))){
									if(Validate.isNull(map.get("FILENAME2"))){%>
										<img src="<%=imagePath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"))%>" original="<%=imagePath+String.valueOf(""+map.get("FILENAME"))%>" onclick="showOriginal(this)" style="width:100px;height:100px;margin-left:15px;">
									<%}else{%>
										<img style="width:100px;height:100px;margin-left:15px;" original="<%=imagePath+String.valueOf(""+map.get("FILENAME"))%>" onclick="showOriginal(this)" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>"><br/>
									<%}
								//视频
								}else if(VediosList.contains(map.get("EXTENDNAME"))){
									if(Validate.isNull(map.get("FILENAME2"))){%>
										<img class="video-same-img" src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>" style="width:100px;height:100px;margin-left:15px;"/>
									<%}else{%>
										<img style="width:100px;height:100px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>"><br/>
									<%}
								}else{ 
									if(Validate.isNull(map.get("FILENAME2"))){%>
										<img style="width:100px;height:100px;margin-left:15px;" src="<%=path%>/image/<%=image%>"><br/>
									<%}else{%>
										<img style="width:100px;height:100px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>"><br/>
									<%
									}
								}
									%>
								
								<%
									if(Validate.isNull(userId)){
										if(ProcessFileUtil.isVideoFile(map.get("EXTENDNAME"))){
										%>
											<a href="<%=path%>/jsp/login.jsp?url=<%=url%>"><span style="font-size: 13px;font-weight: bold;">预览</span></a>
										<%
											}else if(ProcessFileUtil.isPriviewNoVideo(map.get("EXTENDNAME"))){
										%>	
											<a href="<%=path%>/jsp/login.jsp?url=<%=url%>"><span style="font-size: 13px;font-weight: bold;">预览</span></a>
										<%}else if(".swf".equals(map.get("EXTENDNAME"))){%>	
											<a href="<%=path%>/jsp/login.jsp?url=<%=url%>"><span style="font-size: 13px;font-weight: bold;">预览</span></a>
										<%}
										if("00".equals(download)){
											%>
											&nbsp;<a href="<%=path%>/jsp/login.jsp?url=<%=url%>"><span style="font-size: 13px;font-weight: bold;">下载</span></a>
											<%
										}	
									}else{ 
										if(ProcessFileUtil.isVideoFile(map.get("EXTENDNAME"))){
										%>
											<a href="<%=request.getContextPath()%>\\subjectAchievement\\playVideo.jsp?fileName=<%=map.get("SWFPATH")%>.flv&fullName=<%=map.get("FULLNAME")%>" target="_blank" id="browse"><span style="font-size: 13px;font-weight: bold;">预览</span></a>
										<%
											}else if(ProcessFileUtil.isPriviewNoVideo(map.get("EXTENDNAME"))){
										%>	
											<a href="<%=path+"\\jsp\\view.jsp?swfFile="%><%=map.get("SWFPATH")%>&fullName=<%=map.get("FULLNAME")%>&fileId=<%=fileId %>" target="_blank" id="browse"><span style="font-size: 13px;font-weight: bold;">预览</span></a>
										<%}else if(".swf".equals(map.get("EXTENDNAME"))){%>	
											<a href="<%=path+"\\jsp\\view.jsp?swfFile="%><%=map.get("SWFPATH")%>&fullName=<%=map.get("FULLNAME")%>&fileId=<%=fileId %>" target="_blank" id="browse"><span style="font-size: 13px;font-weight: bold;">预览</span></a>
										<%}
										if("00".equals(download)){
											%>
											&nbsp;<a href="<%=path+"/DownLoadServlet?FILEID="+map.get("FILEID")%>" id="down"><span style="font-size: 13px;font-weight: bold;">下载</span></a>
											<%
										}
									}
									%>
							</td>
							<td style="border:0px;" width="38%">
								<ul style="font-size: 13px;font-weight: bold;">
									<li style="display:block;line-height: 30px;width:260px;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;">文件名称:&nbsp;<span><%=Validate.isNullToDefault(map.get("REALNAME"), "") %></span>&nbsp;</li>
									<li style="display:block;line-height: 30px;">资源类型:<span>&nbsp;<%=Validate.isNullToDefault(map.get("NAME"), "") %></span></li>
									<li style="display:block;line-height: 30px;">文件格式:<span>&nbsp;<%=Validate.isNullToDefault(map.get("EXTENDNAME"), "") %></span></li>
									<li style="display:block;line-height: 30px;">上传时间:<span>&nbsp;<%=Validate.isNullToDefault(map.get("CREATETIME"), "") %></span></li>
								</ul>
							</td>
							<td style="border:0px;" width="38%">
								<ul style="font-size: 13px;font-weight: bold;">
									<li style="display:block;line-height: 30px;">下载次数:&nbsp;<span id="num" style="color:red;"><%=Validate.isNullToDefault(map.get("DOWNLOADTIME"), "0") %></span>&nbsp;次</li>
									<li style="display:block;line-height: 30px;">浏览次数:&nbsp;<span id="LL" style="color:blue;"><%=Validate.isNullToDefault(map.get("BROWSETIME"), "0") %></span>&nbsp;次</li>
									<li style="display:block;line-height: 30px;">文件大小:<span>&nbsp;<%=df.format(size)%>&nbsp;<%=danwei %></span></li>
									<li style="display:block;line-height: 30px;">所属课程:<span>&nbsp;<%=Validate.isNullToDefault(map.get("KCNAME"), "") %></span></li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		
		<div class="bgr layout" id="comment" style="width:100%;height:272px;">
			<div style="height:20px;font-size: 14px;font-weight: bold;">
				<div id="category_1" style="margin-left:2px;" class="category_show" onclick="tabCategory(this,1)">
					<span class="category_text" style="border-right:0px;line-height:26px;">资源简介</span>
				</div>
				<div id="category_2" style="border-right:0px;" class="category" onclick="tabCategory(this,2)">
					<span class="category_text" style="line-height:26px;">资源评价</span>
				</div>
				<div style="width:100%;float:left;height:245px;">
					<div id="category_body_1" style="display:block">
						<table style="margin-top:-3px;border:0px;">
							<tr>
								<td style="width:799px;height:245px;font-size: 13px;font-weight: bold;margin-top: -3px;border:0px;">&nbsp;&nbsp;<%=Validate.isNullToDefault(map.get("REMARK"), "") %></td>
							</tr>
						</table>
					</div>
					<div id="category_body_2" style="display:none;height:245px;/*overflow-y: scroll;overflow-x: hidden;*/">
						<div id="PL"></div>
					</div>
				</div>
			</div>
		</div>
		</div>
		<div class="layout_line">
			<jsp:include page="../common/bottom/footer.jsp"></jsp:include>
	</div>
		<div id="imgFrame">
	        <div><a style="float: right;" href="javascript:close();">关闭</a></div>
	        <div id="imgbox"></div>
	    </div>
<%-- 	<%@include file="/ggs/include/js.inc" %> --%>
<script type="text/javascript">
(function($) {
	$.fn.extend({
		addIframe : function(options) {
			options = $.extend({
				src : "src-is-null",
				iframeId : "iframeId"
			}, options);
			var $this = $(this);
			var src = options.src;
			var iframeId = options.iframeId;
			$iframe = $('<iframe id="" frameborder="0"></iframe>');
			$iframe.attr("id", iframeId);
			$iframe.attr("src", src);
			$this.append($iframe);
		}
	});
	addIframe($("#PL"),"comment","comment.jsp?fileId=<%=fileId%>");
})(jQuery);
	function addIframe($parent, iframeId, src) {
		$parent.addIframe({
			src : src,
			iframeId : iframeId
		});
	};
	function showOriginal(img) {
        document.getElementById("imgFrame").style.display = "block";
        document.getElementById("imgbox").innerHTML = "<img src='" + img.getAttribute("original") + "' />";
    }
	function close() {
        document.getElementById("imgFrame").style.display = "none";
    }
	 $("#down").click(function (){
		var fileId = '<%=fileId%>';
		$.ajax({
			type: "POST",
			url: "ajax.jsp?fileId="+fileId,
			success : function(num){
				num=$.trim(num);
				$("#num").html(num);
			}
		});
	});
	 $("#browse").click(function(){
		var fileId='<%=fileId%>';
		$.ajax({
			type: "POST",
			url: "ajax1.jsp?fileId="+fileId,
			success : function(num){
				num=$.trim(num);
				$("#LL").html(num);
			}
		});
	});
	 function tabCategory(this_,k){
		 $("#category_"+k).removeClass("category").addClass("category_show");
		 $("#category_body_"+k).css("display","block");
		 for(var i=1;i<=3;i++){
			 if(i!=k){
				 $("#category_"+i).removeClass("category_show").addClass("category");
				 $("#category_body_"+i).css("display","none");
			 };
		} ;
		setPageSize();
	};
	function setPageSize() {
// 		setWidth($("#category_body_2"),$("#comment"));
// 		setHeight($("#category_body_2"),$("#comment"),10);
	}
</script>
<!-- bottom -->
	<!-- <jsp:include page="../common/bottom/footer.jsp"></jsp:include>-->
</body>
</html>