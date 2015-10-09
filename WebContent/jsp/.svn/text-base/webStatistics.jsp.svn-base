<%@page import="java.text.DecimalFormat"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.filesManager.netresvindicate.MajorType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>平台统计</title>
<% String path = request.getContextPath();%>
<style type="text/css">
	.webStatistics{
		width:100%;
		height:auto;
		margin:0px auto;
	}
	.webStatistics .title{
		height:30px;
		width:100%;
		background: url('<%=path%>/image/zxzy_1.gif') repeat-x;
	}
	.webStatistics .title_text {
		height: 28px;
		width: 100%;
		float: left;
		margin-left:10px;
		background: url('<%=path%>/image/zxzy_2.gif') left center no-repeat;
	}
	
	.webStatistics .title_text span {
		font-size: 14px;
		color: #026ad3;
		font-weight: bold;
		line-height: 28px;
		padding-left: 16px;
	}
	.webStatistics .content{
		width:100%;
		height:auto;
		float:left;
	}
	.tdfont{
		width:150px;
		color:gray;
		font-size: 14px;
	}
	.tdimg{
		width:20px;
	}
	.numfont{
		color: red;
		font-size: 14px;
	}
	.trstyle{
		line-height:40px;
	}
</style>
</head>
<body>
<div class="webStatistics">
		<div class="title">
			<div class="title_text">
				<span>平台统计</span>
			</div>
		</div>
		<div class="content">
			<%
				MajorType majorType = new MajorType();
				Map map = majorType.findMapByFiles();
				String filesize = Validate.isNullToDefault(map.get("FILESIZE"), "0").toString();
				double size = Double.parseDouble(filesize);
				DecimalFormat    df   = new DecimalFormat("0.00");  
				String danwei = "KB";
				if(size/1024>=1&&size/1024<1000){
					size = size/1024;
					danwei = "MB";
				}else if(size/1024/1024>=1&&size/1024/1024<1000){
					size = size/1024/1024;
					danwei = "GB";
				}else if(size/1024/1024/1024>=1&&size/1024/1024/1024<1000){
					size = size/1024/1024/1024;
					danwei = "TB";
				}
			%>
			<table style="margin-top: 15px;margin-left: 20px;">
				<tr class="trstyle">
					<td class="tdimg">
						<div>
							<img alt="" src="<%=path %>/image/jt2.gif"  />
						</div>
					</td>
					<td class="tdfont">资源总量:</td>
					<td class="numfont"><%=df.format(size)+danwei%></td>
				</tr>
				<tr class="trstyle">
					<td class="tdimg">
						<div>
							<img alt="" src="<%=path %>/image/jt2.gif"  />
						</div>
					</td>
					<td class="tdfont">资源总数:</td>
					<td class="numfont"><%=Validate.isNullToDefault(map.get("COUNT"),"0") %></td>
				</tr>
				<tr class="trstyle">
					<td class="tdimg">
						<div>
							<img alt="" src="<%=path %>/image/jt2.gif"  />
						</div>
					</td>
					<td class="tdfont">总下载量:</td>
					<td class="numfont"><%=Validate.isNullToDefault(map.get("DOWNLOADTIME"),"0") %></td>
				</tr>
				<tr class="trstyle">
					<td class="tdimg">
						<div>
							<img alt="" src="<%=path %>/image/jt2.gif"  />
						</div>
					</td>
					<td class="tdfont">总浏览量:</td>
					<td class="numfont"><%=Validate.isNullToDefault(map.get("BROWSETIME"),"0") %></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>