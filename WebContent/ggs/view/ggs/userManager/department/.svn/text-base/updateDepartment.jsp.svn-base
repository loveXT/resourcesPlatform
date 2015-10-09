<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.ggs.userManager.DepartmentManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改部门信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	String operateType = request.getParameter("operateType");
Boolean bool = false;
if(Validate.noNull(operateType)){
	bool = new CUDHelper(request,"_",null).execute();
}
String umdepartmentid = request.getParameter("umdepartmentid");
DepartmentManager departmentManager = new DepartmentManager();
Map updateMap = departmentManager.findMapByUmdepartmentid(umdepartmentid);
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
	<input type="hidden" name="umdepartmentid" value="<%=umdepartmentid %>">
	<input type="hidden" name="operateType" value="U">
	<input type="hidden" name="P_UMDEPARTMENT_UMDEPARTMENTID_S_WU" value="<%=updateMap.get("UMDEPARTMENTID")==null?"":updateMap.get("UMDEPARTMENTID")%>">
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">名称</div>
		<div class="sm_edit_td_value"><input type="text" class="maxLength:50num" name="P_UMDEPARTMENT_UMDEPARTMENTNAME_S_S" value="<%=updateMap.get("UMDEPARTMENTNAME")==null?"":updateMap.get("UMDEPARTMENTNAME")%>"></div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">父节点</div>
		<div class="sm_edit_td_value">
		<%
		String umdepartmentparentid = updateMap.get("UMDEPARTMENTPARENTID")==null?"":updateMap.get("UMDEPARTMENTPARENTID").toString();
		Map parentMap = departmentManager.findMapByUmdepartmentid(umdepartmentparentid);
		%>
		<input type="text" id="umdepartmentparentid" value="<%=parentMap.get("UMDEPARTMENTNAME")==null?"":parentMap.get("UMDEPARTMENTNAME")%>">
		<input type="hidden" id="umdepartmentparentid" name="P_UMDEPARTMENT_UMDEPARTMENTPARENTID_S_S" value="<%=updateMap.get("UMDEPARTMENTPARENTID")==null?"":updateMap.get("UMDEPARTMENTPARENTID")%>">
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
				model:"save_<%=Power.getOperates(request)%>",
				handler : function() {
					if(validateBySubmit($("form"))){
						var $umdepartmentparentid = $("[name=P_UMDEPARTMENT_UMDEPARTMENTPARENTID_S_S]");
						if($umdepartmentparentid.val()=="basic"){
							$umdepartmentparentid.val("<%=umdepartmentid%>");
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
				src += "&umdepartmentid=<%=umdepartmentid%>"
				selectWindow("资源信息", src, $(this));
			});
		});
		function setPageSize() {

		}
	</script>
</body>
</html>