<%@page import="com.googosoft.questionbank.questionbank.MajorManager"%>
<%@page import="com.googosoft.filesManager.fileManager.MFilesManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源树</title>
<%@include file="/ggs/include/css.inc" %>
</head>
	<select id="major"  name="Major" class="null" onchange="f1()">
			<option value="">全部专业</option>
			<option value="public">公共基础课</option>
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
<%
	String windowsId = request.getParameter("windowsId");
	Boolean isToParent = true;
//改动处begin
	String majorId = request.getParameter("Major_Id");
	String src = request.getParameter("src");
	String folderid = request.getParameter("folderid");
	MFilesManager mfilesmanager = new MFilesManager();
	List trees = mfilesmanager.findfileTreeByPoint(request, majorId);
	String checkedIds = request.getParameter("checkedIds");
	String parentId = request.getParameter("parentId");
	Boolean only = true;
	String bottom = null;
	Boolean basic = false;
//改动处end
%>
<body>
<%@include file="/ggs/include/checkTree.inc" %>
		<form id="major_form" action="" method="post">
				<input type="hidden" name="Major_Id" value=""/>
				<input type="hidden" name="src" value=""/>
		</form>
	<script type="text/javascript">
	$(function(){
		$("[class^=checkTree_1]").find("input").remove();
		$("[class^=checkTree_2]").find("input").remove();
		
		//回显专业
		var msjorObj = $("#major");
		var majorlength = $("#major option").length;
		var major = '<%=majorId%>';
		var str1 = "";
		for(var i=0;i<majorlength;i++){
			str1 = msjorObj[0].options[i].value;
			if(str1 == major){
				msjorObj[0].options[i].selected = true;
			}
		}
	});
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