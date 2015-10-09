<%@page import="com.googosoft.questionbank.questionbank.ChapterManager"%>
<%@page import="com.googosoft.questionbank.questionbank.CourseManager"%>
<%@page import="com.googosoft.filesManager.fileManager.FolderManager"%>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.commons.CodeHelper"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增文件夹信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	//接受chapter_id章节编号,course_id课程编号,major_id专业编号
	String Chapter_id = request.getParameter("CHAPTER_ID");
	String Course_id = null;
	String Major_id = null;
	//通过chapter_id章节编号,course_id课程编号,major_id专业编号来获取名字
	ChapterManager chapterManager = new ChapterManager();
	Map chapterMap = chapterManager.findMapByCHAPTER_ID(Chapter_id);
	Course_id = (String)chapterMap.get("COURSE_ID");
	CourseManager  courseManager = new CourseManager();	
	Map courseMap = courseManager.findMapMAJOR_ID(Course_id);
	Major_id = (String)courseMap.get("MAJOR_ID");
	String operateType = request.getParameter("operateType");
	//生成32位随机id
	String id = CodeHelper.createUUID();
	FolderManager folderManager = new FolderManager();
	//接受参数通过cud进行处理
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"=",null).execute();
%>
<script type="text/javascript">
	parent.location.reload(true);//刷新父窗口 

	window.setTimeout(function(){
		parent.removeJumpWindow();
	}, 1000);//一秒之后 关闭 
</script>
<%

	}
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center" >
	<form class="sm_edit_from" method="post" action="" style="margin-top: 20PX;height: 130px;">
	<input type="hidden" name="operateType" value="C">
	<input type="hidden" name="P=FOLDER=FOLDERID=S=P" value="<%=id %>">
	<input type="hidden" name="P=FOLDER=CHAPTER_ID=S=C" value="<%=Chapter_id%>">
	<input type="hidden" name="P=FOLDER=COURSE_ID=S=C" value="<%=Course_id%>">
	<input type="hidden" name="P=FOLDER=MAJOR_ID=S=C" value="<%=Major_id%>">
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">类别编号</div>
		<div class="sm_edit_td_value">
			<input type="text" class="null maxLength:9num" name="P=FOLDER=FOLDERCODE=S=C" value="<%=Validate.isNullToDefault(request.getParameter("P=FOLDER=FOLDERCODE=S=C"),"") %>">
			<input type="text" id="hide">
		</div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">类别名称</div>
		<div class="sm_edit_td_value">
			<input type="text" class="null maxLength:50num" name="P=FOLDER=FOLDERNAME=S=C" value="<%=Validate.isNullToDefault(request.getParameter("P=FOLDER=FOLDERNAME=S=C"),"") %>">
			<input type="text" id="hide1">
		</div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name" style="height: 50px; ">类别描述</div> 
		<div class="sm_edit_td_value" style="height: 50px; ">
			<textarea style="height: 50px;width: 154px;overflow:auto;" name="P=FOLDER=FLMS=S=C" rows="" cols=""></textarea>
		</div>
	</div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			//隐藏div元素
			$("#hide").hide();
			$("#hide1").hide();
			//cud处理成功后关闭本页面,父页面刷新
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
			//给tool标签增加按钮操作
			$(".tool").toolBar([ {
				text : "保存",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
		});
		function setPageSize() {
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]);
		}
	</script>
</body>
</html>