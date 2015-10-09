<%@page import="com.googosoft.baseInfoManager.MainTypeManager"%>
<%@page import="com.googosoft.baseInfoManager.CourseManager"%>
<%@page import="com.googosoft.baseInfoManager.VersionManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.baseInfoManager.GradeManager"%>
<%@page import="com.googosoft.commons.Validate"%>
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
<div id="category_body_1">
			<div class="xueke" id="xueke">
				<span>学科:</span>
				<ul class="category_body" style="display:block">
				<%
                    CourseManager CM=new CourseManager();
					List courselist=CM.findListCourseManager();
					int cSize = courselist.size();
					Map coursemap=null;
					for(int i=0;i<courselist.size();i++){
						coursemap=(Map)courselist.get(i);
						String COURSE_NAME=coursemap.get("COURSE_NAME").toString();
				%>
					<li >
						<a href="javascript:void(0)" style="width:300px;color: #000000;" onclick="dj(this,<%=i%>,1)">
							<input type="text" class="fontcolor_<%=i%>_1" readonly="readonly" style="border:0px;margin-top: 7px;" name="COURSE_NAME_<%=i%>" value="<%=COURSE_NAME %>">	
							<input type="hidden" name="COURSE_ID_<%=i%>" value="<%=coursemap.get("COURSE_ID")%>">
						</a>
					</li>
				<%
					}
				%>
				</ul>
			</div>
			<div class="xueke">
				<span>年级:</span>
				<ul class="category_body" style="display:block">
				<%
                    GradeManager GM=new GradeManager();
					List gradelist=GM.findListGradeManager();
					Map grademap=null;
					for(int i=0;i<gradelist.size();i++){
						grademap=(Map)gradelist.get(i);
						String NJMC=grademap.get("NJMC").toString();
				%>
					<li>
					<a href="#" style="width:300px;color: #000000;"onclick="dj(this,<%=i%>,2)">
						<input type="text" class="fontcolor_<%=i%>_2" readonly="readonly" style="border:0px;margin-top: 7px;" name="GRADENAME_<%=i%>" value="<%=NJMC %>">	
						<input type="hidden" name="GRADEID_<%=i%>" value="<%=grademap.get("ID")%>">
					</a>
					</li>
				<%
					}
				%>
				</ul>
			</div>
			<div class="xueke" id="banben">
				<span>版本:</span>
				<ul class="category_body" style="display:block">
					<%
	                    VersionManager VM=new VersionManager();
						List versionlist=VM.findListVersionManager();
						Map versionmap=null;
						for(int i=0;i<versionlist.size();i++){
							versionmap=(Map)versionlist.get(i);
							String VERSIONNAME=versionmap.get("VERSIONNAME").toString();
					%>
						<li>
						<a href="#" style="width:300px;color: #000000;"onclick="dj(this,<%=i%>,3)">
							<input type="text" class="fontcolor_<%=i%>_3" readonly="readonly" style="border:0px;margin-top: 7px;" name="VERSIONNAME_<%=i%>" value="<%=VERSIONNAME %>">	
							<input type="hidden" name="VERSIONID_<%=i%>" value="<%=versionmap.get("ID")%>">
						</a>
						</li>
					<%
						}
					%>
				</ul>
			</div>
			<div class="xueke" id="type">
				<ul class="category_body" style="display:block;margin-left: 20px;">
					<%
	                    MainTypeManager MM=new MainTypeManager();
						List mainTypelist=MM.findListMainTypeManager();
						Map mainTypemap=null;
						for(int i=0;i<mainTypelist.size();i++){
							mainTypemap=(Map)mainTypelist.get(i);
							String TYPENAME=mainTypemap.get("TYPENAME").toString();
					%>
						<li>
						<a href="#" style="width:300px;color: #000000;"onclick="dj(this,<%=i%>,4)">
							<input type="text" class="fontcolor_<%=i%>_4" readonly="readonly" style="border:0px;margin-top: 7px;" name="TYPENAME_<%=i%>" value="<%=TYPENAME %>">	
							<input type="hidden" name="TYPEID_<%=i%>" value="<%=mainTypemap.get("ID")%>">
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
					<div class="YC" id="YC1" title="双击移除条件">
						<div class="zcxtj" id="zcxtj1" ondblclick="dbl(this,1)">
						</div>
						<div class="fgimg" ></div>
					</div>
					<div class="YC" id="YC2" title="双击移除条件">
						<div class="zcxtj" id="zcxtj2" ondblclick="dbl(this,2)">
						</div>
						<div class="fgimg"></div>
					</div>
					<div class="YC" id="YC3" title="双击移除条件">
						<div class="zcxtj" id="zcxtj3" ondblclick="dbl(this,3)">
						</div>
						<div class="fgimg"></div>
					</div>
					<div class="YC" id="YC4" title="双击移除条件">
						<div class="zcxtj" id="zcxtj4" ondblclick="dbl(this,4)">
						</div>
						<div class="fgimg"></div>
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
		function dbl(this_,k){
			var flag1 = $("[name=flag1]").val();
			var flag2 = $("[name=flag2]").val();
			var flag3 = $("[name=flag3]").val();
			var flag4 = $("[name=flag4]").val();
			if(k==1){
				$(".fontcolor_"+flag1+"_1").removeClass("fontcolor");
				$("#YC1").removeClass("YC1").addClass("YC");
				$("[name=courseId]").val("");
				$("[name=courseName]").val("");
			}else if(k==2){
				$(".fontcolor_"+flag2+"_2").removeClass("fontcolor");
				$("#YC2").removeClass("YC1").addClass("YC");
				$("[name=gradeId]").val("");
				$("[name=gradeName]").val("");
			}else if(k==3){
				$(".fontcolor_"+flag3+"_3").removeClass("fontcolor");
				$("#YC3").removeClass("YC1").addClass("YC");
				$("[name=versionId]").val("");
				$("[name=versionName]").val("");
			}else if(k==4){
				$(".fontcolor_"+flag4+"_4").removeClass("fontcolor");
				$("#YC4").removeClass("YC1").addClass("YC");
				$("[name=typeId]").val("");
				$("[name=typeName]").val("");
			}

		}

		function dj(this_,i,k){
			var courseName = $("[name='COURSE_NAME_"+i+"']").val();
			var courseId = $("[name='COURSE_ID_"+i+"']").val();
			var gradeName = $("[name='GRADENAME_"+i+"']").val();
			var gradeId = $("[name='GRADEID_"+i+"']").val();
			var versionName = $("[name='VERSIONNAME_"+i+"']").val();
			var versionId = $("[name='VERSIONID_"+i+"']").val();
			var typeName = $("[name='TYPENAME_"+i+"']").val();
			var typeId = $("[name='TYPEID_"+i+"']").val();
			$(".fontcolor_"+i+"_"+k).addClass("fontcolor");
			var cSize = 20;
			for(var j=0;j<=cSize;j++){
				 if(j!=i){
					 $(".fontcolor_"+j+"_"+k).removeClass("fontcolor").addClass("fontcolors");
				 }
			} 
			if(k==1){
				$("#zcxtj"+k).html(courseName);
				$("[name=courseId]").val(courseId);
				$("[name=courseName]").val(courseName);
				$("[name=flag1]").val(i);
			}else if(k==2){
				$("#zcxtj"+k).html(gradeName);
				$("[name=gradeId]").val(gradeId);
				$("[name=gradeName]").val(gradeName);
				$("[name=flag2]").val(i);
			}else if(k==3){
				$("#zcxtj"+k).html(versionName);
				$("[name=versionId]").val(versionId);
				$("[name=versionName]").val(versionName);
				$("[name=flag3]").val(i);
			}else if(k==4){
				$("#zcxtj"+k).html(typeName);
				$("[name=typeId]").val(typeId);
				$("[name=typeName]").val(typeName);
				$("[name=flag4]").val(i);
			}
			$("#YC"+k).removeClass("YC").addClass("YC1");
		}
		$(".sousuo").live("click",function(){
			$("[name=biaoti]").val($("[name=biaotis]").val());
			$("[name=pageClass]").val("1");
			$("[name=nowPage]").val("1");
			$("#fileForm").submit();
		});
		$(function(){
			var courseName = $("[name=courseName]").val();
			var gradeName = $("[name=gradeName]").val();
			var versionName = $("[name=versionName]").val();
			var typeName = $("[name=typeName]").val();
			var flag1 = $("[name=flag1]").val();
			var flag2 = $("[name=flag2]").val();
			var flag3 = $("[name=flag3]").val();
			var flag4 = $("[name=flag4]").val();
			if(courseName!=""&&courseName&&"null"&&courseName!=null){
				$("#zcxtj1").html(courseName);
				$(".fontcolor_"+flag1+"_1").addClass("fontcolor");
				$("#YC1").removeClass("YC").addClass("YC1");
			}
			if(gradeName!=""&&gradeName!="null"&&gradeName!=null){
				$("#zcxtj2").html(gradeName);
				$(".fontcolor_"+flag2+"_2").addClass("fontcolor");
				$("#YC2").removeClass("YC").addClass("YC1");
			}
			if(versionName!=""&&versionName!="null"&&versionName!=null){
				$("#zcxtj3").html(versionName);
				$(".fontcolor_"+flag3+"_3").addClass("fontcolor");
				$("#YC3").removeClass("YC").addClass("YC1");
			}
			if(typeName!=""&&typeName!="null"&&typeName!=null){
				$("#zcxtj4").html(typeName);
				$(".fontcolor_"+flag4+"_4").addClass("fontcolor");
				$("#YC4").removeClass("YC").addClass("YC1");
			}
		});
	</script>
</body>
</html>