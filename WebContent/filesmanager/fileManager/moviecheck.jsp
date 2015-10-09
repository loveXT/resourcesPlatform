<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//设置编码格式为"utf-8"
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	//通过fileName文件名生成文件路径
	String path = request.getContextPath(); 
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
	String fileName = request.getParameter("fileName");
	String operateType = request.getParameter("operateType");
	String playURL = basePath+"ViewVideo/"+fileName;
	request.setAttribute("path", basePath);
	
	String marjorId = request.getParameter("marjorId");
	String courseId = request.getParameter("courseId");
	String chapterId = request.getParameter("chapterId");
	String pointId = request.getParameter("pointId");
	String userName = request.getParameter("userName");
	//根据operateType的类型进行cud进行处理
	Boolean bool = false;
	String fileId = request.getParameter("fileId");
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"=",null).execute();
	}	
	FilesManager filesManager= new FilesManager();
	Map updateMap = filesManager.findMapByFILEID(fileId);
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
				&nbsp;&nbsp;&nbsp;&nbsp;推荐为精品资源:&nbsp;
<!-- 				<select name="perfact" > -->
<!-- 					<option value="T">是</option> -->
<!-- 					<option value="F">否</option> -->
<!-- 				</select> -->
<input type="checkbox" name="perfact" >
			</div>
		</div>
		<div class="sm_list">
		<center>
			<form method="post" action="">
				<div id="container" style="height: 800px;width: 600px;">Loading the player ...</div>
					<input type="hidden" name="P=FILES=ISEXCELLENT=S=S" value="">	
					<input type="hidden" name="P=FILES=FILEID=S=WU" value="<%=updateMap.get("FILEID")==null?"":updateMap.get("FILEID")%>">
			      	<input type="hidden" name="P=FILES=FLAG=S=S">
			      	<input type="hidden" name="operateType" value="U">
			      	<input type="hidden" name="P=FILES=FLAG=S=S">
			      	<input type="hidden" name="P=FILES=CHECKEDID=S=S" value="<%=session.getAttribute("USERIDBYLOGIN")==null?"":session.getAttribute("USERIDBYLOGIN")%>">
					<%
			      	String userid=(String)request.getSession().getAttribute("USERIDBYLOGIN");//添加人员  
			    	String sql = "select username from umuser where userid = '"+userid+"'";
			    	DBHelper dbHelper = new DBHelper();
			    	Map mname = dbHelper.queryForMap(sql);	
			      	%>
					<input type="hidden" name="P=FILES=CHECKEDER=S=S" value="<%=mname.get("USERNAME") %>">
			</form>
		</center>
	</div>
</body>	
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript" src="<%=basePath+ "/jwplayer/jwplayer.js" %>"></script>
<script type="text/javascript">
	$(function(){
		//cud处理成功后关闭本页面,父页面刷新
		if("<%=bool%>"=="true"){
			var src = "verifyFile.jsp?MAJOR_ID=<%=marjorId%>&COURSE_ID=<%=courseId%>&CHAPTER_ID=<%=chapterId%>&POINT_ID=<%=pointId%>&P_Q_LIKE_UM.USERNAME=<%=userName%>";
			parent.location.href=src;
		}	
		//给tool标签增加"审核通过"和"审核不通过"按钮操作
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