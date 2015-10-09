<%@page import="com.googosoft.filesManager.course.FolderController"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改文件信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	String operateType = request.getParameter("operateType");
	String planId = request.getParameter("planId");
	String majorId=request.getParameter("majorid");
    String major_Id = request.getParameter("MAJOR_ID");
	String course_Id = request.getParameter("COURSE_ID");
	String chapter_Id = request.getParameter("CHAPTER_ID");
	String class_Id = request.getParameter("CLASSID");
	String classId = request.getParameter("classId");
	String state=request.getParameter("state");
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"_",null).execute();
	}
	FolderController folderCtr = new FolderController();
	Map updateMap = folderCtr.findMapByPLANID(planId);
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_TEACHPLAN_PLANID_S_WU" value="<%=planId==null?"":planId%>">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">文件名称</div>
			<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_TEACHPLAN_PLANNAME_S_S" value="<%=updateMap.get("PLANNAME")==null?"":updateMap.get("PLANNAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">扩展名名称</div>
			<div class="sm_edit_td_value"><input readonly="readonly" type="text" class="null maxLength:50num" name="P_TEACHPLAN_EXTENDNAME_S_S" value="<%=updateMap.get("EXTENDNAME")==null?"":updateMap.get("EXTENDNAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">班级名称</div>
			<div class="sm_edit_td_value">
				<select id="class" name="P_TEACHPLAN_CLASSID_S_S">
					<%
						List classlist = folderCtr.findListByMajor_Id(request, majorId);
						Map classMap;
						for(int i=0;i<classlist.size();i++){
							classMap = (Map)classlist.get(i);
					%>
					<option value="<%=classMap.get("GID") %>"><%=classMap.get("BJMC") %></option>
					<%
						}
					%>
				</select>
			</div>
		</div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			if("<%=bool%>"=="true"){
				var src = "listFile.jsp?planId=<%=planId%>&MAJOR_ID=<%=major_Id%>&COURSE_ID=<%=course_Id%>&CHAPTER_ID=<%=chapter_Id%>&CLASSID=<%=class_Id%>&state=<%=state%>";
				parent.location.href = src;				
			}
			$(".tool").toolBar([ {
				text : "保存",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("[name=operateType]").val("U");
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
		});
		function setPageSize() {
			
		}
		//回显分类
		var folderObj = $("#class");
		var folderlength = $("#class option").length;
		var folder = '<%=classId==null?"":classId%>';
		var str4 = "";
		for(var i=0;i<folderlength;i++){
			str4 = folderObj[0].options[i].value;
			if(str4 == folder){
				folderObj[0].options[i].selected = true;
			}
		}
	</script>
</body>
</html>