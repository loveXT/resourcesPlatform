<%@page import="com.googosoft.filesManager.openClass.OpenClassManager"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.filesManager.fileManager.FileManager"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
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
	//定义截取图片的参数
	long h=0;
	long m = 0;
	long s=5;
	//定义编码格式
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	//接受参数,Major_id专业编号,COURSE_ID课程编号,CHAPTER_ID章节编号,POINT_ID知识点编号
	String Fid = request.getParameter("Fid");
	String sp = File.separator;  
	String toPathreal = request.getRealPath(sp)+"upload";
	String COURSE_ID = request.getParameter("COURSE_ID");
	//folderName分类编号operateTypecud执行参数
	String folderName = request.getParameter("folderName");
	String operateType = request.getParameter("operateType");
	//分页设置,每页显示几条数据,和当前页
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null? "0": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null? "0": request.getParameter("nowPage"));
	boolean bool = false;
	String path = request.getContextPath();
	if (Validate.noNull(operateType)) {
		bool = new CUDHelper(request, "=", null).execute();
	}
	FileManager fileManager = new FileManager();
	String userid=(String)request.getSession().getAttribute("USERIDBYLOGIN");
	String sql = "select username from umuser where userid = '"+userid+"'";
	DBHelper dbHelper = new DBHelper();
	Map mname = dbHelper.queryForMap(sql);
	
%>
<body>
<div class="tool"></div>
	<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
	<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
<%
	OpenClassManager ocm = new OpenClassManager();
	Map map = ocm.findCourseByCourseId(COURSE_ID);
%>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="" style="margin-top: 1%;height: 275px;">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P=OPENCLASS=FILEID=S=P" value="">
		<input type="hidden" name="P=OPENCLASS=FALSENAME=S=C" value="<%=request.getParameter("P=OPENCLASS=REALNAME=S=C")==null?"":request.getParameter("P=OPENCLASS=REALNAME=S=C")%>">
		<input type="hidden" name="h" value="">
		<input type="hidden" name="m" value="">
		<input type="hidden" name="s" value="">
		<input type="hidden" name="P=OPENCLASS=FILENAME=S=C" value="<%=request.getParameter("P=OPENCLASS=FILENAME=S=C")==null?"":request.getParameter("P=OPENCLASS=FILENAME=S=C")%>" >
		<input type="hidden" name="P=OPENCLASS=FILEPATH=S=C" value="<%=request.getParameter("P=OPENCLASS=FILEPATH=S=C")==null?"":request.getParameter("P=OPENCLASS=FILEPATH=S=C")%>">
		<input type="hidden" name="P=OPENCLASS=EXTENDNAME=S=C" value="<%=request.getParameter("P=OPENCLASS=EXTENDNAME=S=C")==null?"":request.getParameter("P=OPENCLASS=EXTENDNAME=S=C")%>">
		<input type="hidden" name="P=OPENCLASS=SWFPATH=S=C" value="<%=request.getParameter("P=OPENCLASS=SWFPATH=S=C")==null?"":request.getParameter("P=OPENCLASS=SWFPATH=S=C")%>">
		<input type="hidden" class="uploader" name="P=OPENCLASS=UPLOADER=S=C" value="<%=session.getAttribute("USERIDBYLOGIN")%>">
		<input type="hidden" name="P=OPENCLASS=FILENAME2=S=C" value="<%=request.getParameter("P=OPENCLASS=FILENAME2=S=C")==null?"":request.getParameter("P=OPENCLASS=FILENAME2=S=C")%>" >
		<input type="hidden" name="P=OPENCLASS=EXTENDNAME2=S=C" value="<%=request.getParameter("P=OPENCLASS=EXTENDNAME2=S=C")==null?"":request.getParameter("P=OPENCLASS=EXTENDNAME2=S=C")%>">
		<input type="hidden" name="P=OPENCLASS=FILESIZE=S=C" value="<%=request.getParameter("P=OPENCLASS=FILESIZE=S=C")==null?"":request.getParameter("P=OPENCLASS=FILESIZE=S=C")%>">
		<input type="hidden" name="P=OPENCLASS=DOWNLOAD=S=C" value="00">
		<input type="hidden" name="P=OPENCLASS=DOWNLOADTIME=S=C" value="0">
		<input type="hidden" name="P=OPENCLASS=BROWSETIME=S=C" value="0">
		<div class="sm_edit_tr">
		<div class="sm_edit_td_name">文件名:</div>
			<div class="sm_edit_td_value">
			<input type="text"  class="null" name="P=OPENCLASS=REALNAME=S=C" value="<%=request.getParameter("P=OPENCLASS=REALNAME=S=C")==null?"":request.getParameter("P=OPENCLASS=REALNAME=S=C")%>"></div>
			<div class="sm_edit_td_name">所属课程:</div>
			<input type="hidden" name="P=OPENCLASS=COURSE_ID=S=C" value="<%=map.get("COURSE_ID")%>" >
			<div class="sm_edit_td_value"><input type="text"  readonly="readonly" value="<%=map.get("COURSE_NAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">上传时间:</div>
			<div class="sm_edit_td_value">
				<%SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");%>
				<input id="Wdate" name="P=OPENCLASS=CREATETIME=S=C" value="<%=sdf.format(new Date()) %>">
			</div>
			<div class="sm_edit_td_name">上传人:</div>
			<div class="sm_edit_td_value">
				<input value="<%=mname.get("USERNAME")%>">
			</div>
		</div>
		<div class="sm_edit_tr" style="height: 45px;">
			<div class="sm_edit_td_name" style="height: 45px;">资源描述:</div>
			<div class="sm_edit_td_value">
			<textarea style="height:50px;width:420px;" class="maxLength:40num null" name="P=OPENCLASS=REMARK=S=C"><%=Validate.isNullToDefault(request.getParameter("P=OPENCLASS=REMARK=S=C"), "") %></textarea> 
			</div>
		</div>		
		
		<div class="sm_edit_tr" style="height: 70px;">
			<div class="sm_edit_td_name" style="height: 70px;">上传资源</div>
			<div class="sm_edit_td_value" >
				<input type="file"  id="fileInput"/>
				<div id="fileQueue" style="float:left"></div>
			</div>
			
		</div>
		<div class="sm_edit_tr" style="height: 70px;">
		<div class="sm_edit_td_name" style="height: 70px;">上传缩略图</div>
		<div class="sm_edit_td_value">
			<input type="file" id="Thumbnail"/>
			<div id="filesQueue" style="float:left"></div>
		</div>
		 </div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
			//为页面新增加的内容绑定click  执行function 
			$(".delimp").live("click",function(){
				var obj = $(this);
				var img = $(this).attr("src");
				if(confirm("确认删除？")){
					var filename = $("[name='P=OPENCLASS=FILENAME=S=C']").val();
					 $.ajax({
	 						type: "POST",
	 						url: "<%=path%>/FileDelete",
							data: "filename="+filename,
									success : function(){ 
	 						}
	 					});
					$("[name='P=OPENCLASS=REALNAME=S=C']").val("");
					obj.parent().remove();
				}
			});
		$(function() {
			$("[name='P=OPENCLASS=REALNAME=S=C']").blur(function(){
				var realname = $("[name='P=OPENCLASS=REALNAME=S=C']").val();
				$("[name='P=OPENCLASS=FALSENAME=S=C']").val(realname);
			})
			
			//判断如果页面提交,cud执行成功,把值传给父页面并刷新
			if("<%=bool%>"=="true"){
				var src = "listFile.jsp?COURSE_ID=<%=COURSE_ID%>";
				parent.location.href = src;
			}
			if("<%=request.getParameter("view")%>"=="true"){
				parent.location.href = "listFile.jsp?COURSE_ID=<%=COURSE_ID%>";
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
			$("#Wdate").bind("click",function(){
				WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});
			});
			setPageSize();
			function setPageSize() {
			}
			function validateForFLV (ext){
				if(".flv"!=ext&&".FLV"!=ext){
					return false
				}
				return true;
			}
			$(document).ready(function(){
				//得到上传路径
				<%
				String toPath = request.getRealPath(sp) + IUploadImgContants.IMGPATH;
				toPath = toPath.replace(sp,sp+sp);
				%>
				//上传插件
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
				 	'fileExt':'*.flv;*.FLV',
				 	'fileDesc': '请选择.flv格式的视频',
				 	'displayData': 'percentage', //有speed和percentage两种，一个显示速度，一个显示完成百分比
				 	'onComplete': function(event, ID, fileObj, response, data) {
				 		//response返回值：重命名后的文件名称,文件保存路径
				 		var html='<img  style="width: 16px;height:16px; float:right; "  class="delimp" src="<%=path%>/ggs/skin/default/image/delete.bmp"/>'
				 		$(html).prependTo("#fileInput"+ID);
				 		var resultArray=response.split(",");
				 		var fileName = resultArray[0];
				 		var filesize = fileObj.size/1024;
				 		var extendName=fileName.substring(fileName.lastIndexOf("."));
				 		if(!validateForFLV(extendName)){
				 			alert("请上传.flv格式的视频");
				 			delImg($("#fileInput"+ID).find(".delimp"));
				 		}
				 		var updateName=fileName.substring(0,32);
				 		var realName=fileName.substring(32,fileName.lastIndexOf("."));
				 		$("[name='P=OPENCLASS=REALNAME=S=C']").val(realName);
				 		$("[name='P=OPENCLASS=FALSENAME=S=C']").val(realName);
				 		$("[name='P=OPENCLASS=FILEPATH=S=C']").val("<%=toPath%>"+updateName+extendName);
				 		$("[name='P=OPENCLASS=FILENAME=S=C']").val(updateName+extendName);
				 		$("[name='P=OPENCLASS=EXTENDNAME=S=C']").val(extendName);
				 		$("[name='P=OPENCLASS=SWFPATH=S=C']").val(updateName);
				 		$("[name='P=OPENCLASS=FILESIZE=S=C']").val(filesize);
				 		window.parent.desktopManager(resultArray[0]);
				 	} ,
				 	'onCancel': function(event,ID,fileObj,data) {
				 	}
			    }); 
			    function delImg($imp){
					var obj = $imp;
						var filename = "<%=path%>"+$("[name='P=OPENCLASS=FILENAME=S=C']").val();
						 $.ajax({
		 						type: "POST",
		 						url: "<%=path%>/FileDelete",
								data: "filename="+filename,
										success : function(){ 
		 						}
		 					});
						obj.parent().remove();
						$("[name*='P=OPENCLASS=FILENAME=S=C']").remove();
				}
			    $('#Thumbnail').uploadify({
			    	'uploader': '<%=pathSkinTool%>/tool/uploadify/uploadify.swf',
				    'script': '<%=request.getContextPath()%>/UploadServlet?TOPATH=<%=toPath%>',	//指定服务端处理类的入口 
				 	'cancelImg' : '<%=pathSkinTool%>/tool/uploadify/cancel.png',
				    'queueID': 'filesQueue',
				    'fileDataName': 'Thumbnail',//和input的name属性值保持一致
				    'auto': true,//是否选取文件后自动上传   
				    'multi': false,//是否支持多文件上传
				    'simUploadLimit' : 1,//每次最大上传文件数
				    'removeCompleted' : false,
					'buttonImg':'<%=pathSkinTool%>/tool/uploadify/upload.png',
				    'width': 52,
				 	'height': 22,
				 	'fileExt':'*.jpg;*.png;*.jpeg',
				 	'fileDesc':'*.rm;*.mp4;*.flv;*.rmvb;*.pdf;*.txt;*.doc;*.docx;*.xls;*.htm;*.java',
				 	'displayData': 'percentage', //有speed和percentage两种，一个显示速度，一个显示完成百分比
				 	'onComplete': function(event, ID, fileObj, response, data) {
				 		//response返回值：重命名后的文件名称,文件保存路径
				 		var html='<img  style="width: 16px;height:16px; float:right; "  class="delimp" src="<%=path%>/ggs/skin/default/image/delete.bmp"/>'
				 		$(html).prependTo("#Thumbnail"+ID);
				 		var resultArray=response.split(",");
				 		var fileNName = resultArray[0];
				 		var s  =  $.trim(fileNName);
				 		var swfFileName=response.split(".");
				 		var fileName = resultArray[0];
				 		var extendName=fileName.substring(fileName.lastIndexOf("."));
				 		var updateName=fileName.substring(0,32);
				 		var realName=fileName.substring(32,fileName.lastIndexOf("."));
				 		$("[name='P=OPENCLASS=FALSENAME2=S=C']").val(realName);
				 		$("[name='P=OPENCLASS=FILENAME2=S=C']").val(updateName+extendName);
				 		$("[name='P=OPENCLASS=EXTENDNAME2=S=C']").val(extendName);
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