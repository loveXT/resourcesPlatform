<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
String SMsession = (String)session.getAttribute("sm");

SMsession = "blue";
String pathSkin = request.getContextPath()+"/ggs";
String pathSkinTool = request.getContextPath()+"/ggs/skin/blue"; 
%>
<%--公共--%>
<link type="text/css" rel="stylesheet" href="<%=pathSkin%>/common/css/default.css" />
<%--个性化--%>
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/css/sm_main.css" />
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/css/sm_lead.css" />
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/css/sm_search.css" />
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/css/sm_edit.css" />
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/css/sm_list.css" />
<%--插件--%>
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/tool/uploadify/uploadify.css"/>
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/tool/page/page.css" />
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/tool/hoverColor/hoverColor.css" />
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/tool/jumpWindow/jumpWindow.css"/>
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/tool/optionBar/optionBar.css" />
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/tool/toolBar/toolBar.css" />
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/tool/tree/tree.css" />
<link type="text/css" rel="stylesheet" href="<%=pathSkinTool%>/tool/validate/validate.css" />

<%--GPX--%>
<link type="text/css" rel="stylesheet" href="<%=pathSkin%>/common/css/main.css" />
