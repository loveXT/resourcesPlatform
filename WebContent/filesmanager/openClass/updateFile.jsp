<%@page import="com.googosoft.filesManager.fileManager.CategoryManager"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@page import="com.googosoft.filesManager.fileManager.CategoryManager" %>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改文件信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	//获取文件id
	String fileId = request.getParameter("fileId");
	String operateType = request.getParameter("operateType");
	String Major_id = request.getParameter("Major_id");
	String COURSE_ID = request.getParameter("COURSE_ID");
	String CHAPTER_ID = request.getParameter("CHAPTER_ID");
	String POINT_ID = request.getParameter("POINT_ID");
	//执行增删改查操作
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"_",null).execute();
	}
	//根据文件Id获取文件其他相关信息
	FilesManager filesManager= new FilesManager();
	Map updateMap = filesManager.findMapByFILEID(fileId); 
	String classify = Validate.isNullToDefault(updateMap.get("CLASSIFY"), "").toString();
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="" style="margin-top: 20px;">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_FILES_FILEID_S_WU" value="<%=updateMap.get("FILEID")==null?"":updateMap.get("FILEID")%>">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">文件名称</div>
			<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_FILES_FALSENAME_S_S" value="<%=updateMap.get("FALSENAME")==null?"":updateMap.get("FALSENAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">扩展名名称</div>
			<div class="sm_edit_td_value"><input readonly="readonly" type="text" class="null maxLength:50num" name="P_FILES_EXTENDNAME_S_S" value="<%=updateMap.get("EXTENDNAME")==null?"":updateMap.get("EXTENDNAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">文件分类</div>
			<div class="sm_edit_td_value">
			<select id="EXTENDNAME" name="P_FILES_CLASSIFY_S_S" class="null">
						<option value="" <%if(Validate.isNull(classify)){%>selected<%} %> >文件分类</option>
						<%
							CategoryManager categorymanager=new CategoryManager();
							List categorylist=categorymanager.findPageInfo();
							Map categoryMap;
							for(int i=0;i<categorylist.size();i++){
								categoryMap=(Map) categorylist.get(i);
						%>
						    <option value="<%=categoryMap.get("ID") %>" <%if(categoryMap.get("ID").equals(classify)){%>selected<%} %>><%=categoryMap.get("NAME")%></option>
						<%
							}
						%>
					</select>	
			</div>
		</div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		//保存操作
		$(function() {
				//判断如果页面提交,cud执行成功,把值传给父页面并刷新
			if("<%=bool%>"=="true"){
				var src = "listFile.jsp?POINT_ID=<%=POINT_ID%>&CHAPTER_ID=<%=CHAPTER_ID%>&COURSE_ID=<%=COURSE_ID%>&MAJOR_ID=<%=Major_id%>";
				parent.location.href = src;				
			}
			$(".tool").toolBar([ {
				text : "保存",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("[name=operateType]").val("U");
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
		});
		//设置页面属性,增加页面滚动条
		function setPageSize() {
			
		}
	</script>
</body>
</html>