<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="/ggs/include/css.inc" %>
</head>

<%
	//接受chapter_id章节编号,course_id课程编号,major_id专业编号
	String majorId = request.getParameter("majorId");
	String cid = request.getParameter("courseId");
	String chapterId = request.getParameter("chapterId");
	//根据operateType的类型进行cud进行处理
	String operateType = request.getParameter("operateType");
	boolean bool = false;
	if (Validate.noNull(operateType)) {
		CUDHelper cudHelper = new CUDHelper(request, "=", null);
		bool = cudHelper.execute();
	}
%>
<body>
	<div class="tool"></div>
	<center class="sm_edit_center">
		<form class="sm_edit_from" method="post" action="">
			<input type="hidden" name="operateType" value="C"> 
			<input type="hidden" name="cid" value="<%=cid%>"> 
			<input type="hidden" name="P=KNOWLEDGE_POINT=POINT_ID=S=P" value="">
			<input type="hidden" name="P=KNOWLEDGE_POINT=CHAPTER_ID=S=P" value="<%=chapterId%>">
			<input type="hidden" name="P=KNOWLEDGE_POINT=COURSE_ID=S=C" value="<%=cid%>">
			<input type="hidden" class="maxLength:32num"
				name="P=KNOWLEDGE_POINT=USERIDBYLOGIN=S=C"
				value="<%=session.getAttribute("USERIDBYLOGIN")%>"> 
			<input type="hidden" class="maxLength:32num" name="P=KNOWLEDGE_POINT=SAAS=S=C"
				value="<%=session.getAttribute("SAAS")%>">
			<div class="sm_edit_tr" style="border-left: 0px;">
				<div class="sm_edit_td_name">知识点名称：</div>
				<div class="sm_edit_td_value">
					<input type="text" class="maxLength:250num null" id="pointName"
						name="P=KNOWLEDGE_POINT=POINT_NAME=S=C" style="width:450px"
						value="<%=request.getParameter("P=KNOWLEDGE_POINT=POINT_NAME=S=C") == null ? ""
					: request.getParameter("P=KNOWLEDGE_POINT=POINT_NAME=S=C")%>">
					<input id="aaaa">
				</div>
			</div>
			<div class="sm_edit_tr" style="border-left: 0px;height:315px">
				<div class="sm_edit_td_name" style="height:300px;">知识点内容：</div>
				<div class="sm_edit_td_value" style="height:300px;width:450px"><textarea style="overflow: auto;width:450px;height: 300px;" rows="20" cols="20" class="maxLength:500num" name="P=KNOWLEDGE_POINT=POINT_CONTENT=S=C" ><%=request.getParameter("P=KNOWLEDGE_POINT=POINT_CONTENT=S=C")==null?"":request.getParameter("P=KNOWLEDGE_POINT=POINT_CONTENT=S=C")%></textarea></div>
			</div>
		</form>
	</center>
	<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			//cud处理成功后关闭本页面,父页面刷新
			if(<%=bool%>){
				parent.location.href = "listFile.jsp?MAJOR_ID=<%=majorId%>&COURSE_ID=<%=cid%>&CHAPTER_ID=<%=chapterId%>";
			}
			var chapterflag=false;
			$("#pointName").bind('blur',function(){
				var pointName = encodeURIComponent($(this).val());
				pointName = encodeURIComponent(pointName);
				var url = "<%=path%>/filesmanager/fileManager/validateByAdd.jsp?TABLENAME=KNOWLEDGE_POINT&WHERECOLUMN1=CHAPTER_ID&VALUE1=<%=chapterId%>&WHERECOLUMN2=POINT_NAME&VALUE2="+pointName;
				$.ajax({
					url: url,
					type:"post",
					success:function(data){
						if(data>0){
							alert("该章节下，此知识点已存在！");
							$("#pointName").val("");							
						}else{
							if(!chapterflag){
								chapterflag=!chapterflag;
							}
						}
					}
				});
			});
			
			//给tool标签增加"返回"和"保存"按钮操作
			$(".tool").toolBar([ {
				text : "返回",
				width : 60,
				position : "-200px -20px",
				handler : function() {
					history.go(-1);
				}
			},{
				text : "保存",
				width : 60,
				position : "-140px -160px",
				handler : function() {
					if(validateBySubmit($("form"))&&chapterflag){
						$("form").submit();
					}
				}
			} ]);
			$('#aaaa').hide();
			setPageSize();
			
		});
		function setPageSize() {
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]);
		}
	</script>
</body>
</html>