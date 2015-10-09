<%@page import="com.googosoft.filesManager.course.FolderController"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.googosoft.filesManager.viewManager.StringConstant"%>
<%@page import="com.googosoft.filesManager.fileManager.DeleteFiles"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.filesManager.fileManager.ConvertFileUtilImp"%>
<%@page import="com.googosoft.filesManager.fileManager.ConvertFileUtil"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<%@page import="com.googosoft.commons.CodeHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增文件信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	long h=0;
	long m = 0;
	long s=5;
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	String Fid = request.getParameter("Fid");
	String sp = File.separator;  
	String toPathreal = request.getRealPath(sp)+"upload";
	String operateType = request.getParameter("operateType");
	String Major_id = request.getParameter("Major_id");
	String COURSE_ID = request.getParameter("COURSE_ID");
	String CHAPTER_ID = request.getParameter("CHAPTER_ID");
	String CLASSID=request.getParameter("CLASSID");
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null? "0": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null? "0": request.getParameter("nowPage"));
	boolean bool = false;
	String path = request.getContextPath();
	if (Validate.noNull(operateType)) {
		bool = new CUDHelper(request, "=", null).execute();
%>
<%
	String fileName = request.getParameter("P=TEACHPLAN=REALNAME=S=C");
	String toPath = request.getRealPath(sp)
			+ IUploadImgContants.IMGPATH;
	toPath = toPath + fileName;
	String extendName = request.getParameter("P=TEACHPLAN=EXTENDNAME=S=C");
	List<String> extendList = Arrays.asList(StringConstant.AVALIABLETRANSFILES);
	if (extendName.equals(".rm") || extendName.equals(".rmvb")
			|| extendName.equals(".mp4") || extendName.equals(".flv")) {
		//这里的操作就是执行视频格式的转换工作
		response.sendRedirect(request.getContextPath()+sp+"upMovie?CLASSID="+CLASSID+"&CHAPTER_ID="+CHAPTER_ID+"&COURSE_ID="+COURSE_ID+"&MAJOR_ID="+Major_id+"&fileName="+fileName+"&h="+h+"&m="+m+"&s="+s+"&extendName="+extendName);
	} else if(extendName.equals(".pdf")){
		String noextendName = fileName.substring(0,fileName.lastIndexOf("."));
		String newPath = request.getRealPath(sp)
				+ IUploadImgContants.IMGPATH + noextendName
				+ ".pdf";
		//ProcessFileUtil fileutil = new ProcessFileUtil();
		//fileutil.transpdfToSwf(newPath);
		
	}else if(extendList.contains(extendName)){
		//ProcessFileUtil fileutil = new ProcessFileUtil();
		//fileutil.transOreFileToSwf(toPath);
	}
}
	String folderParentId = request.getParameter("folderParentId");
	String folderparentid = CodeHelper.createUUID();
	String userid=(String)request.getSession().getAttribute("USERIDBYLOGIN");
%>
<body>
<div class="tool"></div>
	<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
	<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
<%
	FolderController folderCtr = new FolderController ();
	PageInfo pageInfo = null; 
	pageInfo = folderCtr.findPageInfoByFOLDER1(nowPage, pageSize, "=", request, CHAPTER_ID);
	List list = pageInfo.getList();
	Map map;
	map = (Map)list.get(0);
	Map cmap=folderCtr.findMapByClassId(CLASSID);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="" style="margin-top: 1%">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P=TEACHPLAN=PLANID=S=P" value="">
		<input type="hidden" name="P=TEACHPLAN=UPLOADERID=S=C" value="<%=userid %>">
		<input type="hidden" name="P=TEACHPLAN=COMMIT=S=C" value="00">
		<input type="hidden" name="P=TEACHPLAN=FLAG=S=C" value="11">
		<input type="hidden" name="P=TEACHPLAN=ISCONVERTSUCESS=S=C" value="F">
		<input type="hidden" name="h" value="">
		<input type="hidden" name="m" value="">
		<input type="hidden" name="s" value="">
		<input type="hidden" name="P=TEACHPLAN=REALNAME=S=C" value="<%=request.getParameter("P=TEACHPLAN=REALNAME=S=C")==null?"":request.getParameter("P=TEACHPLAN=REALNAME=S=C")%>" >
		<input type="hidden"  name="P=TEACHPLAN=EXTENDNAME=S=C" value="<%=request.getParameter("P=TEACHPLAN=EXTENDNAME=S=C")==null?"":request.getParameter("P=TEACHPLAN=EXTENDNAME=S=C")%>">
		<input type="hidden"  name="P=TEACHPLAN=SWFPATH=S=C" value="<%=request.getParameter("P=TEACHPLAN=SWFPATH=S=C")==null?"":request.getParameter("P=TEACHPLAN=SWFPATH=S=C")%>">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">文件名</div>
			<div class="sm_edit_td_value">
			<input type="text"  class="null" name="P=TEACHPLAN=PLANNAME=S=C" value="<%=request.getParameter("P=TEACHPLAN=PLANNAME=S=C")==null?"":request.getParameter("P=TEACHPLAN=PLANNAME=S=C")%>"></div>
			
			<div class="sm_edit_td_name">所属专业</div>
			<input type="hidden" name="P=TEACHPLAN=MAJOR_ID=S=C" value="<%=map.get("MAJOR_ID") %>">
			<div class="sm_edit_td_value"><input type="text"  readonly="readonly" value="<%=map.get("MAJOR_NAME")== null?"公开课":map.get("MAJOR_NAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">所属课程</div>
			<input type="hidden" name="P=TEACHPLAN=COURSE_ID=S=C" value="<%=map.get("COURSE_ID")%>" >
			<div class="sm_edit_td_value"><input type="text"  readonly="readonly" value="<%=map.get("COURSE_NAME")%>"></div>

			<div class="sm_edit_td_name">所属章节</div>
			<input type="hidden" name="P=TEACHPLAN=CHAPTER_ID=S=C" value="<%=map.get("CHAPTER_ID") %>">
			<div class="sm_edit_td_value"><input type="text"  readonly="readonly"  value="<%=map.get("CHAPTER_NAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">所属班级</div>
			<input type="hidden" name="P=TEACHPLAN=CLASSID=S=C" value="<%=cmap.get("GID") %>">
			<div class="sm_edit_td_value"><input type="text"  readonly="readonly"  value="<%=cmap.get("BJMC")%>"></div>
			
			<div class="sm_edit_td_name">是否允许下载</div>
			<div class="sm_edit_td_value">
				<input type="radio" name="P=TEACHPLAN=DOWNLOAD=S=C" value="00" checked="checked">允许 &nbsp; &nbsp;
				<input type="radio" name="P=TEACHPLAN=DOWNLOAD=S=C" value="11">不允许
			</div>
		</div>
		
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">上传时间</div>
			<div class="sm_edit_td_value">
				<input type="text" class="Wdate" name="P=TEACHPLAN=CREATETIME=S=C" value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) %>"/>
			</div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">上传</div>
			<div class="sm_edit_td_value">
				<input type="file"  id="fileInput"/>
				<div id="fileQueue" style="float:left">       
				</div>
			</div>
		</div>
		
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
			$(".delimp").live("click",function(){ //绑定click  执行function 
				var obj = $(this);
				var img = $(this).attr("src");
				if(confirm("确认删除？")){
					var filename = $("[name='P=TEACHPLAN=REALNAME=S=C']").val();
					 $.ajax({
	 						type: "POST",
	 						url: "<%=path%>/FileDelete?filename="+filename,
							data: "filename="+filename,
									success : function(){ 
	 						}
	 					});
					$("[name='P=TEACHPLAN=PLANNAME=S=C']").val("");
					obj.parent().remove();
				}
			});
			
		$(function() {
<%-- 			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp"); --%>
			if("<%=bool%>"=="true"){
				parent.location.href = "listFile.jsp?CHAPTER_ID=<%=CHAPTER_ID%>&COURSE_ID=<%=COURSE_ID%>&MAJOR_ID=<%=Major_id%>&CLASSID=<%=CLASSID%>";
			}
			if("<%=request.getParameter("view")%>"=="true"){
				parent.location.href = "listFile.jsp?CHAPTER_ID=<%=CHAPTER_ID%>&COURSE_ID=<%=COURSE_ID%>&MAJOR_ID=<%=Major_id%>&CLASSID=<%=CLASSID%>";
			}
			$(".tool").toolBar([ {
				
				text : "保存",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("[name=operateType]").val("C");
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
			function setPageSize() {

			}
			$(document).ready(function(){
				<%
// 				String sp = File.separator;
				String toPath = request.getRealPath(sp) + IUploadImgContants.IMGPATH;
				toPath = toPath.replace(sp,sp+sp);
				%>
			    $('#fileInput').uploadify({
			    	'uploader': '<%=pathSkinTool%>/tool/uploadify/uploadify.swf',
				    'script': '<%=request.getContextPath()%>/UploadServlet?TOPATH=<%=toPath%>',	//指定服务端处理类的入口 
				 	'cancelImg' : '<%=pathSkinTool%>/tool/uploadify/cancel.png',
				    'queueID': 'fileQueue',
				    'fileDataName': 'fileInput',//和input的name属性值保持一致
				    'auto': true,//是否选取文件后自动上传   
				    'multi': false,//是否支持多文件上传
				    'simUploadLimit' : 1,//每次最大上传文件数
				    'removeCompleted' : false,
					'buttonImg':'<%=pathSkinTool%>/tool/uploadify/upload.png',
				    'width': 52,
				 	'height': 22,
				 	'fileExt':'*',
				 	'displayData': 'percentage', //有speed和percentage两种，一个显示速度，一个显示完成百分比
				 	'onComplete': function(event, ID, fileObj, response, data) {
				 		//response返回值：重命名后的文件名称,文件保存路径
				 		var html='<img  style="width: 16px;height:16px; float:right; "  class="delimp" src="<%=path%>/ggs/skin/default/image/delete.bmp"/>'
				 		$(html).prependTo(".uploadifyQueueItem");
				 		var resultArray=response.split(",");
				 		var fileNName = resultArray[0];
				 		var s  =  $.trim(fileNName);
				 		var swfFileName=response.split(".");
				 		var fileName = resultArray[0];
				 		var extendName=fileName.substring(fileName.lastIndexOf("."));
				 		var updateName=fileName.substring(0,32);
				 		var realName=fileName.substring(32,fileName.lastIndexOf("."));
				 		$("[name='P=TEACHPLAN=PLANNAME=S=C']").val(realName);
				 		$("[name='P=TEACHPLAN=REALNAME=S=C']").val(updateName+extendName);
				 		$("[name='P=TEACHPLAN=EXTENDNAME=S=C']").val(extendName);
				 		$("[name='P=TEACHPLAN=SWFPATH=S=C']").val(updateName);
				 		window.parent.desktopManager(resultArray[0]);
				 	} ,
				 	'onCancel': function(event,ID,fileObj,data) {
				 	}
			    }); 
			});
		});
		
	</script>
</body>
</html>