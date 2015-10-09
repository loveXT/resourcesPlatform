<%@page import="com.googosoft.baseInfoManager.PointManager"%>
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
<title>修改章节</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
request.setCharacterEncoding("utf-8");
String operateType = request.getParameter("operateType");
String id = request.getParameter("id");
PointManager pointManager = new PointManager();
Map map = pointManager.findMapByID(id);
boolean bool = false;
if(Validate.noNull(operateType)){
	CUDHelper cudHelper = new CUDHelper(request,"=",null);
	bool = cudHelper.execute();
}
%>
<body>
<div class="tool"></div>
	<form   class="sm_edit_from" style="height: 140px;width: 365px;margin-top: 40px;margin-left: 80px;" method="post" action="">
		<input type="hidden" name="operateType" value="U">
		<input type="hidden" name="P=KNOWLEDGE_POINT=POINT_ID=S=WU" value="<%=id%>">
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name">知识点名称</div>
			<div class="sm_edit_td_value" >
			<input type="text" style="width: 260px;" class="maxLength:200num null" name="P=KNOWLEDGE_POINT=POINT_NAME=S=S" value="<%=Validate.isNullToDefault(map.get("POINT_NAME"), "")%>"></div>
		</div>
		<div class="sm_edit_tr"  style="height: 310px;width: 280px; " >
			<div class="sm_edit_td_name" style="height: 100px; ">知识点内容</div>
			<div class="sm_edit_td_value" >
			<textarea style="height: 100px;width: 262px;" class="maxLength:200num" name="P=KNOWLEDGE_POINT=POINT_CONTENT=S=S" ><%=Validate.isNullToDefault(map.get("POINT_CONTENT"), "")%></textarea>
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