<%@page import="com.googosoft.commons.StringUtil"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.oa.teacherinfo.TeacherInfoManager"%>
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<%@page import="org.apache.commons.collections.CollectionUtils"%>
<%@page import="com.googosoft.page.PageInfo"%>
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
<title>新增教师档案</title>
</head>
<%@include file="/ggs/include/css.inc"  %>
<%

	request.setCharacterEncoding("utf-8");
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null ?"20": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null ? "0": request.getParameter("nowPage"));
	String operateType = request.getParameter("operateType");
	String Id = StringUtil.objToString(session.getAttribute(ISessionContants.USERIDBYLOGIN));
	TeacherInfoManager tm = new TeacherInfoManager();
	boolean result = tm.IdIn(Id);
	Boolean bool = false;
	if (Validate.noNull(operateType)) {
		bool = new CUDHelper(request, "_", null).execute();
	}
%>
<body>
<iframe id="content" name="content" src="addTeacherinfo.jsp">
	
</iframe>
<%@include file="/ggs/include/js.inc" %>

<script type="text/javascript">
		$(function() {
			var Id = "<%=Id%>";
			var result = "<%=result%>"
			if(result=='false'){
				$("#content").attr("src","addTeacherinfo.jsp?Id="+Id);
			}if(result=='true'){
				$("#content").attr("src","updateTeacherinfo.jsp?Id="+Id);
			}
		});
	</script>
</body>
</html>