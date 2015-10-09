<%@page import="com.googosoft.filesManager.netresvindicate.MajorType"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.filesManager.netresvindicate.ResourceManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>搜索</title>
<% String path = request.getContextPath(); %>
<script type="text/javascript" src="<%=path%>/js/searchFunction.js"></script>
<style type="text/css">
	.search{
		width:100%;
		height:auto;
		margin:0px auto;
	}
	.search .category_top {
		background-color: #FFF;
		top: auto;
		float: left;
		width: 100%;
		height: 31px;
		clear: both;
		background:url('<%=path%>/image/zylb_1.gif') repeat-x;
	}
	.search .category{
		height:31px;
		width:104px;
		float:left;
		border-right:1px solid #ACDAFE;
		cursor: pointer;
	}
	.search .category_show{
		height:30px;
		width:104px;
		float:left;
		border-top:1px solid #ACDAFE;
		border-right:1px solid #ACDAFE;
		background:url(<%=path%>/image/jt5.gif) no-repeat center bottom;
		cursor: pointer;
	}
	.search .category .category_text {
		font-size: 14px;
		color: #000000;
		line-height: 31px;
		padding-left: 22px;
	}
	.search .category_show .category_text {
		font-size: 14px;
 		color: #026ad3;
 		font-weight: bold;
		line-height: 31px;
		padding-left: 22px;
	}
	.search ul.category_body{
		width:1052px;
		background:#FFFFFF;
		margin-top:0px;
		display:block;
		height:30px;
		margin:0px;
		padding:0px;
		display:none;
	}
	.search .category_body li{
		display:block;
		float:left;
		height:30px;
		width:110px;
		line-height:30px;
		font-size:12px;
		text-align:center;
		white-space:nowrap;
		text-overflow:ellipsis;
		overflow: hidden;
	}
	.search ul .more{
		float:left;
		width:50px;
		height:30px;
		margin-left:100px;
		color:#15428B;
		line-height: 30px;
		font-size: 12px;
	}
	.search .search_input{
		float:left;
		width:270px;
		heihgt:30px;
		margin-left:500px;
		margin-top:4px;
	}
	.search .input_button{
		float:left;
		width:50px;
		height:20px;
		background:url('<%=path%>/image/ss.gif') no-repeat;
		margin-top:5px;
		margin-left:3px;
	}
	.search select,input{
		border:1px solid #ACDAFE;
	}
	.search .majorstyle{
		color:red;
	}
	.search li a{
		font-size:13px;
	}
</style>
</head>
<body>
<%
	String typeId = request.getParameter("Type_Id");
	String src = request.getParameter("src");
	String biaoti = request.getParameter("biaoti");
	MajorType mt = new MajorType();
%>
	<div class="search">
		<div class="category_top">
			<div id="category_1" class="category_show" onclick="tabCategory(this,1)">
				<span class="category_text">专业大类</span>
			</div>
			<div id="category_2" class="category" onclick="tabCategory(this,2)">
				<span class="category_text">格式大类</span>
			</div>
			<div class="search_input">
				<select id="type" name="Type" style="width:100px;height:22px;" onchange="f1()">
					<option value="" selected="selected">--检索--</option>
					<option value="01" <%if("01".equals(request.getParameter("Type_Id"))){%>selected<%} %>>文件类别</option>
					<option value="02" <%if("02".equals(request.getParameter("Type_Id"))){%>selected<%} %>>标题</option>
					<option value="03" <%if("03".equals(request.getParameter("Type_Id"))){%>selected<%} %>>格式</option>
					<option value="04" <%if("04".equals(request.getParameter("Type_Id"))){%>selected<%} %>>专业</option>
				</select>
  						<select id="keyWord" style="width: 135px;margin-left:10px;height: 22px;display:none;" name="KeyWord" >
  						<option value="">--请选择--</option> 
 						<% 
 	 					List typeList=new ResourceManager().findListByRESOURCEMANAGER();  
 	 					Map typeMap;  
 	 					for (int i=0;i<typeList.size();i++) {  
 	 						typeMap=(Map)typeList.get(i);  
 	 					%>  
	 						<option value="<%=typeMap.get("ID")%>"<%if((typeMap.get("ID")).equals(request.getParameter("biaoti"))){%>selected<%} %>><%=Validate.isNullToDefault(typeMap.get("NAME"),"") %></option> 
	 					<% 
 	 					}  
 	 					%> 
  						</select>  
				<input type="text" id="sInput" style="height:18px;width:133px;margin-left:10px;" name="REALNAME" value="">
				</div>
			<div class="input_button"></div>
		</div>
		<div style="height:auto;width:100%;float:left;">
			<%
			List mlist = mt.findMajorlist();
			if(mlist.size()>8){
				%>
			<ul class="category_body" id="category_body_1" style="display:block">
			<% 
				for(int i=0;i<8;i++){
					Map map = (Map)mlist.get(i);
				%>
				<li>
					<a href="<%=path%>/filesmanager/fileManager/myFiles/mainPicture.jsp?majorid=<%=map.get("MAJOR_ID") %>"><%=Validate.isNullToDefault(map.get("MAJOR_NAME"),"")%></a>
				</li>
				<%
				}
				%>
				<li class="more" >
					<a href="javascript:void(0)" onclick="showHideCode(this)">展开&gt;&gt;</a>
				</li>
			</ul>
			<ul class="category_body" id="category_body_3" style="display:none">
			<%
			for(int i=8;i<mlist.size();i++){
				Map map = (Map)mlist.get(i);
				String majorName = Validate.isNullToDefault(map.get("MAJOR_NAME"), "").toString();
				if(majorName.length()>8){
					majorName = majorName.substring(0, 8);
				}
			%>
				<li>
					<a href="<%=path%>/filesmanager/fileManager/myFiles/mainPicture.jsp?majorid=<%=map.get("MAJOR_ID") %>"><%=majorName%></a>
				</li>
			<%
			}
			%>
			</ul>
			<%
			}else if(mlist.size()<=8){
				%>
				<ul>
				<%
				for(int i=0;i<mlist.size();i++){
					Map map = (Map)mlist.get(i);
					%>
					<li>
						<a href="<%=path%>/filesmanager/fileManager/myFiles/mainPicture.jsp?majorid=<%=map.get("MAJOR_ID") %>"><%=Validate.isNullToDefault(map.get("MAJOR_NAME"),"")%></a>
					</li>
					<%
				}
			}
			%>
			</ul>
			<ul class="category_body" id="category_body_2">
			<%
			List tlist = mt.findClassifyList();
			for(int i=0;i<tlist.size();i++){
				Map map = (Map)tlist.get(i);
			%>
				<li>
					<a href="<%=path%>/filesmanager/fileManager/myFiles/mainPicture.jsp?classify=<%=map.get("ID") %>"><%=Validate.isNullToDefault(map.get("NAME"),"")%></a>
				</li>
			<%
			}
			%>
			</ul>
		</div>
	</div>
	<form id="type_form" action="" method="post">
			<input type="hidden" name="Type_Id" value=""/>
			<input type="hidden" name="src" value=""/>
			<input type="hidden" name="biaoti" value="">
	</form>
<script type="text/javascript">
	function tabCategory(this_,k){
		 $("#category_"+k).removeClass("category").addClass("category_show");
		 $("#category_body_"+k).css("display","block");
		 for(var i=1;i<=3;i++){
			 if(i!=k){
				 $("#category_"+i).removeClass("category_show").addClass("category");
				 $("#category_body_"+i).css("display","none");
			 }
		} 
	}
	var typeId = $("#type").val();
	if("01"==typeId){
		$("[id=sInput]").hide();
    	$("[id=keyWord]").show();
	}else{
		$("[id=sInput]").show();
		$("[id=keyWord]").hide();
	}
	function f1(){
		var typeId = $("#type").val();
		if("01"==typeId){
			var url = "<%=path%>/jsp/json.jsp";
		    var params="typeId="+typeId;
		    jQuery.getJSON(url,params,function callback(data){
		    	$("[id=sInput]").hide();
		    	$("[id=keyWord]").show();
		    	$("[id=keyWord] option").remove();
		    	$("[id=keyWord]").append('<option value="">--请选择--</option>');
	 			jQuery.each(data,function(i,item){
		 	    	$("[id=keyWord]").append(
		 	    		'<option value="'+item.ID+'">'+item.NAME+'</option>'
		 	    	);
	 			});
	 		});
		}else{
			$("[id=sInput]").show();
			$("[id=keyWord]").hide();
		}
	}
	$(".input_button").live("click",function(){
		var str = $("#type").val();
		var src = "<%=path%>/filesmanager/fileManager/myFiles/mainPicture.jsp";
		var biaoti=$("[name=REALNAME]").val();
		if("01"==str){
			biaoti=$("#keyWord").val();
		}
		src += "?Type_Id="+str+"&biaoti="+biaoti;
		window.location.href=src;
	});
	function showHideCode(this_){
		if("展开&gt;&gt;"==$(this_).html()){
        	$(this_).html("收起&gt;&gt;");
        }else if("收起&gt;&gt;"==$(this_).html()){
        	$(this_).html("展开&gt;&gt;");        	
        }
        $("#category_body_3").toggle();
     }
</script>
</body>
</html>