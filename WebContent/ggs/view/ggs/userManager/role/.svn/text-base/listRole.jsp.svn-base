<%@page import="com.googosoft.zapi.CUDHelper"%>
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
<style type="text/css">
</style>
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
		bool = new CUDHelper(request,"_",null).execute();
	}
%>
<body>
	<div class="tool"></div>
	<form id="pageForm" class="sm_search" style="" action="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_UMROLE_ROLEID_S_WD" value="">
		<input type="hidden" name="P_UMMANAGER_UMROLEID_S_WD" value="">
		<input type="hidden" name="P_UMUSERROLE_UMROLEID_S_WD" value="">
	</form>
<div class="sm_list">
		<%
			RoleManager roleManager = new RoleManager();
			PageInfo pageInfo = roleManager.findPageInfoByUmRole(nowPage,
					pageSize,null);
			List roleList = pageInfo.getList();
		%>
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 100px;">角色名称</td>
				<td style="width: 100px;">角色生效</td>
				<td style="width: 200px;">创建时间</td>
			</tr>
		</table>
		<table>
			<%
				Map roleMap;
				for (int i = 0; i < roleList.size(); i++) {
					roleMap = (Map) roleList.get(i);
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i + 1%></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" value="<%=roleMap.get("ROLEID")%>">
				</td>
				<td style="width: 100px;"><%=roleMap.get("ROLENAME")%></td>
				<%
				String roleuseable = roleMap.get("ROLEUSEABLE")==null?"":roleMap.get("ROLEUSEABLE").toString();
				if("T".equals(roleuseable)){
					roleuseable = "是";
				}else{
					roleuseable = "否";
				}
				%>
				<td style="width: 100px;" class="sm_center"><%=roleuseable%></td>
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
				text : "新增",
				width : 60,
				position : "-340px -100px",
				model:"add_<%=Power.getOperates(request)%>",
				handler : function() {
					var src = "addRole.jsp";
					location.href = src;
				}
			}, {
				text : "修改",
				width : 60,
				position : "-360px -100px",
				model:"update_<%=Power.getOperates(request)%>",
				handler : function() {
					var id = "";
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					if($checkeds.length!=1){
						alert("只能选择一条信息进行操作");
					}else{
						var id = $checkeds.val();
						var src = "updateRole.jsp";
						src += "?roleId="+id;
						location.href = src;
					}
				}
			},{
				text : "删除",
				width : 60,
				position : "-320px -100px",
				model:"delete_<%=Power.getOperates(request)%>",
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
						$("[name=P_UMROLE_ROLEID_S_WD]").val(ids.join("','"));
						$("[name=P_UMMANAGER_UMROLEID_S_WD]").val(ids.join("','"));
						$("[name=P_UMUSERROLE_UMROLEID_S_WD]").val(ids.join("','"));
						$("#pageForm").submit();
					}
				}
			}  ]);
			setPageSize();
		});
		function setPageSize() {
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]);
		}
	</script>
</body>
</html>