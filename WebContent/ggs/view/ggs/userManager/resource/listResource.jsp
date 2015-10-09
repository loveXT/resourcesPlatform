<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.ggs.userManager.ResourceManager"%>
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
<%
	String resourceParentId = request.getParameter("resourceParentId");
String resourceuseable = null;
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	String operateType = request.getParameter("operateType");
	ResourceManager resourceManager = new ResourceManager();
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		Map initMap = new CUDHelper(request,"_",null).getInitMap();
		String resourceParentIdToDel = initMap.get("P_UMRESOURCE_UMRESOURCEID_S_WD").toString();
		if(0==resourceManager.findResourceSizeByResourceParentId(resourceParentIdToDel)){
			bool = new CUDHelper(request,"_",null).execute();
		}else{
			%>
			<script type="text/javascript">
				alert("该资源下含有子节点信息，删除失败");
			</script>
			<%
		}
	}
%>
<body>
	<div class="tool"></div>
	<form id="pageForm" action="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="resourceParentId" value="<%=resourceParentId %>">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_UMRESOURCE_UMRESOURCEID_S_WD" value="">
		<input type="hidden" name="P_UMMANAGER_UMRESOURCEID_S_WD" value="">
	</form>
<div class="sm_list">
		<%
			PageInfo pageInfo = resourceManager.findPageInfoByumresource(nowPage,
					pageSize,resourceParentId,resourceuseable);
			List resourceList = pageInfo.getList();
		%>
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 100px;">名称</td>
				<td style="width: 400px;">链接地址</td>
				<td style="width: 100px;">显示顺序</td>
				<td style="width: 100px;">是否生效</td>
			</tr>
		</table>
		<table>
			<%
				Map resourceMap;
				for (int i = 0; i < resourceList.size(); i++) {
					resourceMap = (Map) resourceList.get(i);
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i + 1%></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" value="<%=resourceMap.get("UMRESOURCEID")%>">
				</td>
				<td style="width: 100px;"><%=resourceMap.get("UMRESOURCENAME")%></td>
				<td style="width: 400px;"><%=Validate.isNullToDefault(resourceMap.get("UMRESOURCEURL"),"")%></td>
				<td style="width: 100px;" class="sm_number"><%=Validate.isNullToDefault(resourceMap.get("UMORDER"),"")%></td>
				<%
				String umresourcesueable = resourceMap.get("UMRESOURCEUSEABLE")==null?"":resourceMap.get("UMRESOURCEUSEABLE").toString();
				if("T".equals(umresourcesueable)){
					umresourcesueable = "是";
				}else{
					umresourcesueable = "否";
				}
				%>
				<td style="width: 100px;" class="sm_center"><%=umresourcesueable%></td>
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
				handler : function() {
					var src = "addResource.jsp";
					src += "?resourceParentId=<%=resourceParentId%>";
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
						var src = "updateResource.jsp";
						src += "?umResourceid="+id;
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
						$("[name=P_UMRESOURCE_UMRESOURCEID_S_WD]").val(ids.join("','"));
						$("[name=P_UMMANAGER_UMRESOURCEID_S_WD]").val(ids.join("','"));
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