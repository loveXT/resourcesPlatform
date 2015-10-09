<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.oa.webContent.WebContentManager"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.menumanager.MenuManager" %>
<%@page import="com.googosoft.menumanager.NoticeManager" %>
<%@page import="com.googosoft.menumanager.NewsManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学科资源平台</title>
<% String path = request.getContextPath(); %>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/index.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/xcConfirm.css"/>
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/xcConfirm.js"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
<style type="text/css">
	.text{
		margin-left:5px;
		white-space:nowrap;
		text-overflow:ellipsis;
		overflow: hidden;
		width:420px;
		text-align:left;
	}
	
	.time{
		font-family: "宋体";
	}
</style>
<%
String url = request.getScheme()+"://"; 
String urls=request.getContextPath();
System.out.println(urls);
%>
</head>
	<body>
	<jsp:include page="head.jsp"></jsp:include>
		<div class="wrapper">
			<div class="header">
				<div class="logo"></div>
				<div class="headerRight">
					<div class="search">
						<input type="text" name="searchText" value="请输入关键字..."/>
					</div>
					<div class="nav">
						<ul class="navul">
						<%
							MenuManager menumanager=new MenuManager();
							List list=menumanager.findPageInfo();
							Map map=null;
							for(int i=0;i<list.size();i++){
								map=(Map) list.get(i);
								
						%>
							<li><a href="<%=path%>/<%=Validate.isNullToDefault(map.get("ADDRESS"),"")%>" style="color:#FFFFFF;ba"><%=map.get("NAVIGATIONNAME") %></a>&nbsp;|</li>
							<%
							}
							%>
						</ul>
					</div>
				</div>
				
			</div>
			<div class="content"> 
				<div class="bigPic">
				<jsp:include page="bigPic.jsp"></jsp:include>
				</div>
				<div class="newsContent">
						<div class="notice">
							<div class="fontnotice">
								<div class="noticeImg"></div>公告
								<a href="<%=urls %>/platform/view.jsp" class="moreA"></a>
							</div>
							<div>
								<ul>
								<%
									NoticeManager NM=new NoticeManager();
									List noticelist=NM.findPageInfoByNotice();
									int ans=noticelist.size()>7? 7:noticelist.size();
									Map noticemap=null;
									for(int i=0;i<ans;i++){
										noticemap=(Map) noticelist.get(i);
										String title=noticemap.get("TITLE").toString();
										if(title.length()>23){
											title=title.substring(0,23)+"...";
										}
										String time=noticemap.get("UPDATETIME").toString().substring(5, 10);
										
								%>
									<li><a href="<%=urls %>/notice/notice.jsp?id=<%=noticemap.get("ID") %>" style="width:300px;color: #000000;"><%=title %></a><span class="time"><%=time %></span></li>
									<%
									}
									%>
								</ul>
							</div>
						</div>
						<div class="lineDiv"></div>
						<div class="news">
							<div class="fontnotice">
							<div class="newsImg"></div>新闻
								<a href="<%=urls %>/platform/view.jsp" class="moreA" ></a>
							</div>
							<div>
								<ul>
									<%
										NewsManager newsmanager= new NewsManager();
										List newslist=newsmanager.findPageInfoByNews();
										int pos=newslist.size()>7? 7:newslist.size();
										Map newsmap=null;
										for(int i=0;i<pos;i++){
											newsmap=(Map)newslist.get(i);
											String title=newsmap.get("TITLE").toString();
											if(title.length()>23){
												title=title.substring(0,23)+"...";
											}
											String time=newsmap.get("UPDATETIME").toString().substring(5, 10);
									%>
									<li><a href="<%=urls %>/notice/notice.jsp?id=<%=newsmap.get("ID") %>"			 style="width:300px;color: #000000;"><%=title %></a><span class="time"><%=time %></span></li>
									<%
										}
									%>
								</ul>
							</div>
						</div>
				</div>
				<div class="links">
					<a href="">返回首页&nbsp;|</a>
					<a href="">关于我们&nbsp;|</a>
					<a href="">友情链接&nbsp;|</a>
					<a href="">网站声明&nbsp;|</a>
					<a href="">意见建议</a>
				</div>
			</div>
			<div class="footer">
					<div class="footcontent">
					<p class="time">电话：0536-559035 邮编:261325 邮箱:sd271jyjt@126.com</p>
					<p>地址:山东省潍坊市峡山区主城区</p>
					<p class="time">271教育集团 版权所有 访问量：3649</p>
					<p class="time">备案号：鲁ICP备14033316号</p>
				</div>
				<div class="binaryCode">
					<div class="weixinma"></div>
					<div class="shoujima"></div>
				</div>				
			</div>
		</div>
	</body>
</html>