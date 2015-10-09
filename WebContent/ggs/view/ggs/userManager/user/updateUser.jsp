<%@page import="java.util.List"%>
<%@page import="com.googosoft.ggs.userManager.UserDepartmentManager"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.ggs.userManager.UserManager"%>
<%@page import="com.googosoft.ggs.userManager.DepartmentManager"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改部门信息</title>
<%@include file="/ggs/include/css.inc" %>
</head>
<%
	String operateType = request.getParameter("operateType");
	String userId = request.getParameter("userId");
UserDepartmentManager userDepartmentManager = new UserDepartmentManager();
Boolean bool = false;
if(Validate.noNull(operateType)){
	Map initMap = new CUDHelper(request,"_","-").getInitMap();
	bool = userDepartmentManager.saveUserDepartmentByUser(initMap,"_","-",userId);
}
DepartmentManager departmentManager = new DepartmentManager();
UserManager userManager = new UserManager();
Map updateMap = userManager.findMapByuserId(userId);
List departmentListByUser = userDepartmentManager.findListByumuserdepartment(userId);
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
	<input type="hidden" name="operateType" value="D_U_C">
	<input type="hidden" name="P_UMUSERDEPARTMENT-0_UMUSERID_S_WD" value="<%=updateMap.get("USERID")==null?"":updateMap.get("USERID")%>">
	<input type="hidden" name="P_UMUSER-1_USERID_S_WU" value="<%=updateMap.get("USERID")==null?"":updateMap.get("USERID")%>">
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">用户名</div>
		<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMUSER-1_USERNAME_S_S" value="<%=updateMap.get("USERNAME")==null?"":updateMap.get("USERNAME")%>"></div>
		<div class="sm_edit_td_name">登录名</div>
		<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMUSER-1_LOGINNAME_S_S" value="<%=updateMap.get("LOGINNAME")==null?"":updateMap.get("LOGINNAME")%>"></div>
	</div>
	<div class="sm_edit_tr">
		<div class="sm_edit_td_name">所属部门</div>
		<div class="sm_edit_td_value">
			<%
			String departmentIds = "",departmentNames="";
			Map departmentMap;
			for(int i=0;i<departmentListByUser.size();i++){
				departmentMap = (Map)departmentListByUser.get(i);
				departmentIds += departmentMap.get("UMDEPARTMENTID").toString()+",";
				departmentNames += departmentMap.get("UMDEPARTMENTNAME").toString()+",";
			}
			%>
			<input type="text" id="departmentid" class="null" name="" value="<%=Validate.isNull(departmentNames)?"":departmentNames %>">
			<input type="hidden" id="departmentid" name="DEPARTMENTIDS" value="<%=departmentIds %>">
		</div>
		<div class="sm_edit_td_name"></div>
		<div class="sm_edit_td_value"></div>
	</div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","doneByParent.jsp");
			$(".tool").toolBar([ {
				text : "返回",
				width : 50,
				position : "-340px -100px",
				handler : function() {
					window.parent.location.reload();
				}
			}, {
				text : "保存",
				width : 50,
				position : "-360px -100px",
				model:"save_<%=Power.getOperates(request)%>",
				handler : function() {
					if(validateBySubmit($("form"))){
						$("form").submit();
					}
				}
			} ]);
			setPageSize();
			$("[id=departmentid]").click(function() {
				var parentId = $(this).attr("id");
				var checkedIds = $(":hidden[id=" + parentId + "]").val();
				var src = "treeDepartment.jsp";
				src += "?checkedIds=" + checkedIds;
				src += "&parentId=" + parentId;
				selectWindow("资源信息", src, $(this));
			});
			$("[name=P_UMUSER-1_LOGINNAME_S_S]").focusout(function(){
				$.ajax({
					url:"validateByLoginName.jsp?LOGINNAME="+$(this).val(),
					type:"post",
					success:function(b){
						var f = $.trim(b);
						if(f=="false"){
							alert("此用户名已注册，请重新输入");
							$(this).val("");
						}
					}
				});
			});
		});
		function setPageSize() {

		}
	</script>
</body>
</html>