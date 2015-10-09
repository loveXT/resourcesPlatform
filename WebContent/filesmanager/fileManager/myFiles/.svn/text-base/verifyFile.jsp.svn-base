<%@page import="java.util.ArrayList"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="com.googosoft.questionbank.questionbank.PointManager"%>
<%@page import="com.googosoft.common.util.Validator"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.filesManager.fileManager.FolderController"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
<%@page import="com.googosoft.filesManager.fileManager.FileManager"%>
<%@page import="com.googosoft.filesManager.fileManager.DeleteFiles"%>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.ggs.homeManager.Power"%>
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
<title>文件列表信息</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.sm_edit_from select{
		width:154px;
		height:20px;
	}
	.sm_edit_td_name{
		width:50px;
	}
	.mytool{
		margin-top: 3px;
		margin-right:5px;
		float:left;
	}
	#major,#chapter,#course,#point{
		width:130px;
	}
	.sm_edit_td_value input{
		width:120px;
	}
	.sm_edit_td_value select{
		width:120px;
	}
	.sm_goSearch_btn_init{
		margin-left: 5px;
	}
	.sm_edit_td_name{
		margin-top: 3px;
		padding-bottom: 0px;
	}
	.sm_edit_td_value{
		width: 150px;
	}
</style>
<%	
	//获取当前用户对该页面的权限
	String operate = OperationCache.getOperation(request);
	//设置页面的编码格式
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	//得到文件的路径
	String sp = File.separator;
    String path = request.getContextPath();  
	String serverPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String downbase=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    String basePath = request.getRealPath("/");  
  	//获取文件所属专业Id、课程Id、章节Id、知识点Id
    String Major_Id = request.getParameter("MAJOR_ID");
	String COURSE_ID = request.getParameter("COURSE_ID");
	//String CHAPTER_ID = request.getParameter("CHAPTER_ID");
	//String POINT_ID = request.getParameter("POINT_ID");
    //试题文件的绝对地址
	String downFilePath =basePath + IUploadImgContants.IMGPATH;
	String downURL = request.getContextPath()+"/DownLoad/";
	//设置页面分页
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	//得到文件Id进行增删改查
	String Fid = request.getParameter("Fid");
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	String ids = request.getParameter("P_FILES_FILEID_S_WD");
	if(Validate.noNull(operateType)){
		if(operateType.equals("D")){
			String sps = File.separator;
			String toPath = request.getRealPath(sps) + IUploadImgContants.IMGPATH;
			DeleteFiles df = DeleteFiles.getInstance();
			df.judgeIds(ids,toPath);
		}
		bool = new CUDHelper(request,"_",null).execute();
	}
%>
<body>

	<form class="sm_edit_from" id="pageForm" style="background:#B5E1FF;" method="post" action="verifyFile.jsp">
	<div class="tool">
		<div class="mytool">
<!-- 		&nbsp;&nbsp;&nbsp;审核状态: -->
		<select class="flag" name="FLAG" onchange="flag();">
		<option value="" selected >全部</option>
			<option value="11">待审核</option>
			<option value="22">已审核</option>
			
<!-- 		<option value="33">打回</option> -->
		</select>
		</div>
	</div>

		<!-- 配置文件的基本属性 -->
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_FILES_FILEID_S_WD" value="">
		
		<!-- 查询条件 -->
		<div class="sm_edit_tr" style="border-left: 1px solid #84b8f1;width:auto;">
			<div class="sm_edit_td_name" >专业</div>
			<div class="sm_edit_td_value">
				<select id="major"   class="pageSelect" name="MAJOR_ID" onchange="addMajor();">
					<option id="default" value="">----选择专业----</option>
					<option value="public">公共基础课</option>
				<%
				SelectFilesManager selectFiles = new SelectFilesManager();
				List majorList = selectFiles.findPageInfo();
				Map majorMap;
				for(int i=0;i<majorList.size();i++){
					majorMap = (Map)majorList.get(i);
					%>
					<option value="<%=majorMap.get("MAJOR_ID")%>"><%=majorMap.get("MAJOR_NAME")%></option>
					<%
				}
				%>
				</select>
			</div>
			<div class="sm_edit_td_name">课程</div>
			<div class="sm_edit_td_value">
				<select id="course" name="COURSE_ID" onchange="addCourse();">
					<option value="">----选择课程----</option>
				<%
				List courseList = new ArrayList();
				if(Validate.noNull(Major_Id)){
					courseList = selectFiles.findCourseByMajorId(Major_Id);
				}
				Map courseMap;
				for(int i=0;i<courseList.size();i++){
					courseMap = (Map)courseList.get(i);
					%>
					<option value="<%=courseMap.get("COURSE_ID")%>"><%=courseMap.get("COURSE_NAME")%></option>
					<%
				}
				%>
				</select>
			</div>
<!-- 			<div class="sm_edit_td_name">章节</div> -->
<!-- 			<div class="sm_edit_td_value"> -->
<!-- 				<select id="chapter" name="CHAPTER_ID" onchange="addChapter();"> -->
<!-- 					<option value="">----选择章节----</option> -->
<%-- 				<% --%>
<!-- 				List chapterList = new ArrayList(); -->
<!-- 				if(Validate.noNull(COURSE_ID)){ -->
<!-- 					 chapterList = selectFiles.findChapterByCourseId(COURSE_ID); -->
<!-- 				} -->
<!-- 				Map chapterMap; -->
<!-- 				for(int i=0;i<chapterList.size();i++){ -->
<!-- 					chapterMap = (Map)chapterList.get(i); -->
<!-- 					%> -->
<%-- 					<option value="<%=chapterMap.get("CHAPTER_ID")%>"><%=chapterMap.get("CHAPTER_NAME")%></option> --%>
<%-- 					<% --%>
<!-- 				} -->
<!-- 				%> -->
<!-- 				</select> -->
<!-- 			</div> -->
<!-- 			<div class="sm_edit_td_name">知识点</div> -->
<!-- 					<div class="sm_edit_td_value"> -->
<!-- 						<select id="point" name="POINT_ID" onchange="addPoint();"> -->
<!-- 							<option value="">----选择知识点----</option> -->
<%-- 						<% --%>
<!-- 						PointManager pointManager = new PointManager(); -->
<!-- 						List pointList = new ArrayList(); -->
<!-- 						if(Validate.noNull(CHAPTER_ID)){ -->
<!-- 							pointList = pointManager.findPointByChapterId(CHAPTER_ID); -->
<!-- 						} -->
<!-- 						Map pointMap; -->
<!-- 						for(int i=0;i<pointList.size();i++){ -->
<!-- 							pointMap = (Map)pointList.get(i); -->
<!-- 							%> -->
<%-- 							<option value="<%=pointMap.get("POINT_ID")%>"><%=pointMap.get("POINT_NAME")%></option> --%>
<%-- 							<% --%>
<!-- 						} -->
<!-- 						%> -->
<!-- 						</select> -->
<!-- 					</div> -->
			<div class="sm_edit_td_name">上传人</div> 
			<div class="sm_edit_td_value">
				<input name="P_Q_LIKE_UM.USERNAME" type="text"
					value="<%=request.getParameter("P_Q_LIKE_UM.USERNAME") == null
					? ""
					: request.getParameter("P_Q_LIKE_UM.USERNAME")%>" >
			</div>
				<div class="sm_edit_td_value" style="width: 377px;">
				<div class="select sm_goSearch_btn_init">查询</div>
				<div class="sm_goSearch_back sm_goSearch_btn_init">清空</div>
			</div>
		</div>
	</form>
	
<div class="sm_list">
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input type="checkbox"></td>
				<td style="width: 100px;">文件名</td>
				<td style="width: 100px;">所属专业</td>
				<td style="width: 100px;">所属课程</td>
				<td style="width: 100px;">所属章节</td>
				<td style="width: 100px;">所属知识点</td>
				<td style="width: 60px;">下载权限</td>
				<td style="width: 100px;">上传人</td>
				<td style="width: 100px;">审核人</td>
				<td style="width: 60px;">精品课程</td>
				<td style="width: 80px;">审核状态</td>
				<td style="width: 150px;">上传时间</td>
			</tr>
		</table>
		<table>
			<%
				FilesManager filesManager = new FilesManager();
				PageInfo pageInfo = null;
				pageInfo = filesManager.findPageInfoByFILES(nowPage, pageSize, "_", request);
				List list = pageInfo.getList();
				Map map;
				PointManager pointManager = new PointManager();
				for(int i=0;i<list.size();i++){
					map = (Map)list.get(i);
					Map	pMap = pointManager.findMapByPOINT_ID((String)map.get("POINT_ID"));
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i+1 %></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" name="<%=i %>" value="<%=map.get("FILEID")%>">
				<input type="hidden" name="swfpath" value="<%=map.get("SWFPATH")%>">
				<input type="hidden" class="checkedddd" value="<%=map.get("FLAG") %>">
				<input type="hidden" class="POINT_NAME" value="<%=pMap.get("POINT_NAME") %>">
				<input type="hidden" class="yinren" value=<%=map.get("FILENAME") %>>
				<input type="hidden" class="majordddd" value="<%=map.get("MAJOR_NAME")%>">
				<input type="hidden" class="courseddd" value="<%=map.get("COURSE_NAME")%>">
				<input type="hidden" class="charpterddd" value="<%=map.get("CHAPTER_NAME")%>">
				<input type="hidden" class="filenamennn" value="<%=map.get("FALSENAME")%>">
				
				</td>
				<td style="width: 100px;"><%=map.get("FULLNAME")==null?"":map.get("FULLNAME") %></td>
				<td style="width: 100px;" ><%=Validator.isNull(map.get("MAJOR_NAME"))?"公共基础课":map.get("MAJOR_NAME") %></td>
				<td style="width: 100px;" ><%=map.get("COURSE_ID")==null?"":map.get("COURSE_NAME") %></td>
				<td style="width: 100px;" class="chapter"><%=map.get("CHAPTER_NAME")==null?"":map.get("CHAPTER_NAME") %></td>
				<td style="width: 100px;" ><%=pMap.get("POINT_NAME")==null?"":pMap.get("POINT_NAME") %></td>
				<td style="width: 60px;"><%=map.get("DOWNLOAD")==null?"":"00".equals(map.get("DOWNLOAD"))?"是":"否" %></td>
				<td style="width: 100px;"><%=map.get("UPLOADER")==null?"": map.get("UPLOADER")%></td>
				<td style="width: 100px;">
				<%
					if("22".equals(map.get("FLAG"))){
						%>
						<%=map.get("CHECKERNAME")==null?"":map.get("CHECKERNAME") %>
						<%
					}
				%>
				
				
				</td>
				<td style="width: 60px;"><%="T".equals(map.get("ISEXCELLENT"))?"是":"F".equals(map.get("ISEXCELLENT"))?"否":"" %></td>
				<td style="width: 80px;" ><%="11".equals(map.get("FLAG"))?"待审核":"22".equals(map.get("FLAG"))?"通过":"打回" %></td>
				<td style="width: 150px;"><%=map.get("CREATETIME")==null?"":map.get("CREATETIME")%>
				<%if(ProcessFileUtil.isVideoFile(map.get("EXTENDNAME"))){%>
					<input type="hidden" name="justmov" value="movie">
				<%}else if(ProcessFileUtil.isPriviewNoVideo(map.get("EXTENDNAME"))){%>	
					<input type="hidden" name="justmov" value="notmovie">
				<%}else{%>
					<input type="hidden" name="justmov" value="elsezip">
				<%}%>
				</td>
			</tr>
			<%}%>	
		</table>
	</div>
<%@include file="/ggs/include/page.inc"%>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript" src="<%=path %>/js/jquery.zclip.js"></script>
<script type="text/javascript">
		$(function() {
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
			
			//对选中的文件进行审核
			$(".tool").toolBar([ {
				text : "审核",
				width : 60,
				position : "-240px -100px",
<%-- 				model:"verify_<%=operate%>",  --%>
				handler : function() {
					var id = "";
					var swfFile = $(".sm_list table").eq(1).find(":checkbox").filter(":checked").parent().find('[name=swfpath]').val();
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					var verify = $checkeds.siblings(".checkedddd").val();
					var down = $checkeds.siblings(".yinren").val();
					var major = $checkeds.siblings(".majordddd").val();
					var course = $checkeds.siblings(".courseddd").val();
					var charpter = $checkeds.siblings(".charpterddd").val();
					var filenamed = $checkeds.siblings(".filenamennn").val();
					if($checkeds.length!=1){
						alert("只能选择一条信息进行操作");
					}else{
						if("11"!=verify){
							alert("该文件资料已审核，请勿重复审核！");
						} else{
							var majorId = $("[name=MAJOR_ID]").val();
							var courseId = $("[name=COURSE_ID]").val();
							var chapterId = $("[name=CHAPTER_ID]").val();
							var pointId = $("[name=POINT_ID]").val();
							var userName = $("[name='P_Q_LIKE_UM.USERNAME']").val();
							
						
							var id = $checkeds.val();
							var name = $checkeds.parent().parent().parent().find("[name=justmov]").val();
							if(name=="movie"){
								var src = "moviecheck.jsp";
								var fileName = $checkeds.next().val();
								src += "?fileId="+id+"&fileName="+fileName+".flv&marjorId="+majorId+"&courseId="+courseId+"&chapterId="+chapterId+"&pointId="+pointId+"&userName="+userName;
								jumpWindow("审核文件",625,500,src);
							
							} else if(name=="notmovie"){
								var src = "viewcheck.jsp";
								src += "?fileId="+id+"&swfFile="+swfFile+"&marjorId="+majorId+"&courseId="+courseId+"&chapterId="+chapterId+"&pointId="+pointId+"&userName="+userName;
								jumpWindow("审核文件","800px","800px",src);
							} else {
								var src = "checkZip.jsp";
								src += "?fileId="+id+"&swfFile="+swfFile+"&down="+down+"&major="+major+"&course="+course+"&charpter="+charpter+"&filenamed="+filenamed+"&userName="+userName;
								src += "&swfFile="+swfFile+"&marjorId="+majorId+"&courseId="+courseId+"&chapterId="+chapterId+"&pointId="+pointId;
								jumpWindow("审核文件","600px","360px",src);
							}
						}
					}
				}
			}  ]);
			
			//回显专业
			var msjorObj = $("#major");
			var majorlength = $("#major option").length;
			var major = '<%=Validate.isNullToDefault(Major_Id,"")%>';
			var str1 = "";
			for(var i=0;i<majorlength;i++){
				str1 = msjorObj[0].options[i].value;
				if(str1 == major){
					msjorObj[0].options[i].selected = true;
				}
			}
			
			//回显课程
			var courseObj = $("#course");
			var courselength = $("#course option").length;
			var course = '<%=Validate.isNullToDefault(COURSE_ID,"")%>';
			var str2 = "";
			for(var i=0;i<courselength;i++){
				str2 = courseObj[0].options[i].value;
				if(str2 == course){
					courseObj[0].options[i].selected = true;
				}
			}
			
			//回显章节
			var chapterObj = $("#chapter");
			var chapterlength = $("#chapter option").length;
			var chapter = '';
			var str3 = "";
			for(var i=0;i<chapterlength;i++){
				str3 = chapterObj[0].options[i].value;
				if(str3 == chapter){
					chapterObj[0].options[i].selected = true;
				}
			}
			
			//回显知识点
			var folderObj = $("#point");
			var folderlength = $("#point option").length;
			var folder = '';
			var str4 = "";
			for(var i=0;i<folderlength;i++){
				str4 = folderObj[0].options[i].value;
				if(str4 == folder){
					folderObj[0].options[i].selected = true;
				}
			}
			
			//回显审核状态
			var obj = $("[name='FLAG']");
			var flag = "<%=request.getParameter("FLAG")%>";
			if(flag == "11"){
				obj[0].options[1].selected = true;
			}else if(flag == "22"){
				obj[0].options[2].selected = true;
			}else{
				obj[0].options[0].selected = true;
			}
			
			//清空输入查询内容
			$(".sm_goSearch_back").click(function(){
				clear();
			});
			//查询按钮
			$(".select").click(function(){
				$("#pageForm").submit();
			});
			setPageSize();
		});
		
		//查看各种审核状态的文件
		function flag(){
			clear();
			$("#pageForm").submit();
		}
		
		function clear(){
			var msjorObj = $("#major");
			msjorObj[0].options[0].selected = true;
	    	$("[id=course] option").remove();
	    	$("[id=course]").append('<option value="">----选择课程----</option>');
	    	$("[id=chapter] option").remove();
	    	$("[id=chapter]").append('<option value="">----选择章节----</option>');
		    $("[id=point] option").remove();
		    $("[id=point]").append('<option value="">----选择知识点----</option>');
		    $("[name='P_Q_LIKE_UM.USERNAME']").val("");
		}
		
		//根据专业查询课程
		function addMajor(){
			var majorId = $("#major").val();
			var url = "selectCourse.jsp";
		    var params="type=1&pkId="+majorId;
		    jQuery.getJSON(url,params,function callback(data){
		    	$("[id=course] option").remove();
		    	$("[id=course]").append('<option value="">----选择课程----</option>');
		    	$("[id=chapter] option").remove();
		    	$("[id=chapter]").append('<option value="">----选择章节----</option>');
			    $("[id=point] option").remove();
			    $("[id=point]").append('<option value="">----选择知识点----</option>');
	 			jQuery.each(data,function(i,item){
		 	    	$("[id=course]").append(
		 	    		'<option value="'+item.COURSE_ID+'">'+item.COURSE_NAME+'</option>'
		 	    	);
	 			});
	 		});
		}
		//根据课程查询章节
		function addCourse(){
			var courseId = $("#course").val();
			var url = "selectCourse.jsp";
		    var params="type=2&pkId="+courseId;
		    jQuery.getJSON(url,params,function callback(data){
		    	$("[id=chapter] option").remove();
		    	$("[id=chapter]").append('<option value="">----选择章节----</option>');
			    $("[id=point] option").remove();
			    $("[id=point]").append('<option value="">----选择知识点----</option>');
	 			jQuery.each(data,function(i,item){
		 	    	$("[id=chapter]").append(
		 	    		'<option value="'+item.CHAPTER_ID+'">'+item.CHAPTER_NAME+'</option>'
		 	    	);
	 			});
	 		});
		}
		//根据章节查询知识点
		function addChapter(){
			var chapterObj = $("#chapter");
			var chapterId = chapterObj.val();
			var url = "<%=request.getContextPath()%>\\filesmanager\\fileManager\\selectCourse.jsp";
			var params="type=4&pkId="+chapterId;
			jQuery.getJSON(url,params,function callback(data){
			    $("[id=point] option").remove();
			    $("[id=point]").append('<option value="">----选择知识点----</option>');
		 		jQuery.each(data,function(i,item){
			 	    $("[id=point]").append(
			 	    	'<option value="'+item.POINT_ID+'">'+item.POINT_NAME+'</option>'
			 	   	);
		 		});
		 	});
		}
		
		function setPageSize() {
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".page"),$(".sm_edit_from")]);
		}

		//分享
		$(function(){
			$('.shareddom').zclip({
				path:'<%=serverPath%>/js/ZeroClipboard.swf',
			    copy:function(){
			    	return '<%=downbase%>'+$(this).siblings('.downloadfile').attr('href');
			    }
		   	 });
		});
	</script>
</body>
</html>