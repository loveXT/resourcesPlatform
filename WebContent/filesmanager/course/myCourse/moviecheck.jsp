<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	String path = request.getContextPath(); 
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	String fileName = request.getParameter("fileName");
	String operateType = request.getParameter("operateType");
	String playURL = basePath+"ViewVideo/"+fileName;
	request.setAttribute("path", basePath);
	Boolean bool = false;
	String fileId = request.getParameter("fileId");
	
	String major_Id = request.getParameter("major_Id");
	String classId = request.getParameter("classId");
	String uploader = request.getParameter("uploader");
	String state = request.getParameter("state");
	
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"=",null).execute();
	}	
	String userid=(String)request.getSession().getAttribute("USERIDBYLOGIN");//添加人员
	Date nowDate = new Date();
	String dateNow=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nowDate).toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/ggs/include/css.inc" %>
</head>
<body>
<div class="tool">
	<div style="position: absolute;left: 180px;margin-top: 3px;">
			&nbsp;&nbsp;&nbsp;&nbsp;推荐优秀教案:&nbsp;
		<input id="check" name="perfact" type="checkbox">
	</div>
</div>
<div style="margin-top: 5px;" class="sm_list">
<div class="sm_list">
	<center>
		<form method="post" action="">
			<div id="container" style="height: 800px;width: 600px;">Loading the player ...</div>
			<input type="hidden" name="P=TEACHPLAN=ISEXCELLENT=S=S" value="">
	      	<input type="hidden" name="operateType" value="U">
			<input type="hidden" name="P=TEACHPLAN=PLANID=S=WU" value="<%=fileId==null?"":fileId%>">
	      	<input type="hidden" name="P=TEACHPLAN=FLAG=S=S" value="">
	      	<input type="hidden" name="P=TEACHPLAN=COMMIT=S=S" value="">
	      	<input type="hidden" name="P=TEACHPLAN=CHECKEDTIME=S=S"  value="<%=dateNow%>">
	      	<input type="hidden" name="P=TEACHPLAN=CHECKEDER=S=S" value="<%=userid==null?"":userid%>">
		</form>
	</center>
</div>
</div>
</body>	
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript" src="<%=basePath+ "/jwplayer/jwplayer.js" %>"></script>
<script type="text/javascript">
	$(function(){
		if("<%=bool%>"=="true"){
			var src = "verifyFile.jsp?MAJOR_ID=<%=major_Id%>&uploader=<%=uploader%>&CLASSID=<%=classId%>&state=<%=state%>";
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
					}else{
						$("[name='P=TEACHPLAN=ISEXCELLENT=S=S']").val("F");
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
		jwplayer('container').setup({
			flashplayer: '<%= basePath+"/jwplayer/player.swf" %>',
			file: '<%=playURL%>',
			skin: '<%=basePath+"/jwplayer/glow.zip" %>',
			autostart: true,
			height: $('#container').width() * 0.75,
			width: $('#container').width()
		});
	});
		
	function setPageSize(){
		setWidth($(".sm_list"),$("body"));
		setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]); 
	}
</script>
</html>