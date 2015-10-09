<%@page import="com.googosoft.baseInfoManager.MainTypeManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.googosoft.questionbank.questionbank.PointManager"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.googosoft.filesManager.viewManager.StringConstant"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.filesManager.fileManager.FolderController"%>
<%@page import="com.googosoft.filesManager.fileManager.FileManager"%>
<%@page import="com.googosoft.filesManager.fileManager.CategoryManager" %>
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
	//接受参数,COURSE_ID课程编号,CHAPTER_ID章节编号,POINT_ID知识点编号
	String Fid = request.getParameter("Fid");
	String sp = File.separator;  
	String toPathreal = request.getRealPath(sp)+"upload";
	String COURSE_ID = request.getParameter("COURSE_ID");
	String CHAPTER_ID = request.getParameter("CHAPTER_ID");
	String POINT_ID = request.getParameter("POINT_ID");
	//folderName分类编号operateTypecud执行参数
	String folderName = request.getParameter("folderName");
	String operateType = request.getParameter("operateType");
	//分页设置,每页显示几条数据,和当前页
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null? "0": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null? "0": request.getParameter("nowPage"));
	boolean bool = false;
	String path = request.getContextPath();
	//根据页面上传文件类型,来分别进行处理(不同类型文件,需要不同的格式转换工作)
	if (Validate.noNull(operateType)) {
			bool = new CUDHelper(request, "=", null).execute();
			String fileName = request.getParameter("P=FILES=FILENAME=S=C");
			String toPath = request.getRealPath(sp)
					+ IUploadImgContants.IMGPATH;
			toPath = toPath + fileName;
			String extendName = request.getParameter("P=FILES=EXTENDNAME=S=C");
			List<String> extendList = Arrays.asList(StringConstant.AVALIABLETRANSFILES);
			//如果是视频格式,则跳转到uploadMovie.do进行执行格式转换工作
			if (extendName.equals(".rm") || extendName.equals(".rmvb")
					|| extendName.equals(".mp4") || extendName.equals(".flv")) {
				response.sendRedirect(request.getContextPath()+sp+"uploadMovie.do?POINT_ID="+POINT_ID+"&CHAPTER_ID="+CHAPTER_ID+"&COURSE_ID="+COURSE_ID+"&fileName="+fileName+"&h="+h+"&m="+m+"&s="+s+"&extendName="+extendName);
			} else if(extendName.equals(".pdf")){//pdf格式进行处理
				String noextendName = fileName.substring(0,
						fileName.lastIndexOf("."));
				String newPath = request.getRealPath(sp)
						+ IUploadImgContants.IMGPATH + noextendName
						+ ".pdf"; 
				ProcessFileUtil fileutil = new ProcessFileUtil();
				fileutil.transpdfToSwf(newPath);
				
			}else if(extendList.contains(extendName)){//其他格式进行处理
				ProcessFileUtil fileutil = new ProcessFileUtil();
				fileutil.transOreFileToSwf(toPath);
			}
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
	FolderController folderCtr = new FolderController();
	PageInfo pageInfo = null;
	pageInfo = folderCtr.findPageInfoByFOLDER1(nowPage, pageSize, "_", request, CHAPTER_ID, COURSE_ID, POINT_ID);
	List list = pageInfo.getList();
	Map map;
	map = (Map)list.get(0);
%>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="" style="margin-top: 1%;height: 340px;">
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P=FILES=FILEID=S=P" value="">
		<input type="hidden" name="P=FILES=FALSENAME=S=C" value="<%=request.getParameter("P=FILES=REALNAME=S=C")==null?"":request.getParameter("P=FILES=REALNAME=S=C")%>">
		<input type="hidden" name="P=FILES=FILESIZE=S=C" value="<%=request.getParameter("P=FILES=FILESIZE=S=C")==null?"":request.getParameter("P=FILES=FILESIZE=S=C")%>">
		<input type="hidden" name="h" value="">
		<input type="hidden" name="m" value="">
		<input type="hidden" name="s" value="">
		<input type="hidden" name="P=FILES=FLAG=S=C" value="22"/>
		<input type="hidden" name="P=FILES=ISCONVERTSUCESS=S=C" value="F"/>
		<input type="hidden" class="" name="P=FILES=FILENAME=S=C" value="<%=request.getParameter("P=FILES=FILENAME=S=C")==null?"":request.getParameter("P=FILES=FILENAME=S=C")%>" >
		<input type="hidden" name="P=FILES=FILEPATH=S=C" value="<%=request.getParameter("P=FILES=FILEPATH=S=C")==null?"":request.getParameter("P=FILES=FILEPATH=S=C")%>">
		<input type="hidden" readonly="readonly" class="" name="P=FILES=EXTENDNAME=S=C" value="<%=request.getParameter("P=FILES=EXTENDNAME=S=C")==null?"":request.getParameter("P=FILES=EXTENDNAME=S=C")%>">
		<input type="hidden" readonly="readonly" class="" name="P=FILES=SWFPATH=S=C" value="<%=request.getParameter("P=FILES=SWFPATH=S=C")==null?"":request.getParameter("P=FILES=SWFPATH=S=C")%>">
		<input type="hidden" class="uploader" name="P=FILES=UPLOADERID=S=C" value="<%=session.getAttribute("USERIDBYLOGIN")%>">
		<input type="hidden" class="" name="P=FILES=FILENAME2=S=C" value="<%=request.getParameter("P=FILES=FILENAME2=S=C")==null?"":request.getParameter("P=FILES=FILENAME2=S=C")%>" >
		<input type="hidden" readonly="readonly" class="" name="P=FILES=EXTENDNAME2=S=C" value="<%=request.getParameter("P=FILES=EXTENDNAME2=S=C")==null?"":request.getParameter("P=FILES=EXTENDNAME2=S=C")%>">
		<input type="hidden" readonly="readonly" class="" name="P=FILES=SWFPATH2=S=C" value="<%=request.getParameter("P=FILES=SWFPATH2=S=C")==null?"":request.getParameter("P=FILES=SWFPATH2=S=C")%>">
		<input type="hidden" class="uploader" name="P=FILES=UPLOADER=S=C" value="<%=mname.get("USERNAME") %>"><div class="sm_edit_tr">
		<div class="sm_edit_td_name">输入原文件名</div>
			<div class="sm_edit_td_value">
			<input type="text"  class="null" name="P=FILES=REALNAME=S=C" value="<%=request.getParameter("P=FILES=REALNAME=S=C")==null?"":request.getParameter("P=FILES=REALNAME=S=C")%>"></div>
			<div class="sm_edit_td_name">所属课程</div>
			<input type="hidden" name="P=FILES=COURSE_ID=S=C" value="<%=map.get("COURSE_ID")%>" >
			<div class="sm_edit_td_value"><input type="text"  readonly="readonly" value="<%=map.get("COURSE_NAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">所属章节</div>
			<input type="hidden" name="P=FILES=CHAPTER_ID=S=C" value="<%=map.get("CHAPTER_ID") %>">
			<div class="sm_edit_td_value"><input type="text"  readonly="readonly"  value="<%=map.get("CHAPTER_NAME")%>"></div>
			<div class="sm_edit_td_name">所属知识点</div>
		
			<%
			PointManager pointManager = new PointManager();
			Map pointMap = pointManager.findMapByPOINT_ID(POINT_ID);
			%>
			<div class="sm_edit_td_value">
				<input type="hidden" name="P=FILES=POINT_ID=S=C" value="<%=POINT_ID%>">
			<input type="text"  readonly="readonly"  value="<%=pointMap.get("POINT_NAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">所属类别</div>
			<div class="sm_edit_td_value">
				<select name="P=FILES=ZYMAINTYPEID=S=C" class="null" style="width:155px;">
				<option value="">--请选择类别--</option>
				 <%
				 	MainTypeManager mainTypeManager=new MainTypeManager();
					List typeList=mainTypeManager.findListMainTypeManager();
					Map typeMap;
					for(int i=0;i<typeList.size();i++){
						typeMap=(Map)typeList.get(i);		
				%>
					<option value="<%=typeMap.get("ID")%>"><%=typeMap.get("TYPENAME")%></option>	
				<%
						}
				%> 
					</select>
			</div>
			<div class="sm_edit_td_name">文件类型</div>
			<div class="sm_edit_td_value">
				<select name="P=FILES=CLASSIFY=S=C" class="null" style="width:155px;">
				<option value="">--请选择类型--</option>
				 <%
					CategoryManager categorymanager=new CategoryManager();
					List categorylist=categorymanager.findPageInfo();
					Map categoryMap;
					for(int i=0;i<categorylist.size();i++){
						categoryMap=(Map)categorylist.get(i);		
				%>
					<option value="<%=categoryMap.get("ID")%>"><%=categoryMap.get("NAME")%></option>	
				<%
						}
				%> 
					</select>
			</div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">上传时间</div>
			<div class="sm_edit_td_value">
			<%SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");%>
			<input id="Wdate"  name="P=FILES=CREATETIME=S=C" value="<%=sdf.format(new Date()) %>" style="width:150px;">
			</div>
			<div class="sm_edit_td_name">是否允许下载</div>
			<div class="sm_edit_td_value">
				<input type="hidden" name="P=FILES=DOWNLOAD=S=C">
				<input type="radio" name="download" value="00" checked="checked">允许 &nbsp; &nbsp;<input type="radio" name="download" value="11">不允许
			</div>
		</div>
		
		<div class="sm_edit_tr" style="height: 45px;">
			<div class="sm_edit_td_name" style="height: 45px;">资源描述</div>
			<div class="sm_edit_td_value">
<!-- 			<input type="text" class="null" name="P_FILES_REMARK_S_C" /> -->
			<textarea style="height:50px;width:420px;" class="maxLength:40num null" name="P=FILES=REMARK=S=C"><%=Validate.isNullToDefault(request.getParameter("P=FILES=REMARK=S=C"), "") %></textarea> 
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
					var filename = $("[name='P=FILES=FILENAME=S=C']").val();
					 $.ajax({
	 						type: "POST",
	 						url: "<%=path%>/FileDelete",
							data: "filename="+filename,
									success : function(){ 
	 						}
	 					});
					$("[name='P=FILES=REALNAME=S=C']").val("");
					obj.parent().remove();
				}
			});
			
	
		$(function() {
			$("[name='P=FILES=REALNAME=S=C']").blur(function(){
				var realname = $("[name='P=FILES=REALNAME=S=C']").val();
				$("[name='P=FILES=FALSENAME=S=C']").val(realname);
			})
			
			//判断如果页面提交,cud执行成功,把值传给父页面并刷新
			if("<%=bool%>"=="true"){
				var src = "listFile.jsp?POINT_ID=<%=POINT_ID%>&CHAPTER_ID=<%=CHAPTER_ID%>&COURSE_ID=<%=COURSE_ID%>";
				parent.location.href = src;
			}
			if("<%=request.getParameter("view")%>"=="true"){
				parent.location.href = "listFile.jsp?POINT_ID=<%=POINT_ID%>&CHAPTER_ID=<%=CHAPTER_ID%>&COURSE_ID=<%=COURSE_ID%>";
			}
			$(".tool").toolBar([ {
				text : "保存",
				width : 50,
				position : "-360px -100px",
				handler : function() {
					var download = document.getElementsByName("download");
					if(!download[0].checked){
						$("[name='P=FILES=DOWNLOAD=S=C']").val("11");
					}else {
						$("[name='P=FILES=DOWNLOAD=S=C']").val("00");
					}
					
					if(validateBySubmit($("form"))){
						$("[name=operateType]").val("C");
						$("form").submit();
					}
				}
			} ]);
			$("#Wdate").bind("click",function(){
				WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});
			});
			setPageSize();
			function setPageSize() {
				
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
				 	'fileExt':'*',
				 	'displayData': 'percentage', //有speed和percentage两种，一个显示速度，一个显示完成百分比
				 	'onComplete': function(event, ID, fileObj, response, data) {
				 		//response返回值：重命名后的文件名称,文件保存路径
				 		var html='<img  style="width: 16px;height:16px; float:right; "  class="delimp" src="<%=path%>/ggs/skin/default/image/delete.bmp"/>'
				 		$(html).prependTo("#fileInput"+ID);
				 		var resultArray=response.split(",");
				 		var filesize = fileObj.size/1024;
				 		var fileName = resultArray[0];
				 		var extendName=fileName.substring(fileName.lastIndexOf("."));
				 		var updateName=fileName.substring(0,32);
				 		var realName=fileName.substring(32,fileName.lastIndexOf("."));
				 		$("[name='P=FILES=FILESIZE=S=C']").val(filesize);
				 		$("[name='P=FILES=REALNAME=S=C']").val(realName);
				 		$("[name='P=FILES=FALSENAME=S=C']").val(realName);
				 		$("[name='P=FILES=FILEPATH=S=C']").val("<%=toPath%>"+updateName+extendName);
				 		$("[name='P=FILES=FILENAME=S=C']").val(updateName+extendName);
				 		$("[name='P=FILES=EXTENDNAME=S=C']").val(extendName);
				 		$("[name='P=FILES=SWFPATH=S=C']").val(updateName);
				 		window.parent.desktopManager(resultArray[0]);
				 	} ,
				 	'onCancel': function(event,ID,fileObj,data) {
				 	}
			    }); 
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
				 		$("[name='P=FILES=REALNAME2=S=C']").val(realName);
				 		$("[name='P=FILES=FALSENAME2=S=C']").val(realName);
				 		$("[name='P=FILES=FILENAME2=S=C']").val(updateName+extendName);
				 		$("[name='P=FILES=EXTENDNAME2=S=C']").val(extendName);
				 		$("[name='P=FILES=SWFPATH2=S=C']").val(updateName);
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