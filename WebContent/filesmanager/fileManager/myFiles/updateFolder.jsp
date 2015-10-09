<%@page import="com.googosoft.filesManager.fileManager.FolderController"%>
<%@page import="com.googosoft.filesManager.fileManager.FolderManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改文件夹信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"=",null).execute();
	}
	String folderid = request.getParameter("Id");
	FolderController folderManager = new FolderController();
	Map updateMap = folderManager.findMapByFOLDERID(folderid);
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="" style="margin-top: 20PX;height: 130px;">
	<input type="hidden" name="operateType" value="U">
	<input type="hidden" name="P=FOLDER=FOLDERID=S=WU" value="<%=folderid %>">
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">类别编号</div>
		<div class="sm_edit_td_value">
			<input type="text" class="null maxLength:9num" name="P=FOLDER=FOLDERCODE=S=S" value="<%=Validate.isNullToDefault(updateMap.get("FOLDERCODE"),"") %>">
			<input type="text" id="hide">
		</div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">类别名称</div>
		<div class="sm_edit_td_value">
			<input type="text" class="null maxLength:50num" name="P=FOLDER=FOLDERNAME=S=S" value="<%=Validate.isNullToDefault(updateMap.get("FOLDERNAME"),"") %>">
			<input type="text" id="hide1">
		</div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name" style="height: 50px;">类别描述</div>
		<div class="sm_edit_td_value" style="height: 50px; ">
			<textarea style="height: 50px;width:154px;overflow:auto;" name="P=FOLDER=FLMS=S=S" rows="" cols=""><%=Validate.isNullToDefault(updateMap.get("FLMS"),"") %></textarea>
		</div>
	</div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			$("#hide").hide();
			$("#hide1").hide(); 
			
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","doneByParent.jsp");
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

		}
	</script>
</body>
</html>