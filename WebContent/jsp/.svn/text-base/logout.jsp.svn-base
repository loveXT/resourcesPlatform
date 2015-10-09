<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.commons.Validate"%>
<%
	response.setContentType("text/html;charset=UTF-8");
	String logout = Validate.isNullToDefault(request.getParameter("logout"), "").toString();
	if(logout.equals("yes")){
		session.removeAttribute(ISessionContants.USERIDBYLOGIN);
	}
%>