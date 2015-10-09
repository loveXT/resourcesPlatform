<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.googosoft.resource.SubResourceManager" %>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/journal/journal.css">
<style type="text/css">
  .subjectContent {
    width:956px;
    min-height:500px;
    float:right;
    padding:21px;
    margin:3px 0px 3px 0px;
  	border:1px solid #e6e7e7;
  }
  .subjectImg {
    width:358px;
    height:153px;
    float:left;
  } 
  .subjectEntry{
    width:358px;
    height:20px;
	font-size:14px;
	font-family: 宋体;
	font-weight: bold;
	line-height: 20px;
   }
</style>
</head>
<body>
	<!--top  -->
	<jsp:include page="../common/top/head.jsp"></jsp:include>
	<div class="jounalContent" >
	
	       <div class="positionImg">
		          <div class="jtImg"></div><span>首页 > 学科研究  </span>
	       </div> 
	       <div  class="subjectContent">
	     <%
	     		String  course_id=request.getParameter("course_id");
				SubResourceManager SubjectResourceManager=new SubResourceManager();
         		List sublist=SubjectResourceManager.findSchool(course_id);
				Map submap=null;
				for(int i=0;i<sublist.size();i++){
					submap = (Map)sublist.get(i);
	     %>	
	               <div class="subjectImg">
	                        <div class="subjectEntry" ><img src="../image/subjectResearch/8-1.gif" width="6" height="17">&nbsp;<%=submap.get("SCHOOLNAME")%>
	                                  <div style="float:right; padding:2px;"><a href="#" >进入网站>></a></div>
	                         </div>
	                         <div><img src="../image/subjectResearch/yuwen.gif" width="358" height="133"></div>
	               </div>
	       <%
			   }
			  %> 	  
	         </div>
	</div>
	<!-- bottom -->
	<jsp:include page="../common/bottom/footer.jsp"></jsp:include>
</body>
</html>