<%@page import="org.apache.poi.hwpf.model.ListLevel"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="com.googosoft.filesManager.viewManager.StringConstant"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.filesManager.fileManager.FilesQuery"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.List"%>
    <%@page import="java.util.Map"%>
    <%@page import="com.googosoft.baseInfoManager.*"%>
     <%@page import="com.googosoft.filesManager.netresvindicate.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<% 
String path = request.getContextPath();  
String toPath = request.getContextPath()+"/"+ IUploadImgContants.IMGPATH;
String serverPath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()
+ path;
String imagePath = serverPath + "/ggs/common/ggs/upload/";

%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/search.css">
<style type="text/css">
.fontcolor{
	color:#F60100;
	font-weight:bold;
}
.fontcolors{
	colot:#000000;
}
.YC{
	display:none;
}
.YC1{
	display:block;
}
.wjliebiao li{
	width:100% !important;
}
.liborder{
	width:100% !important;
}
.yuedu{
  	width: 180px;
  	height: 45px;
  	float: right;
	border-left: 1px solid #cfcfcf;
	margin: auto auto;
  	margin-top: -30px;
  	padding-left: 15px;
  	padding-top: 18px;
  	font-size: 13px;
}
</style>
<%
int pageSize = Integer
.valueOf(request.getParameter("pageSize") == null
? "10"
: request.getParameter("pageSize"));
int nowPage = Integer
.valueOf(request.getParameter("nowPage") == null
? "1"
: request.getParameter("nowPage"));
String buttonClass = Validate.isNullToDefault(request.getParameter("buttonClass"), "0")+"";
String pageClass = Validate.isNullToDefault(request.getParameter("pageClass"), "1")+"";
DecimalFormat    df   = new DecimalFormat("0.00");  
%>
</head>
<body>
	<div class="positionImg">
		<div class="jtImg"></div><span>首页 > 学科成果</span>
	</div>
	<div class="category_top">
		<div id="category_1" class="category_show" onclick="tabCategory(this,1)">
			<span class="category_text">按课程</span>
		</div>
		<div id="category_2" class="category" onclick="tabCategory(this,2)">
			<span class="category_text">按类型</span>
		</div>
<!-- 		<div id="category_3" class="category" onclick="tabCategory(this,3)"> -->
<!-- 			<span class="category_text">按学校</span> -->
<!-- 		</div> -->
	</div>
	<div style="height:auto;width:100%;float:left;">
			<jsp:include page="selectByCourse.jsp"></jsp:include>
			<jsp:include page="selectByType.jsp"></jsp:include>
			<ul class="category_body" id="category_body_3" style="display:none">
			</ul>
	</div>
<div style="width:1000px;height:auto;">
	<div class="right" style="width:1000px;margin-left:0px;">
		<div class="rightTop" style="width:100%;">
			<div class="gxwenjain" >共享文件</div>
		</div>
<!-- 		<div class="wjtype"> -->
<!-- 			<span>全部(6886份)</span> -->
<!-- 			<ul style="display:block"> -->
<!-- 				<li><a href="#">教学设计</a></li> -->
<!-- 				<li><a href="#">导学案</a></li> -->
<!-- 				<li><a href="#">课件</a></li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
		<div class="paixu" style="width:100%;">
			<div style=" float: left;  margin-left: 10px">排序:</div>
			<div class="paixuchaxun">
			<a href="#" onclick="paixuTime()">发布时间</a>
			<div class="imgpaixu" id="time"></div>
			</div>
			<div class="paixuchaxun" style="width:50px;">
			<a href="#" onclick="paixuSize()">大小</a>
			<div class="imgnopaixu" id="size"></div>
			</div>
<!-- 			<div class="shangchuan"></div> -->
		</div>
		<form id="fileForm" action="" method="post">
			<!-- 分页参数 -->
			<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
			<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
			<input type="hidden" name="buttonClass" value="<%=buttonClass%>">
			<input type="hidden" name="pageClass" value="<%=pageClass%>">
			<!-- 按课程查询需要传的参数 -->
			<input type="hidden" name="courseName" value="<%=Validate.isNullToDefault(request.getParameter("courseName"), "")%>"/>
			<input type="hidden" name="courseId" value="<%=Validate.isNullToDefault(request.getParameter("courseId"), "")%>"/>
			<input type="hidden" name="gradeName" value="<%=Validate.isNullToDefault(request.getParameter("gradeName"), "")%>"/>
			<input type="hidden" name="gradeId" value="<%=Validate.isNullToDefault(request.getParameter("gradeId"), "")%>"/>
			<input type="hidden" name="versionName" value="<%=Validate.isNullToDefault(request.getParameter("versionName"), "")%>">
			<input type="hidden" name="versionId" value="<%=Validate.isNullToDefault(request.getParameter("versionId"), "")%>">
			<input type="hidden" name="typeName" value="<%=Validate.isNullToDefault(request.getParameter("typeName"), "")%>">
			<input type="hidden" name="typeId" value="<%=Validate.isNullToDefault(request.getParameter("typeId"), "")%>">
			<input type="hidden" name="biaoti" value="<%=Validate.isNullToDefault(request.getParameter("biaoti"), "")%>">
			<input type="hidden" name="flag1" value="<%=Validate.isNullToDefault(request.getParameter("flag1"), "")%>">
			<input type="hidden" name="flag2" value="<%=Validate.isNullToDefault(request.getParameter("flag2"), "")%>">
			<input type="hidden" name="flag3" value="<%=Validate.isNullToDefault(request.getParameter("flag3"), "")%>">
			<input type="hidden" name="flag4" value="<%=Validate.isNullToDefault(request.getParameter("flag4"), "")%>">
			<!-- 按类型查询需要传的参数 -->
			<input type="hidden" name="classifyName" value="<%=Validate.isNullToDefault(request.getParameter("classifyName"), "")%>">
			<input type="hidden" name="classifyId" value="<%=Validate.isNullToDefault(request.getParameter("classifyId"), "")%>">
			<input type="hidden" name="flag5" value="<%=Validate.isNullToDefault(request.getParameter("flag5"), "")%>">
			<!-- 查询类型的编号 -->
			<input type="hidden" name="selectNum" value="<%=Validate.isNullToDefault(request.getParameter("selectNum"), "")%>">
			<!-- 排序 -->
			<input type="hidden" name="orderByTime" value="<%=Validate.isNullToDefault(request.getParameter("orderByTime"), "")%>">
			<input type="hidden" name="orderBySize" value="<%=Validate.isNullToDefault(request.getParameter("orderBySize"), "")%>">
		</form>
		
		<div class="wjliebiao" style="width:100%;">
			<ul style="display:block">
				<%
					FilesQuery FQ = new FilesQuery();
					PageInfo pageInfo = FQ.findPageInfoFilesQuery(nowPage, pageSize, "_", request);
					List list = pageInfo.getList();
					double listSize = Double.parseDouble(String.valueOf(pageInfo.getAllBand()));
					List<String> ImagesList = Arrays.asList(StringConstant.Images);
					List<String> VediosList = Arrays.asList(StringConstant.Vedios);
					MajorType majorType = new MajorType();
					for(int i=0;i<list.size();i++){
						Map filesmap = (Map)list.get(i);
						String image=majorType.findImageByExtendName(Validate.isNullToDefault(filesmap.get("EXTENDNAME"), "").toString());
				%>
			<li>
				<div class="liborder">
					<div style="float:left;">
					<%
						//图片
						if(ImagesList.contains(filesmap.get("EXTENDNAME"))){
							if(Validate.isNull(filesmap.get("FILENAME2"))){%>
								<img class="wjImg" src="<%=imagePath+String.valueOf("pic_"+filesmap.get("SWFPATH")+filesmap.get("EXTENDNAME"))%>">
							<%}else{%>
								<img class="wjImg" src="<%=toPath %><%=Validate.isNullToDefault(filesmap.get("FILENAME2"), "") %>"><br/>
							<%}
						//视频
						}else if(VediosList.contains(filesmap.get("EXTENDNAME"))){
							if(Validate.isNull(filesmap.get("FILENAME2"))){%>
								<img class="wjImg" src="<%=imagePath +String.valueOf(filesmap.get("SWFPATH")+".jpg")%>"/>
							<%}else{%>
								<img class="wjImg" src="<%=toPath %><%=Validate.isNullToDefault(filesmap.get("FILENAME2"), "") %>"><br/>
							<%}
						}else{ 
							if(Validate.isNull(filesmap.get("FILENAME2"))){%>
								<img class="wjImg" src="<%=path%>/image/<%=image%>"><br/>
							<%}else{%>
								<img class="wjImg" src="<%=toPath %><%=Validate.isNullToDefault(filesmap.get("FILENAME2"), "") %>"><br/>
							<%
							}
						}
					 %>
					</div>
					<div class="btStyle">
					<%
						String REALNAME = Validate.isNullToDefault(filesmap.get("REALNAME"), "").toString();
						String BROWSETIME = Validate.isNullToDefault(filesmap.get("BROWSETIME"), "").toString();
						String EXTENDNAME = Validate.isNullToDefault(filesmap.get("EXTENDNAME"), "").toString();
						if(Validate.noNull(EXTENDNAME)){
							EXTENDNAME = EXTENDNAME.substring(1);
						}
					%>
						<a  target="_blank" href="<%=path %>/jsp/content.jsp?fileId=<%=filesmap.get("FILEID")%>"><%=REALNAME%></a>
					</div>
					<%
					String filesize = Validate.isNullToDefault(filesmap.get("FILESIZE"), "0").toString();
					double size = Double.parseDouble(filesize);
					String danwei = "KB";
					if(size/1024>=1&&size/1024<1000){
						size = size/1024;
						danwei = "MB";
					}else if(size/1024/1024>=1&&size/1024/1024<1000){
						size = size/1024/1024;
						danwei = "GB";
					}
					%>
						<span>大小:<%=df.format(size)%><%=danwei %></span>
						<span>格式:<%=EXTENDNAME%></span>
						<div class="yuedu"><%=Validate.isNullToDefault(BROWSETIME, "0")%>人已经阅读</div>
				</div>
			</li>
		<%
			}
		%>
			</ul>
		</div>
	</div>
	<div class="fpage" id="fpage">
		<div class="pages" id="page0" style="width:75px;" onclick="change(this,0)">上一页</div>
		<%
		double yeshu = listSize/pageSize;
		int pages = (int)Math.ceil(yeshu);
		if(pages<=10){
			for(int i=0;i<pages;i++){
				if(i==0){
					%>
					<div class="page1" id="page<%=i+1%>" onclick="change(this,<%=i+1%>)"><%=i+1 %></div>
					<%
				}else{
					%>
					<div class="pages" id="page<%=i+1 %>" onclick="change(this,<%=i+1%>)"><%=i+1 %></div>
					<%
				}
			}
		}else if(pages>10){
			for(int i=0;i<10;i++){
				if(i==0){
					%>
					<div class="page1" id="page<%=i+1%>" onclick="change(this,<%=i+1%>)"><%=i+1 %></div>
					<%
				}else{
					%>
					<div class="pages" id="page<%=i+1 %>" onclick="change(this,<%=i+1%>)"><%=i+1 %></div>
					<%
				}
			}
		}
		%>
		<div class="pages" id="page01" style="width:75px;" onclick="change(this,-1)">下一页</div>
	</div>
</div>
		
	<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="<%=path%>/js/searchFunction.js"></script>
	<script type="text/javascript">
		function tabCategory(this_,k){
			 $("#category_"+k).removeClass("category").addClass("category_show");
			 $("#category_body_"+k).css("display","block");
			 $("[name=selectNum]").val(k);
			 for(var i=1;i<=3;i++){
				 if(i!=k){
					 $("#category_"+i).removeClass("category_show").addClass("category");
					 $("#category_body_"+i).css("display","none");
				 }
			 }
			 if(k==2){
				 $("[name=courseId]").val("");
				 $("[name=courseName]").val("");
				 $("[name=gradeId]").val("");
				 $("[name=gradeName]").val("");
				 $("[name=versionId]").val("");
				 $("[name=versionName]").val("");
				 $("[name=typeId]").val("");
				 $("[name=typeName]").val("");
			 }else if(k==1){
				 $("[name=classifyId]").val("");
				 $("[name=classifyName]").val("");
			 }
		}
		function paixuTime(){
			$("[name=orderByTime]").val("desc");
			$("[name=orderBySize]").val("");
			$("#fileForm").submit();
		}
		function paixuSize(){
			$("[name=orderBySize]").val("desc");
			$("[name=orderByTime]").val("");
			$("#size").removeClass("imgnopaixu").addClass("imgpaixu");
			$("#time").removeClass("imgpaixu").addClass("imgnopaixu");
			$("#fileForm").submit();
		}
		function change(obj,k){
			var nowPage = k;
			if(k!=0&&k!=-1){
				nowPage = obj.innerText;				
			}
			if(k==0){
				var b = '<%=nowPage%>';
				if(b==1){
					return;
				}else{
					nowPage = Number(b)-1;
				}
			}
			if(k==-1){
				var b = '<%=nowPage%>';
				var pages='<%=pages%>';
				if(b!=pages){
					nowPage = Number(b)+1;
				}else{
					alert("当前是最后一页");
					return;
				}
			}
			
			$("[name=nowPage]").val(nowPage);
			$("[name=pageClass]").val(nowPage);
			$("#fileForm").submit();
		}
		$(function(){
			var pc = $("[name=pageClass]").val();
			if(pc!=0 && pc!=1){
				$("#page1").removeClass("page1").addClass("pages");
				$("#page"+pc).removeClass("pages").addClass("page1");
			}
			var nowPage = $("[name=nowPage]").val();
			if(nowPage>10){
				for(var j=1;j<=10;j++){
					$("#page"+j).html(Number(j)+Number(nowPage)-10);
				}
				$("#page10").addClass("page1").removeClass("pages");
			}
			
			var orderBySize = $("[name=orderBySize]").val();
			if(orderBySize==""||orderBySize=="null"||orderBySize==null){
				
			}else{
				$("#size").removeClass("imgnopaixu").addClass("imgpaixu");
				$("#time").removeClass("imgpaixu").addClass("imgnopaixu");
			}
		});
	</script>
</body>
</html>