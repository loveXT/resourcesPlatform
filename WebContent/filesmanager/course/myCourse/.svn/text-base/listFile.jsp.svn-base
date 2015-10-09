<%@page import="com.googosoft.common.util.Validator"%>
<%@page import="com.googosoft.filesManager.course.DeleteFiles"%>
<%@page import="com.googosoft.filesManager.course.CourseManager"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.filesManager.fileManager.FolderController"%>
<%@page import="com.googosoft.filesManager.fileManager.FileManager"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
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
<%@page import="java.util.ArrayList"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教案管理列表</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.sm_edit_from select{
		width:120px;
		height:20px;
	}
	.sm_edit_from{
		height: 65px;
	}
	.sm_edit_td_name{
		width:30px;
		margin-top: 3px;
	}
	.mytool{
		display:inline;
		font-size: 12px;
		height: 22px;
		float: left;
		margin-right: 3px;
	}
	#state{
		margin-top: 3px;
	}
	.sm_edit_td_value {
		width: 120px;
	}
	.sm_goSearch_btn_init{
		margin-left: 0px;
	}
</style>
<%	
	String operate = OperationCache.getOperation(request);
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	String sp = File.separator;
    String path = request.getContextPath();  
    String basePath = request.getRealPath("/");  
    String Major_Id = request.getParameter("MAJOR_ID");
	String COURSE_ID = request.getParameter("COURSE_ID");
	String CHAPTER_ID = request.getParameter("CHAPTER_ID");
	String CLASSID=request.getParameter("CLASSID");
	String downFilePath =basePath + IUploadImgContants.IMGPATH;
	//跳转到文件下载的servlet所需的路径以及文件名
	String downURL = request.getContextPath()+"/CDownLoad/";
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	String majorId = request.getParameter("MAJOR_ID");
	String courseId = request.getParameter("COURSE_ID");
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	String ids = request.getParameter("P_TEACHPLAN_PLANID_S_WD");
	if(Validate.noNull(operateType)){
		if(operateType.equals("D")){
			String sps = File.separator;
			String toPath = request.getRealPath(sps) + IUploadImgContants.IMGPATH;
			DeleteFiles df = DeleteFiles.getInstance();
			df.judgeIds(ids,toPath);
		}
		bool = new CUDHelper(request,"_",null).execute();
	}
	//增加时判断左侧结构数列是否选中末级
%>
<body>

	<form style="background:#B5E1FF;" class="sm_edit_from" id="pageForm"  method="post" action="listFile.jsp">
	<div>
		<div class="tool">
			<div class="mytool">
				<select id="state" name="state"  onchange="changeName()">
					<!-- <option>--文件状态--</option> -->
					<option value="">查询全部</option>
					<option value="sub" <% if("sub".equals(Validate.isNullToDefault(request.getParameter("state"),"").toString())){%>selected="selected"<%} %>>未提交</option>
					<option value="ver" <% if("ver".equals(Validate.isNullToDefault(request.getParameter("state"),"").toString())){%>selected="selected"<%} %>>打回</option>
					<option value="dver" <% if("dver".equals(Validate.isNullToDefault(request.getParameter("state"),"").toString())){%>selected="selected"<%} %>>待审核</option>
					<option value="verd" <% if("verd".equals(Validate.isNullToDefault(request.getParameter("state"),"").toString())){%>selected="selected"<%} %>>审核已通过</option>
				</select>
			</div>
		</div>
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_TEACHPLAN_PLANID_S_WD" value="">
		<input type="hidden" name="P_TEACHPLAN_PLANID_S_WU" value="">
<!--		<input type="hidden" name="P_TEACHPLAN_FLAG_S_S" value="">-->
		<input type="hidden" name="P_TEACHPLAN_COMMIT_S_S" value="">
		<div class="sm_edit_tr" style="solid #84b8f1;width:auto;">
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
				if(Validate.noNull(majorId)){//Major_Id
					courseList = selectFiles.findCourseByMajorId(majorId);
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
			<div class="sm_edit_td_name">章节</div>
			<div class="sm_edit_td_value">
				<select id="chapter" name="CHAPTER_ID" onchange="addChapter();">
					<option value="">----选择章节----</option>
			<%
				List chapterList = new ArrayList();
				if(Validate.noNull(courseId)&&Validate.noNull(majorId)){
					chapterList = selectFiles.findChapterByCourseId(courseId);
				}
				Map chapterMap;
				if(courseList.size()>0){
			%>
					<option value="add">(添加章节)</option>
			<%
				}
				for(int i=0;i<chapterList.size();i++){
					chapterMap = (Map)chapterList.get(i);
			%>
					<option value="<%=chapterMap.get("CHAPTER_ID")%>"><%=chapterMap.get("CHAPTER_NAME")%></option>
			<%
				}
			%>
				</select>
			</div>
			<div class="sm_edit_td_name">班级</div>
			<div class="sm_edit_td_value">
				<select id="class"  name="CLASSID" >
					<option value="">----选择班级----</option>
			<%
				List classList = new ArrayList();
				if(Validate.noNull(Major_Id)){
					classList = selectFiles.findClassByMajorId(Major_Id);
				}
				Map classMap;
				for(int i=0;i<classList.size();i++){
					classMap = (Map)classList.get(i);
			%>
					<option value="<%=classMap.get("GID")%>"><%=classMap.get("BJMC")%></option>
			<%
				}
			%>
				</select>
			</div>
				<div class="sm_edit_td_value" style="width: 377px;">
				<div class="shangchuan sm_goSearch_btn_init" >上传</div>
				<div class="sm_goSearch_back sm_goSearch_btn_init" >清空</div>
			</div>
		</div>
	</div>
	</form>
<div class="sm_list">	
	<table>
		<tr>
			<td style="width: 30px;" class="sm_index"></td>
			<td style="width: 30px;" class="sm_index">
				<input type="checkbox">
			</td>
			<td style="width: 180px;">文件名</td>
			<td style="width: 100px;">所属专业</td>
			<td style="width: 100px;">所属课程</td>
			<td style="width: 120px;">所属班级</td>
			<td style="width: 80px;">优秀教案</td>
			<td style="width: 100px;">状态</td>
			<td style="width: 150px;">上传时间</td>
			<td style="width: 150px;">审核时间</td>
			<td style="width: 170px;">操作</td>
		</tr>
	</table>
	<table>
		<%
			String state=request.getParameter("state");
			CourseManager filesManager = new CourseManager();
			PageInfo pageInfo = null;
			pageInfo = filesManager.findPageInfoByCOURSE(nowPage, pageSize, "_", request,state);
			List list = pageInfo.getList();
			Map map;
			for(int i=0;i<list.size();i++){
				map = (Map)list.get(i);
		%>
		<tr>
			<td style="width: 30px;" class="sm_index"><%=i+1 %></td>
			<td style="width: 30px;" class="sm_index">
			<input type="checkbox" name="<%=i %>" value="<%=map.get("PLANID")%>">
			<input type="hidden" class="classddd" value="<%=map.get("CLASSID") %>">
			<input type="hidden" class="majorddd" value="<%=map.get("MAJOR_ID") %>">
			<input type="hidden" class="checkedddd" value="<%=Validate.isNullToDefault(map.get("FLAG"),"")%>">
			<input type="hidden" class="iscommit" value="<%=Validate.isNullToDefault(map.get("COMMIT"),"")%>">
			</td>
			<!--文件名-->
			<td style="width: 180px;">
				<%=map.get("PLANNAME")==null?"":map.get("PLANNAME") %>
				<%=map.get("EXTENDNAME")==null?"":map.get("EXTENDNAME") %>
			</td>
			<td style="width: 100px;" ><%=Validator.isNull(map.get("MAJOR_NAME"))?"公共基础课":map.get("MAJOR_NAME") %></td>
			<td style="width: 100px;" ><%=map.get("COURSE_NAME")==null?"":map.get("COURSE_NAME") %></td>
			<td style="width: 120px;" ><%=map.get("BJMC")==null?"":map.get("BJMC") %></td>
			<td style="width: 80px;"><%=map.get("ISEXCELLENT")==null?"":"T".equals(map.get("ISEXCELLENT"))?"是":"否" %></td>
			<td style="width: 100px;">
			<%
				if("00".equals(Validate.isNullToDefault(map.get("COMMIT"),""))
						&&"11".equals(Validate.isNullToDefault(map.get("FLAG"),"").toString())){
			%>
					未提交
			<%
				}else if("00".equals(map.get("COMMIT"))
						&&"22".equals(Validate.isNullToDefault(map.get("FLAG"),"").toString())){
			%>
					打回
			<%
				}else if("11".equals(map.get("COMMIT"))
						&&("22".equals(Validate.isNullToDefault(map.get("FLAG"),"").toString())
							||"11".equals(Validate.isNullToDefault(map.get("FLAG"),"").toString()))){
			%>
					待审核
			<%
				}else if("11".equals(map.get("COMMIT"))
						&&"44".equals(Validate.isNullToDefault(map.get("FLAG"),"").toString())){
			%>
					审核已通过
			<%
				}
			%>
			</td>
			<!--创建时间-->
			<td style="width: 150px;"><%=map.get("CREATETIME")==null?"": map.get("CREATETIME")%></td>
			<!--审核时间-->
			<td style="width: 150px;"><%=Validate.isNullToDefault(map.get("CHECKEDTIME"),"")%></td>
			
			<td style="width: 170px;">
			<%	
					if(ProcessFileUtil.isVideoFile(map.get("EXTENDNAME"))){
			%>
					<input type="hidden" name = "justmov"   value="movie">
					&nbsp;<a onclick="lookView('<%=map.get("SWFPATH")%>')" href="#">在线预览</a>&nbsp;
			<%
					}else if(ProcessFileUtil.isPriviewNoVideo(map.get("EXTENDNAME"))){
			%>	
					<input type="hidden" name = "justmov"   value="notmovie">
					<a href="<%=request.getContextPath()+"\\filesmanager\\course\\view.jsp?swfFile="%><%=map.get("SWFPATH")%>">在线预览</a>
			<%
					}else{
						%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<%
						}
			%>
					<input type="hidden" name="swfpath<%=i %>" value="<%=map.get("SWFPATH") %>">
			<%
				if("00".equals(map.get("DOWNLOAD"))){
			%>
				<a href="<%=downURL%>?fileName=<%=map.get("REALNAME")%>">下载</a>
			<%
				}
			%>
			</td>
		</tr>		
			<%
				}
			%>	
	</table>
</div>
<%@include file="/ggs/include/page.inc"%>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function() {
		jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
		$("td:contains('审核已通过')").css("color","green");
		//修改按钮
		var updateObj = {
			text : "修改",
			width : 90,
			position : "-360px -100px",
			handler : function() {
				var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
				var classId = $checkeds.siblings(".classddd").val();
				var class_Id=$("[name='CLASSID']").val();						
				var verify = $checkeds.siblings(".checkedddd").val();
				var majorId = $("[name='MAJOR_ID']").val();
				var courseId = $("[name='COURSE_ID']").val();
				var chapterId = $("[name='CHAPTER_ID']").val();
				var state = $("[name='state']").val();
				if($checkeds.length!=1){
					alert("只能选择一条信息进行操作");
				}else{
					if('44'==verify){
						alert('已经通过审核，不可修改！');
					}else{
					var id = $checkeds.val();
					var src = "updateFile.jsp";
					src += "?planId="+id + "&CLASSID="+class_Id+"&MAJOR_ID="+majorId;
					src += "&COURSE_ID="+courseId + "&CHAPTER_ID="+chapterId+"&classId="+classId;
					src += "&state="+state;
					jumpWindow("修改文件名称","350px","180px",src);
					}
				}
			}
		};
			
		//删除按钮	
		var deleteObj = {
			text : "删除",
			width : 60,
			position : "-180px -160px",
				handler : function() {
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
// 					var verify = $checkeds.siblings(".checkedddd").val();
					if($checkeds.length<1){
						alert("最少选择一条信息进行操作");
					}else{
						var ids = [];
						var $this;
						var flag=true;
						$checkeds.each(function(){
							$this = $(this);
							var verify=$this.siblings(".checkedddd").val();
							ids.push($this.val());
							if(verify=='44'){
								flag=false;
								return;
							}
						});
						if(!flag){
							alert('已经审核通过，不可删除！');
						}else{
							if(confirm('确认删除？')){
								$("[name=operateType]").val("D");
								$("[name=P_TEACHPLAN_PLANID_S_WD]").val(ids.join("','"));
								$("#pageForm").submit();
							}
						}
					}
				}
		};
			
		//提交按钮	
		var submitObj = {
			text : "提交",
			width : 60,
			position : "-240px -100px",
			handler : function() {
				var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
				var verify = $checkeds.siblings(".checkedddd").val();
				var iscommit = $checkeds.siblings(".iscommit").val();
				if($checkeds.length!=1){
					alert("只能选择一条信息进行操作！");
				}else{
					if('44'==verify){
						alert('审核已通过，请勿重复提交！');
						return;
					}else if('44'!=verify&&'11'==iscommit){
						alert('该资料正在审核，请勿重复提交！');
						return;
					}else{
						if(confirm('确认提交？')){//staflag
						var pid= $checkeds.val();
						$("[name=operateType]").val("U");
						$("[name=P_TEACHPLAN_PLANID_S_WU]").val(pid);
						//$("[name=P_TEACHPLAN_FLAG_S_S]").val('33');
						$("[name=P_TEACHPLAN_COMMIT_S_S]").val('11');
						$("#pageForm").submit();
						} 
					}
				}
			}
		};
		
		//按钮的样式
		var verifys = $("#state").val();
		if("sub" != verifys && "ver" != verifys && "dver" != verifys && "" != verifys ){
			//若选择审核与否，则不显示前面的按钮
			$(".tool").toolBar([]);
		}else{
			//若选择未提交和打回，则显示前面三个按钮
			//按钮的顺序
			$(".tool").toolBar([updateObj,deleteObj,submitObj]);
		}
			
		//回显专业
		var msjorObj = $("#major");
		var majorlength = $("#major option").length;
		var major = '<%=request.getParameter("MAJOR_ID")==null?"":request.getParameter("MAJOR_ID")%>';
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
		var course = '<%=request.getParameter("COURSE_ID")==null?"":request.getParameter("COURSE_ID")%>';
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
		var chapter = '<%=request.getParameter("CHAPTER_ID")==null?"":request.getParameter("CHAPTER_ID")%>';
		var str3 = "";
		for(var i=0;i<chapterlength;i++){
			str3 = chapterObj[0].options[i].value;
			if(str3 == chapter){
				chapterObj[0].options[i].selected = true;
			}
		}
		
		//回显班级
		var classObj = $("#class");
		var classlength = $("#class option").length;
		var classid = '<%=request.getParameter("CLASSID")==null?"":request.getParameter("CLASSID")%>';
		var str4 = "";
		for(var i=0;i<classlength;i++){
			str4 = classObj[0].options[i].value;
			if(str4 == classid ){
				classObj[0].options[i].selected = true;
			}
		}
			
		//回显状态
		var stateObj = $("#state");
		var statelength = $("#state option").length;
		var sname = '<%=request.getParameter("state")==null?"":request.getParameter("state")%>';
		var str5 = "";
		for(var i=0;i<statelength;i++){
			str5 = stateObj[0].options[i].value;
			if(str5 == sname ){
				stateObj[0].options[i].selected = true;
			}
		}
	
		//清空输入查询内容
		$(".sm_goSearch_back").click(function(){
			msjorObj[0].options[0].selected = true;
	    	$("[id=course] option").remove();
	    	$("[id=course]").append('<option value="">----选择课程----</option>');
	    	$("[id=chapter] option").remove();
	    	$("[id=chapter]").append('<option value="">----选择章节----</option>');
	    	$("[id=class] option").remove();
	    	$("[id=class]").append('<option value="">----选择班级----</option>');
		});
			
		//上传
		$(".shangchuan").click(function(){
			var length1 = $('#chapter').val().length;
			// var length2=$('#class').val().length;
			if(length1<=0){
				alert("请选择章节!");
			}
			// else if(length2<=0){
			// 	alert('请选择班级');
			// }
			else{
				var majorId = $("[name='MAJOR_ID']").val();
				var courseId = $("[name='COURSE_ID']").val();
				var chapterId = $("[name='CHAPTER_ID']").val();
				var classId=$("[name='CLASSID']").val();
				var src = "addFile.jsp?Major_id="+majorId+"&COURSE_ID="+courseId
				+"&CHAPTER_ID="+chapterId+"&CLASSID="+classId;
				jumpWindow("上传文件","590px","250px",src);
			}
		
		});
		setPageSize();
	});
	
	//根据专业查询课程和班级
	function addMajor(){
		var majorId = $("#major").val();
		var url = "selectCourse.jsp";
	    var params="type=1&pkId="+majorId;
	    addClass(url,majorId);
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
		
	//选择班级
	function addClass(url,majorId){
		var params="type=5&pkId="+majorId;
		jQuery.getJSON(url,params,function callback(data){
	    	$("[id=class] option").remove();
	    	$("[id=class]").append('<option value="">----选择班级----</option>');
 			jQuery.each(data,function(i,item){
	 	    	$("[id=class]").append(
	 	    		'<option value="'+item.GID+'">'+item.BJMC+'</option>'
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
	    	$("[id=chapter]").append('<option value="add">(添加章节)</option>');
 			jQuery.each(data,function(i,item){
	 	    	$("[id=chapter]").append(
	 	    		'<option value="'+item.CHAPTER_ID+'">'+item.CHAPTER_NAME+'</option>'
	 	    	);
 			});
 		});
	}
		
	//选择'添加章节'
	function addChapter(){
		var chapterObj = $("#chapter");
		if(chapterObj.val() == "add"){
			var majorId = $("[name='MAJOR_ID']").val();
			var courseId = $("[name='COURSE_ID']").val();
			var src = "addChapter.jsp?majorId="+majorId+"&courseId="+courseId;
			chapterObj[0].options[0].selected = true;
			jumpWindow("添加章节","800px","500px",src);
		}
	}
		
	//查询状态
	function changeName(){
		$("#pageForm").submit();
	}
	
	//在线预览
	function lookView(src){
		src = "<%=request.getContextPath()%>\\filesmanager\\fileManager\\playVideo.jsp?fileName="+src+".flv";
		jumpWindow("在线预览",625,480,src);
	}
	 
	// 设置页面属性,增加页面滚动条 
	function setPageSize() {
		setWidth($(".sm_list"),$("body"));
		setHeight($(".sm_list"),$("body"),[$(".page"),$(".sm_edit_from")]);
	}
</script>
</body>
</html>