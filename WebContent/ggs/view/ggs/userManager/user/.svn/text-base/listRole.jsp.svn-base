<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.ggs.userManager.UserRoleManager"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.ggs.userManager.RoleManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>列表部门信息</title>
<%@include file="/ggs/include/css.inc" %>
<%
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"_","-").execute();
	}
	String userId = request.getParameter("userId");
	String roleuseable = "T";
	RoleManager roleManager = new RoleManager();
	PageInfo pageInfo = roleManager.findPageInfoByUmRole(nowPage,
			pageSize,roleuseable);
	List roleList = pageInfo.getList();
%>
<body>
	<div class="tool"></div>
	<form id="pageForm" action="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="userId" value="<%=userId %>">
		<input type="hidden" name="operateType" value="D_C">
		<input type="hidden" name="P_UMUSERROLE-1_UMUSERID_S_WD" value="<%=userId %>">
	</form>
<div class="sm_list">
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 100px;">角色名称</td>
				<td style="width: 200px;">创建时间</td>
			</tr>
		</table>
		<table>
			<%
				Map roleMap;
				UserRoleManager userRoleManager = new UserRoleManager();
				Boolean isuseable = false;
				for (int i = 0; i < roleList.size(); i++) {
					roleMap = (Map) roleList.get(i);
					String roleId = roleMap.get("ROLEID").toString();
					isuseable = userRoleManager.isUseableByUserAndRole(userId,roleId);
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i + 1%></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" <%if(isuseable){%>checked="checked"<%} %> value="<%=roleId%>">
				</td>
				<td style="width: 100px;"><%=roleMap.get("ROLENAME")%></td>
				<td style="width: 200px;" class="sm_center"><%=roleMap.get("ROLECREATETIME")%></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
<%@include file="/ggs/include/page.inc"%>
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
			},{
				text : "关联账号",
				width : 80,
				position : "-380px -120px",
				model:"relate_<%=Power.getOperates(request)%>",
				handler : function() {
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					var ids = [];
					var $this;
					for(var i=0;i<$checkeds.length;i++){
						var $userRole = $('<input type="hidden" name="P_UMUSERROLE-'+i+'_UMUSERROLEID_S_P" value="">');
						var $userId = $('<input type="hidden" name="P_UMUSERROLE-'+i+'_UMUSERID_S_C" value="<%=userId %>">');
						var $roleId = $('<input type="hidden" name="P_UMUSERROLE-'+i+'_UMROLEID_S_C" value='+$($checkeds[i]).val()+'>');
						$("#pageForm").append($userId).append($roleId).append($userRole);
					}
					$("#pageForm").submit();
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