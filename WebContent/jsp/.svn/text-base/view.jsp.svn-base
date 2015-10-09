<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	String selectFiles = request.getParameter("selectFiles");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	request.setAttribute("basepath",basePath);
	String swfFile = new String(request.getParameter("swfFile").getBytes("utf-8"),"utf-8");
	String fileId = new String(request.getParameter("fileId").getBytes("utf-8"),"utf-8");
	String filename=swfFile+".swf";
	String swfFilePath = basePath+"ggs/common/ggs/upload/"+filename;
	boolean flag=ProcessFileUtil.checkFileExists(filename,request);
	System.out.println(flag);
	System.out.println(selectFiles);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>文档在线预览页面</title>
    <%@include file="/ggs/include/css.inc" %>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="<%=path%>/js/index.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/index.css">
	<script type="text/javascript" src="<%=basePath %>ggs/common/js/flexpaper_flash.js"></script>
	<style type="text/css">
	body{
	overflow-y: scroll;
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
  <body style="display: block;overflow: auto;">
  <div class="body_div">
		<div class="layout_line" style="min-height:450px;">
  	<c:choose>
  	<c:when test="<%=flag %>">
      <div style="display: block;overflow: auto;">
<!--       <div style="position:absolute;left:24%;top:5px;"> -->
		<div style="width:800px;height:750px;margin:0px auto;">
	        <a id="viewerPlaceHolder" style="width:800px;height:750px;display:block;overflow: auto;"></a>
	        <%@include file="/ggs/include/js.inc" %>
	        <script type="text/javascript"> 
				var fp = new FlexPaperViewer(	
						 '<%=basePath %>ggs/common/js/FlexPaperViewer',
						 'viewerPlaceHolder', { config : {
						 SwfFile : '<%=swfFilePath%>',
						 Scale : 0.99, 
						 ZoomTransition : 'easeOut',
						 ZoomTime : 0.5,
						 ZoomInterval : 0.2,
						 FitPageOnLoad : true,
						 FitWidthOnLoad : false,
						 FullScreenAsMaxWindow : false,
						 ProgressiveLoading : false,
						 MinZoomSize : 0.2,
						 MaxZoomSize : 5,
						 SearchMatchAll : false,
						 InitViewMode : 'SinglePage',
						 ViewModeToolsVisible : true,
						 ZoomToolsVisible : true,
						 NavToolsVisible : true,
						 CursorToolsVisible : true,
						 SearchToolsVisible : true,
  						 localeChain: 'en_US'
						 }});
				   $(function() {
// 						$(".tool").toolBar([ {
// 			   				text : "返回",
// 			   				width : 50,
// 			   				position : "-340px -100px",
// 			   				handler : function() {
// // 			   					location.href="listFile.jsp"; 
// 			   					location.href="javascript:history.go(-1)";
// 			   				}
// 			   			}])
			   			setPageSize();
			        });
				   function setPageSize(){
					}
	        </script>
        </div>
        </div>
  		</c:when>
  		<c:otherwise>
  		 <script type="text/javascript">
  		 	alert("文件正在转换中，请稍后进行预览");
  		 	location.href="<%=path %>/jsp/content.jsp?fileId="+'<%=fileId%>';  
  		 </script> 			
  		</c:otherwise>
  	</c:choose>
	</div>
<%-- 			<jsp:include page="../common/bottom/footer.jsp"></jsp:include> --%>
</div>
  </body>
</html>
