<%@page import="com.googosoft.filesManager.course.FolderController"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("utf-8");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	request.setAttribute("basepath",basePath);
	
	String downURL = request.getContextPath()+"/CDownLoad/";
	String operateType = request.getParameter("operateType");
	String fileId = request.getParameter("fileId");
	
	String major_Id = request.getParameter("major_Id");
	String classId = request.getParameter("classId");
	String uploader = request.getParameter("uploader");
	String state = request.getParameter("state");
	
	String userid = (String)request.getSession().getAttribute("USERIDBYLOGIN");//添加人员  
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"=",null).execute();
	}
	FolderController fc=new FolderController();
	Map updateMap = fc.findXXMapByPLANID(fileId);
	Date nowDate = new Date();
	String dateNow=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nowDate).toString();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<html>
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
		&nbsp;&nbsp;&nbsp;&nbsp;推荐优秀教案:&nbsp;
			<input id="check" name="perfact" type="checkbox">
	</div>
</div>
      <form method="post" action="" style="margin-left:25%">
      		<input type="hidden" name="P=TEACHPLAN=ISEXCELLENT=S=S" value="">
	      	<input type="hidden" name="P=TEACHPLAN=PLANID=S=WU" value="<%=updateMap.get("PLANID")==null?"":updateMap.get("PLANID")%>">
	      	<input type="hidden" name="P=TEACHPLAN=FLAG=S=S" value="">
	      	<input type="hidden" name="P=TEACHPLAN=COMMIT=S=S" value="">
	      	<input type="hidden" name="P=TEACHPLAN=CHECKEDTIME=S=S"  value="<%=dateNow%>">
	      	<input type="hidden" name="operateType" value="U">
			<div style="width:245px;height:20px;  padding:10px;background-color:#D6E6F5;border:1px solid #84B8F1;"  >
				<div align="center"><font size="3" title="">下载预览</font></div>
			<div></div>
		</div>
		<div style="width:265px;">
			<div class="sm_edit_tr" style="width:265px;border: 1px solid #84b8f1;" align="center">
				<div class="sm_edit_td_name">文件名称</div>
				<div class="sm_edit_td_value td-span" align="center" >
				<%=updateMap.get("PLANNAME") %>
				</div>
			</div>	
			<div class="sm_edit_tr" style="border: 1px solid #84b8f1;" align="center">
				<div class="sm_edit_td_name">所属专业</div>
				<div class="sm_edit_td_value" align="center">
				<%=updateMap.get("MAJOR_NAME") ==null?"公共基础课":updateMap.get("MAJOR_NAME") %>
				</div>
			</div>	
			<div class="sm_edit_tr" style="border: 1px solid #84b8f1;" align="center">
				<div class="sm_edit_td_name">所属课程</div>
				<div class="sm_edit_td_value" align="center">
				<%=updateMap.get("COURSE_NAME") %>
				</div>
			</div>	
			<div class="sm_edit_tr" style="border: 1px solid #84b8f1;" align="center">
				<div class="sm_edit_td_name">所属章节</div>
				<div class="sm_edit_td_value" align="center">
				<%=updateMap.get("CHAPTER_NAME") %>
				</div>
			</div>
			<div class="sm_edit_tr" style="border: 1px solid #84b8f1;" align="center">
				<div class="sm_edit_td_name">文件下载</div>
				<div class="sm_edit_td_value td-span" align="center">
				<a href="<%=downURL%>?fileName=<%=updateMap.get("REALNAME") %>">
					<%=updateMap.get("PLANNAME") %><%=updateMap.get("EXTENDNAME") %></a>
				</div>
			</div>	
		</div>	
	      	<input type="hidden" name="P=TEACHPLAN=CHECKEDER=S=S" value="<%=userid==null?"":userid%>">
      </form>
</body>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript"> 
		$(function(){
			if("<%=bool%>"=="true"){
				var src = "verifyFile.jsp?MAJOR_ID=<%=major_Id%>&uploader=<%=uploader%>&CLASSID=<%=classId%>&state=<%=state%>";
				parent.location.href=src;
			}
			$(".tool").toolBar([ {
				text : "审核通过",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						if($("#check").attr("checked")){
							$("[name='P=TEACHPLAN=ISEXCELLENT=S=S']").val("T");
							alert('通过优秀');
						}else{
							$("[name='P=TEACHPLAN=ISEXCELLENT=S=S']").val("F");
							alert('通过不优秀');
						}
						$("[name=operateType]").val("U");
						$("[name='P=TEACHPLAN=FLAG=S=S']").val("44");
						$("[name='P=TEACHPLAN=COMMIT=S=S']").val("11");
						//$("[name='P=TEACHPLAN=CHECKEDTIME=S=S']").val("");
						$("form").submit();
					}
				}
			},{
				text : "审核不通过",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("[name='P=TEACHPLAN=ISEXCELLENT=S=S']").val("F");
						$("[name=operateType]").val("U");
						$("[name='P=TEACHPLAN=FLAG=S=S']").val("22");
						$("[name='P=TEACHPLAN=COMMIT=S=S']").val("00");
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
