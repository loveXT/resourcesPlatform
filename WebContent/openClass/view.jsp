<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.commons.StringUtil"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.filesManager.openClass.OpenClassManager"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
    	String path = request.getContextPath();
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/journal/journal.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/openClass/openClass.css">
<title>公开课</title>
</head>
<style type="text/css">
</style>
<%
	String url = request.getScheme()+"://"; 
	url+=request.getHeader("host"); 
	url+=request.getRequestURI(); 
	if(request.getQueryString()!=null) //去掉这两行注销就好使了
	url+="?"+request.getQueryString();
	String userId = StringUtil.objToString(session.getAttribute(ISessionContants.USERIDBYLOGIN));
	
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null ?"20": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null ? "1": request.getParameter("nowPage"));
	String serverPath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()
			+ path;
	String imagePath = serverPath + "/ggs/common/ggs/upload/";
	String operateType = request.getParameter("operateType");
	String buttonClass = Validate.isNullToDefault(request.getParameter("buttonClass"), "0")+"";
	String pageClass = Validate.isNullToDefault(request.getParameter("pageClass"), "1")+"";
	String typeId = Validate.isNullToDefault(request.getParameter("typeId"), "")+"";
	String contents = Validate.isNullToDefault(request.getParameter("CONTENT"), "")+"";
	String COURSEID = Validate.isNullToDefault(request.getParameter("courseId"), "")+"";
	int m;
	Boolean bool = false;
	if (Validate.noNull(operateType)) {
		bool = new CUDHelper(request, "_", null).execute();
	}
%>
<body>
	<form method="post" action="" id="pageForm">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value=""> 
		<input type="hidden" name="buttonClass" value="<%=buttonClass%>">
		<input type="hidden" name="pageClass" value="<%=pageClass%>">
		<input type="hidden" name="typeId" value="<%=typeId%>">
		<input type="hidden" name="CONTENT" value="<%=contents%>">
		<input type="hidden" name="courseId" value="<%=COURSEID%>">
	</form>
	<!--top  -->
	<jsp:include page="../common/top/head.jsp"></jsp:include>
	<div class="jounalContent" >
		<div  class="positionImg">
			<div class="type">
				<img src="<%=path%>/image/openClass/wz.gif">
				<span>&nbsp;首页&nbsp;>&nbsp;公开课</span>
			</div>
			</div>
			<div class="type">
				<input type="button" class="button1" id="button1" value="综合排序" onclick="cx(this,1)">
				<input type="button" class="buttons" id="button2" value="最新发布" onclick="cx(this,2)">
				<input type="button" class="buttons" id="button3" value="最多播放" onclick="cx(this,3)">
		<!-- 		<input type="button" class="buttons" id="button4" value="最多评论" onclick="cx(this,4)"> -->
		<!-- 		<input type="button" class="buttons" id="button5" value="最多收藏" onclick="cx(this,5)"> -->
				&nbsp;
				<select id="select" onchange="f1()">
					<option value="0">筛选条件</option>
					<option value="1" <%if("1".equals(request.getParameter("typeId"))){%>selected<%} %>>资源名称</option>
					<option value="2" <%if("2".equals(request.getParameter("typeId"))){%>selected<%} %>>资源类别</option>
				</select>
				<select id="select1" name="COURSE">
					<option value="">--请选择类别--</option> 
				<% 
					OpenClassManager ocm = new OpenClassManager();
					List typeList=ocm.findCourseByCourseId();
					Map typeMap;  
					for (int i=0;i<typeList.size();i++) {  
						typeMap=(Map)typeList.get(i); 
					%>  
					<option value="<%=typeMap.get("COURSE_ID")%>"<%if(COURSEID.equals(typeMap.get("COURSE_ID"))){%>selected="selected"<%} %>><%=Validate.isNullToDefault(typeMap.get("COURSE_NAME"),"") %></option> 
				<% 
					}  
					%> 
				</select>
				<input type="text" name="contents" class="ssinput" value="<%=contents %>">
				<div class="sousuo">
				</div>
			</div>
		   	<div class="content" style="margin-top:20px;">
				<%
					PageInfo pageInfo = ocm.findResourceByopenClass(nowPage, pageSize, "_", request);
					List list = pageInfo.getList();
					double listSize = Double.parseDouble(String.valueOf(pageInfo.getAllBand()));
					double yeshu = listSize/20;
					int pages = (int)Math.ceil(yeshu);
					for(int i=0;i<list.size();i++){
					Map map = (Map)list.get(i);
				%>
						<div style="float:left;margin-left:20px;margin-top:10px;" title="<%=map.get("FULLNAME")%>">
						<%
							if(Validate.isNull(userId)){%>
								<a href="<%=path%>/jsp/login.jsp?url=<%=url %>">
									<img style="width:170px;height:90px;" src="<%=imagePath + map.get("FILENAME2") %>">
								</a><br/>
								<a href="<%=path%>/jsp/login.jsp?url=<%=url %>")">
									<span id="filename"><%=Validate.isNullToDefault(map.get("REALNAME"), "") %></span>
								</a><br/>
						<% 	}else{
						%>
							<a target="_blank" href="<%=path%>/openClass/playVideo.jsp?fileName=<%=map.get("FILENAME")%>&fullName=<%=map.get("FULLNAME")%>" onclick="bf(this,<%=i%>)">
								<input type="hidden" class="browse<%=i %>" value="<%=Validate.isNullToDefault(map.get("FILEID"), "")%>">
								<img style="width:170px;height:90px;" src="<%=imagePath + map.get("FILENAME2") %>">
							</a><br/>
							<a target="_blank" href="<%=path%>/openClass/playVideo.jsp?fileName=<%=map.get("FILENAME")%>&fullName=<%=map.get("FULLNAME")%>"  onclick="bf(this,<%=i%>)">
								<input type="hidden" class="browse<%=i %>" value="<%=Validate.isNullToDefault(map.get("FILEID"), "")%>" >
								<span id="filename"><%=Validate.isNullToDefault(map.get("REALNAME"), "") %></span>
							</a><br/>
							<%
							}
							%>
							<span id="detail" style="margin-top:3px;">用户:&nbsp;<%=Validate.isNullToDefault(map.get("UPLOADERNAME"), "") %></span><br/>
							<span id="detail" style="margin-top:3px;">播放:&nbsp;<%=Validate.isNullToDefault(map.get("BROWSETIME"), "") %></span><br/>
							<span id="detail" style="margin-top:3px;">发布:&nbsp;<%=Validate.isNullToDefault(map.get("CREATETIME"), "") %></span>
						</div>
						<%
						}
						%>
			</div>
			<div class="fpage">
				<div class="pages" style="width:50px;cursor:pointer;" onclick="change(this,-2)">首页</div>
				<div class="pages" style="width:70px;cursor:pointer;" onclick="change(this,0)">上一页</div>
				<%	
					if(pages<=10){
						for(int i=0;i<10;i++){
							if(i==0){
								%>
								<div class="page1" style="cursor:pointer;" id="page<%=i+1%>" onclick="change(this,<%=i+1%>)"><%=i+1 %></div>
								<%
							}else{
								%>
								<div class="pages" style="cursor:pointer;" id="page<%=i+1 %>" onclick="change(this,<%=i+1%>)"><%=i+1 %></div>
								<%
							}
						}
					}else if(pages>10){
						for(int i=0;i<10;i++){
							if(i==0){
								%>
								<div class="page1" style="cursor:pointer;" id="page<%=i+1%>" onclick="change(this,<%=i+1%>)"><%=i+1 %></div>
								<%
							}else{
								%>
								<div class="pages" style="cursor:pointer;" id="page<%=i+1 %>" onclick="change(this,<%=i+1%>)"><%=i+1 %></div>
								<%
							}
						}
					}
				%>
				<div class="pages" style="width:70px;cursor:pointer;" onclick="change(this,-1)">下一页</div>
				<div class="pages" style="width:50px;cursor:pointer;" onclick="change(this,-3)">末页</div>
		</div>
	</div>
	<!-- bottom -->
	<jsp:include page="../common/bottom/footer.jsp"></jsp:include>
	<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
	//分页
		function change(this_,k){
			var nowPage = k;
			var pages = '<%=pages%>';
			//首页
			if(k==-2){
				nowPage = 1;
			}
			//末页
			if(k==-3){
				nowPage = pages;
			}
			//上一页
			if(k==0){
				var b = '<%=nowPage%>';
				if(b==1){
					return;
				}else{
					nowPage = Number(b)-1;
				}
			}
			//下一页
			if(k==-1){
				var b = '<%=nowPage%>';
				if(b!=pages){
				nowPage = Number(b)+1;
				}else{
					alert("已是最后一页!");
					return;
				}
			}
			//点击某一页
			var a = Number(k);
			var b = Number(pages);
			if(a>b && a!=-1){
				alert("该页无资源!");
				return;
			}
			var buttonClass = '<%=buttonClass%>';
			$("[name=nowPage]").val(nowPage);
			$("[name=pageClass]").val(nowPage);
			$("[name=buttonClass]").val(buttonClass);
			$("#pageForm").submit();
		}
	//增加播放次数
		function bf(this_,i){
			var fileId = $("[class='browse"+i+"']").val();
			$.ajax({
				type: "POST",
				url: "ajax1.jsp?fileId="+fileId,
				success : function(num){
					num=$.trim(num);
				}
			});
		}
	//回显查询
		function cx(this_,j){
			var flag = j;
			$("[name=flag]").val(flag);
			$("[name=buttonClass]").val(j);
			$("#pageForm").submit();
		}
		var typeId = $("#select").val();
		if("2"==typeId){
			$("#select1").show();
	    	$(".ssinput").hide();
		}else{
			$(".ssinput").show();
			$("#select1").hide();
		}
		//搜索
		function f1(){
			var typeId = $("#select").val();
			if("2"==typeId){
				var url = "<%=path%>/openClass/json.jsp";
			    var params="typeId="+typeId;
			    jQuery.getJSON(url,params,function callback(data){
			    	$(".ssinput").hide();
			    	$("#select1").show();
			    	$("[id=select1] option").remove();
			    	$("[id=select1]").append('<option value="">--请选择类别--</option>');
		 			jQuery.each(data,function(i,item){
			 	    	$("[id=select1]").append(
			 	    		'<option value="'+item.COURSE_ID+'">'+item.COURSE_NAME+'</option>'
			 	    	);
		 			});
		 		});
			}else{
				$(".ssinput").show();
				$("#select1").hide();
			}
		}
		$(".sousuo").live("click",function(){
			var typeId = $("#select").val();
			var contents = $("[name=contents]").val();
			var courseId = $("#select1").val();
			$("[name=typeId]").val(typeId);
			$("[name=CONTENT]").val(contents);
			$("[name=courseId]").val(courseId);
			$("#pageForm").submit();
		});
	//按钮样式
		$(function(){
			var bc = $("[name=buttonClass]").val();
			if(bc!=0 && bc!=1){
				$("#button1").removeClass("button1").addClass("buttons");
				$("#button"+bc).removeClass("buttons").addClass("button1");
			}
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
			
		});
	</script>
</body>
</html>