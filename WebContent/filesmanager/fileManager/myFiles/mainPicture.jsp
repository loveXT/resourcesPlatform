<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.filesManager.netresvindicate.ResourceManager"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.filesManager.fileManager.MFilesManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.tree.TreeInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教学资源</title>
<% String path = request.getContextPath(); %>
<link href="<%=path%>/css/index.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.left{
		float: left;
		width: 220px;
		height: 420px !important;
		margin-left:10px;
	}
	.right{
		float: left;
		width: 814px !important;
		height: 520px;
		border: 0px solid #dddddd;
		border-top:0px solid #dddddd;
	}
	.leftwhite{
 		width:150px;
 		float:left;
 		height: 100%;
 		display:none;
 	}
 	
	.lefttotal{
		float: left;
		width: 230px;
		height: 455px;
		margin-top: 5px;
		border: 1px solid #dddddd;
		margin-left:4px;
	}
	#left_sp1{
		float:left;
		line-height:33px;
		font-size:18px;
		color:#FFF;
		width:229px;
		height:32px;
		background:url("<%=path%>/ggs/skin/blue/image/picture/db.gif")  no-repeat 1px 1px;
	}
	.leftbottom{
		background:url("<%=path%>/ggs/skin/blue/image/shipin/gg.gif") no-repeat;
		float:left;
 		width:231px;
 		height:61px;
  		margin-top:5px; 
	}
	.righttotal{
		float:left;
		width: 816px !important;
		height: 550px;
		margin-left:5px;
		margin-top:5px;
		border:1px solid #dddddd;
		margin-bottom:10px;
	}
	.righttop1{
		background:url("<%=path%>/ggs/skin/blue/image/picture/spdb_2.gif") repeat-x 1px 1px;
		float:left;
		width:100px;
		height:28px;
		font-size:18px;
		margin-left:1px;
	}
	.righttop2{
		background:url("<%=path%>/ggs/skin/blue/image/picture/spdb_4.gif") repeat-x 1px 1px;
		float:left;
		width:714px;
		height:28px;
	}
	body{
	overflow-y: scroll;
	}
	li{
		display:block;
	}
	.layout_line{
		width:100%;
		height:auto;
		margin-top:5px;
		float:left;
	}
	.layout{
		height:250px;
		width:auto;
		float:left;
		margin-left:5px;
		border-left:1px solid #ACDAFE;
		border-right:1px solid #ACDAFE;
		border-bottom:1px solid #ACDAFE;
	}
	
</style>
</head>
<body>
<%
	String typeId = request.getParameter("Type_Id");
	String src = request.getParameter("src");
	String biaoti = request.getParameter("biaoti");
	String typename = request.getParameter("typename");
	String resourceURL =  request.getRequestURL().toString();
	String majorid = request.getParameter("majorid");
	String classify = request.getParameter("classify");
%>
<jsp:include page="../../../index/head.jsp"></jsp:include>
<div class="body_div">
<div class="layout_line">
			<div class="layout" style="width:98%;height:auto;">
				<jsp:include page="../../../jsp/search.jsp"></jsp:include>
			</div>
		</div>
<div class="leftwhite"></div>
<div class="lefttotal">
<div id="" style="">
	<div id="left_header">
		<div id="left_sp1"><span style="margin-left:15px;">资源库</span></div>
	</div>
<div class="left">
	<div class="infoTree">
		<div class="tool">
			检索：<input type="text" style="width: 100px;">
		</div>
		<form id="type_form1" action="" method="post">
				<input type="hidden" name="Type_Id" value=""/>
				<input type="hidden" name="src" value=""/>
				<input type="hidden" name="biaoti" value="">
				<input type="hidden" name="typename" value="">
				<input type="hidden" name="url" value="<%=resourceURL%>">
		</form>
		<div class="tree_0" id="">课程信息</div>
	<%
		//改动处begin
		MFilesManager mfilesmanager = new MFilesManager();
		List trees = mfilesmanager.findfileTreeBycourse(request, typeId);
		//改动处end
		TreeInfo tree;
		for(int i=0;i<trees.size();i++){
			tree = (TreeInfo)trees.get(i);		
			%>
			<div name="<%=tree.getLayer() %>" class=tree_<%=tree.getLayer() %> flag="<%=tree.getFlag() %>" search="<%=tree.getName()%>" 
			id=<%=tree.getId() %> >
			<%=tree.getName()%><!--  -->
			</div>
			<%
		}
	%>
		
	</div>
</div>
</div>
<div class="leftbottom"></div>
</div>
<div class="righttotal">
	<div class="righttop1">
		<div style="margin-left: 25px;margin-top: 5px;color: #ffffff;">资       源</div></div>
	<div class="righttop2"></div>
	<div class="right"></div>
</div>
</div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function(){
		$(".tool").toolBar([{}]);
		setPageSize();
		//登陆后，右边首先显示所有成员表
		var resourceURL = "<%=resourceURL%>";
		var src = "<%=src%>";
		if(src==null || src == "null" || src==""){
			addIframe($(".right"),"allFile","allFile.jsp?Type_Id="+'<%=typeId%>'+"&biaoti="+'<%=biaoti%>'+"&url="+resourceURL+"&majorid="+'<%=majorid%>'+"&classify="+'<%=classify%>');
		}else{
			addIframe($(".right"),"allFile",src+"&url="+resourceURL+"&majorid="+'<%=majorid%>'+"&classify="+'<%=classify%>');
		}
		//鼠标点击事件，未用
		$("[class^=tree_]").treeClick({
			handler:function(){
				//点击左边的树（部门），右边显示该部门的人员 
				var src = "allFile.jsp?url="+resourceURL;
				src += "&id="+$(".tree_newColour").attr("id");
				src += "&flag="+$(".tree_newColour").attr("flag");
				src += "&Type_Id="+'<%=typeId%>'+"&biaoti="+'<%=biaoti%>';
 				$("#allFile").attr("src",src);
			}
		});
		treeSearch($(".tool input"),"tree");
		var sexObj = $("#type");
		var length = $("#type option").length;
		var sexNow = "<%=typeId%>";
		var str = "";
		for(var i=0;i<length;i++){
			str = sexObj[0].options[i].value;
			if(str == sexNow){
				sexObj[0].options[i].selected = true;
			}
		}
	});
	function setPageSize(){
		setWidth($(".right"),$("body"),[$(".left")]);
		setHeight($(".left"),$("body"));
	}
</script>
</body>
</html>