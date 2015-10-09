<%@page import="com.googosoft.filesManager.openClass.OpenClassManager"%>
<%
request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");
String fileId = request.getParameter("fileId");
OpenClassManager ocm = new OpenClassManager();
int num = ocm.updateFilesBROWSETIME(fileId);
out.print(num);
%>