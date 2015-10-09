<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.file.FileBean"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
%>
<!DOCTYPE html PUBLIC "-W3CDTD HTML 4.01 TransitionalEN" "http:www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件上传</title>
<%@include file="/ggs/include/css.inc" %>
  	<style type="text/css">
		#fileQueue{
  			position: relative;
  			border: 1px solid #999999;
  			background-color: #FFFFFF;
  			width: 420px;
  			height: 60px;
  			top: 5px;
  			overflow: hidden;
  		}
  		.uploadifyQueueItem{
  			width: 390px;
		}
		.uploadlacate{
		   margin-left: 60px; 
		   margin-top: 5px;
		}
		.fileArray{
		   margin-left: 0px; 
		   margin-top: 10px;
		}
	</style>
</head>
<body>
<input type="file"  id="fileInput"/>
<div id="fileQueue"></div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
$(document).ready(function(){
	<%
	String sp = File.separator;
	String toPath = "d:"+sp+sp+"d";
	%>
    $('#fileInput').uploadify({
    	'uploader': '<%=pathSkinTool%>/tool/uploadify/uploadify.swf',
	    'script': '<%=pathSkinTool%>/tool/uploadify/uploadServlet.jsp?TOPATH=<%=toPath%>',	//指定服务端处理类的入口 
	 	'cancelImg' : '<%=pathSkinTool%>/tool/uploadify/cancel.png',
	    'queueID': 'fileQueue',
	    'fileDataName': 'fileInput',//和input的name属性值保持一致
	    'auto': true,//是否选取文件后自动上传   
	    'multi': false,//是否支持多文件上传
	    'simUploadLimit' : 1,//每次最大上传文件数
	    'removeCompleted' : false,
		'buttonImg':'<%=pathSkinTool%>/tool/uploadify/upload.png',
	    'width': 52,
	 	'height': 22,
	 	'displayData': 'percentage', //有speed和percentage两种，一个显示速度，一个显示完成百分比
	 	'onComplete': function(event, ID, fileObj, response, data) {
	 		//response返回值：重命名后的文件名称,文件保存路径
	 		alert(response);
	 	} ,
	 	'onCancel': function(event,ID,fileObj,data) {
	 	}
    }); 
});
</script>
</body>
</html>