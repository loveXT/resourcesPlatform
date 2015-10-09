<%@page import="com.googosoft.schools.SchoolsManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
request.setCharacterEncoding("utf-8");
String operateType = request.getParameter("operateType");
SchoolsManager ltm =new SchoolsManager();
String id = request.getParameter("id");
boolean bool = false;
if(Validate.noNull(operateType)){
	CUDHelper cudHelper = new CUDHelper(request,"_",null);
	bool = cudHelper.execute();
	%>
	<script type="text/javascript">
		parent.location.reload(false);
		
		window.setTimeout(function(){
			parent.removeJumpWindow();
		}, 1000);
	</script>
	<%
}
Map updateMap = ltm.findMapByID(id);

%>
<body>
<div class="tool"></div>
	<form class="sm_edit_from" style="height: 140px;width: 365px;margin-top: 40px;margin-left: 80px;" method="post" action="">
		<input type="hidden" name="operateType" value="U">
		<input type="hidden" name="P_SCHOOLS_ID_S_WU" value="<%=Validate.isNullToDefault(updateMap.get("ID"), "")%>">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">学校名称</div>
			<div class="sm_edit_td_value">
			<input type="text" style="width: 260px;" class="maxLength:50num null" name="P_SCHOOLS_SCHOOLNAME_S_S" value="<%=Validate.isNullToDefault(updateMap.get("SCHOOLNAME"), "")%>"></div>
		</div>
		<div class="sm_edit_tr" style="height: 310px;" >
			<div class="sm_edit_td_name" style="height: 100px; ">类别描述</div>
			<div class="sm_edit_td_value" >
			<textarea style="height: 100px;width: 262px;"  class="maxLength:200num null" name="P_SCHOOLS_REMARK_S_S" ><%=Validate.isNullToDefault(updateMap.get("REMARK"), "")%></textarea>
			</div>
		</div>
	</form>
	<div style="padding-left: 40px">
		<div style="text-align:center; ">
			<input type="button" class="sm_anniu_div_save" id="submit" style="height:35px ;width: 100px;font-size: 14pt;" value="保存">
		</div>
	</div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			$("#submit").click(function(){
				if(validateBySubmit($("form"))){
					$("form").submit();
				}
			});
			setPageSize();
		});
		function setPageSize() {}
	</script>
</body>
</html>