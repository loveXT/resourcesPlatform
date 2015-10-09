<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.oa.navigation.NavigationManager"%>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="com.googosoft.oa.webContent.WebContentManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.commons.CodeHelper"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<html>
<%//文本编辑器得到路径
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
pageContext.setAttribute("path", basePath); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网页内容增加</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	String operateType = request.getParameter("operateType");
	String sp = File.separator;
	Boolean bool = false;
	if (Validate.noNull(operateType)) {
		bool = new CUDHelper(request, "=", null).execute();
		String fileName = request.getParameter("P=WEBCONTENT=PICTURE=S=C");
		String toPath = request.getRealPath(sp)
				+ IUploadImgContants.IMGPATH;
		toPath = toPath + fileName;
	}
%>
<body style="overflow-y: scroll;">
<div class="tool"></div>
	<div style="width:705px;margin-left: 20px;margin-top: 10px;text-align:center;font-size:16px;font-weight:bold;line-height:30px;letter-spacing:5px;">新增网页内容</div>
		<form class="sm_edit_from" method="post" action="" style="margin-left: 20px;margin-top: 10px;width: 705px;">
			<input type="hidden" name="operateType" value="C">
			<input type="hidden" name="P=WEBCONTENT=ID=S=P" value="">
			<input type="hidden" name="P=WEBCONTENT=UPDATETIME=S=C" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>">
			<input type="hidden" name="P=WEBCONTENT=USERID=S=C" value="<%=(String)request.getSession().getAttribute("USERIDBYLOGIN")%>">
			<input type="hidden" name="P=WEBCONTENT=PICTURE=S=C" value="">
			<input type="hidden" name="P=WEBCONTENT=SMALLPICTURE=S=C" value="">
			<div class="sm_edit_tr" style="height: 45px;">
				<div class="sm_edit_td_name" style="height: 35px;">标题</div> 
				<div class="sm_edit_td_value" style="height: 35px;">
					<input class="null" name="P=WEBCONTENT=TITLE=S=C" style="width: 598px; height: 30px;"> 
				</div>
			</div>
			<div class="sm_edit_tr"	 style="height: 260px;">
				<div class="sm_edit_td_name"	style="height: 250px;">内容</div>
				<div class="sm_edit_td_value"style="width: 600px; height: 250px;" >
				<textarea name="P=WEBCONTENT=CONTENT=S=C" id="textareas" class="null" style="width: 600px; height: 250px;" ></textarea>
				</div>
			</div>
			<div class="sm_edit_tr" style="height: 95px;">
				<div class="sm_edit_td_name" style="height: 85px;">描述</div> 
				<div class="sm_edit_td_value" style="height: 85px;">
					<textarea name="P=WEBCONTENT=DESCRIPTION=S=C" style="width: 600px; height: 80px;"></textarea> 
				</div>
			</div>
			<div class="sm_edit_tr">
				<div class="sm_edit_td_name">选择类别</div> 
				<div class="sm_edit_td_value" style="width: 180px;">
				<%  List list = new NavigationManager().findAllListByNavigation();
				    Map navMap=null;
				%>
					<select name="P=WEBCONTENT=NAVIGATIONID=S=C" class="null">
					<%
						for(int i=0;i<list.size();i++){ 
							navMap=(Map)list.get(i);
					%>
						<option value="<%=Validate.isNullToDefault(navMap.get("ID"), "")%>"><%=Validate.isNullToDefault(navMap.get("NAVIGATIONNAME"), "")%></option>
					<% } %>
					</select>
				</div>
				
				<div class="sm_edit_td_name" >上传缩略图</div> 
				<div class="sm_edit_td_value" style="width: 290px;margin-left:10px;">
					是<input type="radio" class="null" name="P=WEBCONTENT=SFSCSLT=S=C" value="1">
					否<input type="radio" class="null" name="P=WEBCONTENT=SFSCSLT=S=C" checked="checked" value="0">
				</div>
			</div>
			<div class="sm_edit_tr" id="smallImage" style="height: 70px;display:none;">
				<div class="sm_edit_td_name" style="height: 60px;">缩略图</div>
				<div class="sm_edit_td_value">
					<input type="file" id="fileInput"/>
					<div id="filesQueue" style="float:left"></div>
				</div>
			</div>
		</form>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript" src="<%=path%>/kindeditor-4.1.2/kindeditor.js"></script>
<script type="text/javascript">
		$(function() {
			$(".tool").toolBar([{
				text : "返回",
				width : 50,
				position : "-340px -100px",
				handler : function() {
					window.parent.location.reload();
				}
			},{
				text : "保存",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("[name=operateType]").val("C");
						var pictureName = $("[name='P=WEBCONTENT=PICTURE=S=C']").val();
						if(pictureName!=null && pictureName!=""){
							$("[name='P=WEBCONTENT=SMALLPICTURE=S=C']").val("pic_"+pictureName);
						};
						$("form").submit();
						window.parent.location.reload();
					}
				}
			} ]);
			$("[name='P=WEBCONTENT=SFSCSLT=S=C']").change(function(){
				$("#smallImage").toggle();
			});
			var editor;
			KindEditor.ready(function(K) {
			        editor = K.create('#textareas',{
			        	afterBlur : function() {
		        		this.sync();
		        	}});
			});
			$(".delimp").live("click",function(){
				var obj = $(this);
				var img = $(this).attr("src");
				if(confirm("确认删除？")){
					var filename = $("[name='P=WEBCONTENT=PICTURE=S=C']").val();
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
			 		$("[name='P=WEBCONTENT=PICTURE=S=C']").val(updateName+extendName);//本地名字
			 		$("[name='P=WEBCONTENT=PICTURENAME=S=C']").val(realName+extendName);//源名字
			 		window.parent.desktopManager(resultArray[0]);
			 	} ,
			 	'onCancel': function(event,ID,fileObj,data) {
			 	}
		    });
		});
		function setPageSize() {
		}
	</script>
</body>
</html>