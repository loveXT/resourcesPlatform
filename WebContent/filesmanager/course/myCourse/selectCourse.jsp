<%@page import="com.googosoft.questionbank.questionbank.PointManager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String type = request.getParameter("type");
String pkId = request.getParameter("pkId");
SelectFilesManager select = new SelectFilesManager();
List list = new ArrayList();
if("1".equals(type)){
	list = select.findCourseByMajorId(pkId);
}else if("2".equals(type)){
	list = select.findChapterByCourseId(pkId);
}else if("3".equals(type)){
	list = select.findFolderByChapterId();
}else if("4".equals(type)){
	list = new PointManager().findPointByChapterId(pkId);
}else if("5".endsWith(type)){
	list=select.findClassByMajorId(pkId);
}
Gson gson=new Gson();
response.getWriter().print(gson.toJson(list));	
%>
