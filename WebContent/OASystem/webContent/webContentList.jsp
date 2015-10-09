<%@page import="com.googosoft.oa.webContent.WebContentManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/ggs/include/css.inc" %>
<title>网页内容列表</title>
</head>
<body>
<%

	String path=request.getContentType();
	String operateType = request.getParameter("operateType");
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null? "0": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null? "0": request.getParameter("nowPage"));	
	Boolean bool = false;
	WebContentManager webContentManager = new WebContentManager();
	if(Validate.noNull(operateType)){
		if("D".equals(operateType)){
			bool = new CUDHelper(request,"_",null).execute();
		}
	}
%>
<div class="tool"></div>
	<form id="pageForm" class="sm_search" action="" method="post">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="P_WEBCONTENT_ID_S_WD" value="">
		<table class="search_table">
			<tr>
				<td>标题:</td>
				<td>
					<input type="text" name="P_Q_LIKE_T.TITLE" value="<%=Validate.isNullToDefault(request.getParameter("P_Q_LIKE_T.TITLE"),"")%>">
				</td>
				<td>分类:</td>
				<td>
					<input type="text" name="P_Q_LIKE_N.NAVIGATIONNAME" value="<%=Validate.isNullToDefault(request.getParameter("P_Q_LIKE_N.NAVIGATIONNAME"),"")%>">
				</td>
			</tr>
		</table>
	</form>
<div class="sm_list">
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 250px;">标题</td>
				<td style="width: 100px;">上传人</td>
				<td style="width: 150px;">所属分类</td>
				<td style="width: 150px;">更新时间</td>
				<td style="width: 100px;">是否有缩略图</td>
			</tr>
		</table>
		<table>
		<%
			PageInfo pageInfo = null;
			pageInfo = webContentManager.findPageInfoByWebContent(nowPage, pageSize, "_", request);
			List list = pageInfo.getList();
			Map map;
			for(int i=0;i<list.size();i++){
				map = (Map)list.get(i);
	    %>
		<tr>
				<td style="width: 30px;" class="sm_index"><%=i+1 %></td>
				<td style="width: 30px;" class="sm_index">
				<input type="checkbox" name="<%=i %>" value="<%=Validate.isNullToDefault(map.get("ID"),"")%>">
				</td>
				<td style="width: 250px;"><%=Validate.isNullToDefault(map.get("TITLE"),"")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("USERNAME"),"")%></td>
				<td style="width: 150px;"><%=Validate.isNullToDefault(map.get("NAVIGATIONNAME"),"")%></td>
				<td style="width: 150px;"><%=Validate.isNullToDefault(map.get("UPDATETIME"),"")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("SFSCSLT"),"").toString().equals("1")?"有":"无"%></td>
				</tr>
				<%	} %>
				</table>
				</div>
<%@include file="/ggs/include/page.inc"%>
<%@include file="/ggs/include/js.inc" %>

<script type="text/javascript">
		$(function() {
			//cud处理成功后关闭本页面,父页面刷新
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
			$(".tool").toolBar([{
      				text : "新增",
      				width : "60",
      				position : "-40px -160px",
      				handler : function() {
      					var src = "webContentAdd.jsp";
      					window.location.href=src;				
      				}
      			},{
      				text : "修改",
      				width : "60",
      				position : "-20px -160px",
      				handler : function() {
      					var $checked = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
      					if($checked.length!=1){
      						alert("只能选择一条信息!");
      					}else{
      						var id = $checked.val();
      						var src = "webContentUpdate.jsp";
      						src +="?id="+id;
          					window.location.href=src;
      					}
      				}
      			},{
      				text : "刪除",
      				width : 80,
      				position : "-180px -160px",
      				handler : function() {
      					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
      					if($checkeds.length<1){
      						alert("至少选择一条信息!");
      					}else{
      						if(confirm("确认删除?")){
      							var ids = [];
      							var $this;
      							$checkeds.each(function(){
      								$this = $(this);
      								ids.push($this.val());
      							});
      							$("[name=operateType]").val("D");
      							$("[name='P_WEBCONTENT_ID_S_WD']").val(ids.join("','"));
      							$("#pageForm").submit();
      						}
      					}
      				}
      			},{
    				text : "查询",
    				width : 50,
    				position : "-160px -160px",
    				handler : function() {
    					sm_goSearch();
    				}
    			}]);
      			setPageSize();
      		});
     		function setPageSize() {
     			setWidth($(".sm_list"),$("body"));
     			setHeight($(".sm_list"),$("body"),[$(".tool"),$(".page")]);
     		}
</script>
</body>
</html>