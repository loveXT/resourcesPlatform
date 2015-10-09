<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@page import="com.googosoft.filesManager.fileManager.FolderManager"%>
<%@page import="com.googosoft.filesManager.fileManager.FileManager"%>
<%@page import="com.googosoft.ggs.userManager.UserManager"%>
<%@page import="com.googosoft.ggs.saasManager.SaasManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.ggs.userManager.RoleManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改文件信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	String fileId = request.getParameter("fileId");
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	FilesManager filesManager = new FilesManager();
	if(Validate.noNull(operateType)){
		bool = filesManager.moveFile(request);
	}
	Map updateMap = filesManager.findMapByFILEID(fileId);
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="" style="margin-top: 40px;">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_FILES_FILEID_S_WU" value="<%=updateMap.get("FILEID")==null?"":updateMap.get("FILEID")%>">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">文件名称</div>
			<div class="sm_edit_td_value">
				<input type="hidden" readonly="readonly" class="maxLength:100num" name="P_FILES_FILENAME_S_S" value="<%=updateMap.get("FILENAME")==null?"":updateMap.get("FILENAME")%>">
				<input type="text" readonly="readonly" class="maxLength:100num" name="P_FILES_FILENAME_S_S" value="<%=updateMap.get("REALNAME")==null?"":updateMap.get("REALNAME")%>">
			</div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">扩展名名称</div>
			<div class="sm_edit_td_value"><input type="text" readonly="readonly" class="maxLength:50num" name="P_FILES_EXTENDNAME_S_S" value="<%=updateMap.get("EXTENDNAME")==null?"":updateMap.get("EXTENDNAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">知识点名称</div>
			<div class="sm_edit_td_value">
						<input type="text" id="folderid" readonly="readonly" value="<%=updateMap.get("POINT_NAME")==null?"":updateMap.get("POINT_NAME")%>">
						<input type="hidden" id="folderid" name="P_FILES_POINT_ID_S_S" value="<%=updateMap.get("POINT_ID")==null?"":updateMap.get("POINT_ID")%>">
					</div>
		</div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","doneByParent.jsp");
			$(".tool").toolBar([ {
				text : "返回",
				width : 50,
				position : "-340px -100px",
				handler : function() {
					window.parent.location.reload();
				}
			}, {
				text : "保存",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("[name=operateType]").val("U");
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
			 $("[id=folderid]").click(function() {
					var parentId = $(this).attr("id");
					var checkedIds = $(":hidden[id=" + parentId + "]").val();
					var src = "treeFolder.jsp";
					src += "?checkedIds=" + checkedIds;
					src += "&parentId=" + parentId;
					parent.selectWindow("移动文件", src, $(this), "<%= request.getParameter("windowsId")%>");
				});
		});
		function setPageSize() {
			
		}
	</script>
</body>
</html>