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
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教案审核列表</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.selects{width: 80px; }
	.sm_edit_from select{
		width:154px;
		height:20px;
	}
	.sm_edit_from {height: 90px; }
	.sm_edit_td_name{
		width:70px;
	}
	.mytool{
		display:inline;
		//position:absolute;
		left:70px;
		font-size: 12px;
		height: 22px;
 		margin-top: 3px;
 		margin-right: 3px;
 		float: left;
	}

	.sm_edit_from .sm_edit_tr .sm_edit_td_name{
		width: 60px;
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
	String CLASSID=request.getParameter("CLASSID");
	String uploader=request.getParameter("uploader");
    
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
	SelectFilesManager selectFiles = new SelectFilesManager();
	Boolean bool = false;
	
	String operateType =Validate.isNullToDefault(request.getParameter("operateType"),"").toString() ;
	String ids =Validate.isNullToDefault(request.getParameter("P_TEACHPLAN_PLANID_S_WD"),"").toString()   ;
	String courseId =Validate.isNullToDefault(request.getParameter("COURSE_ID"),"").toString()  ;
	String majorId =Validate.isNullToDefault(request.getParameter("MAJOR_ID"),"").toString()  ;
	
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
	
	Date dateNow = new Date();
	String nowDate=new SimpleDateFormat("yyyy-MM-dd").format(dateNow).toString();
	
	String beginTime =  request.getParameter("STARTTIME");
	if("--选择时间--".equals(beginTime)){
		beginTime=null; 
	}
	
	//查询的结束时间
	String endTime =  request.getParameter("ENDTIME");
	if("--选择时间--".equals(endTime)){
		endTime=null; 
	}
	
	String state=request.getParameter("state");
%>
<body>
	<form class="sm_edit_from" id="pageForm" style="background:#B5E1FF;" method="post" action="verifyFile.jsp">
	<div class="tool">
		<div class="mytool">
			<select id="state" name="state" value="" onchange="changeName();">
<!--				<option>--文件状态--</option>-->
				<option value="all" >查询全部</option>
				<option value="sub" >待审核</option>
				<option value="ver" >审核已通过</option>
			</select>
		</div>
	</div>
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_TEACHPLAN_PLANID_S_WD" value="">
		<div class="sm_edit_tr" style=" solid #84b8f1;width:auto;">
			<div class="sm_edit_td_name" >专业:</div>
			<div class="sm_edit_td_value">
				<select id="major"   class="pageSelect" name="MAJOR_ID" onchange="addMajor();">
					<option id="default" value="">----选择专业----</option>
					<option value="public">公共基础课</option>
				<%
				
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
			<div class="sm_edit_td_name">班级:</div>
			<div class="sm_edit_td_value">
				<select id="class"  name="CLASSID" >
					<option value="">----选择班级----</option>
				<%
				List classList=new ArrayList();
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
			<div class="sm_edit_td_name">上传人:</div>
			<div class="sm_edit_td_value">
				<input type="text" name="uploader"  value="<%=Validate.isNullToDefault(request.getParameter("uploader"),"")%>"/>
		</div>
		<br><br>
		<div>
			<div class="sm_edit_td_name" style="width: 80px;">
					<div id="riqi">审核日期：</div>
				</div>
				<div class="sm_edit_td_value">
				<%if(Validate.isNull(beginTime)){ %>
					<input class="selects" type="text" readonly name="STARTTIME" 
					value="--选择时间--">
				<%}else{ %>
					<input class="selects" type="text" readonly name="STARTTIME" 
					value="<%=beginTime%>">
				<%} %>
					
				</div>
				<div id="zhi" class="sm_edit_td_name" style="margin-left: -80px;margin-right: 35px;" >
					<div style="padding-top: 3px;">至</div>
				</div>
				<div class="sm_edit_td_value">
					<!--默认显示查询的结束日期-->
				<%if(Validate.isNull(endTime)){ %>	
					<input id="etime" class="selects" type="text" readonly name="ENDTIME" 
					value="--选择时间--">
				<%}else{ %>	
					<input id="etime" class="selects" type="text" readonly name="ENDTIME" 
					value="<%=endTime%>">
				<%} %>	
				</div>
			</div>
				<div class="sm_edit_td_value" style="width: 277px;">
				<div class="select sm_goSearch_btn_init">查询</div>
				<div class="sm_goSearch_back sm_goSearch_btn_init">清空</div>
			 </div>
		</div>
	</form>
<div class="sm_list" >
	<table>
		<tr>
			<td style="width: 30px;" class="sm_index"></td>
			<td style="width: 30px;" class="sm_index"><input
				type="checkbox"></td>
			<td style="width: 180px;">文件名</td>
			<td style="width: 100px;">所属专业</td>
			<td style="width: 100px;">所属课程</td>
			<td style="width: 100px;">所属章节</td>
			<td style="width: 120px;">所属班级</td>
			<td style="width: 60px;">下载权限</td>
			<td style="width: 110px;">上传人</td>
			<td style="width: 150px;">上传时间</td>
			<td style="width: 80px;">优秀教案</td>
			<td style="width: 100px;">审核状态</td>
			<td style="width: 150px;">审核时间</td>
			<td style="width: 120px;">审核人</td>
		</tr>
	</table>
	<table>
		<%
			//获取文件的查询状态
			
			CourseManager filesManager = new CourseManager();
			PageInfo pageInfo = null;
			pageInfo = filesManager.findPageInfoByCOMMIT
			(nowPage, pageSize, "_", request,state,beginTime,endTime
			,Major_Id,CLASSID,uploader	
			);
			List list = pageInfo.getList();
			Map map;
			String stateFlag="";
			String cheker="";
			CourseManager courseManager=new CourseManager();
			for(int i=0;i<list.size();i++){
				map = (Map)list.get(i);
		%>
		<tr>
			<input type="hidden" name="swfpath<%=i %>" value="<%=map.get("SWFPATH") %>">
			<td style="width: 30px;" class="sm_index"><%=i+1 %></td>
			<td style="width: 30px;" class="sm_index">
			<input type="checkbox" name="<%=i %>" value="<%=map.get("PLANID")%>">
<%-- 			<input type="hidden" value="<%=map.get("SWFPATH")%>"> --%>
			<input type="hidden" class="classddd" value="<%=map.get("CLASSID") %>">
			<input type="hidden" class="majorddd" value="<%=map.get("MAJOR_ID") %>">
			<input type="hidden" class="checkedddd" value="<%=map.get("FLAG") %>">
			</td>
			<!-- 文件名 -->
			<td style="width: 180px;">
			<%=map.get("PLANNAME")==null?"":map.get("PLANNAME") %>
			<%=map.get("EXTENDNAME")==null?"":map.get("EXTENDNAME") %>
			</td>
			<!-- 所属专业 -->
			<td style="width: 100px;" ><%=Validator.isNull(map.get("MAJOR_NAME"))?"公共基础课":map.get("MAJOR_NAME") %></td>
			<!-- 所属课程 -->
			<td style="width: 100px;" ><%=map.get("COURSE_NAME")==null?"":map.get("COURSE_NAME") %></td>
			<!-- 所属章节 -->
			<td style="width: 100px;" ><%=map.get("CHAPTER_NAME")==null?"":map.get("CHAPTER_NAME") %></td>
			<!-- 所属班级 -->
			<td style="width: 120px;" ><%=map.get("BJMC")==null?"":map.get("BJMC") %></td>
			<!-- 下载权限 -->
			<td style="width: 60px;"><%=map.get("DOWNLOAD")==null?"":"00".equals(map.get("DOWNLOAD"))?"是":"否" %></td>
			<!-- 上传人 -->
			<td style="width: 110px;"><%=map.get("UPLOADER")==null?"": map.get("UPLOADER")%></td>
			<!-- 上传时间 -->
			<td style="width: 150px;"><%=map.get("CREATETIME")==null?"": map.get("CREATETIME")%></td>
			<!-- 优秀资源 -->
			<td style="width: 80px;" ><%=map.get("ISEXCELLENT")==null?"":"T".equals(map.get("ISEXCELLENT"))?"是":"否" %></td>
			<!-- 审核状态 -->
			<td style="width: 100px;" >
			<% 
			stateFlag=Validate.isNullToDefault(map.get("FLAG"),"").toString();
			if("11".equals(stateFlag)){
				%>未审核<%
			}else if("22".equals(stateFlag)){
				%>待审核(打回过)<%
			}else if("11".equals(stateFlag)||"22".equals(stateFlag)){
				%>待审核<%
			}else if("44".equals(stateFlag)){
				%>审核已通过<%
			}
			%>
			</td>
			<!-- 审核时间 -->
			<td style="width: 150px;">
			<%=Validate.isNullToDefault(map.get("CHECKEDTIME"),"") %> </td>
			<!-- 审核人 -->
			<%
			if(Validate.noNull(map.get("CHECKEDER"))){
				String checkid=map.get("CHECKEDER").toString();
				Map cMap=new CourseManager().findMapByChecker(checkid);
				cheker=cMap.get("USERNAME").toString();
			}
			%>
			<td style="width: 120px;"><%=cheker==null?"":cheker %></td> 
			<%if(ProcessFileUtil.isVideoFile(map.get("EXTENDNAME"))){%>
				<input type="hidden" name="justmov" value="movie">
			<%}else if(ProcessFileUtil.isPriviewNoVideo(map.get("EXTENDNAME"))){%>	
				<input type="hidden" name="justmov" value="notmovie">
			<%}else{%>
				<input type="hidden" name="justmov" value="elsezip">
			<%}%>
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
			$("td:contains('审核已通过')").css("color","green");
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
			$(".tool").toolBar([ {
				text : "审核",
				width : 60,
				position : "-240px -100px",
				handler : function() {
					var swfFile = $(".sm_list table").eq(1).find(":checkbox").filter(":checked").parent().parent().parent().find('[name^=swfpath]').val();
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					var verify = $checkeds.siblings(".checkedddd").val();
					var major_Id = $("[name='MAJOR_ID']").val();
					var classId = $("[name='CLASSID']").val();
					var uploader = $("[name='uploader']").val();
					var state = $("[name='state']").val();
					if($checkeds.length!=1){
						alert("只能选择一条信息进行操作");
					}else{
						if("44"==verify){
							alert("该文件资料已审核，请勿重复审核！");
						} else{
							var id = $checkeds.val();
							var name = $checkeds.parent().parent().parent().find("[name=justmov]").val();
							if(name=="movie"){
								var src = "moviecheck.jsp";	
								var fileName = $checkeds.next().val();
								src += "?fileId="+id+"&fileName="+fileName+".flv";
								src += "&major_Id="+major_Id; 
								src += "&classId="+classId; 
								src += "&uploader="+uploader;
								src += "&state="+state;
								jumpWindow("在线预览",625,500,src);
							} else if(name=="notmovie"){
								var src = "viewcheck.jsp";
								src += "?fileId="+id+"&swfFile="+swfFile;
								src += "&major_Id="+major_Id; 
								src += "&classId="+classId; 
								src += "&uploader="+uploader;
								src += "&state="+state;
								jumpWindow("审核文件","800px","800px",src);
							} else {
								var src = "checkZip.jsp";
								src += "?fileId="+id;
								src += "&major_Id="+major_Id; 
								src += "&classId="+classId; 
								src += "&uploader="+uploader;
								src += "&state="+state;
								jumpWindow("审核文件","600px","360px",src);
							}
						}
					}
				}
			} ]);

			//回显专业
			var msjorObj = $("#major");
			var majorlength = $("#major option").length;
			var major = '<%=Major_Id%>';
			var str1 = "";
			for(var i=0;i<majorlength;i++){
				str1 = msjorObj[0].options[i].value;
				if(str1 == major){
					msjorObj[0].options[i].selected = true;
				}
			}
			
			//回显班级
			var classObj = $("#class");
			var classlength = $("#class option").length;
			var classid = '<%=CLASSID%>';
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
		    	$("[name=STARTTIME]").val('--选择时间--');
		    	$("[name=ENDTIME]").val('--选择时间--');
		    	$("[name=uploader]").val('');
			});
			
			$("[name='STARTTIME']").click(function(){
				WdatePicker({dateFmt:'yyyy-MM-dd'});
			});
			
			$("[name='ENDTIME']").click(function(){
				WdatePicker({dateFmt:'yyyy-MM-dd'});
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
		
		//查询按钮
		$(".select").click(function(){
			$("form[id='pageForm']").submit();
		});
		
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