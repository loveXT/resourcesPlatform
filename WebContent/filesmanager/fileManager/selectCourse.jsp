<%@page import="com.googosoft.questionbank.questionbank.PointManager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 获得关联类型及主键id 
String type = request.getParameter("type");
System.out.println("+++++++++type:"+type);
String pkId = request.getParameter("pkId");
System.out.println("+++++++++pkId"+pkId);
SelectFilesManager select = new SelectFilesManager();
List list = new ArrayList();
if("1".equals(type)){//根据专业Id查找课程
	list = select.findCourseByMajorId(pkId);
}else if("2".equals(type)){//根据课程Id查找章节
	list = select.findChapterByCourseId(pkId);
}else if("3".equals(type)){//根据章节Id查找分类
	list = select.findFolderByChapterId();				
}else if("4".equals(type)){//根据章节Id查找知识点
	list = new PointManager().findPointByChapterId(pkId);
}
// 将json字符串传给前段页面
Gson gson=new Gson();
response.getWriter().print(gson.toJson(list));	
%>
