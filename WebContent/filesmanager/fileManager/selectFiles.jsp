<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.questionbank.questionbank.PointManager"%>
<%@page import="com.googosoft.baseInfoManager.NjbbxkRelation"%>
<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<%@page import="com.googosoft.questionbank.questionbank.MajorManager"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@page import="com.googosoft.filesManager.fileManager.CategoryManager" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList" %>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件信息</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.sm_list select{
		width:154px;
		height:20px;
	}
	.sm_edit_td_name{
		width:60px;
	}
	.sm_edit_td_value {
		width:120px;
	}
	.sm_edit_td_value input{
		width:116px;
	}
	.sm_edit_td_value select{
		width:120px;
	}
</style>
<%	
	//获取服务相关路径
	String path = request.getContextPath();  
	String serverPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String downbase=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
// 	String operate = OperationCache.getOperation(request);
	
	String EXTENDNAME = request.getParameter("EXTENDNAME");
	//设置编码格式
	request.setCharacterEncoding("UTF-8");
	//设置分页信息 
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	String downURL = request.getContextPath()+"/DownLoad/";
	//执行增删改查操作
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"_",null).execute();
	}
%>
<body>
<!-- 设置综合查询条件 -->

		<form class="sm_edit_from" id="pageForm" style="background:#B5E1FF;" method="post" action="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType">
<!-- 设置专业选择 -->
			<div class="sm_edit_tr" style="border-left: 1px solid #84b8f1;width:auto;">
				<!-- <div class="sm_edit_td_name" >专业</div> -->
				<!-- <div class="sm_edit_td_value"> -->
					<!-- <select id="major" name="T.MAJOR_ID" onchange="addMajor();">
						<option id="default" value="">----选择专业----</option>
					<option value="public">公共基础课</option> -->
				<%
				SelectFilesManager selectFiles = new SelectFilesManager();
				List majorList = selectFiles.findPageInfo();
				Map majorMap;
				for(int i=0;i<majorList.size();i++){
					majorMap = (Map)majorList.get(i);
					%>
					<%-- <option value="<%=majorMap.get("MAJOR_ID")%>"><%=majorMap.get("MAJOR_NAME")%></option> --%>
					<%
				}
				%>
				<!-- </select> -->
			<!-- </div> -->
<!-- 设置课程选择 -->
			<div class="sm_edit_td_name">课程</div>
			<div class="sm_edit_td_value">
				<select id="course" name="P=Q=LIKE=T.COURSE_ID" onchange="addCourse();">
					<option value="">----选择课程----</option>
				<%-- <%
				String majorId = request.getParameter("T.MAJOR_ID");
				List courseList = selectFiles.findCourseByMajorId(majorId);
				Map courseMap;
				for(int i=0;i<courseList.size() && majorId != null && !majorId.equals("");i++){
					courseMap = (Map)courseList.get(i);
					%> 
					 <option value="<%=courseMap.get("COURSE_ID")%>"><%=courseMap.get("COURSE_NAME")%></option> 
					 <%
				}
				%> --%>
				<%
				NjbbxkRelation njbbxkRelation = new NjbbxkRelation();
				List courseList = new ArrayList();
				courseList = njbbxkRelation.findListNjbbxkRelation();
				Map courseMap;
				for(int i=0;i<courseList.size();i++){
					courseMap = (Map)courseList.get(i);
					%>
					<option value="<%=courseMap.get("KCID")%>"><%=courseMap.get("COURSENAME")%></option>
					<%
				}
					%>
				
				</select>
			</div>
<!-- 设置章节选择 -->
			<div class="sm_edit_td_name">章节</div>
			<div class="sm_edit_td_value">
				<select id="chapter" name="P=Q=LIKE=T.CHAPTER_ID" onchange="addChapter();">
					<option value="">----选择章节----</option>
				<%
				String courseId = request.getParameter("P=Q=LIKE=T.COURSE_ID");
				List chapterList = selectFiles.findChapterByCourseId(courseId);
				Map chapterMap;
				for(int i=0;i<chapterList.size() && courseId != null && !courseId.equals("");i++){
					chapterMap = (Map)chapterList.get(i);
					%>
					<option value="<%=chapterMap.get("CHAPTER_ID")%>"><%=chapterMap.get("CHAPTER_NAME")%></option>
					<%
				}
				%>
				</select>
			</div>
<!-- 设置知识点选择 -->
			<div class="sm_edit_td_name">知识点</div>
					<div class="sm_edit_td_value">
						<select id="point" name="P=Q=LIKE=T.POINT_ID" onchange="addPoint();">
							<option value="">----选择知识点----</option>
						<%
						PointManager pointManager = new PointManager();
						String chapterId = request.getParameter("P=Q=LIKE=T.CHAPTER_ID");
						List pointList = pointManager.findPointByChapterId(chapterId);
						Map pointMap;
						for(int i=0;i<pointList.size() && chapterId != null && !chapterId.equals("") ;i++){
							pointMap = (Map)pointList.get(i);
							%>
							<option value="<%=pointMap.get("POINT_ID")%>"><%=pointMap.get("POINT_NAME")%></option>
							<%
						}
						%>
						</select>
					</div>
		</div>
		<div class="sm_edit_tr" style="border-left: 1px solid #84b8f1;width:auto;">
			<div class="sm_edit_td_name">文件名称</div>
			<div class="sm_edit_td_value">
				<input type="text" class="clear" name="FALSENAME" value="<%=Validate.isNullToDefault(request.getParameter("FALSENAME"),"")%>"/>
			</div>
			<div class="sm_edit_td_name">下载权限</div>
			<div class="sm_edit_td_value">
				<select name="P=Q=LIKE=DOWNLOAD">
					<option value="">----全部----</option>
					<option value="00">是</option>
					<option value="11">否</option>
				</select>
			</div>
			<div class="sm_edit_td_name">上传人</div>
			<div class="sm_edit_td_value">
				<input type="text" class="clear" name="P=Q=LIKE=UPLOADER"  value="<%=Validate.isNullToDefault(request.getParameter("P=Q=LIKE=UPLOADER"),"")%>"/>		
			</div>
		<%-- 	<div class="sm_edit_td_name">审核人</div>
			<div class="sm_edit_td_value">
				<input type="text" class="clear" name="P=Q=LIKE=CHECKEDER" value="<%=Validate.isNullToDefault(request.getParameter("P=Q=LIKE=CHECKEDER"),"")%>"/>		
			</div> --%>
		</div>
		<div class="sm_edit_tr" style="border-left: 1px solid #84b8f1;width:auto;">
			<!-- <div class="sm_edit_td_name">优秀资源</div>
			<div class="sm_edit_td_value">
				<select name="P=Q=LIKE=ISEXCELLENT">
					<option value="">----全部----</option>
					<option value="T">是</option>
					<option value="F">否</option>
				</select>
			</div> -->
<!-- 时间段文件上传查询 -->
			<div class="sm_edit_td_name">上传时间</div>
			<div class="sm_edit_td_value">
				<input type="text" class="clear" name="starttime" readonly value="<%=Validate.isNullToDefault(request.getParameter("starttime"),"")%>"/>
			</div>
			<div class="sm_edit_td_name" style="text-align:center;">至</div>
			<div class="sm_edit_td_value">
				<input type="text" class="clear" name="endtime" readonly value="<%=Validate.isNullToDefault(request.getParameter("endtime"),"")%>"/>	
			</div>
			<div class="sm_edit_td_name">资源分类</div>
			<div class="sm_edit_td_value">
				<select id="EXTENDNAME" name="EXTENDNAME">
						<option value="" <%if(Validate.isNull(EXTENDNAME)){%>selected<%} %> >全部</option>
						
						<%
							CategoryManager categorymanager=new CategoryManager();
							List categorylist=categorymanager.findPageInfo();
							Map categoryMap;
							for(int i=0;i<categorylist.size();i++){
								categoryMap= (Map)categorylist.get(i);
							
						
						%>
						
						<option value="<%=categoryMap.get("ID") %>" <%if(categoryMap.get("ID").equals(EXTENDNAME)){%>selected<%} %>><%=categoryMap.get("NAME").toString()%></option>

						<%
							}
						%>
						<%-- <option value="00" <%if("00".equals(EXTENDNAME)){%>selected<%} %>>电子文件</option>
						<option value="01" <%if("01".equals(EXTENDNAME)){%>selected<%} %>>图片</option>
						<option value="02" <%if("02".equals(EXTENDNAME)){%>selected<%} %>>视频</option>
						<option value="03" <%if("03".equals(EXTENDNAME)){%>selected<%} %>>其他</option> --%>
					</select>	
			</div>
			<div class="sm_edit_td_value" style="width: 377px;">
				<div class="sm_goSearch_go sm_goSearch_btn_init">查询</div>
				<div class="sm_goSearch_back sm_goSearch_btn_init">清空</div>
			</div>
		</div>
		</form>
		<div class="sm_list">
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 100px;">文件名</td>
			<!-- 	<td style="width: 100px;">所属专业</td> -->
				<td style="width: 100px;">所属课程</td>
				<td style="width: 100px;">所属章节</td>
				<td style="width: 100px;">所属知识点</td>
				<td style="width: 60px;">下载权限</td>
				<td style="width: 100px;">上传人</td>
				<!-- <td style="width: 100px;">审核人</td> -->
				<!-- <td style="width: 60px;">优秀资源</td> -->
				<td style="width: 150px;">上传时间</td>
				<td style="width: 200px;">操作</td>
				<td style="width: 100px;">文件类型</td>
			</tr>
		</table>
		<table>
		
			<%
			//查询数据库获取文件相关信息及分页信息
				SelectFilesManager filesManager = new SelectFilesManager();
				PageInfo pageInfo = null;
				pageInfo = filesManager.findPageInfoByFILES(nowPage, pageSize, "=", request);
				List list = pageInfo.getList();
				Map map;
				for(int i=0;i<list.size();i++){
					map = (Map)list.get(i);
					String classify = null;
					CategoryManager categoryManagers=new CategoryManager();
					List categorylists=categoryManagers.findPageInfo();
					Map categoryMaps;
					for(int j=0;j<categorylists.size();j++){
						categoryMaps=(Map) categorylists.get(j);
						if(map.get("CLASSIFY").equals(categoryMaps.get("ID"))){
							classify=categoryMaps.get("NAME").toString();
						}
					}
					/* if(map.get("CLASSIFY")!=null){
						if(map.get("CLASSIFY").equals("00")){
							classify = "电子文件";
						}
						if(map.get("CLASSIFY").equals("01")){
							classify = "图片文件";
						}
						if(map.get("CLASSIFY").equals("02")){
							classify = "视频文件";
						}
						if(map.get("CLASSIFY").equals("03")){
							classify = "其他文件";
						}
					} */
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i+1 %></td>
				
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" value="<%=map.get("FILEID") %>">
				</td>
				<td style="width: 100px;"><%=map.get("FULLNAME")==null?"":map.get("FULLNAME") %></td>
				<%-- <td style="width: 100px;"><%=map.get("MAJOR_NAME")==null?"公共基础课":map.get("MAJOR_NAME")%></td> --%>
				<td style="width: 100px;"><%=map.get("COURSE_NAME")==null?"":map.get("COURSE_NAME")%></td>
				<td style="width: 100px;"><%=map.get("CHAPTER_NAME")==null?"":map.get("CHAPTER_NAME")%></td>
				<td style="width: 100px;"><%=map.get("POINT_NAME")==null?"":map.get("POINT_NAME")%></td>
				<td style="width: 60px;"><%=map.get("DOWNLOAD")==null?"":"00".equals(map.get("DOWNLOAD"))?"是":"否"%></td>
				<td style="width: 100px;"><%=map.get("UPLOADER")==null?"": map.get("UPLOADER")%></td>
				<%-- <td style="width: 100px;"><%=map.get("CHECKEDER")==null?"":map.get("CHECKEDER")%></td> --%>
<%-- 				<td style="width: 60px;"><%="T".equals(map.get("ISEXCELLENT"))?"是":"F".equals(map.get("ISEXCELLENT"))?"否":"" %></td>
 --%>				<td style="width: 150px;"><%=map.get("CREATETIME")==null?"":map.get("CREATETIME")%></td>
				<td style="width: 200px;">
					<div class="sharediv" style="position: relative;">
					<!-- 根据扩展名设置在线预览页面跳转操作 -->
					<%
						if(ProcessFileUtil.isVideoFile(map.get("EXTENDNAME"))){
					%>
						<input type="hidden" name = "justmov"   value="movie">
						
						&nbsp;<a onclick="lookView('<%=map.get("SWFPATH")%>')" href="#">在线预览</a>
					<%
						}else if(ProcessFileUtil.isPriviewNoVideo(map.get("EXTENDNAME"))){
					%>	
						<input type="hidden" name = "justmov"   value="notmovie">
						
						&nbsp;<a href="<%=request.getContextPath()+"\\filesmanager\\fileManager\\view.jsp?selectFiles=t&swfFile="%><%=map.get("SWFPATH")%>">在线预览</a>
					<%
						}else{
					%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="hidden" name = "justmov"   value="elsezip">
					<%
						}
					%>
					<input type="hidden" name="swfpath<%=i %>" value="<%=map.get("SWFPATH") %>">
<!-- 根据是否允许下载状态设置操作信息 -->
					<%
						if(map.get("DOWNLOAD").equals("00")){
					%>
						&nbsp;&nbsp;<a href="<%=downURL%>?fileName=<%=map.get("FILENAME")%>" class="downloadfile">下载</a>
						&nbsp;&nbsp;<a href="#" class="shareddom" >分享</a>		
						
					<%	
						}else{
					%>
						&nbsp;&nbsp;<a href="#" style="visibility: hidden;">下载</a>
						&nbsp;&nbsp;<a href="#" style="visibility: hidden;">分享</a>
					<%
						}
					%>
					</div>
				</td>
				<td style="width: 100px;"><%=classify==null?"":classify %>
			</tr>
			<%}%>
		</table>
	</div>
<%@include file="/ggs/include/page.inc"%>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript" src="<%=path %>/js/jquery.zclip.js"></script>
<script type="text/javascript">
		$(function() {
// 			$("#sm_search").hide();
			$('.shareddom').zclip({
				path:'<%=serverPath%>/js/ZeroClipboard.swf',
			    copy:function(){
			    	return '<%=downbase%>'+$(this).siblings('.downloadfile').attr('href');
			    }
		   	 });
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
			//固定时间格式
			$("[name='starttime']").bind("click",function(){
				WdatePicker({dateFmt:'yyyy-MM-dd'});
			});
			$("[name='endtime']").bind("click",function(){
				WdatePicker({dateFmt:'yyyy-MM-dd'});
			});
			
			//回显专业
			var msjorObj = $("#major");
			var majorlength = $("#major option").length;
			var major = '<%=request.getParameter("T.MAJOR_ID")==null?"":request.getParameter("T.MAJOR_ID")%>';
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
			var course = '<%=request.getParameter("P=Q=LIKE=T.COURSE_ID")==null?"":request.getParameter("P=Q=LIKE=T.COURSE_ID")%>';
// 			alert("回显课程:"+course);
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
			var chapter = '<%=request.getParameter("P=Q=LIKE=T.CHAPTER_ID")==null?"":request.getParameter("P=Q=LIKE=T.CHAPTER_ID")%>';
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
			var folder = '<%=request.getParameter("P=Q=LIKE=T.POINT_ID")==null?"":request.getParameter("P=Q=LIKE=T.POINT_ID")%>';
			var str4 = "";
			for(var i=0;i<folderlength;i++){
				str4 = folderObj[0].options[i].value;
				if(str4 == folder){
					folderObj[0].options[i].selected = true;
				}
			}
			//回显是否可以下载
			var downloadObj = $("[name='P=Q=LIKE=DOWNLOAD']");
			var downLoad = "<%=request.getParameter("P=Q=LIKE=DOWNLOAD")%>";
			if(downLoad == "00"){
				downloadObj[0].options[1].selected = true;
			}else if(downLoad == "11"){
				downloadObj[0].options[2].selected = true;
			}
			
			//回显是否是优秀资源
			var obj = $("[name='P=Q=LIKE=ISEXCELLENT']");
			var download = "<%=request.getParameter("P=Q=LIKE=ISEXCELLENT")%>";
			if(download == "T"){
				obj[0].options[1].selected = true;
			}else if(download == "F"){
				obj[0].options[2].selected = true;
			}
			
			//提交表单进行查询
			$(".sm_goSearch_go").click(function(){
				$("form[id='pageForm']").submit();
			});
			
			//清空输入查询内容
			$(".sm_goSearch_back").click(function(){
				msjorObj[0].options[0].selected = true;
		    	$("[id=course] option").remove();
		    	$("[id=course]").append('<option value="">----选择课程----</option>');
		    	$("[id=chapter] option").remove();
		    	$("[id=chapter]").append('<option value="">----选择章节----</option>');
		    	folderObj[0].options[0].selected = true;
				$(".clear").val("");
				obj[0].options[0].selected = true;
				downloadObj[0].options[0].selected = true;
			});
			setPageSize();
		});
// 视频在线预览
		function lookView(src){
			src = "<%=request.getContextPath()%>\\filesmanager\\fileManager\\playVideo.jsp?fileName="+src+".flv";
			jumpWindow("在线预览",625,480,src);
		}
// 选择专业	 
		function addMajor(){
			var majorId = $("#major").val();
			var url = "selectCourse.jsp";
		    var params="type=1&pkId="+majorId;
		    jQuery.getJSON(url,params,function callback(data){
		    	$("[id=course] option").remove();
		    	$("[id=course]").append('<option value="">----选择课程----</option>');
		    	$("[id=chapter] option").remove();
		    	$("[id=chapter]").append('<option value="">----选择章节----</option>');
	 			jQuery.each(data,function(i,item){
		 	    	$("[id=course]").append(
		 	    		'<option value="'+item.COURSE_ID+'">'+item.COURSE_NAME+'</option>'
		 	    	);
	 			});
	 		});
		}
// 选择课程
		function addCourse(){
			var courseId = $("#course").val();
			var url = "selectCourse.jsp";
		    var params="type=2&pkId="+courseId;
		    jQuery.getJSON(url,params,function callback(data){
		    	$("[id=chapter] option").remove();
		    	$("[id=chapter]").append('<option value="">----选择章节----</option>');
	 			jQuery.each(data,function(i,item){
		 	    	$("[id=chapter]").append(
		 	    		'<option value="'+item.CHAPTER_ID+'">'+item.CHAPTER_NAME+'</option>'
		 	    	);
	 			});
	 		});
		}
// 选择章节
		function addChapter(){
			var chapterObj = $("#chapter");
				var chapterId = chapterObj.val();
				var url = "selectCourse.jsp";
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
// 双击进行查看基本信息
		$(function(){
			$(".double").dblclick(function(){
				var id = $(this).parent().find(":checkbox").val();
				var src = "questionInfor.jsp";
				src+="?Qid=" +id;
				location.href = src;
			});
		});
// 设置页面属性,增加页面滚动条 
		function setPageSize() {
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".page"),$(".sm_edit_from")]);
		}
	</script>
</body>
</html>