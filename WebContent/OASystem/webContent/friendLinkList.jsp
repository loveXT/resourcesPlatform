<%@page import="com.googosoft.oa.friendLink.FriendLinkManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.page.PageInfo"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.oa.navigation.NavigationManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/ggs/include/css.inc" %>
<title>友情链接列表</title>
</head>
<body>
<%

	String path=request.getContentType();
	String operateType = request.getParameter("operateType");
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null? "0": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null? "0": request.getParameter("nowPage"));	
	Boolean bool = false;
	FriendLinkManager friendLinkManager = new FriendLinkManager();
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
		<input type="hidden" name="P_FRIENDLINK_ID_S_WD" value="">
	</form>
<div class="sm_list">
		<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index"><input
					type="checkbox"></td>
				<td style="width: 200px;">标题</td>
				<td style="width: 200px;">地址</td>
				<td style="width: 200px;">时间</td>
				<td style="width: 100px;">排列顺序</td>
			</tr>
		</table>
		<table>
		<%
			PageInfo pageInfo = null;
			pageInfo = friendLinkManager.findPageInfoByFriendLink(nowPage, pageSize, "_", request);
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
				<td style="width: 200px;"><%=Validate.isNullToDefault(map.get("TITLE"),"")%></td>
				<td style="width: 200px;"><%=Validate.isNullToDefault(map.get("URL"),"")%></td>
				<td style="width: 200px;"><%=Validate.isNullToDefault(map.get("CREATETIME"),"")%></td>
				<td style="width: 100px;text-align:right;"><%=Validate.isNullToDefault(map.get("PLSX"),"")%></td>
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
      					var src = "friendLinkAdd.jsp";
      					jumpWindow("新增页面","550px","260px",src);				
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
      						var src = "friendLinkUpdate.jsp";
      						src +="?id="+id;
      						jumpWindow("修改页面","550px","260px",src);
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
      							$("[name='P_FRIENDLINK_ID_S_WD']").val(ids.join("','"));
      							$("#pageForm").submit();
      						}
      					}
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