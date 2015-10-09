<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="java.io.File"%>
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
<title>新增学科</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
.uploadifyQueueItem{
  	width: 240px !important;
}
</style>
</head>
<%
request.setCharacterEncoding("utf-8");
String operateType = request.getParameter("operateType");
boolean bool = false;
if(Validate.noNull(operateType)){
	CUDHelper cudHelper = new CUDHelper(request,"=",null);
	bool = cudHelper.execute();
	
}
String path = request.getContextPath();
%>
<body>
<div class="tool"></div>
	<form   class="sm_edit_from" style="height: 225px;width: 365px;margin-top: 40px;margin-left: 80px;" method="post" action="">
		<input type="hidden" name="operateType" value="C">
		<input type="hidden" name="P=COURSE=COURSE_ID=S=P" value="">
		<input type="hidden" name="P=COURSE=CREATETIME=D=C" value="">
		<input type="hidden" class="clr" name="P=COURSE=IMGNAME=S=C" value="">
		<input type="hidden" class="clr" name="P=COURSE=IMGPATH=S=C" value="">
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name">学科名称</div>
			<div class="sm_edit_td_value" >
			<input type="text" style="width: 260px;" class="maxLength:200num null" name="P=COURSE=COURSE_NAME=S=C" value="<%=request.getParameter("P=COURSE=COURSE_NAME=S=C")==null?"":request.getParameter("P=COURSE=COURSE_NAME=S=C")%>"></div>
		</div>
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name" style="height: 100px; ">描述</div>
			<div class="sm_edit_td_value" >
			<textarea style="height: 100px;width: 262px;" class="maxLength:200num" name="P=COURSE=REMARK=S=C" ></textarea>
			</div>
		</div>	
		<div class="sm_edit_tr" style="height: 75px;width: 280px; ">
			<div class="sm_edit_td_name" style="height: 73px;">缩略图</div>
			<div class="sm_edit_td_value">
				<input type="file"  id="fileInput" />
				<div id="fileQueue" style="width:640px;float:left"></div>
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
					var img = $("[name='P=COURSE=IMGPATH=S=C']").val();
					if(img==""||img==null){
						alert("请上传缩略图");
					}else{
						if(validateBySubmit($("form"))){
							$("form").submit();
						}
					}
				}
			} ]);
			$(".delimp").live("click",function(){
				var obj = $(this);
				if(confirm("确认删除？")){
					var filename = $("[name='P=COURSE=IMGPATH=S=C']").val();
					 $.ajax({
							type: "POST",
							url: "<%=path%>/FileDelete",
							data: "filename="+filename,
							success : function(){ 
							}
					});
					$(".clr").val("");
					obj.parent().remove();
				}
			});
			$(document).ready(function(){
				<%
				String sp = File.separator;
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
						var resultArray=response.split(",");
						var fileName = resultArray[0];
						var file = resultArray[1];
						var html='<img name="'+file+'" style="width: 16px;height:16px; float:right; "  class="delimp" src="<%=path%>/ggs/skin/default/image/delete.bmp"/>';
						$(html).prependTo("#fileInput"+ID);
				 		var realName=fileName.substring(32,fileName.lastIndexOf("."));
				 		var extendName=fileName.substring(fileName.lastIndexOf("."));
				 		var updateName=fileName.substring(0,32);
						$("#filesize").val(fileObj.size/1024);
				 		$("[name='P=COURSE=IMGNAME=S=C']").val(realName+extendName);
				 		$("[name='P=COURSE=IMGPATH=S=C']").val("<%=toPath%>"+updateName+extendName);
				 	} ,
				 	'onCancel': function(event,ID,fileObj,data) {
				 	}
			    }); 
			});
			setPageSize();
		});
		function setPageSize() {	}
	</script>
</body>
</html>