<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@page import="com.googosoft.filesManager.fileManager.FolderManager"%>
<%@page import="com.googosoft.filesManager.fileManager.FileManager"%>
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
<title>将文件复制到已有文件夹</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
String fileId = request.getParameter("fileId");
String operateType = request.getParameter("operateType");
Boolean bool = false;
FilesManager filesManager = new FilesManager();
if("C".equals(operateType)){
	bool = filesManager.copyFiles(request);
}
Map copymap = filesManager.findMapByFILEID(fileId);
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
	<input type="hidden" name="operateType" value="C">
	<input type="hidden" name="P=FILES=FILENAME=S=C" value="<%=copymap.get("FILENAME")==null?"":copymap.get("FILENAME")%>">
	<input type="hidden" name="P=FILES=EXTENDNAME=S=C" value="<%=copymap.get("EXTENDNAME")==null?"":copymap.get("EXTENDNAME")%>">
	<input type="hidden" name="P=FILES=SWFPATH=S=C" value="<%=copymap.get("SWFPATH")==null?"":copymap.get("SWFPATH")%>">
	<input type="hidden" name="P=FILES=REALNAME=S=C" value="<%=copymap.get("REALNAME")==null?"":copymap.get("REALNAME")%>">
	<input type="hidden" name="P=FILES=FALSENAME=S=C" value="<%=copymap.get("FALSENAME")==null?"":copymap.get("FALSENAME")%>">
	<input type="hidden" name="P=FILES=UPLOADER=S=C" value="<%=copymap.get("UPLOADER")==null?"":copymap.get("UPLOADER")%>">
	<input type="hidden" name="P=FILES=FLAG=S=C" value="<%=copymap.get("FLAG")==null?"":copymap.get("FLAG")%>">
	<input type="hidden" name="P=FILES=DOWNLOAD=S=C" value="<%=copymap.get("DOWNLOAD")==null?"":copymap.get("DOWNLOAD")%>">
	<input type="hidden" name="P=FILES=CHECKEDER=S=C" value="<%=copymap.get("CHECKEDER")==null?"":copymap.get("CHECKEDER")%>">
	<input type="hidden" name="P=FILES=UPLOADERID=S=C" value="<%=copymap.get("UPLOADERID")==null?"":copymap.get("UPLOADERID")%>">
	<input type="hidden" name="P=FILES=CHECKEDID=S=C" value="<%=copymap.get("CHECKEDID")==null?"":copymap.get("CHECKEDID")%>">
	<%SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");%>
	<input type="hidden" id="" name="P=FILES=CREATETIME=S=C" value="<%=sdf.format(new Date()) %>">
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">文件原名称</div>
		<div class="sm_edit_td_value"><input type="text" readonly="readonly" class="null maxLength:50num" name="P=FILES=REALNAME=S=C" 
		value="<%=copymap.get("REALNAME")==null?"":copymap.get("REALNAME")%>"></div>
	</div>
<!-- 	<div class="sm_edit_tr"> -->
<!-- 		<div class="sm_edit_td_name">文件名称</div> -->
<%-- 		<div class="sm_edit_td_value"><input type="text" readonly="readonly" class="null maxLength:100num" name="P=FILES=FILENAME=S=C" value="<%=Validate.isNullToDefault(request.getParameter("P=FILES=FILENAME=S=C"),map1.get("FILENAME")) %>"></div> --%>
<!-- 	</div> -->
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">文件扩展名</div>
		<div class="sm_edit_td_value"><input type="text" readonly="readonly" class="null maxLength:50num" name="P=FILES=EXTENDNAME=S=C" 
		value="<%=copymap.get("EXTENDNAME")==null?"":copymap.get("EXTENDNAME")%>"></div>
	</div>
<!-- 	<div class="sm_edit_tr"> -->
<!-- 		<div class="sm_edit_td_name">转格式后文件路径</div> -->
<%-- 		<div class="sm_edit_td_value"><input type="text" readonly="readonly" class="null maxLength:50num" name="P=FILES=SWFPATH=S=C" value="<%=Validate.isNullToDefault(request.getParameter("P=FILES=SWFPATH=S=C"),map1.get("SWFPATH")) %>"></div> --%>
<!-- 	</div> -->
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">章节名称</div>
		<div class="sm_edit_td_value">
		<input type="text" id="folderparentid" readonly="readonly" value="<%=copymap.get("CHAPTER_NAME")==null?"":copymap.get("CHAPTER_NAME")%>">
		<input type="hidden" id="folderparentid" name="P_FILES_CHAPTER_ID_S_S" value="<%=copymap.get("CHAPTER_ID")==null?"":copymap.get("CHAPTER_ID")%>">
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
					window.parent.parent.location.reload();
				}
			}, {
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
			$("[id=folderparentid]").click(function() {
				var parentId = $(this).attr("id");
				var checkedIds = $(":hidden[id=" + parentId + "]").val();
				var src = "treeFolder.jsp";
				src += "?checkedIds=" + checkedIds;
				src += "&parentId=" + parentId;
				selectWindow("资源信息", src, $(this));
			});
		});
		function setPageSize() {

		}
	</script>
</body>
</html>