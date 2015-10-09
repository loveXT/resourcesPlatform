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
<title>修改文件夹信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	//这个Id是传递过来的文件夹的id
	String folderId = request.getParameter("folderId");
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"_",null).execute();
	}
	FolderManager folderManager= new FolderManager();
	Map map = folderManager.findMapByFolderId(folderId);
	String folderParentId = (String)map.get("FOLDERPARENTID");
	FolderManager fm = new FolderManager();
	Map map1 = fm.findMapByFolderId(folderParentId);
	
	String folderParentName = (String)map1.get("FOLDERNAME");
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_FOLDER_FOLDERID_S_WU" value="<%=map.get("FOLDERID")==null?"":map.get("FOLDERID")%>">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">文件夹名称</div>
			<div class="sm_edit_td_value">
						<input type="text" id="folderid" value="<%=Validate.isNull(folderParentName)?" ":folderParentName%>">
						<input type="hidden"  value="P_FOLDER_FOLDERNAME_S_S" value="<%=request.getParameter("P_FOLDER_FOLDERNAME_S_S")==null?"":request.getParameter("P_FOLDER_FOLDERNAME_S_S")%>">
						<input type="hidden" id="folderid" name="P_FOLDER_FOLDERPARENTID_S_S" value="<%=Validate.isNull(folderParentId)?"basic":folderParentId%>">
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
					selectWindow("资源信息", src, $(this));
				});
		});
		function setPageSize() {
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]);
		}
	</script>
</body>
</html>