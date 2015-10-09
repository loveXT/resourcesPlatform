<%@page import="com.googosoft.ggs.userManager.UserDepartmentManager"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.ggs.userManager.DepartmentManager"%>
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
	String departmentParentId = request.getParameter("departmentParentId");
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	String operateType = request.getParameter("operateType");
	DepartmentManager departmentManager = new DepartmentManager();
	Boolean bool = false;
	String delsRemark = "";
	if(Validate.noNull(operateType)){
		Map initMap = new CUDHelper(request,"_",null).getInitMap();
		String deleteIds = initMap.get("P_UMDEPARTMENT_UMDEPARTMENTID_S_WD").toString();
		UserDepartmentManager userDepartmentManager = new UserDepartmentManager();
		if(0==departmentManager.findDepartmentSizeByParentid(deleteIds)){
			if(0==userDepartmentManager.findUserSizeBydepartment(deleteIds)){
				bool = new CUDHelper(initMap,"_",null).execute();
			}else{
				delsRemark = "该部门下含有用户信息，删除失败";
			}
		}else{
			delsRemark = "该部门含有子部门，删除失败";
		}
	}
%>
<body>
	<div class="tool"></div>
	<form id="pageForm" action="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="departmentParentId" value="<%=departmentParentId %>">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_UMDEPARTMENT_UMDEPARTMENTID_S_WD" value="">
	</form>
<div class="sm_list">
		<%
			PageInfo pageInfo = departmentManager.findPageInfoByumdepartment(nowPage,
					pageSize,departmentParentId);
			List departmentList = pageInfo.getList();
		%>
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 100px;">名称</td>
			</tr>
		</table>
		<table>
			<%
				Map departmentMap;
				for (int i = 0; i < departmentList.size(); i++) {
					departmentMap = (Map) departmentList.get(i);
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i + 1%></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" value="<%=departmentMap.get("UMDEPARTMENTID")%>">
				</td>
				<td style="width: 100px;"><%=departmentMap.get("UMDEPARTMENTNAME")%></td>
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
			if("<%=delsRemark%>"!=""){
				alert("<%=delsRemark%>");
			}
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","doneByParent.jsp");
			$(".tool").toolBar([ {
				text : "新增",
				width : 50,
				position : "-340px -100px",
				model:"add_<%=Power.getOperates(request)%>",
				handler : function() {
					var src = "addDepartment.jsp";
					src += "?departmentParentId=<%=departmentParentId%>";
					location.href = src;
				}
			}, {
				text : "修改",
				width : 50,
				position : "-360px -100px",
				model:"update_<%=Power.getOperates(request)%>",
				handler : function() {
					var id = "";
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					if($checkeds.length!=1){
						alert("只能选择一条信息进行操作");
					}else{
						var id = $checkeds.val();
						var src = "updateDepartment.jsp";
						src += "?umdepartmentid="+id;
						location.href = src;
					}
				}
			}, {
				text : "删除",
				width : 50,
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
						$("[name=P_UMDEPARTMENT_UMDEPARTMENTID_S_WD]").val(ids.join("','"));
						$("#pageForm").submit();
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