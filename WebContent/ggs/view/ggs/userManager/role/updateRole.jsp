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
<title>修改部门信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	String operateType = request.getParameter("operateType");
Boolean bool = false;
if(Validate.noNull(operateType)){
	bool = new CUDHelper(request,"_",null).execute();
}
String roleId = request.getParameter("roleId");
RoleManager roleManager = new RoleManager();
Map updateMap = roleManager.findMapByroleId(roleId);
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
		<input type="hidden" name="operateType" value="U">
		<input type="hidden" name="P_UMROLE_ROLEID_S_WU" value="<%=updateMap.get("ROLEID")==null?"":updateMap.get("ROLEID")%>">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">角色名称</div>
			<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMROLE_ROLENAME_S_S" value="<%=updateMap.get("ROLENAME")==null?"":updateMap.get("ROLENAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">角色生效</div>
			<div class="sm_edit_td_value">
			<%
			String roleuseable = updateMap.get("ROLEUSEABLE")==null?"":updateMap.get("ROLEUSEABLE").toString();
			%>
				<select class="null" name="P_UMROLE_ROLEUSEABLE_S_S">
					<option value="T" <%if("T".equals(roleuseable)){%>selected="selected"<%} %> >是</option>
					<option value="F" <%if("F".equals(roleuseable)){%>selected="selected"<%} %> >否</option>
				</select>
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