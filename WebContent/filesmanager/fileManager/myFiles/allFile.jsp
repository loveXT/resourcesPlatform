<%@page import="com.googosoft.filesManager.viewManager.StringConstant"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.googosoft.filesManager.netresvindicate.MajorType"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.common.util.VideoUtil"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="com.googosoft.filesManager.fileManager.JpegTool"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.commons.OperationCache"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesManager"%>
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
<title>资源管理</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}
body{
	border:0px;
}
.clearfix:after {
	content: ".";
	display: block;
	height: 0;
	clear: both;
	visibility: hidden;
}
.clearfix {
	zoom: 1;
}
ul,li {
	list-style: none;
}
img {
	border: 0;
}
.wrapper {
	width: 600px;
	margin: 0 auto;
	padding-bottom: 50px;
}
h1 {
	height: 50px;
	line-height: 50px;
	font-size: 22px;
	font-weight: normal;
	font-family: "Microsoft YaHei", SimHei;
	margin-bottom: 20px;
}
/* focus */
#focus {
	width: 700px;
	height: 550px;
	overflow: hidden;
	position: relative;
}
#focus ul {
	height: 380px;
	position: absolute;
}
#focus ul li {
	float: left;
	width: 700px;
	height: 550px;
	overflow: hidden;
	position: relative;
	background: #000;
}
#focus ul li div {
	position: absolute;
	overflow: hidden;
}
#focus .btnBg {
	position: absolute;
	width: 700px;
	height: 20px;
	left: 0;
	bottom: 0;
	background: #000;
}
#focus .preNext {
	width: 45px;
	height: 100px;
	position: absolute;
	top: 250px;
	background: url(sprite.png) no-repeat 0 0;
	cursor: pointer;
}
#focus .pre {
	left: 0;
}
#focus .next {
	right: 0;
	background-position: right top;
}
/* body{ */
/* 	overflow-y: scroll; */
/* 	} */
	 .sm_list{
	 	height:485px !important;
	 }
	.page{
		position:relative;
	}
	.pgToolbar{
		width:811px;
	}
	.pgPanel{
		background:none;
	}
	 a{
		  font-size: 13px;
		  color: gray;
		  font-weight: normal;
		  text-decoration: none;
		  cursor: pointer;
	 }
</style>
<%	
	//设置编码格式为"utf-8"
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	//得到项目路径
	String sp = File.separator;
    String path = request.getContextPath();  
	String serverPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    String toPath = request.getRealPath(sp)+ IUploadImgContants.IMGPATH;
    String imagePath = serverPath+"/ggs/common/ggs/upload/";
    //接受chapter_id章节编号,course_id课程编号,major_id专业编号
    String typeId = request.getParameter("Type_Id");
    String typename = request.getParameter("typename");
    String Dept_Id = request.getParameter("DEPT_ID");
    String Major_Id = request.getParameter("MAJOR_ID");
	String COURSE_ID = request.getParameter("COURSE_ID");
	String CHAPTER_ID = request.getParameter("CHAPTER_ID");
	String FOLDERID = request.getParameter("FOLDERID");
	String biaoti = request.getParameter("biaoti");
	String id = request.getParameter("id");
	String Flag = request.getParameter("flag");
	//分页设置pageSize每页显示几条数据,nowPage当前页
	int pageSize = Integer
	.valueOf(request.getParameter("pageSize") == null
	? "0"
	: request.getParameter("pageSize"));
	int nowPage = Integer
	.valueOf(request.getParameter("nowPage") == null
	? "0"
	: request.getParameter("nowPage"));
	String resourceURL =  request.getParameter("url");
	String userByLogin = Validate.isNullToDefault(session.getAttribute(ISessionContants.USERIDBYLOGIN), "").toString();
	String majorid = request.getParameter("majorid");
	String classify = request.getParameter("classify");
%>
<body >
<form class="sm_edit_from" id="pageForm" style="border:0px;height:0px;" method="post" action="" >
	<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
	<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
</form>
	<div class="sm_list">
			<%
				FilesManager filesManager = new FilesManager();
				PageInfo pageInfo = null;
				pageInfo = filesManager.findPageInfoByVedioFILES(nowPage, pageSize, "_", request,Flag,id,typeId,biaoti);
				List list = pageInfo.getList();
				List<String> ImagesList = Arrays.asList(StringConstant.Images);
				List<String> VediosList = Arrays.asList(StringConstant.Vedios);
				Map map;
				if(list.size()<1){
					%>
					<div style="font-size:40px;color:red;"></div>
					<%
				}else{
					for(int i=0,k=0;i<list.size();i++,k++){
						map = (Map)list.get(i);
						MajorType majorType = new MajorType();
						String image=majorType.findImageByExtendName(Validate.isNullToDefault(map.get("EXTENDNAME"), "").toString());
						//图片
						if(ImagesList.contains(map.get("EXTENDNAME"))){
						String smallImageUrl = toPath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"));
						String imageUrl = Validate.isNullToDefault(map.get("FILENAME"), "").toString();
						boolean flag=ProcessFileUtil.checkFileExists(imageUrl,request);
						if(flag==false){
							k=k-1;
						}else{
							JpegTool j = new JpegTool();
							j.SetScale(0.6);
							j.SetSmallHeight(200);
							j.doFinal(toPath+Validate.isNullToDefault(map.get("FILENAME"),""),smallImageUrl);
						%>
							<div style="float:left;margin-left:15px;margin-top:10px;width:140px;height:150px;"  class="small_span ">
								<%
								if(Validate.noNull(map.get("FILENAME2"))){
								%>	
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img src="<%=imagePath+String.valueOf(""+map.get("FILENAME2"))%>" width="120px" height="120px">
								</a>
								<%
								}else{
								%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img src="<%=imagePath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"))%>" width="120px" height="120px">
								</a>
								<%
								}
								%>
								<div style="text-align:center;margin-top:10px;font-size: 13px;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;color:grey;">
									<a title="<%=Validate.isNullToDefault(map.get("REALNAME"),"")%>" target="_blank"><%=Validate.isNullToDefault(map.get("REALNAME"),"")%></a>
								</div>
								<%
								%>
							</div>
			<%
							}
						//视频
						}else if(VediosList.contains(map.get("EXTENDNAME"))){
							String filename = String.valueOf(map.get("FILENAME"));
							String vedioUrl = String.valueOf(map.get("SWFPATH")+".flv");
							String pictureUrl = String.valueOf(map.get("SWFPATH")+".jpg");
							boolean flagf=ProcessFileUtil.checkFileExists(filename,request);
							boolean flag=ProcessFileUtil.checkFileExists(vedioUrl,request);
							boolean bool = ProcessFileUtil.checkFileExists(pictureUrl, request);
							String absPath = toPath+"\\"+filename;
							if(flag==false){
//	 							将视频转换为flv格式
								boolean flag1 =VideoUtil.convert2Flv(absPath, toPath, FilenameUtils.getBaseName(filename));
							}
							if(bool==false){
								//定义截取图片的参数
								long h=0;
								long m = 0;
								long s=5;
								long screenshotTime = (h * 60 + m * 60 + s);
								String extension=filename.substring(21, filename.lastIndexOf("."));
								extension=FilenameUtils.getExtension(filename);
									//从视频中截图,可以设置缩略图大小220表示宽度，168表示高度
								VideoUtil.captureImage(absPath, toPath, FilenameUtils.getBaseName(filename), 180, 120, screenshotTime);
							}
					%>
						<div style="float:left;margin-left:15px;margin-top:10px;width:140px;height:150px;"   class="small_span1 ">
							<input type="hidden" value="<%=Validate.isNullToDefault(map.get("FILEID"),"")%>" class="vfileId"/>
							<%
							if(Validate.noNull(map.get("FILENAME2"))){
							%>	
							<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
								<img class="video-same-img" src="<%=imagePath+String.valueOf(""+map.get("FILENAME2"))%>" width="120px" height="120px">
							</a>
							<%
							}else{
							%>
							<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
								<img class="video-same-img" src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>" width="120px" height="120px"/>
							</a>	
							<% 
							}
							%>
							<div style="text-align:center;margin-top:10px;font-size: 13px;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;color:grey;">
								<a title="<%=Validate.isNullToDefault(map.get("REALNAME"),"")%>" target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>"><%=Validate.isNullToDefault(map.get("REALNAME"),"")%></a>
							</div>
						<%
						%>
						</div>
						<%
						}else {
								%>
						<div style="float:left;margin-left:15px;margin-top:10px;width:140px;height:150px;"  class="small_span2 ">
								<input type="hidden" value="<%=Validate.isNullToDefault(map.get("FILEID"),"")%>" class="fileId"/>
								<%
								if(Validate.noNull(map.get("FILENAME2"))){
								%>	
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
								<img src="<%=imagePath+String.valueOf(""+map.get("FILENAME2"))%>" width="120px" height="120px">
								</a>
								<%
								}else{
								%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
								<img src="<%=path+"/image/"+image%>" width="120px" height="120px" alt="<%=map.get("REALNAME")%>">
								</a>
								<%
								}
								%>
								<div style="text-align:center;margin-top:10px;font-size: 13px;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;color:grey;">
									<a title="<%=Validate.isNullToDefault(map.get("REALNAME"),"")%>" target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>"><%=Validate.isNullToDefault(map.get("REALNAME"),"")%></a>
								</div>
							</div>
							<%
						}
					}
				}
			%>	
	</div>
<div style="clear: both;"></div>
<%@include file="/ggs/include/page.inc"%>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	jQuery(function(){
// 		var entryWidth = $('#sameContainer').width()/3 - 16;
// 		$('.video-same-img').width(entryWidth);
// 		$('.video-same-img').click(function(){
// 			var fileId=$(this).prev('input[class="vfileId"]').val();
<%-- 			var src = "<%=path%>/jsp/content.jsp?fileId="+fileId; --%>
// 			window.open(src);
// 		});
// 		$('.small_span2 img').click(function(){
// 			var fileId=$(this).prev('input[class="fileId"]').val();
<%-- 			var src = "<%=path%>/jsp/content.jsp?fileId="+fileId; --%>
// 			window.open(src);
// 		});
	});

		setPageSize();
	function setPageSize() {
		setWidth($(".sm_list"),$("body"));
		setHeight($(".sm_list"),$("body"),[$(".page")]);
	}
</script>
</body>
</html>