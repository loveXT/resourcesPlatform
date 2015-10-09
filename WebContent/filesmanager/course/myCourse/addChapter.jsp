<%@page import="com.googosoft.questionbank.questionbank.ChapterManager"%>
<%@page import="com.googosoft.commons.CodeHelper"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
	.sm_edit_from{
		border: 0px;
	}
	.nosee{
	
	}
	
	.course{
		clear: both;
		margin-left: 25%;
		padding: 10px;
		margin-right: 28%;
		border: 1px solid #84B8F1;
		padding-bottom: 40px;
		margin-top: 10px;
		width: 450px;
	}
	
	.chapter{
		height: 100%;
		clear: both;
		width: 450px;
		margin-top: 10px;
	}
	
	.knowledge{
		height: 30px;
		clear: both;
	}
	
	.delcap{
		background: #2497D3;
		border: 0px;
		height: 20px;
		width: 60px;
		color: white;
	}
	
	.delpoi{
		background: #2497D3;
		border: 0px;
		height: 20px;
		width: 76px;
		color: white;
	}
</style>
</head>
<%
	String courseId =request.getParameter("courseId");
	String mid =request.getParameter("majorId");
	String courseid = request.getParameter("P=CHAPTER-1=COURSE_ID=S=C");
	String chapterId = CodeHelper.createUUID();
	String operateType = request.getParameter("operateType");
	boolean bool = false;
	if (Validate.noNull(operateType)) {
		CUDHelper cudHelper = new CUDHelper(request, "=", "-");
		bool = cudHelper.execute();
	}
	String sub = request.getParameter("sub");
%>
<body>
	<div class="tool"></div>
	<form class="sm_edit_from" action="" method="post" style="padding-bottom:20px">
	
	<div class="nosee">
		<input type="hidden" name="operateType" value="C">
		<input type="hidden" name="sub" value="T">
		<input type="hidden" name="P=CHAPTER-1=CHAPTER_ID=S=P" value="<%=chapterId%>"/>
		<input type="hidden" name="P=CHAPTER-1=COURSE_ID=S=C" value="<%=courseId%>"/>		
		<input type="hidden" name="courseid" value="<%=courseid%>"/>
		<input type="hidden" class="maxLength:32num"
						name="P=CHAPTER-1=USERIDBYLOGIN=S=C"
						value="<%=session.getAttribute("USERIDBYLOGIN")%>">
		<input type="hidden" class="maxLength:32num" name="P=CHAPTER-1=SAAS=S=C"
						value="<%=session.getAttribute("SAAS")%>">
	</div>
	<div class="course">
<!-- 		<div class="sm_edit_tr"> -->
<!-- 			<div class="sm_edit_td_name" style="border-left:1px solid #84B8F1; border-top: 1px solid #84B8F1;">章节编号:</div> -->
			<%
			ChapterManager chapterManager = new ChapterManager();
			String StringCode = (String)chapterManager.findMaxCode(courseId);
			int maxCode = Integer.valueOf(StringCode);
			StringCode = String.format("%06d", maxCode+1);
			%>
				<input type="hidden" readonly class="null maxLength:60num" name="P=CHAPTER-1=CHAPTER_CODE=S=C" value="<%=StringCode%>"/>
		<div class="sm_edit_tr">
			<div class="sm_edit_td_name" style="border-left:1px solid #84B8F1; border-top: 1px solid #84B8F1; border-bottom: 1px solid #84B8F1;">章节名称:</div>
			<div class="sm_edit_td_value" style="border-top: 1px solid #84B8F1; border-bottom: 1px solid #84B8F1;"><input type="text" class="null maxLength:60num" id = "addChapterName" name="P=CHAPTER-1=CHAPTER_NAME=S=C"/>
			<input id="hidden"></div>
			<div class="sm_edit_td_value" style="width: 80px; border-top: 1px solid #84B8F1; 
			border-bottom: 1px solid #84B8F1;border-left: 1px solid #84B8F1; border-right: 0px;"><input class="delpoi" type="button" value="添加知识点" id="chapter_button"/></div>
	 		<div class="sm_edit_td_value" style="width: 80px; border-top: 1px solid #84B8F1; 
	 		border-bottom: 1px solid #84B8F1;border-right: 1px solid #84B8F1; margin-bottom:20px"></div>
	 	</div>
 	</div>
 	</form>
	<div class="chapter" style="display:none">
		<div class="sm_edit_td_name" style="border-left:1px solid #84B8F1; border-top: 1px solid #84B8F1; border-bottom: 1px solid #84B8F1;"><font style="font-weight: bold;">知识点名称:</font></div>
		<div class="sm_edit_td_value" style="border-top: 1px solid #84B8F1; border-bottom: 1px solid #84B8F1;"><input type="text" class="null maxLength:60num" name="P=KNOWLEDGE_POINT=POINT_NAME=S=C"/></div>
		<input type="hidden" name="P=KNOWLEDGE_POINT=CHAPTER_ID=S=C" value="<%=chapterId%>"/>
		<input type="hidden" name="P=KNOWLEDGE_POINT=POINT_ID=S=P"/>
		<input type="hidden" name="P=KNOWLEDGE_POINT=COURSE_ID=S=C" value="<%=courseId%>"/>
		<input type="hidden" class="maxLength:32num"
						name="P=KNOWLEDGE_POINT=USERIDBYLOGIN=S=C"
						value="<%=session.getAttribute("USERIDBYLOGIN")%>"> 
		<input type="hidden" class="maxLength:32num" name="P=KNOWLEDGE_POINT=SAAS=S=C"
						value="<%=session.getAttribute("SAAS")%>">
		<div class="sm_edit_td_value" style="width: 80px; border-top: 1px solid #84B8F1; 
		border-bottom: 1px solid #84B8F1;border-right: 1px solid #84B8F1;"><input class="delpoi" type="button" value="删除知识点"  onclick="$.deleteDom(this.id)"/></div>
		<div style="clear:both;"></div>
	</div>
	<%@include file="/ggs/include/js.inc" %>
	<script  type="text/javascript">
	(function($){
		jQuery.fn.autofield=function(options){
				var defaults = {
					container2:'',
					container3:'',
					//容器2中的button，当点击这个button时，往容器2中添加容器3以及其内容
					operDom:'',
					//当前容器中的button，当点击button时在当前容器中添加容器2以及其内容
					button:''
				}
				var opts=jQuery.extend({},defaults,options);
				var i = 100,j=100;
				return this.each(function(){
					var container =$(this);
					var container2=options.container2;
					var button = options.button;
					var operDom = options.operDom;
					var _container2=$(container2).clone().attr("style","diplay:block");
					$(button).click(function(){
						i++;
						<%
							String uuid = CodeHelper.createUUID();
							String cid = uuid.substring(0,uuid.length()-3);
						%>
						var chapterId = "<%=cid%>"+i;
						var prefix = container2.substring(1,container2.length);
						var idAttr=prefix+i;
						var a = _container2.clone();
						$(container).append(_container2.clone().attr("id",idAttr));
						$("[name='P=KNOWLEDGE_POINT=POINT_NAME=S=C']:first").attr("name","P=KNOWLEDGE_POINT-"+i+"=POINT_NAME=S=C");
						$("[name='P=KNOWLEDGE_POINT=CHAPTER_ID=S=C']:first").attr("name","P=KNOWLEDGE_POINT-"+i+"=CHAPTER_ID=S=C");
						$("[name='P=KNOWLEDGE_POINT=POINT_ID=S=P']:first").attr("name","P=KNOWLEDGE_POINT-"+i+"=POINT_ID=S=P");
						$("[name='P=KNOWLEDGE_POINT=COURSE_ID=S=C']:first").attr("name","P=KNOWLEDGE_POINT-"+i+"=COURSE_ID=S=C");
						$("[name='P=KNOWLEDGE_POINT=USERIDBYLOGIN=S=C']:first").attr("name","P=KNOWLEDGE_POINT-"+i+"=USERIDBYLOGIN=S=C");
						$("[name='P=KNOWLEDGE_POINT=SAAS=S=C']:first").attr("name","P=KNOWLEDGE_POINT-"+i+"=SAAS=S=C");
						$("#"+idAttr+" "+operDom).attr("id",idAttr+"_button");
						setPageSize();
					});
					$.deleteDom = function(id){
						var currentId= 	id;
						var domid=id.substring(0,id.indexOf("_"));
						$("#"+domid).remove();
					}
				});
			
			}
		})(jQuery)
	</script>
	<script type="text/javascript">
		$(function(){
			$(".course").autofield({
				container2:'.chapter',
				button:'#chapter_button', 
				operDom:':input[type=button]'
			});
		});
	</script>
	
	<script type="text/javascript">
		var chapterflag=false;
		$(function() {
			$("#addChapterName").bind('blur',function(){
				var chapterName = encodeURIComponent($(this).val());
				chapterName = encodeURIComponent(chapterName);
				var url = "<%=path%>/filesmanager/fileManager/validateByAdd.jsp?TABLENAME=CHAPTER&WHERECOLUMN1=COURSE_ID&VALUE1=<%=courseId%>&WHERECOLUMN2=CHAPTER_NAME&VALUE2="+chapterName;
				$.ajax({
					url:url,
					type:"post",
					success:function(data){
						if(data>0){
							alert("该课程下，此章节名已存在！");
							$("#addChapterName").val("");
						}else{
							if(!chapterflag){
								chapterflag=!chapterflag;
							}
						}
					}
				});
			});
			if(<%=bool%>){
				parent.location.href = "listFile.jsp?MAJOR_ID=<%=mid%>&COURSE_ID=<%=courseId%>";//刷新父窗口 
			}
			$(".tool").toolBar([ {
				text : "保存",
				width : 60,
				position : "-140px -160px",
				handler : function() {
						if(validateBySubmit($("form"))&&chapterflag){
						$("form").submit();
					} 
					
				}
			} ]);
			$('#hidden').hide();
			
			
		});
		function setPageSize(){
			setHeight($("form"),$("body"),[$(".tool")]);
		}
	</script>
</body>
</html>
