<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	//非视频文件审核
		request.setCharacterEncoding("utf-8");
	//获取文件信息
		String down = request.getParameter("down");
      	
	//获取服务相关路径
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	//将路径绑定到request
		request.setAttribute("basepath",basePath);
		String swfFile = request.getParameter("swfFile");
		String swfFilePath = basePath+"ggs/common/ggs/upload/"+swfFile+".swf";
		String downURL = request.getContextPath()+"/DownLoad/";
		String filename=swfFile+".swf";
		
		String marjorId = request.getParameter("marjorId");
		String courseId = request.getParameter("courseId");
		String chapterId = request.getParameter("chapterId");
		String pointId = request.getParameter("pointId");
		String userName = request.getParameter("userName");
		System.out.println("DDDDDDDDDD"+userName);
	//检查文件是否存在
		boolean flag=ProcessFileUtil.checkFileExists(filename,request);
	//获取文件Id	
		String operateType = request.getParameter("operateType");
		String fileId = request.getParameter("fileId");
	//执行增删改查操作
		Boolean bool = false;
		if(Validate.noNull(operateType)){
			bool = new CUDHelper(request,"=",null).execute();
		}
	//根据文件Id获取文件其他相关信息
		FilesManager filesManager= new FilesManager();
		Map updateMap = filesManager.findMapByFILEID(fileId);
%>
  <head>
  
	<!-- 设置页面的属性以及导入需要的文件 -->
    <base href="<%=basePath%>">
    <title>文件审核</title>
	<%@include file="/ggs/include/css.inc" %>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="${basepath}css/styles.css">
	<script type="text/javascript" src="<%=basePath %>ggs/common/js/flexpaper_flash.js"></script>

  </head>
  
  <body>
  	<!-- 设置当前资源是否问优秀资源 -->
  	  <div class="tool">
  	  	<div style="position: absolute;left: 180px;margin-top: 3px;">
			&nbsp;&nbsp;&nbsp;&nbsp;推荐为精品资源:&nbsp;
<!-- 			<select name="perfact" > -->
<!-- 				<option value="T">是</option> -->
<!-- 				<option value="F">否</option> -->
<!-- 			</select> -->
				<input type="checkbox" name="perfact" >
		</div>
  	  </div>
      <div class="sm_list">
      
      <form method="post" action="">
      	<input type="hidden" name="P=FILES=ISEXCELLENT=S=S" value="">
      	<input type="hidden" name="P=FILES=FILEID=S=WU" value="<%=updateMap.get("FILEID")==null?"":updateMap.get("FILEID")%>">
      	<input type="hidden" name="P=FILES=FLAG=S=S">
      	<input type="hidden" name="operateType" value="U">
      	<input type="hidden" name="P=FILES=FLAG=S=S">
      	<input type="hidden" name="P=FILES=CHECKEDID=S=S" value="<%=session.getAttribute("USERIDBYLOGIN")==null?"":session.getAttribute("USERIDBYLOGIN")%>">
		<%
      	//获取当前登录人信息
      	String userid=(String)request.getSession().getAttribute("USERIDBYLOGIN");//添加人员  
    	String sql = "select username from umuser where userid = '"+userid+"'";
    	DBHelper dbHelper = new DBHelper();
    	Map mname = dbHelper.queryForMap(sql);	
      	%>
		<input type="hidden" name="P=FILES=CHECKEDER=S=S" value="<%=mname.get("USERNAME") %>">
      </form>
      <div style="left:10px;top:10px;margin-top:30px;margin-left:30px;margin-bottom: 30px;overflow:auto;">
	        <a id="viewerPlaceHolder" style="width:680px;height:480px;display:block"></a>
      </div>
     	
    </div>         
  </body>
		<%@include file="/ggs/include/js.inc" %>
	        <script type="text/javascript"> 
	        
	        	//预览非视频文件
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
	        	
				//增删改查操作
				$(function(){
					if("<%=bool%>"=="true"){
						 var src = "filesmanager/fileManager/verifyFile.jsp?MAJOR_ID=<%=marjorId%>&COURSE_ID=<%=courseId%>&P_Q_LIKE_UM.USERNAME=<%=userName%>";
						//var src = "verifyFile.jsp?MAJOR_ID=<%=marjorId%>&COURSE_ID=<%=courseId%>&P_Q_LIKE_UM.USERNAME=<%=userName%>";
						parent.location.href=src;
					}
					$(".tool").toolBar([ {
						text : "审核通过",
						width : 50,
						position : "-360px -100px",
						handler : function() {
							if(validateBySubmit($("form"))){
								
								var perfact = $("[name=perfact]");
								if(perfact.attr("checked")){
									$("[name='P=FILES=ISEXCELLENT=S=S']").val("T");
								}else{
									$("[name='P=FILES=ISEXCELLENT=S=S']").val("F");
								}
								$("[name=operateType]").val("U");
								$("[name='P=FILES=FLAG=S=S']").val("22");
								$("form").submit();
							}
						}
					},{
						text : "审核不通过",
						width : 50,
						position : "-360px -100px",
						handler : function() {
							if(validateBySubmit($("form"))){
								$("[name=operateType]").val("U");
								$("[name='P=FILES=FLAG=S=S']").val("33");
								$("form").submit();
							}
						}
					} ]);
					setPageSize();
				});
				//设置页面属性,增加页面滚动条
				function setPageSize(){
					setWidth($(".sm_list"),$("body"));
					setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]); 
				}
	        </script>
</html>
