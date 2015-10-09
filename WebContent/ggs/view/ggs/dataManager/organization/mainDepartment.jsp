<%@page import="com.googosoft.tree.TreeInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.ggs.userManager.DepartmentManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门信息</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.left{
		float: left;
		width: 200px;
		border-right: 1px solid #efefef;
		height: 100%;
	}
	.right{
		float: left;
		width: 70%;
		height: 100%;
	}
	.top{
		height: 50%;
	}
	.bottom{
		height: 50%;
	}
</style>
</head>
<body>
<div class="top">
	<div class="left">
		<div class="infoTree">
			<div class="tool">
				检索：<input type="text" style="width: 80px;">
			</div>
			<div class="tree_0" id="">管理者部门信息</div>
		<%
			//改动处begin
			DepartmentManager departmentManager = new DepartmentManager(); 
			List trees = departmentManager.findTreeByumdepartment();
			//改动处end
			TreeInfo tree;
			for(int i=0;i<trees.size();i++){
				tree = (TreeInfo)trees.get(i);
				%>
				<div class=tree_<%=tree.getLayer() %> search="<%=tree.getName()%>" id=<%=tree.getId() %> >
				<%=tree.getName() %>
				</div>
				<%
			}
		%>
		</div>
	</div>
	<div class="right">
	</div>
</div>
<div class="bottom">
</div>
<input type="hidden" id="managerId" value="">
<input type="hidden" id="employeeTypeHidden" value="employeeInfoList.jsp">
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function(){
		$(".tool").toolBar([{}]);
		setPageSize();
		addIframe($(".top .right"),"managerList","managerList.jsp");
		addIframe($(".bottom"),"employeeManager","employeeManager.jsp?employeeType="+$("#employeeTypeHidden").val());
		//鼠标点击事件
		$(".top [class^=tree_]").treeClick({
			handler:function(){
				var src = "managerList.jsp";
				src += "?departmentId="+$(".top .tree_newColour").attr("id");
				$("#managerList").attr("src",src);
			}
		});
		treeSearch($(".top .tool input"),"tree");
	});
	function setPageSize(){
		setWidth($(".top .right"),$("body"),[$(".top .left")]);
	}
	function addEmployeeManager(managerId){
		$("#managerId").val(managerId);
		reloadEmployeeManager();
	}
	function reloadEmployeeManager(){
		var src = "employeeManager.jsp";
		src += "?managerId="+$("#managerId").val();
		src += "&employeeType="+$("#employeeTypeHidden").val();
		$("#employeeManager").attr("src",src);
	}
</script>
</body>
</html>