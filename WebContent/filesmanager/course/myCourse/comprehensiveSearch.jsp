<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.filesManager.course.CourseManager"%>
<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<%@page import="com.googosoft.questionbank.questionbank.MajorManager"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="com.googosoft.common.util.Validator"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教案综合查询</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.sm_list select{
		width:154px;
		height:20px;
	}
	.sm_edit_td_name{
		width:80px;
	}
</style>
<%	
	//获取服务相关路径
	String path = request.getContextPath();  
	String serverPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String downbase=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String operate = OperationCache.getOperation(request);
	//设置编码格式
	request.setCharacterEncoding("UTF-8");
	
	String majorId = request.getParameter("T.MAJOR_ID");
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
			<div class="sm_edit_td_name" >专业</div>
			<div class="sm_edit_td_value">
				<select id="major" name="T.MAJOR_ID" onchange="addMajor();">
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
				<%}%>
				</select>
			</div>
			<!-- 设置班级选择 -->
			<div class="sm_edit_td_name">班级</div>
			<div class="sm_edit_td_value">
				<select id="classes"  name="classes" >
					<option value="">----选择班级----</option>
			<%
				List classList = new ArrayList();
				if(Validate.noNull(majorId)){
					classList = selectFiles.findClassByMajorId(majorId);
				}
				Map classMap;
				for(int i=0;i<classList.size();i++){
					classMap = (Map)classList.get(i);
			%>
					<option value="<%=classMap.get("GID")%>"><%=classMap.get("BJMC")%></option>
			<%}%>
				</select>
			</div>
			<div class="sm_edit_td_name">文件名称</div>
			<div class="sm_edit_td_value">
				<input type="text" class="clear" name="FALSENAME" value="<%=Validate.isNullToDefault(request.getParameter("FALSENAME"),"")%>"/>
			</div>
			</div>
			<div class="sm_edit_tr" style="border-left: 1px solid #84b8f1;width:auto;">
			<div class="sm_edit_td_name">上传人</div>
			<div class="sm_edit_td_value">
				<input type="text" class="clear" name="uploader"  value="<%=Validate.isNullToDefault(request.getParameter("uploader"),"")%>"/>		
			</div>
			<div class="sm_edit_td_name">优秀资源</div>
			<div class="sm_edit_td_value">
				<select name="isExcellent" id="isExcellent">
					<option value="">----全部----</option>
					<option value="T">是</option>
					<option value="F">否</option>
				</select>
			</div>
		</div>
		<div class="sm_edit_tr" style="border-left: 1px solid #84b8f1;width:auto;">
		<!-- 时间段文件上传查询 -->
			<div class="sm_edit_td_name">上传时间</div>
			<div class="sm_edit_td_value">
				<input type="text" class="clear" name="starttime" readonly value="<%=Validate.isNullToDefault(request.getParameter("starttime"),"")%>"/>
			</div>
			<div class="sm_edit_td_name" style="text-align:center;">至</div>
			<div class="sm_edit_td_value">
				<input type="text" class="clear" name="endtime" readonly value="<%=Validate.isNullToDefault(request.getParameter("endtime"),"")%>"/>	
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
				<td style="width: 30px;" class="sm_index"><input type="checkbox"></td>
				<td style="width: 100px;">文件名</td>
				<td style="width: 100px;">所属专业</td>
				<td style="width: 100px;">所属课程</td>
				<td style="width: 100px;">所属章节</td>
				<td style="width: 100px;">所属班级</td>
				<td style="width: 100px;">上传人</td>
				<td style="width: 60px;">优秀资源</td>
				<td style="width: 150px;">上传时间</td>
				<td style="width: 150px;">操作</td>
			</tr>
		</table>
		<table>
			<%
			//查询数据库获取文件相关信息及分页信息
				CourseManager coursefilesManager = new CourseManager();
				PageInfo pageInfo = null;
				pageInfo = coursefilesManager.findAllByChecked(nowPage, pageSize, "=", request);
				List list = pageInfo.getList();
				Map map;
				for(int i=0;i<list.size();i++){
					map = (Map)list.get(i);
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i+1 %></td>
				<td style="width: 30px;" class="sm_index"><input type="checkbox" value="<%=map.get("FILEID") %>">
				</td>
				<td style="width: 100px;"><%=map.get("PLANNAME")==null?"":map.get("PLANNAME") %></td>
				<td style="width: 100px;" ><%=Validator.isNull(map.get("MAJOR_NAME"))?"公共基础课":map.get("MAJOR_NAME") %></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("COURSE_NAME"),"")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("CHAPTER_NAME"),"")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("BJMC"),"")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("UPLOADER"),"")%></td>
				<td style="width: 60px;"><%="T".equals(map.get("ISEXCELLENT"))?"是":"F".equals(map.get("ISEXCELLENT"))?"否":"" %></td>
				<td style="width: 150px;"><%=map.get("CREATETIME")==null?"":map.get("CREATETIME")%></td>
				<td style="width: 150px;">
					<div class="sharediv" style="position: relative;">
					<input type="hidden" name="swfpath<%=i %>" value="<%=map.get("SWFPATH") %>">
						&nbsp;&nbsp;&nbsp;
					<%if(ProcessFileUtil.isVideoFile(map.get("EXTENDNAME"))){%>
							<input type="hidden" name = "justmov"   value="movie">
							&nbsp;<a onclick="lookView('<%=map.get("SWFPATH")%>')" href="#">在线预览</a>&nbsp;
					<%}else if(ProcessFileUtil.isPriviewNoVideo(map.get("EXTENDNAME"))){%>	
							<input type="hidden" name = "justmov"   value="notmovie">
							&nbsp;<a href="<%=request.getContextPath()+"\\filesmanager\\course\\view.jsp?swfFile="%><%=map.get("SWFPATH")%>">在线预览</a>
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
			
			//回显班级
			var classObj = $("#classes");
			var classlength = $("#classes option").length;
			var classid = '<%=request.getParameter("classes")==null?"":request.getParameter("classes")%>';
			var str4 = "";
			for(var i=0;i<classlength;i++){
				str4 = classObj[0].options[i].value;
				if(str4 == classid ){
					classObj[0].options[i].selected = true;
				}
			}
			
			//回显是否是优秀资源
			var obj = $("[name='isExcellent']");
			var excellent = "<%=request.getParameter("isExcellent")%>";
			if(excellent == "T"){
				obj[0].options[1].selected = true;
			}else if(excellent == "F"){
				obj[0].options[2].selected = true;
			}
			
			//提交表单进行查询
			$(".sm_goSearch_go").click(function(){
				$("form[id='pageForm']").submit();
			});
			
			//清空输入查询内容
			$(".sm_goSearch_back").click(function(){
				msjorObj[0].options[0].selected = true;
		    	$("[id=classes] option").remove();
		    	$("[id=classes]").append('<option value="">----选择班级----</option>');
		    	obj[0].options[0].selected = true;
		    	$(".clear").val("");
			});
			setPageSize();
		});
		
		//在线预览
		function lookView(src){
			src = "<%=request.getContextPath()%>\\filesmanager\\fileManager\\playVideo.jsp?fileName="+src+".flv";
			jumpWindow("在线预览",625,480,src);
		}
		
		// 选择专业	 
		function addMajor(){
			var majorId = $("#major").val();
			var url = "selectCourse.jsp";
		    var params="type=1&pkId="+majorId;
		    addClass(url,majorId);
		}
		//选择班级
		function addClass(url,majorId){
			var params="type=5&pkId="+majorId;
			jQuery.getJSON(url,params,function callback(data){
		    	$("[id=classes] option").remove();
		    	$("[id=classes]").append('<option value="">----选择班级----</option>');
	 			jQuery.each(data,function(i,item){
		 	    	$("[id=classes]").append(
		 	    		'<option value="'+item.GID+'">'+item.BJMC+'</option>'
		 	    	);
	 			});
	 		});
		}
		// 设置页面属性,增加页面滚动条 
		function setPageSize() {
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".page"),$(".sm_edit_from")]);
		}
	</script>
</body>
</html>