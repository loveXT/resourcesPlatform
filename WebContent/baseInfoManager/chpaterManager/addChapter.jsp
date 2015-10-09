<%@page import="com.googosoft.baseInfoManager.ChapterManager"%>
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
<title>新增章节</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
request.setCharacterEncoding("utf-8");
String operateType = request.getParameter("operateType");
String kcId = request.getParameter("kcId");
boolean bool = false;
if(Validate.noNull(operateType)){
	CUDHelper cudHelper = new CUDHelper(request,"=",null);
	bool = cudHelper.execute();
}
%>
<body>
<div class="tool"></div>
	<form   class="sm_edit_from" style="height: 140px;width: 365px;margin-top: 40px;margin-left: 80px;" method="post" action="">
		<input type="hidden" name="operateType" value="C">
		<input type="hidden" name="P=CHAPTER=CHAPTER_ID=S=P" value="">
		<input type="hidden" name="P=CHAPTER=CREATETIME=D=C" value="">
		<input type="hidden" name="P=CHAPTER=COURSE_ID=S=C" value="<%=kcId%>">
		<%
			ChapterManager chapterManager = new ChapterManager();
			String StringCode = (String)chapterManager.findMaxCode(kcId);
			int maxCode = Integer.valueOf(StringCode);
			StringCode = String.format("%06d", maxCode+1);
			%>
			<input type="hidden" readonly class="null maxLength:60num" name="P=CHAPTER=CHAPTER_CODE=S=C" value="<%=StringCode%>"/>
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name">章节名称</div>
			<div class="sm_edit_td_value" >
			<input type="text" style="width: 260px;" class="maxLength:200num null" name="P=CHAPTER=CHAPTER_NAME=S=C" value="<%=request.getParameter("P=CHAPTER=CHAPTER_NAME=S=C")==null?"":request.getParameter("P=CHAPTER=CHAPTER_NAME=S=C")%>"></div>
		</div>
		<div class="sm_edit_tr"  style="height: 310px;width: 280px; " >
			<div class="sm_edit_td_name" style="height: 100px; ">描述</div>
			<div class="sm_edit_td_value" >
			<textarea style="height: 100px;width: 262px;" class="maxLength:200num null" name="P=CHAPTER=REMARK=S=C" ></textarea>
			</div>
		</div>	
	</form>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","doneByParent.jsp");
			$(".tool").toolBar([ {
				text : "保存",
				width : 50,
				position : "-80px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
		});
		function setPageSize() {	}
	</script>
</body>
</html>