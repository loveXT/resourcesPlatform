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
<title>Insert title here</title>
<% String path = request.getContextPath();  %>
</head>
<body>
<div id="category_body_2" style="display:none">
			<div class="xueke" id="type">
				<span>类型:</span>
				<ul class="category_body" style="display:block;">
				<%
					ResourceManager RM=new ResourceManager();
					List resourcelist=RM.findListByRESOURCEMANAGER();
					Map resourcemap=null;
					for(int i=0;i<resourcelist.size();i++){
						resourcemap=(Map)resourcelist.get(i);
						String NAME=resourcemap.get("NAME").toString();
				%>
					<li>
						<a href="#" style="width:300px;color: #000000;"onclick="dianji(this,<%=i%>,5)">
							<input type="text" class="fontcolor_<%=i%>_5" readonly="readonly" style="border:0px;margin-top: 7px;" name="classifyName_<%=i%>" value="<%=NAME %>">	
							<input type="hidden" name="classifyId_<%=i%>" value="<%=resourcemap.get("ID")%>">
						</a>
					</li>
				<%
					}
				%>
				</ul>
			</div>
			<div class="chaxuntiaojian">
				<div class="cximg"></div>
				<div class="bjimg">
					<div class="fgimg"></div>
					<div class="YC" id="YC5" title="双击移除条件">
						<div class="zcxtj" id="zcxtj5" ondblclick="dblc(this,5)">
						</div>
						<div class="fgimg" ></div>
					</div>
					<div style="  width: 400px;height: 24px;float: right;">
						<input type="text" name="biaotis" class="ssinput" value="<%=Validate.isNullToDefault(request.getParameter("biaoti"), "") %>">
						<div class="sousuo">
					</div>
					</div>
				</div>
				<div class="zhimg"></div>
			</div>
		</div>
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="<%=path%>/js/searchFunction.js"></script>
	<script type="text/javascript">
		function dblc(this_,k){
			var flag5 = $("[name=flag5]").val();
			if(k==5){
				$(".fontcolor_"+flag5+"_5").removeClass("fontcolor");
				$("#YC5").removeClass("YC1").addClass("YC");
				$("[name=classifyId]").val("");
				$("[name=classifyName]").val("");
			}
		}

		function dianji(this_,i,k){
			var classifyName = $("[name='classifyName_"+i+"']").val();
			var classifyId = $("[name='classifyId_"+i+"']").val();
			$(".fontcolor_"+i+"_"+k).addClass("fontcolor");
			var cSize = 20;
			for(var j=0;j<=cSize;j++){
				 if(j!=i){
					 $(".fontcolor_"+j+"_"+k).removeClass("fontcolor").addClass("fontcolors");
				 }
			} 
			if(k==5){
				$("#zcxtj"+k).html(classifyName);
				$("[name=classifyId]").val(classifyId);
				$("[name=classifyName]").val(classifyName);
				$("[name=flag5]").val(i);
				$("#YC"+k).removeClass("YC").addClass("YC1");
			}
		}
		$(".sousuo").live("click",function(){
			$("[name=biaoti]").val($("[name=biaotis]").val());
			$("[name=pageClass]").val("1");
			$("[name=nowPage]").val("1");
			$("#fileForm").submit();
		});
		$(function(){
			var classifyName = $("[name=classifyName]").val();
			var flag5 = $("[name=flag5]").val();
			if(classifyName!=""&&classifyName&&"null"&&classifyName!=null){
				$("#zcxtj5").html(classifyName);
				$(".fontcolor_"+flag5+"_5").addClass("fontcolor");
				$("#YC5").removeClass("YC").addClass("YC1");
			}
			var num = $("[name=selectNum]").val();
			if(num==""||num=="null"||num==null){
				num=1;
			}
			 $("#category_"+num).removeClass("category").addClass("category_show");
			 $("#category_body_"+num).css("display","block");
			 for(var i=1;i<=3;i++){
				 if(i!=num){
					 $("#category_"+i).removeClass("category_show").addClass("category");
					 $("#category_body_"+i).css("display","none");
				 }
			 }

		});
	</script>
</body>
</html>