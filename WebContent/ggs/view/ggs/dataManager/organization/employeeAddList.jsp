<%@page import="com.googosoft.ggs.homeManager.Power"%>
<%@page import="com.googosoft.ggs.dataManager.OrganizationManager"%>
<%@page import="com.googosoft.ggs.userManager.UserDepartmentManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.ggs.userManager.UserRoleManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.ggs.userManager.UserManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>列表部门信息</title>
<%@include file="/ggs/include/css.inc" %>
<%
	String departmentId = request.getParameter("departmentId");
	String managerId = request.getParameter("managerId");
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	String operateType = request.getParameter("operateType");
	OrganizationManager organizationManager = new OrganizationManager();
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		Map initMap = new CUDHelper(request,"_","-").getInitMap();
		bool = organizationManager.saveUmdataByCud(initMap,"_","-");
	}
	UserDepartmentManager userDepartmentManager = new UserDepartmentManager();
%>
<body>
	<div class="tool"></div>
	<form id="pageForm" action="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="departmentId" value="<%=departmentId %>">
		<input type="hidden" name="managerId" value="<%=managerId %>">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" class="" name="MANAGERID" value="<%=managerId%>">
		<input type="hidden" class="" name="EMPLOYEEID">
	</form>
<div class="sm_list">
		<%
			UserManager userManager = new UserManager();
			PageInfo pageInfo = userManager.findPageInfoByUmUser(nowPage,
					pageSize,null,request,departmentId);
			List userList = pageInfo.getList();
		%>
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 100px;">用户名</td>
				<td style="width: 300px;">隶属部门</td>
				<td style="width: 300px;">已关联角色</td>
			</tr>
		</table>
		<table>
			<%
				Map userMap,userRoleMap;
				String userId;
				List userRoleList,departmentListByUser;
				UserRoleManager userRoleManager = new UserRoleManager();
				for (int i = 0; i < userList.size(); i++) {
					userMap = (Map) userList.get(i);
					userId = userMap.get("USERID").toString();
					userRoleList = userRoleManager.findListByUmUserRole(userId);
					String roleNames="";
					for(int j=0;j<userRoleList.size();j++){
						userRoleMap = (Map)userRoleList.get(j);
						roleNames += Validate.isNull(userRoleMap.get("ROLENAME"))?"":userRoleMap.get("ROLENAME").toString();
						if(j!=userRoleList.size()-1){
							roleNames += ",";
						}
					}
					departmentListByUser = userDepartmentManager.findListByumuserdepartment(userId);
					String departmentNames="";
					Map departmentMap;
					for(int j=0;j<departmentListByUser.size();j++){
						departmentMap = (Map)departmentListByUser.get(j);
						departmentNames += departmentMap.get("UMDEPARTMENTNAME").toString()+",";
					}
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i + 1%></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" value="<%=userId%>">
				</td>
				<td style="width: 100px;"><%=userMap.get("USERNAME")%></td>
				<td style="width: 300px;"><%=departmentNames %></td>
				<td style="width: 300px;"><%=roleNames%></td>
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
				text : "确认添加",
				width : 80,
				model:"add_<%=Power.getOperates(request)%>",
				position : "-360px -100px",
				handler : function() {
					if("<%=managerId%>"!=""){
						var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
						if($checkeds.length<1){
							alert("最少选择一条信息进行操作");
						}else{
							var ids = [];
							var $this;
							$checkeds.each(function(){
								$this = $(this);
								ids.push($this.val());
							});
							$("[name=operateType]").val("D_C");
							$("[name=EMPLOYEEID]").val(ids);
							$("#pageForm").submit();
						}
					}else{
						alert("选择管理者");
					}
				}
			} ]);
			setPageSize();
		});
		function setPageSize() {
			setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]);
		}
	</script>
</body>
</html>