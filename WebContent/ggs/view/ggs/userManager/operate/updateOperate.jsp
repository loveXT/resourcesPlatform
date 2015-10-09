<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.ggs.userManager.OperateManager"%>
<%@page import="java.util.Map"%>
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
Boolean bool = false;
if(Validate.noNull(operateType)){
	bool = new CUDHelper(request,"_",null).execute();
}
String operateId = request.getParameter("operateId");
OperateManager operateManager = new OperateManager();
Map updateMap = operateManager.findMapByumOperateId(operateId);
%>
<body>
<div class="tool"></div>
<center class="sm_edit_center">
	<form class="sm_edit_from" method="post" action="">
		<input type="hidden" name="operateType" value="U">
		<input type="hidden" name="P_UMOPERATE_UMOPERATEID_S_WU" value="<%=updateMap.get("UMOPERATEID")==null?"":updateMap.get("UMOPERATEID")%>">
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">操作名称</div>
			<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMOPERATE_UMOPERATENAME_S_S" value="<%=updateMap.get("UMOPERATENAME")==null?"":updateMap.get("UMOPERATENAME")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">备注名称</div>
			<div class="sm_edit_td_value"><input type="text" class="null maxLength:50num" name="P_UMOPERATE_UMOPERATECN_S_S" value="<%=updateMap.get("UMOPERATECN")==null?"":updateMap.get("UMOPERATECN")%>"></div>
		</div>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name">是否生效</div>
			<div class="sm_edit_td_value">
				<%
				String umoperateuseable = updateMap.get("UMOPERATEUSEABLE")==null?"":updateMap.get("UMOPERATEUSEABLE").toString();
				%>
				<select class="null" name="P_UMOPERATE_UMOPERATEUSEABLE_S_S">
					<option value="T" <%if("T".equals(umoperateuseable)){%>selected="selected"<%} %> >是</option>
					<option value="F" <%if("F".equals(umoperateuseable)){%>selected="selected"<%} %> >否</option>
				</select>
			</div>
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
		});
		function setPageSize() {
			
		}
	</script>
</body>
</html>