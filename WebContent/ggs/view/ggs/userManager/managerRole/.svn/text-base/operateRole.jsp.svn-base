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
<%@page import="com.googosoft.tree.TreeInfo"%>
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>操作资源</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	#pageForm{
		display: block;
	}
</style>
</head>
<%
	String operateuseAble = "T";
	String resourceParentId = "ROLEUSE";
	String resourceuseable = "T";
	String roleId = request.getParameter("roleId");
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null? "500": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null? "0": request.getParameter("nowPage"));
	RoleManager roleManager = new RoleManager();
	OperateManager operateManager = new OperateManager();
	ResourceManager resourceManager = new ResourceManager();
	UMManager umManager = new UMManager();
	//声明变量（默认不进行权限操作，设置数据为空）
	PageInfo pageInfo = new PageInfo();
	List resourceList = new ArrayList();
	Map operateMap = new HashMap();
	List operateList = new ArrayList();
	String operateType = request.getParameter("operateType");
	boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"_","-").execute();
	}
	//判断该角色id是否为空
	if(Validate.noNull(roleId)){
		pageInfo = resourceManager.findPageInfoByumresource(nowPage,pageSize,resourceParentId,resourceuseable);
		resourceList = pageInfo.getList();
		operateList = operateManager.findTreeByUmOperate("T");
		operateMap = operateManager.findIdAndNameMapByUmOperate(operateuseAble);
	}
	Map resourceMap;
%>
<body>
<div class="tool"></div>
<form id="pageForm" action="" method="post">
	<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
	<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
	<input type="hidden" name="roleId" value="<%=roleId %>">
	<input type="hidden" name="operateType" value="">
<div class="sm_list">
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 100px;">资源名称</td>
				<td style="width: 50px;">
					<input type="checkbox" id="all">
				</td>
				<td style="width: 1500px; text-align: left; font-weight: normal" class="normal_checkbox">
				<%
					String operateId,operateName;
					TreeInfo treeInfo;
					for(int j=0;j<operateList.size();j++){
						treeInfo = (TreeInfo)operateList.get(j);
						operateId = treeInfo.getId();
						operateName = treeInfo.getName();
						%>
				<div style="float: left; width: 50px;">
				<input type="checkbox" value="<%=operateId %>" ><%=operateName %>
				</div>
						<%
					}
				%>
				</td>
			</tr>
		</table>
		<table>
			<%
				String resourceId;
				Object resourceUrl;
				List umList,umOperateIds;
				int displayNum = 0;
				for (int i = 0; i < resourceList.size(); i++) {
					resourceMap = (Map) resourceList.get(i);
					resourceId = resourceMap.get("UMRESOURCEID").toString();
					resourceUrl = resourceMap.get("UMRESOURCEURL");
					if(Validate.isNull(resourceUrl)){
						continue;
					}
					displayNum++;
					umList = umManager.findListByUmManager(roleId,resourceId);
					Map umMap = null;
					umOperateIds = new ArrayList();
					for(int j = 0;j<umList.size();j++){
						umMap = (Map)umList.get(j);
						umOperateIds.add(umMap.get("UMOPERATEID").toString());
					}
			%>
			<tr id="<%=resourceId%>">
				<td style="width: 30px;" class="sm_index"><%=displayNum%></td>
				<td style="width: 100px;"><%=resourceMap.get("UMRESOURCENAME")%></td>
				<td style="width: 50px;" class="sm_center">
					<input type="checkbox" value="all" id="resourceId<%=resourceId%>">
					<input type="hidden" name="P_UMMANAGER-<%=i %>_UMRESOURCEID_S_WD" value="<%=resourceId %>">
					<input type="hidden" name="P_UMMANAGER-<%=i %>_UMROLEID_S_WD" value="<%=roleId %>">
				</td>
				<td style="width: 1500px;" class="normal_checkbox">
				<%
					for(int j=0;j<operateList.size();j++){
						treeInfo = (TreeInfo)operateList.get(j);
						operateId = treeInfo.getId();
						operateName = treeInfo.getName();
						%>
				<div style="float: left; width: 50px;">
				<input type="checkbox" value="<%=operateId %>" id="resourceId<%=resourceId%>" <%if(umOperateIds.contains(operateId)){%>checked="checked"<%} %> ><%=operateName %>
				<input type="hidden" name="P_UMMANAGER-<%=i+""+j%>_UMMANAGERID_S_P" value="">
				<input type="hidden" name="P_UMMANAGER-<%=i+""+j%>_UMRESOURCEID_S_C" value="<%=resourceId %>">
				<input type="hidden" name="P_UMMANAGER-<%=i+""+j%>_UMROLEID_S_C" value="<%=roleId %>">
				<input type="hidden" name="P_UMMANAGER-<%=i+""+j%>_UMOPERATEID_S_C" value="<%=operateId %>">
				</div>
						<%
					}
				%>
				</td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
</form>
<%@include file="/ggs/include/page.inc"%>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
$(function() {
	jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
	$(".tool").toolBar([{
		text : "保存",
		width : 50,
		position : "-360px -100px",
		model:"save_<%=Power.getOperates(request)%>",
		handler : function() {
			var $this;
			var bool;
			$(".sm_table_body .normal_checkbox :checkbox").each(function(){
				$this = $(this);
				bool = $this.attr("checked");
				if(!bool){
					$this.parent("div").find(":hidden").remove();
				}
			});
			$("[name=operateType]").val("D_C");
			$("#pageForm").submit();
		}
	}]);
	setPageSize();
	//竖向选择begin
	$(".sm_list .sm_table_head :checkbox").click(function(){
		var $this = $(this);
		var bool = $this.attr("checked");
		var id = $this.val();
		$(".sm_list .sm_table_body [value="+id+"]").attr("checked",bool);
	});
	$(".sm_list .sm_table_body :checkbox").click(function(){
		var $this = $(this);
		var id = $this.val();
		var num = $(".sm_list .sm_table_body [value="+id+"]").length;
		var checks = $(".sm_list .sm_table_body [value="+id+"]").filter(":checked").length;
		if(num==checks){
			$(".sm_list .sm_table_head [value="+id+"]").attr("checked","checked");
		}else{
			$(".sm_list .sm_table_head [value="+id+"]").attr("checked","");
		}
	});
	//竖向选择end
	//横向选择begin
	$(".sm_list .sm_center :checkbox").click(function(){
		var $this = $(this);
		var bool = $this.attr("checked");
		var id = $this.attr("id");
		$(".sm_list [id="+id+"]").attr("checked",bool);
	});
	$(".sm_list .normal_checkbox :checkbox").click(function(){
		var $this = $(this);
		var id = $this.attr("id");
		var num = $(".sm_list .normal_checkbox [id="+id+"]").length;
		var checks = $(".sm_list .normal_checkbox [id="+id+"]").filter(":checked").length;
		if(num==checks){
			$(".sm_list .sm_center [id="+id+"]").attr("checked","checked");
		}else{
			$(".sm_list .sm_center [id="+id+"]").attr("checked","");
		}
	});
	//横向选择end
	//全部选中begin
	$("#all").click(function(){
		$(":checkbox").attr("checked",$(this).attr("checked"));
	});
	//全部选中end
});
function setPageSize() {
	setWidth($(".sm_list"),$("body"));
	setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]);
}
</script>
</body>
</html>