<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.ggs.userManager.ResourceManager"%>
<%@page import="com.googosoft.commons.CodeHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
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
String resourceParentId = request.getParameter("resourceParentId");
String umresourceid = CodeHelper.createUUID();
ResourceManager resourceManager = new ResourceManager();
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
	<input type="hidden" name="operateType" value="C">
	<input type="hidden" name="P_UMRESOURCE_UMRESOURCEID_S_P" value="<%=umresourceid %>">
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">资源名称</div>
		<div class="sm_edit_td_value" style="width: 425px;"><input type="text" style="width: 420px;" class="null maxLength:50num" name="P_UMRESOURCE_UMRESOURCENAME_S_C" value="<%=Validate.isNullToDefault(request.getParameter("P_UMRESOURCE_UMRESOURCENAME_S_C"),"") %>"></div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">父节点</div>
		<div class="sm_edit_td_value" style="width: 425px;">
		<%
		Map parentMap = resourceManager.findMapByumResourceId(resourceParentId);
		Object umdepartmentname = parentMap.get("UMRESOURCENAME");
		%>
		<input type="text" id="resourceParentId" style="width: 420px;" class="null" value="<%=Validate.isNull(umdepartmentname)?"根节点":umdepartmentname%>">
		<input type="hidden" id="resourceParentId" name="P_UMRESOURCE_UMRESOURCEPARENTID_S_C" value="<%=Validate.isNull(resourceParentId)?"basic":resourceParentId%>">
		</div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">链接地址</div>
		<div class="sm_edit_td_value" style="width: 425px;"><input type="text" style="width: 420px;" class="maxLength:1500num" name="P_UMRESOURCE_UMRESOURCEURL_S_C" value="<%=Validate.isNullToDefault(request.getParameter("P_UMRESOURCE_UMRESOURCEURL_S_C"),"") %>"></div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">显示顺序</div>
		<div class="sm_edit_td_value" style="width: 425px;"><input type="text" style="width: 420px;" class="maxLength:5num num null" name="P_UMRESOURCE_UMORDER_S_C" value="<%=Validate.isNullToDefault(request.getParameter("P_UMRESOURCE_UMORDER_S_C"),"") %>"></div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">是否生效</div>
		<div class="sm_edit_td_value" style="width: 425px;">
			<select class="null" style="width: 420px;" name="P_UMRESOURCE_UMRESOURCEUSEABLE_S_C">
				<option value="T">是</option>
				<option value="F">否</option>
			</select>
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
					window.parent.location.reload();
				}
			}, {
				text : "保存",
				width : 50,
				position : "-360px -100px",
<%-- 				model:"save_<%=Power.getOperates(request)%>", --%>
				handler : function() {
					if(validateBySubmit($("form"))){
						var $umresourceid = $("[name=P_UMRESOURCE_UMRESOURCEPARENTID_S_C]");
						if($umresourceid.val()=="basic"){
							$umresourceid.val("<%=umresourceid%>");
						}
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
			$("[id=resourceParentId]").click(function() {
				var parentId = $(this).attr("id");
				var checkedIds = $(":hidden[id=" + parentId + "]").val();
				var src = "treeResource.jsp";
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