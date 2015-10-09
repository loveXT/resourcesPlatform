<%@page import="com.googosoft.commons.CodeHelper"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增部门信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	String operateType = request.getParameter("operateType");
String userId = CodeHelper.createUUID();
Boolean bool = false;
if(Validate.noNull(operateType)){
	bool = new CUDHelper(request,"_","-").execute();
}
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_UMSAAS-1_UMSAASID_S_P" value="">
		<input type="hidden" name="P_UMSAAS-1_UMUSERID_S_C" value="<%=userId %>">
		<input type="hidden" name="P_UMUSER-1_SAAS_S_C" value="">
		<input type="hidden" name="P_UMUSER-1_USERID_S_P" value="<%=userId %>">
		<input type="hidden" class="null maxLength:50num" name="P_UMUSER-1_USERNAME_S_C" value="saas">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">企事业编号</div>
			<div class="sm_edit_td_value"><input type="text" class="null" name="P_UMSAAS-1_UMSAASCOOD_S_C" value="<%=request.getParameter("P_UMSAAS-1_UMSAASCOOD_S_C")==null?"":request.getParameter("P_UMSAAS-1_UMSAASCOOD_S_C")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">企事业名称</div>
			<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMSAAS-1_UMSAASNAME_S_C" value="<%=request.getParameter("P_UMSAAS-1_UMSAASNAME_S_C")==null?"":request.getParameter("P_UMSAAS-1_UMSAASNAME_S_C")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">登录名</div>
			<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMUSER-1_LOGINNAME_S_C" value="<%=request.getParameter("P_UMUSER-1_LOGINNAME_S_C")==null?"":request.getParameter("P_UMUSER-1_LOGINNAME_S_C")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">登录密码</div>
			<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMUSER-1_LOGINPASSWORD_M_C" value="<%=request.getParameter("P_UMUSER-1_LOGINPASSWORD_M_C")==null?"":request.getParameter("P_UMUSER-1_LOGINPASSWORD_M_C")%>"></div>
		</div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
			$(".tool").toolBar([ {
				text : "返回",
				width : 50,
				position : "-340px -100px",
				handler : function() {
					window.parent.location.reload();
				}
			}, {
				text : "保存",
				width : 50,
				position : "-360px -100px",
				model:"save_<%=Power.getOperates(request)%>",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("[name=operateType]").val("C");
						$("[name=P_UMUSER-1_SAAS_S_C]").val($("[name=P_UMSAAS-1_UMSAASCOOD_S_C]").val());
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
		});
		function setPageSize() {

		}
	</script>
</body>
</html>