<%@page import="com.googosoft.ggs.dataManager.normCode.Dict"%>
<%@page import="com.googosoft.oa.teacherinfo.TeacherInfoManager"%>
<%@page import="com.googosoft.ggs.homeManager.Power"%>
<%@page import="org.apache.commons.collections.CollectionUtils"%>
<%@page import="com.googosoft.page.PageInfo"%>
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
<title>教师信息列表</title>
</head>
<%@include file="/ggs/include/css.inc"  %>
<%
	String deptId=request.getParameter("deptId");//部门id
	request.setCharacterEncoding("utf-8");
	int pageSize = Integer.valueOf(request.getParameter("pageSize") == null ?"20": request.getParameter("pageSize"));
	int nowPage = Integer.valueOf(request.getParameter("nowPage") == null ? "0": request.getParameter("nowPage"));
	String operateType = request.getParameter("operateType");
	Boolean bool = false;
	if (Validate.noNull(operateType)) {
		bool = new CUDHelper(request, "_", null).execute();
	}
%>
<body>
	<div class="tool"></div>
	<form id="pageForm"  class="sm_search" action="" method="post" style="">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="pageSize" id="pageSize" value="<%=pageSize%>" />
		<input type="hidden" name="operateType" value="">
		<input type="hidden" name="deptId" value="<%=request.getParameter("deptId")%>">
		<input type="hidden" name="P_TEACHERSINFO_ID_S_WD" value="">
		<table class="search_table" >
			<tr>
				<td>姓名:
				
					<input type="text" style="width:100px" name="P_Q_LIKE_T.XM"
					value="<%=request.getParameter("P_Q_LIKE_T.XM") == null ? ""
					: request.getParameter("P_Q_LIKE_T.XM")%>">
				</td>
				<td>性别:
					<select style="width:50px" name="P_Q_LIKE_T.XBM">
						<option value="">选择性别</option>
					    <option value="0">男</option>
					    <option value="1">女</option>
					</select>
				</td>
				<td>身份证号:
					<input type="text" style="width:150px" name="P_Q_LIKE_T.SFZJH"
					value="<%=request.getParameter("P_Q_LIKE_T.SFZJH") == null ? ""
 					: request.getParameter("P_Q_LIKE_T.SFZJH")%>">
				</td>
			</tr>
		</table>
	</form>
<div class="sm_list">
	<table>
			<tr>
				<td style="width: 30px;" class="sm_index"></td>
				<td style="width: 30px;" class="sm_index">
					<input type="checkbox">
				</td>
				<td style="width: 100px;">编号</td>
				<td style="width: 100px;">姓名</td>
				<td style="width: 80px;">性别</td>
				<td style="width: 100px;">出生日期</td>
				<td style="width: 150px;">身份证号</td>
				<td style="width: 200px;">籍贯</td>
				<td style="width: 200px;">住址</td>
				<td style="width: 100px;">所属部门</td>
				<td style="width: 100px;">兼职部门</td>
				<td style="width: 100px;">来校日期</td>
				<td style="width: 100px;">参加工作时间</td>
				<td style="width: 100px;">主要岗位类别</td>
				<td style="width: 100px;">编制类别</td>
				<td style="width: 100px;">任教科目</td>
			</tr>
		</table>
		<table>
			<%	
				PageInfo pageInfo = new TeacherInfoManager().findPageInfoByTEACHERSINFO(nowPage, pageSize, "_", request,"1");
				List teacherInfo = pageInfo.getList();
				Map map;
				Dict dict = new Dict();
				for (int i = 0; i < teacherInfo.size(); i++) {
					map = (Map)teacherInfo.get(i);
			%>
			<tr>
				<td style="width: 30px;" class="sm_index"><%=i + 1%></td>
				<td style="width: 30px;" class="sm_index">
					<input type="checkbox" value="<%=map.get("ID")%>">
				</td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("DABH"), "")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("XM"), "")%></td>
				<td style="width: 80px;"><%if("0".equals(Validate.isNullToDefault(map.get("XBM"), ""))){%>男
				<%}if("1".equals(Validate.isNullToDefault(map.get("XBM"), ""))){%>女<%}%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("CSRQ"), "")%></td>
				<td style="width: 150px;"><%=Validate.isNullToDefault(map.get("SFZJH"), "")%></td>
				<td style="width: 200px;"><%=Validate.isNullToDefault(map.get("JG"), "")%></td>
				<td style="width: 200px;"><%=Validate.isNullToDefault(map.get("APPENDADDRESS"), "")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("UMDEPARTMENTNAME"), "")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("JZDEPARTMENTNAME"), "")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("LXRQ"), "")%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("CJGZNY"), "")%></td>
				<td style="width: 100px;"><%if("0".equals(Validate.isNullToDefault(map.get("JZGLBM"), ""))){%>教学	
				<%}if("1".equals(Validate.isNullToDefault(map.get("JZGLBM"), ""))){%>工勤	
				<%}if("2".equals(Validate.isNullToDefault(map.get("JZGLBM"), ""))){%>管理<%}%></td>
				<td style="width: 100px;"><%if("0".equals(Validate.isNullToDefault(map.get("BZLBM"), ""))){%>事业
				<%}if("1".equals(Validate.isNullToDefault(map.get("BZLBM"), ""))){%>人事代理<%}%></td>
				<td style="width: 100px;"><%=Validate.isNullToDefault(map.get("RKZKM"), "")%></td>
				</tr>
			<%
				}
			%>
		</table>
	</div>
<%@include file="/ggs/include/page.inc"%>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
		$(function() {
			jumpRemark("<%=bool%>","<%=request.getContextPath()%>","done.jsp");
			$(".tool").toolBar([{
				text : "审核",
				width : 50,
				position : "-20px -160px",
				handler : function() {
					var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
					if($checkeds.length!=1){
						alert("只能选择一条信息进行操作");
					}else{
						var id = $checkeds.val();	
						var src = "../check/listCheck.jsp";
						src += "?CHECKID="+id;
						jumpWindow("审核教师信息",950,800,src);
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