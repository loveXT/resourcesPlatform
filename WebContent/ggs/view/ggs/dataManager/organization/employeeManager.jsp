
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>列表部门信息</title>
<%@include file="/ggs/include/css.inc" %>
<%
	String managerId = request.getParameter("managerId");
	String employeeType = request.getParameter("employeeType");
	String url = employeeType+"?managerId="+managerId;
%>
<body>
	<div class="optionBar"></div>
	<div class="main"></div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			addIframe($(".main"),"employeeType","<%=url%>");
			$(".optionBar").optionBar([ {
				text : "查看员工",
				width : 80,
				handler : function() {
					$(window.parent.document).find("#employeeTypeHidden").val("employeeInfoList.jsp");
					parent.reloadEmployeeManager();
				}
			} , {
				text : "管理员工",
				width : 80,
				handler : function() {
					$(window.parent.document).find("#employeeTypeHidden").val("employeeAddMain.jsp");
					parent.reloadEmployeeManager();
				}
			} ]);
			$(".optionBar_button_newColor").removeClass("optionBar_button_newColor");
			var employee = 0;
			if("employeeAddMain.jsp"=="<%=employeeType%>"){
				employee = 1;
			}
			$(".optionBar_button").eq(employee).addClass("optionBar_button_newColor");
			setPageSize();
		});
		function setPageSize() {
			setHeight($(".main"),$("body"));
		}
	</script>
</body>
</html>