<%@page import="com.googosoft.ggs.userManager.UMManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.googosoft.ggs.userManager.ResourceManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.ggs.userManager.OperateManager"%>
<%@page import="com.googosoft.ggs.userManager.RoleManager"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>操作资源</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	String roleuseable = "T";
	String operateuseAble = "T";
	String resourceId = request.getParameter("resourceId");
	int pageSize = Integer
			.valueOf(request.getParameter("pageSize") == null
					? "0"
					: request.getParameter("pageSize"));
	int nowPage = Integer
			.valueOf(request.getParameter("nowPage") == null
					? "0"
					: request.getParameter("nowPage"));
	RoleManager roleManager = new RoleManager();
	OperateManager operateManager = new OperateManager();
	ResourceManager resourceManager = new ResourceManager();
	UMManager umManager = new UMManager();
	//判断该资源是否可进行权限操作
	Map resourceMap = resourceManager.findMapByumResourceId(resourceId);
	Object resourceUrl = resourceMap.get("UMRESOURCEURL");
	Boolean isResourceUrl = Validate.noNull(resourceUrl);
	//声明变量（默认不进行权限操作，设置数据为空）
	PageInfo pageInfo = new PageInfo();
	List roleList = new ArrayList();
	Map operateMap = new HashMap();
	//判断该资源id是否为空
	if(isResourceUrl && Validate.noNull(resourceId)){
		//进行权限操作，获取数据
		pageInfo = roleManager.findPageInfoByUmRole(nowPage,pageSize,roleuseable);
		roleList = pageInfo.getList();
		operateMap = operateManager.findIdAndNameMapByUmOperate(operateuseAble);
	}
	Map roleMap;
%>
<body>
<div class="tool"></div>
<form id="pageForm" action="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="resourceId" value="<%=resourceId %>">
		<input type="hidden" name="operateType" value="">
	</form>
<div class="sm_list">
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 100px;">角色名称</td>
				<td style="width: 700px;">关联操作</td>
				<td style="width: 100px;">操作</td>
			</tr>
		</table>
		<table>
			<%
				String roleid;
				List umList;
				for (int i = 0; i < roleList.size(); i++) {
					roleMap = (Map) roleList.get(i);
					roleid = roleMap.get("ROLEID").toString();
					umList = umManager.findListByUmManager(roleid,resourceId);
			%>
			<tr id="<%=roleid%>">
				<td style="width: 30px;" class="sm_index"><%=i + 1%></td>
				<td style="width: 100px;"><%=roleMap.get("ROLENAME")%></td>
				<td style="width: 700px;" class="sm_center">
				<%
				String operateId,operateIds="",operateCN="";
				Map umMap;
				for(int j=0;j<umList.size();j++){
					umMap = (Map)umList.get(j);
					operateId = umMap.get("UMOPERATEID").toString();
					operateIds += operateId + ",";
					if(Validate.noNull(operateMap.get(operateId))){
						operateCN += operateMap.get(operateId).toString();
						operateCN += ",";
					}
				}
				%>
				<input type="text" readonly="readonly" style="width: 695px;border: 0px;" id="umManager<%=roleid%>" value="<%=operateCN %>">
				<input type="hidden" id="umManager<%=roleid%>" value="<%=operateIds %>">
				</td>
				<td id="operate" style="width: 100px;" class="sm_center"><a href="#">操作管理</a></td>
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
	$(".tool").toolBar([{}]);
	setPageSize();
	$("[id=operate]").click(function() {
		$(".jumpWindow_main").remove();
		var $this = $(this);
		var roleId=$this.parent().attr("id");
		var $prev = $this.prev("td");
		var parentId = "umManager"+roleId;
		var checkedIds = $(":hidden[id=" + parentId + "]").val();
		var src = "treeOperateByResource.jsp";
		src += "?checkedIds=" + checkedIds;
		src += "&parentId=" + parentId;
		src += "&resourceId=<%=resourceId%>";
		src += "&roleId="+roleId;
		selectWindow("操作信息", src, $prev);
	});
});
function setPageSize() {
	setWidth($(".sm_list"),$("body"));
	setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]);
}
</script>
</body>
</html>