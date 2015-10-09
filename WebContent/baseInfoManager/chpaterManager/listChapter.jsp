<%@page import="com.googosoft.baseInfoManager.ChapterManager"%>
<%@page import="com.googosoft.baseInfoManager.CourseManager"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>章节信息</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
.point{
    height:282px;
}
.page{
	bottom:285px;
}
.sm_list{
	height:345px !important;
}
</style>
<%
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null
	? "0": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null
	? "0": request.getParameter("nowPage"));	
	String operateType = request.getParameter("operateType");
	String id = request.getParameter("id");
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		if("D".equals(operateType)){
			bool = new CUDHelper(request,"=",null).execute();
		}
	}
%>
</head>
<body>
	<div class="tool"></div>
	<form id="pageForm" class="sm_search" action="" method="post">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P=CHAPTER=CHAPTER_ID=S=WD" value="">
	</form>
	<div class="sm_list" >
		<!--列表  标题-->
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input type="checkbox"></td>
				<td style="width: 120px;">章节编号</td>
				<td style="width: 120px;">章节名称</td>
			</tr>
		</table>
		<!--列表  内容-->	
		<table>
			<%
				ChapterManager chapterManager = new ChapterManager();
				PageInfo pageInfo = chapterManager.findPageInfoByChapterManager(nowPage, pageSize, "_", request);
				List list = pageInfo.getList();
				Map map;
				for(int i=0;i<list.size();i++){
					map = (Map)list.get(i);
			%>		
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i+1%></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" value="<%=Validate.isNullToDefault(map.get("CHAPTER_ID"),"")%>">
				<input type="hidden" value="<%=Validate.isNullToDefault(map.get("COURSE_ID"),"")%>">
			</td>
				<td style="width: 120px;"><%=Validate.isNullToDefault(map.get("CHAPTER_CODE"),"")%></td>
				<td style="width: 120px;"><%=Validate.isNullToDefault(map.get("CHAPTER_NAME"),"")%></td>
			</tr>
			<%}%>
		</table>
	</div>
	<div class="point"></div>
<%@include file="/ggs/include/page.inc"%>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			addIframe($(".point"),"point","listPoint.jsp");//添加页面
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
			$(".tool").toolBar([
			{
				text : "新增",
				width : "60",
				position : "-40px -160px",
				handler : function() {
					var kcId = '<%=id%>';
					if(kcId==""||kcId==null||kcId=="null"){
						alert("请选择课程");
					}else{
						var src = "addChapter.jsp?kcId="+kcId;
						jumpWindow("新增章节","550px","260px",src);					
					}
				}
			},{
				text : "修改",
				width : "60",
				position : "-20px -160px",
				handler : function() {
					var $checked = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					if($checked.length!=1){
						alert("只能选择一条信息!");
					}else{
						var id = $checked.val();
						var src = "updateChapter.jsp";
						src +="?id="+id;
						jumpWindow("修改章节","550px","260px",src);			
					}
				}
			},{
				text : "刪除",
				width : 80,
				position : "-180px -160px",
				handler : function() {
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					if($checkeds.length<1){
						alert("至少选择一条信息!");
					}else{
						if(confirm("确认删除?")){
							var ids = [];
							var $this;
							$checkeds.each(function(){
								$this = $(this);
								ids.push($this.val());
							});
							$("[name=operateType]").val("D");
							$("[name='P=CHAPTER=CHAPTER_ID=S=WD']").val(ids.join("','"));
							$("#pageForm").submit();
						}
					}
				}
			}]);
			setPageSize();
			$(".sm_list table:eq(1) tr").click(function(){
				var $checkbox = $(this).find("input[type=checkbox]");
				var kcId = $checkbox.next().val();
				var src = "listPoint.jsp";
				src += "?id="+$checkbox.val()+"&kcId="+kcId;
				
				$("#point").attr("src",src);
			});
		});
		function setPageSize() {
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]);
		}
	</script>
</body>
</html>