<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.commons.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%-- <%@include file="/ggs/include/css.inc" %> --%>
</head>
<style type="text/css">
	.content{
	 height: 387px !important;
 	 width: 805px !important;
 	 font-size:12px !important;
 	 overflow: none;
	}
	.pageinline{
		display:block;
		float:left;
		line-height:22px;
		font-size:12px;
	}
	.pgToolbar .pgPanel .separator{
		width:15px;
		height:22px;
	}
	.pgBtn{
		margin-top:3px;
	}
	.pgPrev{
		margin-left:7px;
	}
	.pgLast{
		margin-left:7px;
	}
</style>
<%
	String url = request.getScheme()+"://"; 
	url+=request.getHeader("host"); 
	url+=request.getRequestURI(); 
	if(request.getQueryString()!=null) //去掉这两行注销就好使了
	url+="?"+request.getQueryString();		
	
	String pathSkin = request.getContextPath()+"/ggs";
	String pathSkinTool = request.getContextPath()+"/ggs/skin/blue"; 
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null ?"10": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null ? "0": request.getParameter("nowPage"));
	
	String userId = StringUtil.objToString(session.getAttribute(ISessionContants.USERIDBYLOGIN));
	String path = request.getContextPath();
	String fileId = request.getParameter("fileId");
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	if (Validate.noNull(operateType)) {
		bool = new CUDHelper(request, "_", "-").execute();
	}
%>
<body style="overflow-x: hidden;font-size:5px;margin-bottom:0px;">
	<form method="post" action="" id="pageForm">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value=""> 
		<input	type="hidden" name="P_CONTENT-1_CID_S_P" value="">
		<input	type="hidden" name="P_CONTENT-1_MID_S_C" value="<%=fileId%>">
		<input	type="hidden" name="P_CONTENT-1_CREATETIME_D_C" value="">
		<input	type="hidden" name="P_CONTENT-1_USERID_S_C" value="<%=request.getSession().getAttribute("USERIDBYLOGIN")%>">
		<div>
			<textarea style="width:99.5%;height:40px;" id="textareas" name="P_CONTENT-1_CONTENT_S_C" class="null maxLength:500num"><%=Validate.isNullToDefault(request.getParameter("P_CONTENT-1_CONTENT_S_C"), "") %></textarea>
		</div>
	</form>
		<input type="button" value="发表评论"  id="submit" style="margin-top:1px;">
	<!--  评论    -->
   	<div class="content" style="height:320px;">
		<table style="width: 99.9%;border:0px;overflow-y: scroll;">
		<%
			PageInfo pageInfo = new SelectFilesManager().findPageInfoByCONTENT(nowPage, pageSize, "_", request,fileId);
// 			String smPage = (String)session.getAttribute("sm");
			String smPage = "blue";
			String pathPage = request.getContextPath() + "/ggs/skin/"+smPage+"/tool/page/images";
			if (pageInfo == null) {
				pageInfo = new PageInfo();
			}
			List content = pageInfo.getList();
			Map cmap;
			for (int i = 0; i < content.size(); i++) {
				cmap = (Map)content.get(i);
		%>
			<tr>
				<td style="border:0px;margin-top:0px;line-height:30px;">
					<div class="person" style="background-color: gainsboro;">
						&nbsp;<img src="<%=path%>/image/jt4.gif"><span style="font-weight: bold;"><%=Validate.isNullToDefault(cmap.get("USERNAME"), "")%>&nbsp;[<%=Validate.isNullToDefault(cmap.get("CREATETIME"), "") %>]</span>
					</div>
					<div class="content2"  style="background-color: ghostwhite;">
					<%=Validate.isNullToDefault(cmap.get("CONTENT"), "")%>
					</div>
				</td>
			</tr>
			<%} %>
		</table>
	</div>
	<div style="position: inherit;" class="page">
		<div class="pgToolbar" style="width:99.5%;">
			<div class="pgPanel">
				<div class="pageinline">
					每页显示
					<input class="pgPerSize" type="text" value="<%=pageInfo.getPageSize()%>" onchange="perPageColSizeAction()" size="2" id="viewPageColSize"/>
					条记录
				</div>
				<div class="separator pageinline"></div>
				<div class="pgBtn pgFirst pageinline" id="pgFirst" title="首页">
					<%if (pageInfo.getNowPage() != 1) {%>
						<img src="<%=pathPage%>/first.gif" onclick="pageAction(1);" />
					<%} else {%>
						<img src="<%=pathPage%>/first_disabled.gif" />
					<%}%>
				</div>
				<div class="pgBtn pgPrev pageinline" id="pgPrev" title="上页">
					<%if (pageInfo.getNowPage() != 1){%>
						<img src="<%=pathPage%>/prev.gif" onclick="pageAction(<%=pageInfo.getLastPage()%>);"/>
					<%}else{%>
						<img src="<%=pathPage%>/prev_disabled.gif" />
					<%}%>
				</div>
				<div class="separator pageinline"></div>
				<div class="pageinline">
					第 <select class="pageSelect" id="gotoPage" onchange="pageAction()">
				<%if(pageInfo.getAllPage()< 1){%>
						<option value="1">0</option>
				<%}for (int i = 1; i <= pageInfo.getAllPage(); i++){%>
						<option value="<%=i%>"<%if (i == pageInfo.getNowPage()){%>selected="selected" <%}%>><%=i%></option>
				<%}%>
					</select>页 / 共 <%=pageInfo.getAllPage()%> 页
				</div>
				<div class="separator pageinline"></div>
				<div class="pgBtn pgNext pageinline" id="pgNext" title="下页">
					<%if (pageInfo.getNowPage() != pageInfo.getAllPage()) {%>
						<img src="<%=pathPage%>/next.gif" onclick="pageAction(<%=pageInfo.getNextPage()%>);" />
					<%}else{%>
						<img src="<%=pathPage%>/next_disabled.gif" />
					<%}%>
				</div>
				<div class="pgBtn pgLast pageinline" id="pgLast" title="尾页">
					<%if (pageInfo.getNowPage() != pageInfo.getAllPage()) {%>
						<img src="<%=pathPage%>/last.gif" onclick="pageAction(<%=pageInfo.getAllPage()%>);" />
					<%}else{%>
						<img src="<%=pathPage%>/last_disabled.gif" />
					<%}%>
				</div>
				<div class="separator pageinline"></div>
				<%if (pageInfo.getAllBand() != 0){
					int start = pageInfo.getStartBand();
					int end = pageInfo.getEndBand();
					if (end > pageInfo.getAllBand()){
						end = pageInfo.getAllBand();
					}%>
				<div class="pgSearchInfo pageinline">
					检索到 <%=pageInfo.getAllBand()%> 条记录, 显示第 <%=start%> 条 - 第 <%=end%> 条记录
				</div>
				<%}else{%>
				<div class="pgSearchInfo pageinline">检索到 <%=pageInfo.getAllBand()%> 条记录
				</div>
				<%}%>
<!-- 				<hr class="cleanFloat" /> -->
			</div>
		</div>
	</div>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function() {
		$("#submit").click(function(){
			var userId = '<%=userId%>';
			var url = "<%=path%>/jsp/content.jsp?fileId=<%=fileId%>";
			var src = "login.jsp?url="+url;
			var content=$("[name=P_CONTENT-1_CONTENT_S_C]").val();
			if(userId=="" || userId==null){
				parent.location.href = src;
			}else{
				if(content==null || content==""){
					alert('回复内容不能为空！');
					return;
				}
				$("[name=operateType]").val("C");
					$("#pageForm").submit();
			}
		});
		setPageSize();
	});
//第几页
 	function pageAction (val){
 		if(val == undefined){
	 		document.getElementById("nowPage").value=document.getElementById("gotoPage").value; 
 		}else{
	 		document.getElementById("nowPage").value=val; 
 		}
 		document.getElementById('pageForm').submit();	 
 	} 
//每页显示多少条
 	function perPageColSizeAction (){ 
 		var regNum = /^[0-9]*[1-9][0-9]*$/; 
 		var	val = document.getElementById("viewPageColSize").value; 
 		if (val == '' ||val == '0' || !regNum.test(val)){  
 			alert("请输入有效数字"); 
 			document.getElementById("viewPageColSize").value = 
 			document.getElementById("pageSize").value; 
 			return; 
 		}else {
 			document.getElementById("nowPage").value=document.getElementById("gotoPage").value; 
 			document.getElementById("pageSize").value = val; 
 			document.getElementById('pageForm').submit(); 
 		}
 	} 
	function setPageSize() {
		setWidth($(".content"),$("body"));
		setHeight($(".content"),$("body"));
	}
</script>
</body>
</html>