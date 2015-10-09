<%@page import="com.googosoft.commons.CodeHelper"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.ggs.userManager.DepartmentManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增部门信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	String operateType = request.getParameter("operateType");
Boolean bool = false;
if(Validate.noNull(operateType)){
	bool = new CUDHelper(request,"_",null).execute();
}
String departmentParentId = request.getParameter("departmentParentId");
String umdepartmentparentid = CodeHelper.createUUID();
DepartmentManager departmentManager = new DepartmentManager();
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
	<input type="hidden" name="operateType" value="C">
	<input type="hidden" name="P_UMDEPARTMENT_SAAS_S_C" value="<%=session.getAttribute("SAAS") %>">
	<input type="hidden" name="P_UMDEPARTMENT_UMDEPARTMENTID_S_P" value="<%=umdepartmentparentid %>">
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">部门名称</div>
		<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMDEPARTMENT_UMDEPARTMENTNAME_S_C" value="<%=Validate.isNullToDefault(request.getParameter("P_UMDEPARTMENT_UMDEPARTMENTNAME_S_C"),"") %>"></div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">父节点</div>
		<div class="sm_edit_td_value">
		<%
		Map parentMap = departmentManager.findMapByUmdepartmentid(departmentParentId);
		Object umdepartmentname = parentMap.get("UMDEPARTMENTNAME");
		%>
		<input type="text" id="umdepartmentparentid" value="<%=Validate.isNull(umdepartmentname)?"根节点":umdepartmentname%>">
		<input type="hidden" id="umdepartmentparentid" name="P_UMDEPARTMENT_UMDEPARTMENTPARENTID_S_C" value="<%=Validate.isNull(departmentParentId)?"basic":departmentParentId%>">
		</div>
	</div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
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
				model:"save_<%=Power.getOperates(request)%>",
				handler : function() {
					if(validateBySubmit($("form"))){
						var $umdepartmentparentid = $("[name=P_UMDEPARTMENT_UMDEPARTMENTPARENTID_S_C]");
						if($umdepartmentparentid.val()=="basic"){
							$umdepartmentparentid.val("<%=umdepartmentparentid%>");
						}
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
			$("[id=umdepartmentparentid]").click(function() {
				var parentId = $(this).attr("id");
				var checkedIds = $(":hidden[id=" + parentId + "]").val();
				var src = "treeDepartment.jsp";
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