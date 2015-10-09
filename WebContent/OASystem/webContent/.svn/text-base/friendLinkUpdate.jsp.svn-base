<%@page import="com.googosoft.oa.friendLink.FriendLinkManager"%>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<title>新增友情链接</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
#fileQueue {
	position: relative;
	border: 0px solid #999999;
	width: 415px;
	height: 50px;
	top: 5px;
	bottom: 5px;
	overflow: auto;
	background-color: #E1E1E1; 
	}	
#fujian{
		background-color: #F5F5F5;
		border: 2px solid #E5E5E5;
		font: 11px Verdana, Geneva, sans-serif;
		margin-top: 5px;
		padding: 10px;
		width: 240px;
	}
</style>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String sp = File.separator;
	String path = request.getContextPath();
	String operateType = request.getParameter("operateType");
	String id = request.getParameter("id");
	FriendLinkManager friendLinkManager = new FriendLinkManager();
	Map map = friendLinkManager.findMapByID(id);
	boolean bool = false;
	if(Validate.noNull(operateType)){
		CUDHelper cudHelper = new CUDHelper(request,"_",null);
		bool = cudHelper.execute();
	%>
	<script type="text/javascript">
		parent.location.reload(false);
		
		window.setTimeout(function(){
			parent.removeJumpWindow();
		}, 500);
	</script>
<%
	}
%>
<body>
<div class="tool"></div>
	<form class="sm_edit_from" style="height: 160px;width: 365px;margin-top: 30px;margin-left: 80px;" method="post" action="">
		<input type="hidden" name="operateType" value="U">
		<input type="hidden" name="P_FRIENDLINK_ID_S_WU" value="<%=id%>">
		<input type="hidden" class="clr" name="P_FRIENDLINK_IMAGE_S_S" value="<%=Validate.isNullToDefault(map.get("IMAGE"), "")%>">
		<input type="hidden" class="clr" name="P_FRIENDLINK_IMAGENAME_S_S" value="<%=Validate.isNullToDefault(map.get("IMAGENAME"), "")%>">
		<input type="hidden" name="P_FRIENDLINK_CREATETIME_S_S" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>">
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name" style="height: 20px;line-heihgt:20px;">名称</div>
			<div class="sm_edit_td_value" >
			<input type="text" style="width: 260px;line-heihgt:30px;" class="maxLength:200num null" name="P_FRIENDLINK_TITLE_S_S" value="<%=Validate.isNullToDefault(map.get("TITLE"), "")%>"></div>
		</div>
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name" style="height: 20px;line-heihgt:20px;">地址</div>
			<div class="sm_edit_td_value" >
			<input type="text" style="width: 260px;line-heihgt:30px;" class="null" name="P_FRIENDLINK_URL_S_S" value="<%=Validate.isNullToDefault(map.get("URL"), "")%>"></div>
		</div>
		<div class="sm_edit_tr"  style="height: 20px;width: 280px;" >
			<div class="sm_edit_td_name" style="height: 20px;line-heihgt:30px;">排列顺序</div>
			<div class="sm_edit_td_value" style="width: 100px;">
				<input type="text" style="width: 47px;line-heihgt:30px;" class="number null" name="P_FRIENDLINK_PLSX_S_S" value="<%=Validate.isNullToDefault(map.get("PLSX"), "")%>">
			</div>
		</div>
		<div class="sm_edit_tr" id="smallImage" style="height: 70px;">
			<div class="sm_edit_td_name" style="height: 60px;">链接图片<font style="color:red">*</font></div>
			<div class="sm_edit_td_value">
				<input type="file" id="fileInput"/>
				<div id="filesQueue"  style="float:left">
					<%if(Validate.noNull(map.get("IMAGE"))){%>
					    <div id="fujian">
					   		<div class="filename" style="width:200px;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;float:left;"><%=Validate.isNullToDefault(map.get("IMAGENAME"), "")%></div>
							<img name="<%=Validate.isNullToDefault(map.get("IMAGENAME"), "") %>" 
							style="width: 16px;height:16px;float: right;" class="delimp" src="<%=path%>/ggs/skin/default/image/delete.bmp"><br>
					    </div>
					  <% }%>
				</div>
			</div>
		</div>
	</form>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
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
			$(".delimp").live("click",function(){
				var obj = $(this);
				if(confirm("确认删除？")){
					var filename = $("[name='P_FRIENDLINK_IMAGE_S_S']").val();
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
			
			<%
				String toPath = request.getRealPath(sp) + IUploadImgContants.IMGPATH;
				toPath = toPath.replace(sp,sp+sp);
			%>
			$('#fileInput').uploadify({
		    	'uploader': '<%=pathSkinTool%>/tool/uploadify/uploadify.swf',
			    'script': '<%=path%>/UploadServlet?TOPATH=<%=toPath%>',	//指定服务端处理类的入口 
			 	'cancelImg' : '<%=pathSkinTool%>/tool/uploadify/cancel.png',
			    'queueID': 'filesQueue',
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
			 		$(html).prependTo("#fileInput"+ID);
			 		var resultArray=response.split(",");
			 		var fileName = resultArray[0];
			 		var realName=fileName.substring(32,fileName.lastIndexOf("."));
			 		var extendName=fileName.substring(fileName.lastIndexOf("."));
			 		var updateName=fileName.substring(0,32);
			 		$("[name='P_FRIENDLINK_IMAGENAME_S_S']").val(realName+extendName);//文件源文件名
			 		$("[name='P_FRIENDLINK_IMAGE_S_S']").val(updateName+extendName);//本地存放名
			 		$(".uploadifyQueueItem").css("width","240px");
			 		window.parent.desktopManager(resultArray[0]);
			 	} ,
			 	'onCancel': function(event,ID,fileObj,data) {
			 	}
		    });
			setPageSize();
		});
		function setPageSize() {}
</script>
</body>
</html>