<%@page import="com.googosoft.commons.MD5"%>
<%@page import="com.googosoft.commons.StringUtil"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.ggs.userManager.UserManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>新增考试</title>
		<%@include file="/ggs/include/css.inc" %>
	</head>
	<%
		request.setCharacterEncoding("utf-8");
		String userId = StringUtil.objToString(session.getAttribute(ISessionContants.USERIDBYLOGIN));
		UserManager userManager = new UserManager();
		Map updateMap = userManager.findMapByuserId(userId);
		String operateType = request.getParameter("operateType");
		boolean bool = false;
		if(Validate.noNull(operateType)){
			CUDHelper cudHelper = new CUDHelper(request,"_",null);
			bool = cudHelper.execute();
		} 
	%>
	<body>
		<div class="tool"></div>	
		<center class="sm_edit_center">	
		<form   class="sm_edit_from" style="margin-top: 20px;margin-bottom: 20px;" method="post" action="">
			<input type="hidden" name="operateType" value="U">
			<input type="hidden" name="P_UMUSER_USERID_S_WU" value="<%=userId %>">
			<div class="sm_edit_tr">
				<div class="sm_edit_td_name">用户名</div>
				<div class="sm_edit_td_value">
					<input type="text" readonly class="null maxLength:50num" name="" value="<%=updateMap.get("USERNAME")==null?"":updateMap.get("USERNAME")%>">
				</div>
			</div>
			<div class="sm_edit_tr">
				<div class="sm_edit_td_name">登录名</div>
				<div class="sm_edit_td_value">
					<input type="text" class="null maxLength:50num" name="P_UMUSER_LOGINNAME_S_S" value="<%=updateMap.get("LOGINNAME")==null?"":updateMap.get("LOGINNAME")%>">
				</div>
			</div>
			<div class="sm_edit_tr">
				<div class="sm_edit_td_name">密码</div>
				<div class="sm_edit_td_value">
				<input type="text" class="maxLength:50num" name="P_UMUSER_UMWPWD_S_S" value="<%=updateMap.get("UMWPWD")==null?"":updateMap.get("UMWPWD")%>">
				<input type="hidden" class="null maxLength:50num" name="P_UMUSER_LOGINPASSWORD_M_S" value="<%=updateMap.get("UMWPWD")==null?"":updateMap.get("UMWPWD")%>">
				</div>
			</div>
			</form>
			</center>
			<div style="padding-left: 35px">
				 <div style="text-align:center; ">
						<input type="button" class="sm_anniu_div_save"id="submit" style="height:35px ;width: 100px;font-size: 14pt;" value="保存">
				</div>
			</div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","doneByParent.jsp");
			$("#submit").click(function(){
				if(validateBySubmit($("form"))){
					$("[name='P_UMUSER_LOGINPASSWORD_M_S']").val($("[name='P_UMUSER_UMWPWD_S_S']").val());
					$("form").submit();
				}
			});
			setPageSize();
		});
		function setPageSize() {	}
</script>
	</body>
</html>