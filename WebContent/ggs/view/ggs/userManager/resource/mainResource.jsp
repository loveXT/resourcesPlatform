<%@page import="com.googosoft.tree.TreeInfo"%>
<%@page import="com.googosoft.ggs.userManager.ResourceManager"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源信息</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.left{
		float: left;
		width: 200px;
		height: 100%;
		border-right: 1px solid #efefef;
	}
	.right{
		float: left;
		width: 70%;
		height: 100%;
	}
</style>
</head>
<body>
<div class="left">
	<div class="infoTree">
		<div class="tool">
			检索：<input type="text" style="width: 80px;">
		</div>
		<div class="tree_0" id="">资源表</div>
	<%
		//改动处begin
		ResourceManager resourceManager = new ResourceManager(); 
		String resourcesueable = null;
		List trees = resourceManager.findTreeByumresource(resourcesueable);
		//改动处end
		TreeInfo tree;
		for(int i=0;i<trees.size();i++){
			tree = (TreeInfo)trees.get(i);
			%>
			<div class=tree_<%=tree.getLayer() %> title="<%=tree.getName()%>" search="<%=tree.getName()%>" id=<%=tree.getId() %> >
			<%=tree.getName() %>
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
		$(".tool").toolBar([{}]);
		setPageSize();
		addIframe($(".right"),"listResource","listResource.jsp");
		//鼠标点击事件，未用
		$("[class^=tree_]").treeClick({
			handler:function(){
				var src = "listResource.jsp";
				src += "?resourceParentId="+$(".tree_newColour").attr("id");
				$("#listResource").attr("src",src);
			}
		});
		treeSearch($(".tool input"),"tree");
	});
	function setPageSize(){
		setWidth($(".right"),$("body"),[$(".left")]);
		setHeight($(".infoTree"),$("body"));
	}
</script>
</body>
</html>