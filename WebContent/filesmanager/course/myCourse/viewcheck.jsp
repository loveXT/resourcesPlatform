<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	request.setAttribute("basepath",basePath);
	String swfFile = request.getParameter("swfFile");
	String swfFilePath = basePath+"ggs/common/ggs/upload/"+swfFile+".swf";
	String operateType = request.getParameter("operateType");
	String fileId = request.getParameter("fileId");
	
	String major_Id = request.getParameter("major_Id");
	String classId = request.getParameter("classId");
	String uploader = request.getParameter("uploader");
	String state = request.getParameter("state");
	
	String userid=(String)request.getSession().getAttribute("USERIDBYLOGIN");//添加人员  
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"=",null).execute();
	}
// 	FilesManager filesManager= new FilesManager();
// 	Map updateMap = filesManager.findMapByFILEID(fileId);
	Date nowDate = new Date();
	String dateNow=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nowDate).toString();
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
	<link rel="stylesheet" type="text/css" href="${basepath}css/styles.css">
	<script type="text/javascript" src="<%=basePath %>ggs/common/js/flexpaper_flash.js"></script>
</head>
<body>
  	<div class="tool">
		<div style="position: absolute;left: 180px;margin-top: 3px;">
			&nbsp;&nbsp;&nbsp;&nbsp;推荐优秀教案:&nbsp;
				<input name="perfact" id="check" type="checkbox">
		</div>
	</div>
    <div style="margin-top:530px;margin-left:720px;">
    </div>
    <div class="sm_list">
	    <form method="post" action="">
	      	<input type="hidden" name="P=TEACHPLAN=ISEXCELLENT=S=S" value="">
	      	<input type="hidden" name="operateType" value="U">
	      	<input type="hidden" name="P=TEACHPLAN=PLANID=S=WU" value="<%=fileId==null?"":fileId%>">
	      	<input type="hidden" name="P=TEACHPLAN=FLAG=S=S" value="">
	      	<input type="hidden" name="P=TEACHPLAN=COMMIT=S=S" value="">
	      	<input type="hidden" name="P=TEACHPLAN=CHECKEDTIME=S=S" value="<%=dateNow%>">
	      	<input type="hidden" name="P=TEACHPLAN=CHECKEDER=S=S" value="<%=userid==null?"":userid%>">
	    </form>
    <div style="position:absolute;left:10px;top:10px;margin-top:30px;overflow:auto;">
	    <a id="viewerPlaceHolder" style="width:680px;height:480px;display:block"></a>
    </div>
    </div> 
</body>
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
		
		$(function(){
			if("<%=bool%>"=="true"){
				var src = "filesmanager/course/verifyFile.jsp?MAJOR_ID=<%=major_Id%>&uploader=<%=uploader%>&CLASSID=<%=classId%>&state=<%=state%>";
				parent.location.href=src;
			}
			
			$(".tool").toolBar([ {
				text : "审核通过",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						if($("#check").attr("checked")){
							$("[name='P=TEACHPLAN=ISEXCELLENT=S=S']").val("T");
							alert('通过优秀');
						}else{
							$("[name='P=TEACHPLAN=ISEXCELLENT=S=S']").val("F");
							alert('通过不优秀');
						}
						$("[name=operateType]").val("U");
						$("[name='P=TEACHPLAN=FLAG=S=S']").val("44");
						$("[name='P=TEACHPLAN=COMMIT=S=S']").val("11");
						$("form").submit();
					}
				}
			},{
				text : "审核不通过",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("[name='P=TEACHPLAN=ISEXCELLENT=S=S']").val("F");
						$("[name=operateType]").val("U");
						$("[name='P=TEACHPLAN=FLAG=S=S']").val("22");
						$("[name='P=TEACHPLAN=COMMIT=S=S']").val("00");
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
		});
		function setPageSize(){
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]); 
		}
</script>
</html>
