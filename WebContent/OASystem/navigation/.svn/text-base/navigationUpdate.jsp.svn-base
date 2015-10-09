<%@page import="com.googosoft.oa.navigation.NavigationManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增导航菜单</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
request.setCharacterEncoding("utf-8");
String operateType = request.getParameter("operateType");
NavigationManager navigationManager = new NavigationManager();
String id = request.getParameter("id");
Map map = navigationManager.findMapByID(id);
boolean bool = false;
if(Validate.noNull(operateType)){
	CUDHelper cudHelper = new CUDHelper(request,"_",null);
	bool = cudHelper.execute();
	%>
	<script type="text/javascript">
		parent.location.reload(false);
		
		window.setTimeout(function(){
			parent.removeJumpWindow();
		}, 500);
	</script>
<%
	}
%>
<body>
<div class="tool"></div>
	<form class="sm_edit_from" style="height: 180px;width: 365px;margin-top: 20px;margin-left: 80px;" method="post" action="">
		<input type="hidden" name="operateType" value="U">
		<input type="hidden" name="P_NAVIGATION_ID_S_WU" value="<%=id%>">
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name" style="height: 20px;line-heihgt:20px;">导航菜单名称</div>
			<div class="sm_edit_td_value" >
			<input type="text" style="width: 260px;line-heihgt:30px;" class="maxLength:200num null" name="P_NAVIGATION_NAVIGATIONNAME_S_S" value="<%=Validate.isNullToDefault(map.get("NAVIGATIONNAME"), "")%>"></div>
		</div>
		<div class="sm_edit_tr"  style="width: 280px; " >
			<div class="sm_edit_td_name" style="height: 20px;line-heihgt:20px;">地址</div>
			<div class="sm_edit_td_value" >
			<input type="text" style="width: 260px;line-heihgt:30px;" class="null" name="P_NAVIGATION_ADDRESS_S_S" value="<%=Validate.isNullToDefault(map.get("ADDRESS"), "")%>"></div>
		</div>
		<div class="sm_edit_tr"  style="height: 20px;width: 280px;" >
			<div class="sm_edit_td_name" style="height: 20px;line-heihgt:30px;">排列顺序</div>
			<div class="sm_edit_td_value" style="width: 100px;">
				<input type="text" style="width: 90px;line-heihgt:30px;" class=" null" name="P_NAVIGATION_PLSX_S_S" value="<%=Validate.isNullToDefault(map.get("PLSX"), "")%>">
			</div>
			
			<div class="sm_edit_td_name" style="height: 20px;line-heihgt:30px;">是否隐藏</div>
			<div class="sm_edit_td_value" >
			<%if(map.get("STATE").equals("1")){ %>
				是<input type="radio" class="null" name="P_NAVIGATION_STATE_S_S" value="0">
				否<input type="radio" class="null" name="P_NAVIGATION_STATE_S_S" checked="checked" value="1">
			<%}else{ %>
			是<input type="radio" class="null" name="P_NAVIGATION_STATE_S_S"  checked="checked" value="0">
				否<input type="radio" class="null" name="P_NAVIGATION_STATE_S_S" value="1">
			<%} %>
			</div>
		</div>
		<div class="sm_edit_tr"  style="height: 80px;width: 280px; " >
			<div class="sm_edit_td_name" style="height: 80px; ">菜单描述</div>
			<div class="sm_edit_td_value" >
			<textarea style="height: 80px;width: 262px;" class="maxLength:200num null" name="P_NAVIGATION_DESCRIPTION_S_S" ><%=Validate.isNullToDefault(map.get("DESCRIPTION"), "")%>
			</textarea>
			</div>
		</div>	
	</form>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			$(".tool").toolBar([ {
				text : "保存",
				width : 50,
				position : "-80px -100px",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
		});
		function setPageSize() {}
</script>
</body>
</html>