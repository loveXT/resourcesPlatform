<%@page import="com.googosoft.ggs.userManager.DepartmentManager"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.tree.TreeInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.left{
		float: left;
		width: 22%;
		height: 100%;
		border-right: 1px solid #efefef;
	}
	.right{
		float: left;
		width: 77%;
		height: 100%;
	}
	.top{
		height: 49%;
	}
	.bottom{
		height: 49%;
		border-top: 1px solid #efefef;
	}
</style>
</head>

<body>
<div class="left">
<div class="infoTree">
		<div class="tool">
			检索：<input type="text" style="width: 80px;">
		</div>
		<div class="tree_0">部门信息</div>
	<%
		//改动处begin
		DepartmentManager deManager = new DepartmentManager();
		List trees = deManager.findTreeByumdepartment();
		//改动处end
		TreeInfo tree;
		for(int i=0;i<trees.size();i++){ 
			        tree = (TreeInfo)trees.get(i);
	%>
			<div class=tree_<%=tree.getLayer() %> title="<%=tree.getName()%>"  search="<%=tree.getName()%>" id=<%=tree.getId() %> flag="<%=tree.getFlag() %>">
			    <%=tree.getName()%>
			</div>
	<%
		   }
	%>
	</div>
	</div>
<div class="right">

</div>
	<%@include file="/ggs/include/js.inc" %>
	<script type="text/javascript">
	$(function(){
		$(".tool").toolBar([{
			text : "刷新",
			width : 60,
			position : "-120px -120px",
			handler : function() {
				window.location.reload();
			}
		}]);
		addIframe($(".right"),"teacherinfoList","teacherinfoList.jsp");
		setPageSize();
		//鼠标点击事件
		$("[class^=tree]").treeClick({
			handler:function(){
                var src = "teacherinfoList.jsp";
				src += "?deptId="+$(".tree_newColour").attr("id");	
				src += "&flag="+$(".tree_newColour").attr("flag");
				$("#teacherinfoList").attr("src",src);
			}
		});
		treeSearch($(".tool input"),"tree");
	});
	function setPageSize(){
// 		setWidth($(".right"),$("body"),[$(".left")]);
		setHeight($(".left"),$("body"),[$(".tool")]);
	}
</script>
</body>
</html>