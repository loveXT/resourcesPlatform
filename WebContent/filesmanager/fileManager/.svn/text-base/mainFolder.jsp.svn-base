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
<title>部门信息</title>
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
<%
	String majorId = request.getParameter("Major_Id");
	String src = request.getParameter("src");
%>
<div class="left">
	<div class="infoTree">
		<div class="tool">
			检索：<input type="text" style="width: 80px;">
		</div>
		<div class="" id="">专业信息</div>
		<select id="major"  name="Major" class="null" onchange="f1()">
						<option value="">— —全部专业— —</option>
						<%
						List majorList=new MajorManager().findlistBymajor("=", request);
						Map majorMap;
						for (int i=0;i<majorList.size();i++) {
							majorMap=(Map)majorList.get(i);
							%>
						<option value="<%=majorMap.get("MAJOR_ID")%>"><%=majorMap.get("MAJOR_NAME") %></option>
							<%
						}
						%>
		</select>
		<form id="major_form" action="" method="post">
				<input type="hidden" name="Major_Id" value=""/>
				<input type="hidden" name="src" value=""/>
		</form>
		<div class="tree_0" id="">课程信息</div>
	<%
		//改动处begin
		CourseManager courseManager = new CourseManager();
		List trees = courseManager.findfileTreeBycourse(request, majorId);
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
<div class="right">

</div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function(){
		$(".tool").toolBar([{}]);
		setPageSize();
		//登陆后，右边首先显示所有成员表
		var src = "<%=src%>";
		var str = $("#major").val();
		if(src==null || src == "null" || src==""){
			addIframe($(".right"),"listFolder","listFolder.jsp");
		}else{
			addIframe($(".right"),"listFolder",src);
		}
		//鼠标点击事件，未用
		$("[class^=tree_]").treeClick({
			handler:function(){
				//点击左边的树（部门），右边显示该部门的人员 
				var src = "listFolder.jsp";
				var check = $(".tree_newColour").attr("name");
				if(check==1){
					src += "?COURSE_ID="+$(".tree_newColour").attr("id");
				}else if(check==2){
					src += "?CHAPTER_ID="+$(".tree_newColour").attr("id");			
				}	
 				$("#listFolder").attr("src",src);
			}
		});
		treeSearch($(".tool input"),"tree");
		var sexObj = $("#major");
		var length = $("#major option").length;
		var sexNow = "<%=majorId%>";
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
	}
	function f1(){
		var str = $("#major").val();
		var src = "listFolder.jsp";
		src += "?MAJOR_ID="+str;
// 		$("#listquestion").attr("src",src);
		$("[name=Major_Id]").val(str);
		$("[name=src]").val(src);
		$("#major_form").submit();
		
	}
</script>
</body>
</html>