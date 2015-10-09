<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.ggs.userManager.OperateManager"%>
<%@page import="com.googosoft.tree.TreeInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源树</title>
<%@include file="/ggs/include/css.inc" %>
<%
String operateType = request.getParameter("operateType");
if(Validate.noNull(operateType)){
	new CUDHelper(request,"_","-").execute();
	%>
	<script type="text/javascript">
		window.parent.removeJumpWindow();
	</script>
	<%
}
%>
</head>
<%
String roleId = request.getParameter("roleId");
String resourceId = request.getParameter("resourceId");
//改动处begin
String operateuseable = "T";
OperateManager operateManager = new OperateManager(); 
List trees = operateManager.findTreeByUmOperate(operateuseable);
String checkedIds = request.getParameter("checkedIds");
String parentId = request.getParameter("parentId");
Boolean only = false;
Boolean bottom = false;
Boolean basic = false;
//改动处end
%>
<body>
<%
String[] checkeds = {};
if(checkedIds != null && !"".equals(checkedIds)){
	checkeds = checkedIds.split(",");
}
String inputType;
if(only){
	inputType = "radio";
}else{
	inputType="checkbox";
}
%>
<div class="infoTree">
	<div class="tool">
		<div class="searchDiv">检索：<input type="text" style="width: 80px;"></div>
	</div>
	<div class="checkTree_0"><%if(basic){%><input name="select" type="<%=inputType%>" value="basic" checked="checked"><%}%>根节点</div>
	<%
		TreeInfo tree;
		for(int i=0;i<trees.size();i++){
			tree = (TreeInfo)trees.get(i);
			%>
			<div class=checkTree_<%=tree.getLayer() %> search="<%=tree.getName()%>">
			<input name="select" type="<%=inputType%>" value="<%=tree.getId() %>"
			<%
				for(int j=0;j<checkeds.length;j++){
					String treeId = tree.getId();
					if(treeId.equals(checkeds[j])){
						%>
						checked = "checked";
						<%
					}
				}
			%>
			>
			<%=tree.getName() %>
			</div>
			<%
		}
	%>
	</div>
	<form action="treeOperateByResource.jsp" method="post">
		<input type="hidden" name="checkedIds" value="<%=checkedIds %>">
		<input type="hidden" name="parentId" value="<%=parentId %>">
		<input type="hidden" name="resourceId" value="<%=resourceId %>">
		<input type="hidden" name="roleId" value="<%=roleId %>">
		<input type="hidden" name="operateType" value="D_C">
		<input type="hidden" name="P_UMMANAGER-1_UMRESOURCEID_S_WD" value="<%=resourceId %>">
		<input type="hidden" name="P_UMMANAGER-1_UMROLEID_S_WD" value="<%=roleId %>">
	</form>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function(){
		setPageSize();
		$(".tool").toolBar([
  		   {
  				text:"确定",
  				width:50,
  				position : "-80px -100px",
  				handler:function(){
  					selectWindowToValues("<%=parentId%>",$(".infoTree"),<%=only%>,<%=bottom%>);
					var $checkeds = $(":checkbox").filter(":checked");
					var i = 0;
					var $managerId,$resourceId,$roleId,$operateId,$useAble;
					$checkeds.each(function(){
						i++;
						$managerId = $('<input type="hidden" name="P_UMMANAGER-'+i+'_UMMANAGERID_S_P" value="">');
						$resourceId = $('<input type="hidden" name="P_UMMANAGER-'+i+'_UMRESOURCEID_S_C" value="<%=resourceId %>">');
						$roleId = $('<input type="hidden" name="P_UMMANAGER-'+i+'_UMROLEID_S_C" value="<%=roleId %>">');
						$operateId = $('<input type="hidden" name="P_UMMANAGER-'+i+'_UMOPERATEID_S_C" value="'+$(this).val()+'">');
						$("form").append($managerId).append($resourceId).append($roleId).append($operateId);
					});
					$("form").submit();
  				}
  			}
  		]);
  		
		treeSearch($(".searchDiv input"),"checkTree");
	});
	function selectWindowToValues(parentId,$infoTree,only,bottom){
		var bool = true;
		var $parent = $(window.parent.document);
		var $parentText = $parent.find(":text[id="+parentId+"]");
		var $parentHidden = $parent.find(":hidden[id="+parentId+"]");
		var inputType;
		if(only){
			inputType = "radio";
		}else{
			inputType="checkbox";
		}
		var $checkeds = $infoTree.find(":"+inputType).filter(":checked");
		var $this,$tree,length,names=[],values=[];
		if(only && $checkeds.length != 1){
			alert("只能选择一条信息");
			bool = false;
			return;
		}
		$checkeds.each(function(){
			$this = $(this);
			if($this.val()=="basic"){
				$tree = $this.parent();
				names.push($.trim($tree.text()));
			}else{
				$tree = $this.parent().parent();
				length = $tree.find(".file").length;
				if(bottom){
					if(length==1){
						names.push($.trim($tree.text()));
					}
				}else{
					names.push($.trim($tree.text()));
				}
			}
			if(names.length==0){
				alert("最少选择一条数据");
				bool = false;
				return;
			}
			values.push($this.val());
		});
		$parentText.val(names.join(","));
		$parentHidden.val(values.join(","));
		$("[name=checkedIds]").val(values.join(","));
		if(bool){
// 			$parent.find(".jumpWindow_main").remove();
		}
	}
	
	function setPageSize() {
		setWidth($(".infoTree"),$("body"));
		setHeight($(".infoTree"),$("body"),[$(".tool")]);
	}
</script>
</body>
</html>