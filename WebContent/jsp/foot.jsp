<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>页面底部</title>
<% String path = request.getContextPath(); %>
<style type="text/css">
	.foot{
		width:100%;
		height:50px;
		text-align:center;
		font-size:12px;
		color:#000000;
		font-family: 微软雅黑,宋体;
		margin:0px auto;
		background:url('<%=path%>/image/foot.gif') no-repeat center;
	}
	.foot .foot_color{
		width: 100%;
  		text-align: center;
 		line-height: 25px;
	}
</style>
</head>
<body>
	<div class="foot">
		<div class="foot_color">@2015&nbsp;&nbsp;Googosoft Corporation All Rights Resevered.</div>
		<div class="foot_color"  style="line-height: 15px;">版权所有：山东国子软件股份有限公司</div>
    </div>
</body>
</html>