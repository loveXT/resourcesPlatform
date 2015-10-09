<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.file.FileBean"%>
<%@page import="com.googosoft.zapi.FileHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

FileHelper fileHelper = new FileHelper();
String toPath = request.getParameter("TOPATH");
Date date = new Date();
String newName = date.getTime()+"";
FileBean fileBean = fileHelper.upLoadFile(toPath,newName,request,response);
request.setCharacterEncoding("UTF-8"); 
response.setCharacterEncoding("UTF-8");
out.println(fileBean.getNewName()+","+fileBean.getNewPath());
%>