<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//设置编码格式为"utf-8"
	request.setCharacterEncoding("utf-8");
	//接受参数name,down
	String name = request.getParameter("name");
	String down = request.getParameter("down");
	String marjorId = request.getParameter("marjorId");
	String courseId = request.getParameter("courseId");
	String chapterId = request.getParameter("chapterId");
	String pointId = request.getParameter("pointId");
	String userName = request.getParameter("userName");
	//接受chapter_id章节编号,course_id课程编号,major_id专业编号
	String major = request.getParameter("major");
	String course = request.getParameter("course");
	String charpter = request.getParameter("charpter");
	String filenamed = request.getParameter("filenamed");
	//path项目路径
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	request.setAttribute("basepath",basePath);
	//给据swfFile文件名称拼接成文件路径
	String swfFile = request.getParameter("swfFile");
	String swfFilePath = basePath+"ggs/common/ggs/upload/"+swfFile+".swf";
	//downURL下载servlet
	String downURL = request.getContextPath()+"/DownLoad/";
	String filename=swfFile+".swf";
	boolean flag=ProcessFileUtil.checkFileExists(filename,request);
	//根据operateType的类型进行cud进行处理
	String operateType = request.getParameter("operateType");
	String fileId = request.getParameter("fileId");
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"=",null).execute();
	}
	FilesManager filesManager= new FilesManager();
	Map updateMap = filesManager.findMapByFILEID(fileId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html>
  <head>
    <base href="<%=basePath%>">
    <title>文档在线预览页面</title>
	<%@include file="/ggs/include/css.inc" %>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${basepath}css/styles.css">
	<script type="text/javascript" src="<%=basePath %>ggs/common/js/flexpaper_flash.js"></script>
  </head>
  <body>
	  	  <div class="tool">
	  	  	<div style="position: absolute;left: 180px;margin-top: 3px;">
				&nbsp;&nbsp;&nbsp;&nbsp;推荐为精品课程:&nbsp;
<!-- 				<select name="perfact" > -->
<!-- 					<option value="T">是</option> -->
<!-- 					<option value="F">否</option> -->
<!-- 				</select> -->
<input type="checkbox" name="perfact" >
			</div>
	  	  </div>
	  	<center class="sm_edit_center">
			<form class="sm_edit_from"  method="post" action="" style="padding: 20px;width: 353px;">
					<input type="hidden" name="P=FILES=ISEXCELLENT=S=S" value="">
			      	<input type="hidden" name="P=FILES=FILEID=S=WU" value="<%=updateMap.get("FILEID")==null?"":updateMap.get("FILEID")%>">
			      	<input type="hidden" name="P=FILES=FLAG=S=S">
			      	<input type="hidden" name="operateType" value="U">
			      	<input type="hidden" name="P=FILES=FLAG=S=S">
		<center>
			<div style="width:287px;height:20px;padding:10px;background-color:#D6E6F5;border:1px solid #84B8F1;margin-right: 10px;"  >
					<div align="center"><font size="3" title="">下载预览</font></div>
				</div>	
			<div class="sm_edit_tr" style="border: 1px solid #84b8f1;margin-right: 10px;" align="center">
				<div class="sm_edit_td_name">文件名称</div>
				<div class="sm_edit_td_value td-span" style="width: 201px" align="center">
				<%=filenamed %>
				</div>
			</div>	
			<div class="sm_edit_tr" style="border: 1px solid #84b8f1;margin-right: 10px;" align="center">
				<div class="sm_edit_td_name">所属专业</div>
				<div class="sm_edit_td_value td-span" style="width: 201px" align="center">
				<%=Validate.isNullToDefault(major,"公共基础课")%>
				</div>
			</div>	
			<div class="sm_edit_tr" style="border: 1px solid #84b8f1;margin-right: 10px;" align="center">
				<div class="sm_edit_td_name">所属课程</div>
				<div class="sm_edit_td_value td-span" style="width: 202px" align="center">
				<%=course %>
				</div>
			</div>
			<div class="sm_edit_tr" style="border: 1px solid #84b8f1;margin-right: 10px;" align="center">
				<div class="sm_edit_td_name">所属章节</div>
				<div class="sm_edit_td_value td-span" style="width: 202px" align="center">
				<%=charpter %>
				</div>
			</div>
			<div class="sm_edit_tr" style="border: 1px solid #84b8f1;margin-right: 10px;" align="center">
				<div class="sm_edit_td_name">文件下载</div>
				<div class="sm_edit_td_value td-span" style="width: 202px" align="center">
				<a href="<%=downURL%>?fileName=<%=down %>"><%=filenamed %></a>
				</div>
			</div>
			  	<input type="hidden" name="P=FILES=CHECKEDID=S=S" value="<%=session.getAttribute("USERIDBYLOGIN")==null?"":session.getAttribute("USERIDBYLOGIN")%>">
			      	<%
				      	String userid = (String)request.getSession().getAttribute("USERIDBYLOGIN");//添加人员  
				    	String sql = "select username from umuser where userid = '"+userid+"'";
				    	DBHelper dbHelper = new DBHelper();
				    	Map mname = dbHelper.queryForMap(sql);	
			      	%>
					<input type="hidden" name="P=FILES=CHECKEDER=S=S" value="<%=mname.get("USERNAME") %>">
			</center>
			</form>
	</center>
  </body>
		<%@include file="/ggs/include/js.inc" %>
	        <script type="text/javascript"> 
				$(function(){
					//cud处理成功后关闭本页面,父页面刷新
					if("<%=bool%>"=="true"){
						var src = "filesmanager/fileManager/verifyFile.jsp?MAJOR_ID=<%=marjorId%>&COURSE_ID=<%=courseId%>&CHAPTER_ID=<%=chapterId%>&POINT_ID=<%=pointId%>&P_Q_LIKE_UM.USERNAME=<%=userName%>";
						parent.location.href=src;
					}
					//给tool标签增加"审核通过"和"审核不通过"按钮操作
					$(".tool").toolBar([ {
						text : "审核通过",
						width : 50,
						position : "-360px -100px",
						handler : function() {
							if(validateBySubmit($("form"))){
								var perfact = $("[name=perfact]");
								if(perfact.attr("checked")){
									$("[name='P=FILES=ISEXCELLENT=S=S']").val("T");
								}else{
									$("[name='P=FILES=ISEXCELLENT=S=S']").val("F");
								}
								$("[name=operateType]").val("U");
								$("[name='P=FILES=FLAG=S=S']").val("22");
								$("form").submit();
							}
						}
					},{
						text : "审核不通过",
						width : 50,
						position : "-360px -100px",
						handler : function() {
							if(validateBySubmit($("form"))){
								$("[name=operateType]").val("U");
								$("[name='P=FILES=FLAG=S=S']").val("33");
								$("form").submit();
							}
						}
					} ]);
					setPageSize();
				});
				function setPageSize(){
					setWidth($(".sm_list"),$("body"));
					setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]); 
				}
	        </script>

</html>
