<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.ggs.userManager.OperateManager"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
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
	<form id="pageForm" class="sm_search" style="" action="" method="post">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_UMOPERATE_UMOPERATEID_S_WD" value="">
		<input type="hidden" name="P_UMMANAGER_UMOPERATEID_S_WD" value="">
		<table>
			<%@include file="/ggs/include/search_synthesized.inc" %>
			<tr>
				<td>
					<select id="name">
				  		<option value="T.UMOPERATENAME">操作名称</option>
				  		<option value="T.UMOPERATECN">备注名称</option>
				  	</select>
				</td>
			</tr>
		</table>
	</form>
<div class="sm_list">
		<%
			OperateManager operateManager = new OperateManager();
			PageInfo pageInfo = operateManager.findPageInfoByUmOperate(nowPage,
					pageSize,"_",request);
			List operateList = pageInfo.getList();
		%>
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 100px;">操作名称</td>
				<td style="width: 100px;">备注名称</td>
				<td style="width: 100px;">操作生效</td>
			</tr>
		</table>
		<table>
			<%
				Map operateMap;
				for (int i = 0; i < operateList.size(); i++) {
					operateMap = (Map) operateList.get(i);
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i + 1%></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" value="<%=operateMap.get("UMOPERATEID")%>">
				</td>
				<td style="width: 100px;"><%=operateMap.get("UMOPERATENAME")%></td>
				<td style="width: 100px;"><%=operateMap.get("UMOPERATECN")%></td>
				<%
				String operateuseable = operateMap.get("UMOPERATEUSEABLE")==null?"":operateMap.get("UMOPERATEUSEABLE").toString();
				if("T".equals(operateuseable)){
					operateuseable = "是";
				}else{
					operateuseable = "否";
				}
				%>
				<td style="width: 100px;" class="sm_center"><%=operateuseable%></td>
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
				width : 50,
				position : "-340px -100px",
				model:"add_<%=Power.getOperates(request)%>",
				handler : function() {
					var src = "addOperate.jsp";
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
						var src = "updateOperate.jsp";
						src += "?operateId="+id;
						location.href = src;
					}
				}
			},{
				text : "查询",
				width : 60,
				position : "-240px -100px",
				handler : function() {
					sm_goSearch();
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
						$("[name=P_UMOPERATE_UMOPERATEID_S_WD]").val(ids.join("','"));
						$("[name=P_UMMANAGER_UMOPERATEID_S_WD]").val(ids.join("','"));
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