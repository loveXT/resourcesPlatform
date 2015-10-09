<%@page import="com.googosoft.filesManager.netresvindicate.ResourceManager"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.filesManager.fileManager.MFilesManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.questionbank.questionbank.MajorManager"%>
<%@page import="com.googosoft.questionbank.questionbank.ChapterManager"%>
<%@page import="com.googosoft.questionbank.questionbank.CourseManager"%>
<%@page import="com.googosoft.tree.TreeInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>视频资源</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.right{
		float: left;
		width: 785px !important;
		height: 100%;
		border: 1px solid #dddddd;
	}
 	.logo1{
 		background:url("<%=request.getContextPath()%>/ggs/skin/blue/image/shipin/logo-1.gif") repeat-x;
 		float:left;
 		height:150px; 
 		width:200px;
 	}
 	.logo2{
 		background:url("<%=request.getContextPath()%>/ggs/skin/blue/image/shipin/logo-1.gif") repeat-x;
 		float:left;
 		height:150px; 
 		width:165px;
 	}
 	
 	.leftwhite{
 		width:200px;
 		float:left;
 		height: 100%;
 	}
 	.logo3{
 		background:url("<%=request.getContextPath()%>/ggs/skin/blue/image/shipin/ss_bj.gif") repeat-x;
 		height:35px;
 		width:100%;
 		float:left;
 		margin-top:-15px;
 	}
 	.sousuo{
 		width: 450px;
		height: 20px;
		float: right;
		margin-top: -30px;
		margin-right: 120px;
 	}
 	.sousuo1{
 		background:url("<%=request.getContextPath()%>/ggs/skin/blue/image/shipin/ss_an.gif") no-repeat;
 		width: 34px;
		height: 35px;
		float: right;
		margin-top: -35px;
		margin-right: 220px;
 	}
 	.lefttotal{
		float: left;
		width: 231px;
		height: 540px;
		margin-top: 5px;
		border: 1px solid #dddddd;
	}
 	.lefttop{
 		background:url("<%=request.getContextPath()%>/ggs/skin/blue/image/shipin/db.gif") no-repeat;
 		float:left;
 		width:231px;
 		height:33px;
 		font-size:18px;
 		font-weight:blod;
 	}
 	.left{
		float: left;
		width: 221px;
		height: 500px !important;
		margin-left:10px;
	}
	.leftbottom{
		background:url("<%=request.getContextPath()%>/ggs/skin/blue/image/shipin/gg.gif") no-repeat;
		float:left;
 		width:231px;
 		height:61px;
 		margin-top:10px;
	}
	.righttotal{
		float:left;
		width: 800px !important;
		height: 590px;
		margin-left:10px;
		margin-top:5px;
	}
	.righttop1{
		background:url("<%=request.getContextPath()%>/ggs/skin/blue/image/shipin/spdb_1.gif") no-repeat;
		float:left;
		width:18px;
		height:29px;
	}
	.righttop2{
		background:url("<%=request.getContextPath()%>/ggs/skin/blue/image/shipin/spdb_2.gif") repeat-x;
		float:left;
		width:750px;
		height:29px;
		font-size:18px;
	}
	.righttop3{
		background:url("<%=request.getContextPath()%>/ggs/skin/blue/image/shipin/spdb_3.gif") no-repeat;
		float:left;
		width:18px;
		height:29px;
	}
	#logo1{
		width: 100%;
		text-align: center;
		background:url("/ZCZJ/ggs/skin/blue/image/shipin/logo-1.gif") repeat-x;
	}
	#logo2{
		height:35px;
		width: 100%;
		text-align: right;
		background:url("/ZCZJ/ggs/skin/blue/image/picture/ss_bj.gif") repeat-x;
	}
	#logo2_1{
		height:35px;
		width:400px;
		margin-left:840px;
	}
	.logo2_{
		height: 24px;border: 0;margin-top: 6px;
	}
</style>
</head>
<body>
<%
	String typeId = request.getParameter("Type_Id");
	String src = request.getParameter("src");
	String biaoti = request.getParameter("biaoti");
	
%>
<div id="header">
	<div id="logo1">
		<img id="logo1_img" src="<%=request.getContextPath()%>/ggs/skin/blue/image/shipin/logo.gif">
	</div>
	<div id="logo2">
		<div id="logo2_1">
			<div id="logo2_11" style="float:left;width:350px;height:35px;line-height:35px;">
 				<div style="float:left;margin-left:-30px;margin-right:8px;color:#fff;">检索</div>
				<select id="type"  style="width: 140px;height: 24px;float: left;margin-top: 5px;" name="Type" class="null" onchange="f1()">
					<option value="" >--请选择--</option>
					<option value="01" <%if("01".equals(request.getParameter("Type_Id"))){%>selected<%} %>>文件类别</option>
					<option value="02" <%if("02".equals(request.getParameter("Type_Id"))){%>selected<%} %>>标题</option>
					<option value="03" <%if("03".equals(request.getParameter("Type_Id"))){%>selected<%} %>>格式</option>
					<option value="04" <%if("04".equals(request.getParameter("Type_Id"))){%>selected<%} %>>专业</option>
				</select>
				<div style="float:left;margin-left:10px;margin-right:8px;color:#fff;">关键字</div>
				<%
  					if("01".equals(typeId)){  
  				%>  
  						<select class="" id="keyWord" style="width: 135px;height: 20px;float:left;margin-top:5px;" name="KeyWord" >  -->
  						<option value="">--请选择--</option> 
 						<% 
 	 					List typeList=new ResourceManager().findListByRESOURCEMANAGER();  
 	 					Map typeMap;  
 	 					for (int i=0;i<typeList.size();i++) {  
 	 						typeMap=(Map)typeList.get(i);  
 	 					%>  
	 						<option value="<%=typeMap.get("ID")%>"<%if((typeMap.get("ID")).equals(request.getParameter("biaoti"))){%>selected<%} %>><%=Validate.isNullToDefault(typeMap.get("NAME"),"") %></option> 
	 					<% 
 	 					}  
 	 					%> 
  						</select>  
				<%
  					}else{  
 				%>  
				<input type="text" id="keyword" name="REALNAME" style="width: 135px;height: 20px;float:left;margin-top:5px;" value="<%=Validate.isNullToDefault(request.getParameter("REALNAME"), "")%>">
				<%
  					}  
  				%>  
			</div>
			<div id="logo2_12" style="width:35px;height:35px;float:left;">
				<img id="logo2_img" src="/ZCZJ/ggs/skin/blue/image/picture/ss_an.gif">
			</div>
		</div>
	</div>

</div>
<div class="leftwhite"></div>
<div class="lefttotal">
	<div class="lefttop">
		<div style="margin-left: 20px;margin-top: 5px;color: #ffffff;">点     播</div>
	</div>
	<div class="left" >
		<div class="infoTree">
		<div class="tool">
			检索：<input type="text" style="width: 100px;">
		</div>
			<form id="major_form" action="" method="post">
					<input type="hidden" name="Type_Id" value=""/>
					<input type="hidden" name="src" value=""/>
					<input type="hidden" name="biaoti" value="">
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
				<div name="<%=tree.getLayer() %>" class=tree_<%=tree.getLayer() %> search="<%=tree.getName()%>" 
				id=<%=tree.getId() %> >
				<%=tree.getName()%><!--  -->
				</div>
				<%
			}
		%>
		</div>
	</div>
	<div class="leftbottom"></div>
</div>
<div class="righttotal">
	<div class="righttop1"></div>
	<div class="righttop2">
		<div style="margin-left: 5px;margin-top: 5px;color: #2c86d2;">视频点播</div>
	</div>
	<div class="righttop3"></div>
	<div class="right"></div>
</div>

<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function(){
		$(".tool").toolBar([{}]);
		setPageSize();
		//登陆后，右边首先显示所有成员表
		var src = "<%=src%>";
		var str = $("#type").val();
		if(src==null || src == "null" || src==""){
			addIframe($(".right"),"vedioFile","vedioFile.jsp");
		}else{
			addIframe($(".right"),"vedioFile",src);
		}
		//鼠标点击事件，未用
		$("[class^=tree_]").treeClick({
			handler:function(){
				//点击左边的树（部门），右边显示该部门的人员 
				var src = "vedioFile.jsp";
				var check = $(".tree_newColour").attr("name");
				if(check==1){
					src += "?MAJOR_ID="+$(".tree_newColour").attr("id");
				}else if(check==2){
					src += "?COURSE_ID="+$(".tree_newColour").attr("id");			
				}else if(check==3){
					src +="?CHAPTER_ID="+$(".tree_newColour").attr("id");	
				}	
 				$("#vedioFile").attr("src",src);
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
	function aaa(){
		$("[class^=tree_]").treeClick({
			handler:function(){
				//点击左边的树（部门），右边显示该部门的人员 
				var src = "vedioFile.jsp";
				var check = $(".tree_newColour").attr("name");
// 				if(check==1){
// 					src += "?DEPTID="+$(".tree_newColour").attr("id");
// 				}else 
					if(check==1){
					src +="?MAJOR_ID="+$(".tree_newColour").attr("id");	
				}else if(check==2){
					src += "?COURSE_ID="+$(".tree_newColour").attr("id");
				}else if(check==3){
					src += "?CHAPTER_ID="+$(".tree_newColour").attr("id");			
				}
 				$("#vedioFile").attr("src",src);
			}
		});
	}
	function setPageSize(){
		setWidth($(".right"),$("body"),[$(".left")]);
		setHeight($(".left"),$("body"));
	}
	function f1(){
		var str = $("#type").val();
		var src = "vedioFile.jsp";
		src += "?Type_Id="+str;
		$("[name=Type_Id]").val(str);
		$("[name=src]").val(src);
		$("#major_form").submit();
	}
	$("#logo2_img").click(function(){
		var str = $("#type").val();
		var src = "vedioFile.jsp";
		var biaoti = $("[name=REALNAME]").val();
		if("01"==str){
			biaoti=$("#keyWord").val();
			alert(biaoti);
		}
		src += "?Type_Id="+str+"&biaoti="+biaoti;
		$("[name=Type_Id]").val(str);
		$("[name=biaoti]").val(biaoti);
		$("[name=src]").val(src);
		$("#major_form").submit();
	});
</script>
</body>
</html>