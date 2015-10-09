<%@page import="com.googosoft.filesManager.openClass.OpenClassManager"%>
<%@page import="com.googosoft.common.util.Validator"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.filesManager.fileManager.DeleteFiles"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="java.io.File"%>
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
<title>资源管理</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.sm_edit_from select{
		width:154px;
		height:20px;
	}
	.sm_edit_td_name{
		width:40px;
	}
	.mytool{
		display:inline;
		font-size: 12px;
		height: 22px;
 		margin-top: 2px;
 		float: left;
	}
	.EXTENDNAME{
		display:inline;
		font-size: 12px;
		height: 22px;
 		margin-top: 4px;
 		float: left;
	}
	#Flag{
		margin-top:2px;
		margin-right:5px;
	}
	#major,#chapter,#course,#point{
		width:110px;
	}
	.sm_edit_td_value{
		width:110px;
	}
	.sm_goSearch_btn_init{
		margin-left: 5px;
	}
	.sm_edit_td_name{
		margin-top: 3px;
		padding-bottom: 0px;
	}
</style>
<%
	//设置编码格式为"utf-8"
	 request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8"); 
	//得到审核状态Flag
// 	String EXTENDNAME= request.getParameter("EXTENDNAME");
	//得到operate按钮操作权限
// 	String operate = OperationCache.getOperation(request);
// 	String admin = OperationCache.isAdmin(request);
// 	System.out.println("operate:"+operate);
	//得到项目路径
	String sp = File.separator;
    String path = request.getContextPath();  
    
	String serverPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String downbase=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    String basePath = request.getRealPath("/"); 
    //接受chapter_id章节编号,course_id课程编号,major_id专业编号
    String Major_Id = request.getParameter("MAJOR_ID");
	String COURSE_ID = request.getParameter("COURSE_ID");
	String CHAPTER_ID = request.getParameter("CHAPTER_ID");
	String POINT_ID = request.getParameter("POINT_ID");
	String downFilePath =basePath + IUploadImgContants.IMGPATH;
	//跳转到文件下载的servlet所需的路径以及文件名
	String downURL = path+"/DownLoad/";
	//分页设置pageSize每页显示几条数据,nowPage当前页
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	//根据operateType的类型进行cud进行处理
	String Fid = request.getParameter("Fid");
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	String ids = request.getParameter("P_OPENCLASS_FILEID_S_WD");
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

	<form class="sm_edit_from" id="pageForm" style="background:#B5E1FF;" method="post" action="listFile.jsp" >
		<div class="tool"></div>
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_OPENCLASS_FILEID_S_WD" value="">
		<input type="hidden" name="P_OPENCLASS_FILEID_S_WU" value="">
		<div class="sm_edit_tr" style="border-left: 1px solid #84b8f1;width:auto;">
			<div class="sm_edit_td_name">课程</div>
			<div class="sm_edit_td_value"> 
				<select id="course" name="COURSE_ID">
					<option value="">----选择课程----</option>
				<%
					OpenClassManager ocm = new OpenClassManager();
					List courseList = ocm.findCourseByCourseId();
					Map courseMap;
					for(int i=0;i<courseList.size();i++){
					courseMap = (Map)courseList.get(i);
				%>
					<option value="<%=Validate.isNullToDefault(courseMap.get("COURSE_ID"), "") %>"><%=Validate.isNullToDefault(courseMap.get("COURSE_NAME"), "")%></option>
					<%
						}
					%>
				</select>
			</div>
				<div class="sm_edit_td_value" style="width: 377px;">
				<div class="shangchuan sm_goSearch_btn_init">上传</div>
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
				<td style="width: 240px;">文件名</td>
				<td style="width: 100px;">所属课程</td>
				<td style="width: 100px;">上传人</td>
				<td style="width: 150px;">上传时间</td>
				<td style="width: 150px;">操作</td>
			</tr>
		</table>
		<table>
			<%
					PageInfo pageInfo = null;
					pageInfo = ocm.findByPrivateAllAndVerified(nowPage, pageSize, "_", request,COURSE_ID);
					List list = pageInfo.getList();
					Map map;
					for(int i=0;i<list.size();i++){
						map = (Map)list.get(i);
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i+1 %></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" name="<%=i %>" value="<%=Validate.isNullToDefault(map.get("FILEID"), "")%>">
				<input type="hidden" value="<%=Validate.isNullToDefault(map.get("SWFPATH"), "")%>">
				<input type="hidden" value=<%=Validate.isNullToDefault(map.get("FILENAME"), "")%>>
				<input type="hidden" value="<%=Validate.isNullToDefault(map.get("COURSE_NAME"), "")%>">
				<input type="hidden" value="<%=Validate.isNullToDefault(map.get("FALSENAME"), "")%>">
				</td>
				<td style="width: 240px;"><%=Validate.isNullToDefault(map.get("FULLNAME"), "")%>
				</td>
				<td style="width: 100px;" ><%=Validate.isNullToDefault(map.get("COURSE_NAME"), "")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("UPLOADERNAME"), "")%></td>
				<td style="width: 150px;" ><%=Validate.isNullToDefault(map.get("CREATETIME"), "")%></td>
				<td style="width: 150px;">
					<div class="sharediv" style="position: relative;">
						<input type="hidden" name = "justmov"   value="movie">
						&nbsp;<a onclick="lookView('<%=Validate.isNullToDefault(map.get("SWFPATH"), "")%>')" href="#">在线预览</a>
						&nbsp;&nbsp;<a href ="<%=path+"/DownLoadServlet?FILEID="+Validate.isNullToDefault(map.get("FILEID"), "")%>"class="downloadfile">下载</a>
					</div>
				</td>
			</tr>		
				<%
					}
				%>	
		</table>
	</div>
<%@include file="/ggs/include/page.inc"%>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript" src="<%=path %>/js/jquery.zclip.js"></script>
<script type="text/javascript">
		$(function() {
			//cud处理成功后关闭本页面,父页面刷新
			jumpRemark("<%=bool%>","<%=path%>","done.jsp");
			$(function(){
				$(".tool").toolBar([{
					text : "删除",
					width : 60,
					position : "-180px -160px",
					handler : function() {
						var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
						if($checkeds.length<1){
							alert("最少选择一条信息进行操作");
						}
						if(confirm("确认删除？")){
						var ids = [];
						var $this;
						$checkeds.each(function(){
							$this = $(this);
							ids.push($this.val());
						});
						$("[name=operateType]").val("D");
						$("[name=P_OPENCLASS_FILEID_S_WD]").val(ids.join("','"));
						$("#pageForm").submit();
						}
					}
				}]);
			});
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
			//清空输入查询内容
			$(".sm_goSearch_back").click(function(){
				msjorObj[0].options[0].selected = true;
		    	$("[id=course] option").remove();
		    	$("[id=course]").append('<option value="">----选择课程----</option>');
		    	folderObj[0].options[0].selected = true;
				obj[0].options[0].selected = true;
			});
			//清空输入查询内容       上传
			$(".shangchuan").click(function(){
				var length = $('#course').val().length;
				if(length<=0){
					alert("请选择课程点!");
				}else{
					var courseId = $("[name='COURSE_ID']").val();
					var src = "addFile.jsp?COURSE_ID="+courseId;
					jumpWindow("上传文件","650px","360px",src);
				}
			});
			setPageSize();
		});
		function setPageSize() {
			setWidth($(".sm_list"),$("body"));
			setHeight($(".sm_list"),$("body"),[$(".page"),$(".sm_edit_from")]);
		}
		 function lookView(src){
			 src = "<%=path%>\\filesmanager\\fileManager\\playVideo.jsp?fileName="+src+".flv";
			 jumpWindow("在线预览",625,480,src);
		 }
	</script>
</body>
</html>