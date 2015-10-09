<%@page import="java.util.Map"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.tree.TreeInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.ggs.homeManager.ResourceByDisplay"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>sm_lead</title>
<%@include file="/ggs/include/css.inc"%>
<style type="text/css">
</style>
</head>
<%
String parentId = request.getParameter("parentId");
%>
<body>
	<div class="sm_lead_left">
		<div class="sm_lead_title">系统菜单</div>
		<div class="sm_lead_resource">
			<div class="sm_resource_1" id="sm_desktop" layer="1" name="我的桌面"
				url="desktop.jsp">
				<div class="sm_resource_logo_1">我的桌面</div>
			</div>
			<%
				ResourceByDisplay resourceByDisplay = new ResourceByDisplay();
				List list = resourceByDisplay.findTreeByumresource(request,parentId);
				TreeInfo info = null,next=null;
				Map resourceMap = null;
				boolean bool;
				for (int i = 0; i < list.size(); i++) {
					bool = false;
					info = (TreeInfo) list.get(i);
					if(i!=list.size()-1){
						next = (TreeInfo) list.get(i+1);
						if(info.getLayer()+1==next.getLayer()){
							bool = true;
						}
					}
			%>
			<div class="sm_resource_<%=info.getLayer()%>"
				id="<%=info.getId()%>" layer="<%=info.getLayer()%>"
				name="<%=info.getName()%>"
				url="<%=path + Validate.isNullToDefault(info.getRemark(), "")%>">
				<%
				if(bool){
					%><div class="sm_resource_logo_<%=info.getLayer()%>"><%=info.getName()%></div><%
				}else{
					%><div class="sm_resource_logo_null"><%=info.getName()%></div><%
				}
				%>
			</div>
			<%
				}
			%>
		</div>
		<div class="sm_lead_title"></div>
	</div>
	<div class="sm_lead_middle" display="block"></div>
	<div class="sm_lead_right">
		<div class="sm_lead_remark">
			<div class="sm_lead_iframe_name"></div>
			<div class="sm_lead_resource_three">
				<div class="optionBar"></div>
			</div>
		</div>
		<div class="sm_lead_iframe"></div>
	</div>
	<%@include file="/ggs/include/js.inc"%>
	<script type="text/javascript">
	$(function(){
		setPageSize();
		addIframe($(".sm_lead_iframe"),"","");
		//二级菜单点击事件
		sm_resource_1_click();
		//三级菜单点击事件
		sm_resource_2_click();
		//我的桌面点击事件
		sm_desktop_click();
		//左右变换点击事件
		sm_lead_middle_click();
 		$("#sm_desktop").trigger("click");
	});
	function setPageSize(){
		setWidth($(".sm_lead_right"),$("body"),[$(".sm_lead_left"),$(".sm_lead_middle")]);
		setHeight($(".sm_lead_resource"),$(".sm_lead_left"),[$(".sm_lead_title")],25);
		setHeight($(".sm_lead_iframe"),$(".sm_lead_right"),[$(".sm_lead_remark")]);
	}
	//二级菜单点击事件
	function sm_resource_1_click(){
		$(".sm_resource_1").click(function(){
			var $this = $(this);
			$(".sm_resource_1_new").removeClass("sm_resource_1_new");
			$(".sm_resource_logo_1_new").removeClass("sm_resource_logo_1_new");
			$(".sm_display_block").removeClass("sm_display_block");
			$this.addClass("sm_resource_1_new");
			$this.find(".sm_resource_logo_1").addClass("sm_resource_logo_1_new");
			var url = $this.attr("url");
			if(url=="<%=path%>"){
				sm_resource_2_display($this);
			}else{
				//通过权限加载页面
				sm_lead_setCloseAndOpten($this);
			}
		});
		//二级菜单的子节点展开
		function sm_resource_2_display($prev){
			var $this = $prev.next();
			var layer = $this.attr("layer");
			if(layer == "2"){
				$this.addClass("sm_display_block");
				sm_resource_2_display($this);
			}else if(layer == "3"){
				sm_resource_2_display($this);
			}
		}
	}
	//三级菜单点击事件
	function sm_resource_2_click(){
		$(".sm_resource_2").click(function(){
			var $this = $(this);
			$(".sm_resource_2_new").removeClass("sm_resource_2_new");
			$this.addClass("sm_resource_2_new");
			//清空四级菜单
			$(".optionBar").html("");
			var url = $this.attr("url");
			if(url=="<%=path%>"){
				//加载三级菜单的子节点
				sm_resource_3_display($this);
				$(".optionBar_button_newColor").removeClass("optionBar_button_newColor");
				var $optionBarFrist = $(".optionBar .optionBar_button").first();
				$optionBarFrist.addClass("optionBar_button_newColor");
				$optionBarFrist.trigger("click");
			}else{
				//通过权限加载页面
				sm_lead_setCloseAndOpten($this);
			}
		});
		//三级菜单的子节点展开
		function sm_resource_3_display($prev){
			var $this = $prev.next();
			var name = $this.attr("name");
			var id = $this.attr("id");
			var url = $this.attr("url");
			var layer = $this.attr("layer");
			if(layer == "3"){
				//添加四级标题
				$(".optionBar").optionBar([ {
					text : name,
					width : 100,
					handler : function() {
						sm_lead_closeAndOpten(id,name,url);
					}
				} ]);
				sm_resource_3_display($this);
			}
		}
	}
	//我的桌面点击事件
	function sm_desktop_click(){
		$("#sm_desktop").click(function(){
			$(".sm_resource_2_new").removeClass("sm_resource_2_new");
			//通过权限加载页面
			sm_lead_setCloseAndOpten($(this));
		});
	}
	//右侧加载当前点击对象
	function sm_lead_setCloseAndOpten($this){
		var id = $this.attr("id");
		var name = $this.attr("name");
		var url = $this.attr("url");
		sm_lead_closeAndOpten(id,name,url);
	}
	//右侧加载当前点击对象
	function sm_lead_closeAndOpten(id,name,url){
		var showStr="欢迎您, <%=((Map) session.getAttribute("USERMAP")).get("USERNAME")%>！ 当前位置 -> "+name;
		$(".sm_lead_iframe_name").html("").html(showStr);
		var powerUrl = "../power.jsp";
		powerUrl += "?resourceId="+id;
		powerUrl += "&resourceUrl="+url;
		$("iframe").attr("src",powerUrl);
	}
	//左右变换点击事件
	function sm_lead_middle_click(){
		$(".sm_lead_middle").click(function(){
			var $this = $(this);
			var thisDisplay = $this.attr("display");
			var nextDisplay;
			if("block" == thisDisplay){
				nextDisplay = "none";
				$(".sm_lead_left").addClass("sm_display_none");
				$this.addClass("sm_lead_middle_new");
				setWidth($(".sm_lead_right"),$("body"),[$(".sm_lead_middle")]);
			}else{
				nextDisplay = "block";
				$(".sm_lead_left").removeClass("sm_display_none");
				$this.removeClass("sm_lead_middle_new");
				setWidth($(".sm_lead_right"),$("body"),[$(".sm_lead_left"),$(".sm_lead_middle")]);
				
			}
			$this.attr("display",nextDisplay);
		});
	}
</script>
</body>
</html>