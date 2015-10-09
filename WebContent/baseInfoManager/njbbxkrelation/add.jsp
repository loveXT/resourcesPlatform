<%@page import="com.googosoft.baseInfoManager.CourseManager"%>
<%@page import="com.googosoft.baseInfoManager.VersionManager"%>
<%@page import="com.googosoft.baseInfoManager.GradeManager"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增学科</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
.uploadifyQueueItem{
  	width: 240px !important;
}
</style>
</head>
<%
request.setCharacterEncoding("utf-8");
String operateType = request.getParameter("operateType");
boolean bool = false;
if(Validate.noNull(operateType)){
	CUDHelper cudHelper = new CUDHelper(request,"_",null);
	bool = cudHelper.execute();
	
}
String path = request.getContextPath();
%>
<body>
<div class="tool"></div>
	<form   class="sm_edit_from" style="height: 225px;width: 365px;margin-top: 40px;margin-left: 80px;" method="post" action="">
		<input type="hidden" name="operateType" value="C">
		<input type="hidden" name="P_NJBBXKRELATION_KCID_S_P" value="">
		<input type="hidden" name="P_NJBBXKRELATION_CREATETIME_D_C" value="">
		<input type="hidden" name="P_NJBBXKRELATION_KCNAME_S_C" value="">
		
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name">课程</div>
			<div class="sm_edit_td_value" >
				<select id="course" class="null" style="width: 260px;" name="P_NJBBXKRELATION_COURSEID_S_C">
					<option value="">----选择课程----</option>
					<%
					CourseManager courseManager = new CourseManager();
					List courseList = courseManager.findListCourseManager();
					Map courseMap;
					for(int i=0;i<courseList.size();i++){
						courseMap = (Map)courseList.get(i);
						%>
						<option value="<%=courseMap.get("COURSE_ID")%>"><%=courseMap.get("COURSE_NAME")%></option>
						<%
					}
					%>
				</select>
			</div>
		</div>
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name">年级</div>
			<div class="sm_edit_td_value" >
				<select id="grade" class="null" style="width: 260px;" name="P_NJBBXKRELATION_GRADEID_S_C">
					<option value="">----选择年级----</option>
					<%
					GradeManager gradeManager = new GradeManager();
					List gradeList = gradeManager.findListGradeManager();
					Map gradeMap;
					for(int i=0;i<gradeList.size();i++){
						gradeMap = (Map)gradeList.get(i);
						%>
						<option value="<%=gradeMap.get("ID")%>"><%=gradeMap.get("NJMC")%></option>
						<%
					}
					%>
				</select>
			</div>
		</div>
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name">版本</div>
			<div class="sm_edit_td_value" >
				<select id="version" class="null" style="width: 260px;" name="P_NJBBXKRELATION_VERSIONID_S_C">
					<option value="">----选择版本----</option>
					<%
					VersionManager versionManager = new VersionManager();
					List versionList = versionManager.findListVersionManager();
					Map versionMap;
					for(int i=0;i<versionList.size();i++){
						versionMap = (Map)versionList.get(i);
						%>
						<option value="<%=versionMap.get("ID")%>"><%=versionMap.get("VERSIONNAME")%></option>
						<%
					}
					%>
				</select>
			</div>
		</div>
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name" style="height: 100px; ">描述</div>
			<div class="sm_edit_td_value" >
			<textarea style="height: 100px;width: 262px;" class="maxLength:200num" name="P_NJBBXKRELATION_REMARK_S_C" ></textarea>
			</div>
		</div>	
	</form>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","doneByParent.jsp");
			$(".tool").toolBar([ {
				text : "保存",
				width : 50,
				position : "-80px -100px",
				handler : function() {
					var njmc = $("#grade").find("option:selected").text();
					var xkmc = $("#course").find("option:selected").text();
					var bbmc = $("#version").find("option:selected").text();
					var kcmc = njmc+xkmc+bbmc;
					$("[name=P_NJBBXKRELATION_KCNAME_S_C]").val(kcmc);
					if(validateBySubmit($("form"))){
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
		});
		function setPageSize() {	}
	</script>
</body>
</html>