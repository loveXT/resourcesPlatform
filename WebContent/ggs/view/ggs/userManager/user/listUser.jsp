<%@page import="com.googosoft.commons.StringUtil"%>
<%@page import="com.googosoft.ggs.homeManager.Power"%>
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
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	String operateType = request.getParameter("operateType");
	if(Validate.noNull(operateType)){
		new CUDHelper(request,"_",null).execute();
	}
	UserDepartmentManager userDepartmentManager = new UserDepartmentManager();
%>
<body>
	<div class="tool"></div>
	<form id="pageForm" action="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="departmentId" value="<%=departmentId %>">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_UMUSER_USERID_S_WD" value="">
		<input type="hidden" name="P_UMUSERROLE_UMUSERID_S_WD" value="">
		<input type="hidden" name="P_UMUSERDEPARTMENT_UMUSERID_S_WD" value="">
	</form>
<div class="sm_list">
		<%
			UserManager userManager = new UserManager();
			PageInfo pageInfo = userManager.findPageInfoByUmUser(nowPage,
					pageSize,"_",request,departmentId);
			List userList = pageInfo.getList();
		%>
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 100px;">用户名</td>
				<td style="width: 100px;">登录名</td>
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
						departmentNames += StringUtil.objToString(departmentMap.get("UMDEPARTMENTNAME"))+",";
					}
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i + 1%></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" value="<%=userId%>">
				</td>
				<td style="width: 100px;"><%=userMap.get("USERNAME")%></td>
				<td style="width: 100px;"><%=userMap.get("LOGINNAME")%></td>
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
			$(".tool").toolBar([ {
				text : "新增",
				width : 60,
				model:"add_<%=Power.getOperates(request)%>",
				position : "-340px -100px",
				handler : function() {
					var src = "addUser.jsp";
					src += "?departmentId=<%=departmentId%>";
					if(<%=Validate.noNull(departmentId)%>){
						location.href = src;
					}else{
						alert("选择部门");
					}
				}
			}, {
				text : "修改",
				width : 60,
				model:"update_<%=Power.getOperates(request)%>",
				position : "-360px -100px",
				handler : function() {
					var id = "";
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					if($checkeds.length!=1){
						alert("只能选择一条信息进行操作");
					}else{
						var id = $checkeds.val();
						var src = "updateUser.jsp";
						src += "?userId="+id;
						location.href = src;
					}
				}
			}, {
				text : "删除",
				width : 60,
				model:"delete_<%=Power.getOperates(request)%>",
				position : "-320px -100px",
				handler : function() {
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
						$("[name=operateType]").val("D");
						$("[name=P_UMUSER_USERID_S_WD]").val(ids.join("','"));
						$("[name=P_UMUSERROLE_UMUSERID_S_WD]").val(ids.join("','"));
						$("[name=P_UMUSERDEPARTMENT_UMUSERID_S_WD]").val(ids.join("','"));
						$("#pageForm").submit();
					}
				}
			}, {
				text : "关联角色",
				width : 80,
				model:"relate_<%=Power.getOperates(request)%>",
				position : "-380px -120px",
				handler : function() {
					var id = "";
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					if($checkeds.length!=1){
						alert("选择一条信息进行操作");
					}else{
						var id = $checkeds.val();
						var src = "listRole.jsp";
						src += "?userId="+id;
						location.href = src;
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