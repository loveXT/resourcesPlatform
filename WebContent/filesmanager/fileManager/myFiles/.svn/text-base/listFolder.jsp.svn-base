<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.filesManager.fileManager.FolderController"%>
<%@page import="com.googosoft.filesManager.fileManager.DelfolderManager"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="com.googosoft.zapi.FileHelper"%>
<%@page import="com.googosoft.filesManager.fileManager.FolderManager"%>
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<%@page import="com.googosoft.filesManager.fileManager.FileManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件夹列表信息</title>
<%@include file="/ggs/include/css.inc" %>
<%	
	//设置编码格式为"utf-8"
 	request.setCharacterEncoding("utf-8");
	//接受operate按钮操作权限
	String operate = OperationCache.getOperation(request);
	//接受chapter_id章节编号,course_id课程编号,major_id专业编号
	String Major_id = request.getParameter("MAJOR_ID");
	String COURSE_ID = request.getParameter("COURSE_ID");
	String CHAPTER_ID = request.getParameter("CHAPTER_ID");
	String folderId = request.getParameter("folderId");
	String folderName = request.getParameter("folderName");
	String delFolder = request.getParameter("P_FOLDER_FOLDERID_S_WD");
	String basePath = request.getRealPath("/");  
	String downFilePath =basePath + IUploadImgContants.IMGPATH;
	//分页设置pageSize每页显示几条数据,nowPage当前页
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	//根据operateType的类型进行cud进行处理
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
		DelfolderManager dm = DelfolderManager.getInstance();
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"=",null).execute();
	}
	//增加时判断左侧结构数列是否选中末级
		Boolean checkCHAPTER_ID = false;
		if(CHAPTER_ID==null){
			checkCHAPTER_ID = true;	
		}
%>
<body>
	<div class="tool"></div>
	<form id="pageForm" class="sm_search" method="post" action="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P=FOLDER=FOLDERID=S=WD" value="">
		<table class="search_table">
			<tr>
				<td>类别编号</td>
				<td>
<%-- 					<input type="text" name="P=Q=LIKE=FOLDERCODE" value="<%=Validate.isNullToDefault(request.getParameter("P=Q=LIKE=FOLDERCODE"),"") %>"> --%>
					<input type="text" name="P=Q=LIKE=FOLDERCODE" value="<%=request.getParameter("P=Q=LIKE=FOLDERCODE")==null?"":request.getParameter("P=Q=LIKE=FOLDERCODE") %>">
				</td>
				<td>类别名称</td>
				<td>
<%-- 					<input type="text" name="P=Q=LIKE=FOLDERNAME" value="<%=Validate.isNullToDefault(request.getParameter("P=Q=LIKE=FOLDERNAME"),"") %>"> --%>
					<input type="text" name="P=Q=LIKE=FOLDERNAME" value="<%=request.getParameter("P=Q=LIKE=FOLDERNAME")==null?"":request.getParameter("P=Q=LIKE=FOLDERNAME") %>">
				</td>
			</tr>
		</table>
	</form>
<div class="sm_list">
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox"></td>
				<td style="width: 150px;">类别编号</td>
				<td style="width: 150px;">类别名称</td>
				<td style="width: 200px;">类别描述</td>
			</tr>
		</table>
		<table>
			<%
			FolderController folderManager = new FolderController();
				PageInfo pageInfo = null;
				Map map;
				pageInfo = folderManager.findPageInfoByFOLDER(nowPage, pageSize, "=",request,Major_id,CHAPTER_ID,COURSE_ID);
				List list = pageInfo.getList();
				for(int i=0;i<list.size();i++){
					map = (Map)list.get(i);
			%>
				<tr>
				<td style="width: 30px;" class="sm_index"><%=i+1 %></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" value="<%=map.get("FOLDERID") %>">
				</td>
				<td style="width: 150px;"><%=map.get("FOLDERCODE")==null?"":map.get("FOLDERCODE") %></td>
				<td style="width: 150px;"><%=map.get("FOLDERNAME") %></td>
				<td style="width: 200px;"><%=map.get("FLMS")==null?"":map.get("FLMS") %></td>
			</tr>
				<%
			}
			%>
		</table>
	</div>
<%@include file="/ggs/include/page.inc"%>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			//cud处理成功后关闭本页面,父页面刷新
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
			//给tool标签增加"新增"和"修改"和"查询"和""删除"按钮操作
			$(".tool").toolBar([ {
				text : "新增",
				width : 60,
				position : "-40px -160px",
				handler : function() {
						var src = "addFolder.jsp";
						src += "?CHAPTER_ID=<%=CHAPTER_ID%>";
						jumpWindow("新增分类信息","400px","220px",src);
				}
			},{
				text : "修改",
				width : 60,
				position : "-20px -160px",
				handler : function() {
					var id = "";
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					if($checkeds.length!=1){
						alert("只能选择一条信息进行操作");
					}else{
						var id = $checkeds.val();
						var src = "updateFolder.jsp";
						src += "?Id="+id;
						jumpWindow("修改文件夹名称", "400px", "220px", src);
					}
				}
			}, {
				text : "查询",
				width : 60,
				position : "-240px -100px",
				handler : function() {
					sm_goSearch();
				}
			},{
				text : "删除",
				width : 60,
				position : "-180px -160px",
				handler : function() {
						var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
						if($checkeds.length<1){
							alert("最少选择一条信息进行操作");
						}else{
								if(confirm("确认删除?")){
									var ids = [];
									var $this;
									$checkeds.each(function(){
										$this = $(this);
										ids.push($this.val());
									});
									$.ajax({
										url:"<%=request.getContextPath()%>/ggs/help/validateByDelete.jsp?TABLENAME=FILES&RELATECOLUMN=FOLDERID&VALUE="+ids.join("','"),
										type:"post",
										async:"false",
										success:function(data){
											if(data<=0){
												$("[name=operateType]").val("D");
												$("[name='P=FOLDER=FOLDERID=S=WD']").val(ids.join("','"));
												$("#pageForm").submit();
											}else{
												if(confirm("含有子文件！是否继续删除？")){
													$("[name=operateType]").val("D");
													$("[name='P=FOLDER=FOLDERID=S=WD']").val(ids.join("','"));
													$("#pageForm").submit();
												}
											}
										}
									});
								}
						}//else
					}//function
			}  ]);
		});
		function setPageSize() {
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]);
		}
	</script>
</body>
</html>