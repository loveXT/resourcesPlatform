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
<title>新增年级</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
request.setCharacterEncoding("utf-8");
String operateType = request.getParameter("operateType");
boolean bool = false;
if(Validate.noNull(operateType)){
	CUDHelper cudHelper = new CUDHelper(request,"_",null);
	bool = cudHelper.execute();
}
%>
<body>
<div class="tool"></div>
	<form   class="sm_edit_from" style="height: 30px;width: 365px;margin-top: 40px;margin-left: 80px;" method="post" action="">
		<input type="hidden" name="operateType" value="C">
		<input type="hidden" name="P_GRADE_ID_S_P" value="">
		<input type="hidden" name="P_GRADE_CREATETIME_D_C" value="">
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name">年级</div>
			<div class="sm_edit_td_value" >
			<input type="text" style="width: 260px;" class="maxLength:200num null" name="P_GRADE_NJMC_S_C" value="<%=request.getParameter("P_GRADE_NJMC_S_C")==null?"":request.getParameter("P_GRADE_NJMC_S_C")%>"></div>
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