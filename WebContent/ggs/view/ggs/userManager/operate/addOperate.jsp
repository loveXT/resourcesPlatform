<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.ggs.userManager.DepartmentManager"%>
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
String departmentId = request.getParameter("departmentId");
DepartmentManager departmentManager = new DepartmentManager();
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
		<input type="hidden" name="operateType" value="C">
		<input type="hidden" name="P_UMOPERATE_UMOPERATEID_S_P" value="">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">操作名称</div>
			<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMOPERATE_UMOPERATENAME_S_C" value="<%=Validate.isNullToDefault(request.getParameter("P_UMOPERATE_UMOPERATENAME_S_C"),"") %>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">备注名称</div>
			<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMOPERATE_UMOPERATECN_S_C" value="<%=Validate.isNullToDefault(request.getParameter("P_UMOPERATE_UMOPERATECN_S_C"),"") %>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">是否生效</div>
			<div class="sm_edit_td_value">
				<select class="null" name="P_UMOPERATE_UMOPERATEUSEABLE_S_C">
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
				model:"save_<%=Power.getOperates(request)%>",
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