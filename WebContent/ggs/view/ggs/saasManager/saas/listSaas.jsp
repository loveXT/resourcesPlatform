<%@page import="com.googosoft.ggs.userManager.UserManager"%>
<%@page import="com.googosoft.ggs.saasManager.SaasManager"%>
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
	if(Validate.noNull(operateType)){
		new CUDHelper(request,"_",null).execute();
	}
%>
<body>
	<div class="tool"></div>
	<form id="pageForm" style="" action="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_UMSAAS_UMUSERID_S_WD">
		<input type="hidden" name="P_UMUSER_USERID_S_WD">
	</form>
<div class="sm_list">
		<%
			SaasManager saasManager = new SaasManager();
			PageInfo pageInfo = saasManager.findPageInfoByumsaas(nowPage,pageSize);
			List saasList = pageInfo.getList();
		%>
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 100px;">企事业编号</td>
				<td style="width: 200px;">企事业名称</td>
				<td style="width: 200px;">登陆名</td>
			</tr>
		</table>
		<table>
			<%
				Map saasMap,userMap;
				String userId,umSaasId;
				UserManager userManager = new UserManager();
				for (int i = 0; i < saasList.size(); i++) {
					saasMap = (Map) saasList.get(i);
					umSaasId = saasMap.get("UMSAASID").toString();
					userId = saasMap.get("UMUSERID").toString();
					userMap = userManager.findMapByuserId(userId);
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i + 1%></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" userId="<%=userId %>" value="<%=umSaasId%>" edit="<%=Validate.isNull(userMap.get("LOGINNAME"))?false:true %>">
				</td>
				<td style="width: 100px;"><%=saasMap.get("UMSAASCOOD")%></td>
				<td style="width: 200px;" class="sm_center"><%=saasMap.get("UMSAASNAME")%></td>
				<td style="width: 200px;"><%=userMap.get("LOGINNAME")==null?"登陆企事业账号后查看":userMap.get("LOGINNAME")%></td>
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
				width : 50,
				position : "-40px -160px",
				model:"add_<%=Power.getOperates(request)%>",
				handler : function() {
					var src = "addSaas.jsp";
					location.href = src;
				}
			}, {
				text : "修改",
				width : 50,
				position : "-20px -160px",
				model:"update_<%=Power.getOperates(request)%>",
				handler : function() {
					var id = "";
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					if($checkeds.length!=1){
						alert("只能选择一条信息进行操作");
					}else{
						var edit = $checkeds.attr("edit");
						if(edit=="true"){
							var id = $checkeds.val();
							var src = "updateSaas.jsp";
							src += "?saasId="+id;
							location.href = src;
						}else{
							alert("不可修改");
						}
					}
				}
			}, {
				text : "删除",
				width : 50,
				position : "-180px -160px",
				model:"delete_<%=Power.getOperates(request)%>",
				handler : function() {
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					if($checkeds.length<1){
						alert("最少选择一条信息进行操作");
					}else{
						var bool = "true";
						var ids = [];
						var $this;
						$checkeds.each(function(){
							$this = $(this);
							var edit = $this.attr("edit");
							if(edit=="false"){
								bool = "false";
							}else{
								ids.push($this.attr("userId"));
							}
						});
						if(bool=="true"){
							$("[name=operateType]").val("D");
							$("[name=P_UMSAAS_UMUSERID_S_WD]").val(ids.join("','"));
							$("[name=P_UMUSER_USERID_S_WD]").val(ids.join("','"));
							$("#pageForm").submit();
						}else{
							alert("有不可删除项");
						}
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