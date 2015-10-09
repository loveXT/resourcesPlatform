<%@page import="com.googosoft.tree.TreeInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
.main_checkTree{
	overflow: auto;
	width: 100%;
	height: 200px;
}
</style>

<%
System.out.println("checkbox树使用规范：trees：树集合，不能为空，checkedIds：默认选中，可以为空,parentId：父页面接收id，不能为空，only：是否只选择一条，不能为空,bottom：是否只选择最底层，不能为空,basic：是否可选根目录，不能为空");
String[] checkeds = {};
if(checkedIds != null && !"".equals(checkedIds)){
	checkeds = checkedIds.split(",");
}
String inputType=null;
if(only){
	inputType = "radio";
}else{
	inputType="checkbox";
}
%>
<div class="tool">
	<div class="searchDiv">检索：<input type="text" style="width: 80px;"></div>
</div>
<div class="main_checkTree">
<div class="infoTree">
	<div class="checkTree_0"><%if(basic){%><input name="select" type="<%=inputType%>" value="basic" checked="checked"><%}%>根节点</div>
	<%
		TreeInfo tree;
		for(int i=0;i<trees.size();i++){
			tree = (TreeInfo)trees.get(i);
			%>
			<div class="checkTree_<%=tree.getLayer() %>" flag="<%=tree.getFlag()%>" search="<%=tree.getName()%>" >
			<input name="select" style="float:left;" type="<%=inputType%>" value="<%=tree.getId() %>"
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
			<%
				if(only && bottom != null && !bottom.equals(tree.getFlag())){
					%>
						style="display: none;"
					<%
				}
			%>
			>
			<div style="float:left;"><%=tree.getName()%></div>
			</div>
			<%
		}
	%>
	</div>
</div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function(){
		$(".tool").toolBar([
  		   {
  				text:"确定",
  				width:50,
  				position : "-140px -160px",
  				handler:function(){
					selectWindowToValue("<%=parentId%>",$(".infoTree"),<%=only%>,"<%=bottom%>", "<%=windowsId%>", <%=isToParent%>);
  				}
  			}
  		]);
  		
  		$("[class^=checkTree_]").checkTreeClick({
			handler:function(){
			},
			dblhandler:function(){
				selectWindowToValue("<%=parentId%>",$(".infoTree"),<%=only%>,"<%=bottom%>", "<%=windowsId%>", <%=isToParent%>);
			}
		});
  		
  		setPageSize();
		treeSearch($(".searchDiv input"),"checkTree");
	});
	function setPageSize(){
		setHeight($(".main_checkTree"),$("body"),[$(".tool")]);
	}
</script>
