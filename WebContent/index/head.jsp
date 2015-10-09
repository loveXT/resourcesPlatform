<%@page import="java.util.List"%>
<%@page import="com.googosoft.oa.navigation.NavigationManager"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.commons.StringUtil"%>
<%@page import="com.googosoft.ggs.userManager.UserManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix= "c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网页头部</title>
<style type="text/css">
	.head{
		float:left;
		width:100%;
		height:auto;
	}
	.head .navigation li a{
		font-size:14px;
		color:#FFFFFF;
	}
	.head table{
		border:0px solid #FFF;
		border-spacing:0px;
	}
	.head table td{
		border:0px solid #FFF;
	}
	.head table td a{
		font-size:12px;
	}
</style>
<%
String path = request.getContextPath();
/**得到当前地址url**/
String url = request.getScheme()+"://"; 
url+=request.getHeader("host"); 
url+=request.getRequestURI(); 
if(request.getQueryString()!=null) //去掉这两行注销就好使了
url+="?"+request.getQueryString();

Map userMap = new UserManager().findUserInfoById(StringUtil.objToString(session.getAttribute(ISessionContants.USERIDBYLOGIN)));
String username = Validate.isNullToDefault(userMap.get("USERNAME"), "").toString();
NavigationManager navigationManager = new NavigationManager();
List list = navigationManager.findListByNavigation();
%>
</head>
<body>
<div class="head">
	<div class="head_top" align="center" >
	  <table>
          <tr>
       	    <td width="240px" style="text-align:left !important;">您好<span style="color:red;"><%=username %></span> 欢迎来到学科资源平台</td>
            <td  width="400px"></td>
          <% 
          		if(Validate.isNull(username)){
          %><td width="120px" style="text-align:center">
                <a href="<%=path%>/jsp/login.jsp?url=<%=url%>">登录</a>
            </td>
          <%	
          		}else{ 
          %><td width="50px" style="text-align:center">
                <a href="javascript:void(0)" onclick="logout();">注销</a>
          	</td>
          	<td width="70px" style="text-align:left">
                <a href="<%=path%>/ggs/view/ggs/homeManager/blue/main.jsp">后台管理</a>
         	</td>
          <%	
          		}	
          %>
                <td width="280px" style="text-align:right !important;">  
                	<div id="sys-datetime">
            			<div id="date_time" style="float:left;">2014年07月09日</div>
            			<div id="tool_time" style="margin-left:10px;float:left;">11:10:56</div>
        			</div>
        		</td>
            </tr>
        </table>
    </div>
</div>
<script type="text/javascript">
	function logout(){
		$.ajax({
			type : "post",
			url : "<%=path%>/jsp/logout.jsp",
			dataType : "text",
			data : {logout : "yes"},
			success : function() {
				window.location.href="<%=path%>";
			}
		})
	}
</script>
</body>
</html>