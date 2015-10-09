<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%
request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");
String fileId = request.getParameter("fileId");
SelectFilesManager sg = new SelectFilesManager();
int num = sg.updateFilesBROWSETIME(fileId);
out.print(num);
%>