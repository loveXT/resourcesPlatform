<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
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
	//接收fileId资源编号
	String fileId = request.getParameter("fileId");
	//根据operateType的类型进行cud进行处理
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"=",null).execute();
	}
	//调用findMapByFILEID方法,进行回显
	FilesManager filesManager= new FilesManager();
	Map updateMap = filesManager.findMapByFILEID(fileId);
	Map mname = (Map)request.getSession().getAttribute("USERMAP");
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
		<input type="hidden" name="operateType" value="U">
		<input type="hidden" name="P=FILES=FILEID=S=WU" value="<%=updateMap.get("FILEID")==null?"":updateMap.get("FILEID")%>">
		<input type="hidden" name="P=FILES=CHECKEDID=S=S" value="<%=mname.get("USERID") %>">
		<input type="hidden" name="P=FILES=CHECKEDER=S=S" value="<%=mname.get("USERNAME") %>">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name"></div>
			<div class="sm_edit_td_value" style="width:200px">
				<input type="radio" name="P=FILES=FLAG=S=S" checked="checked" value="00"> 审核通过&nbsp;&nbsp; <input type="radio" name="P=FILES=FLAG=S=S" value="11"> 审核不通过
			</div>
		</div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			//cud处理成功后关闭本页面,父页面刷新
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","doneByParent.jsp");
			//给tool标签增加"返回"和"保存"按钮操作
			$(".tool").toolBar([ {
				text : "保存",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						var check = document.getElementsByName("check");
						if(confirm("确认考核？")){
	 						$("form").submit();
						}
						
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