<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.googosoft.resource.SubResourceManager" %>
<%
	String path = request.getContextPath();
	String serverPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String imagePath = serverPath+"/ggs/common/ggs/upload/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/journal/journal.css">
<title>学科研究</title>
<style type="text/css">
 * {
 	margin:0px;
 	padding:0px;
 }
 .jounalContent li {
  	list-style-type: none;
  	width:198px;
  	line-height: 28px;
  	margin-top:3px;
  	text-align: center;
  	font-size:14px; 
  	font-family: 宋体;
  	background: url('../image/subjectResearch/5-2.gif') no-repeat;
  }
  .jounalContent li:hover {
  	 background: url('../image/subjectResearch/5-3.gif') no-repeat;
  	 font-weight: bold;
  }
  .jounalContent span {
  	  	padding-right:35px;
  	  	padding-left:20px;
  }
 .jounalContent  li:hover span {
  	background: url("../image/subjectResearch/5-4.gif") no-repeat right;
  }
  /*****ie6专用********/
  .jounalContent li.hover {
  	 background: url('../image/subjectResearch/5-3.gif') no-repeat;
  	 font-weight: bold;
  }
  .jounalContent li.hover span {
  	background: url("../image/subjectResearch/5-4.gif") no-repeat right;
  }
  .subjectList {
  	width:190px;
  	min-height:200px;
  	margin: 0px 0px 3px 0px;
  	background: url("../image/subjectResearch/5-1.gif") no-repeat;
  	padding:55px 18px 15px 16px;
  	border:1px solid #e6e7e7;
  }
  
  .srList {
    width:720px;
    min-height:500px;
    float:right;
    margin:5px 0px 5px 10px;
    padding:21px;
  	border:1px solid #e6e7e7;
  }
  
 .subjectImg {
    width:358px;
    height:160px;
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
  .linePosition{
	height: 30px;
	width:762px;
	float:right;
	margin:3px 0px 0px 3px;
	line-height:30px;
	background:url('../ggs/skin/blue/image/images/4-1.gif') repeat-x;
   }
   .linePosition span{
	font-weight: bold;
	font-size:14px;
	}
   .text{
    width:226px;
  	min-height:190px;
  	line-height:25px;
  	font-size:14px;
	font-family: 宋体;
  	margin:10px 10px 0px 0px;
  	border:1px solid #e6e7e7;
  	background: url('../image/subjectResearch/6-1.gif') no-repeat;
    }
    .textWord{
    width:65px;
    min-height:100px;
    float:left;
    font-size:14px;
	font-family: 宋体;
    }
    .textImg{
    width:140px;
    min-height:100px;
    margin-bottom:3px;
    float:left;
    }
</style>
</head>
<body>
	<!--top  -->
	<jsp:include page="../common/top/head.jsp"></jsp:include>
	<div class="jounalContent" >
	      <div class="linePosition">
		         <div class="jtImg"></div><span>首页 > 学科研究</span>
	       </div>
	       <div class="srList">
	     <%
				SubResourceManager SubjectResourceManager=new SubResourceManager();
         		List sublist=SubjectResourceManager.findCourse();
				Map submap=null;
				for(int i=0;i<sublist.size();i++){
					submap = (Map)sublist.get(i);
					String imgPath = Validate.isNullToDefault(submap.get("IMGPATH"),"").toString();
					if(Validate.noNull(imgPath)){
						imgPath = imgPath.substring(imgPath.lastIndexOf("\\")+1);
					}	
	     %>	
	             <div class="subjectImg">
	                   <div class="subjectEntry" ><img src="../image/subjectResearch/8-1.gif" width="6" height="17">&nbsp;<%=submap.get("COURSE_NAME")%>
	                          <div style="float:right; padding:2px;"><a href="list.jsp?course_id=<%=submap.get("COURSE_ID")%>">进入学校>></a></div>
	                   </div>
	                   <div><img src="<%=imagePath+String.valueOf(imgPath)%>" width="358" height="133"></div>
	             </div>
	       <%
				}
		   %> 	  
	        </div>
	        <div  class="subjectList" >
	             <ul >
	    <%
				SubResourceManager SubResourceManager=new SubResourceManager();
	            List list=SubResourceManager.findCourse();
				Map map=null;
				for(int i=0;i<list.size();i++){
					map = (Map)list.get(i);
	     %>	
     			        <li ><span><a href="list.jsp?course_id=<%=map.get("COURSE_ID")%>"><%=map.get("COURSE_NAME")%></a></span></li>
              <%
				}
			  %> 
	             </ul>
	        </div>
	        <div class="text">&nbsp;短信沟通 
	             <p>&nbsp;</p>
	             <div class="textWord"><p>&nbsp;学科：</p><p>&nbsp内容：</p></div>
	             <div class="textImg">
	                    <input type="text" name="textfield" style="width:140px;"/>
	                    <textarea name="textarea" rows="5" style=" width:140px;margin-top:5px;"></textarea>
	             </div>
	       <div align="center"><img src="../image/subjectResearch/6-2.gif" ></div>  
           </div>
	       <div style="clear: both;"></div>
	</div>
	<!-- bottom -->
	<jsp:include page="../common/bottom/footer.jsp"></jsp:include>
</body>
</html>