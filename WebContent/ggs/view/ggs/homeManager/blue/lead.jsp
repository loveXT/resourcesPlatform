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
	.sm_lead_title{
		background:url('<%=path%>image/ht_dhbt.gif') no-repeat;
		height:33px;
		padding:0px;
		border:0px;
	}
	.sm_lead_left{
		background:none;
	}
	.sm_lead_middle{
		background:center url("<%=path%>ggs/skin/blue/image/lead/sm_lead_middle.jpg") no-repeat #1775A9;
	}
	.sm_lead_middle_new {
		background: center url("<%=path%>ggs/skin/blue/image/lead/sm_lead_middle_new.jpg") no-repeat #1775A9;
	}
	body{
		border-left:0px;
	}
	.sm_lead_resource{
		border:0px;
		background:white;
	}
	.sm_resource_1{
		background:url("<%=path%>image/ht_cd-1.gif") repeat-x;
		border-bottom:solid 1px #9CBAD2;
		border-top:solid 1px white;
		height:22px;
	}
	.sm_resource_icon_1 .sm_resource_logo_1{
		background:url("<%=path%>image/ht_yhgl.gif") no-repeat;
	}
	.sm_resource_icon_2 .sm_resource_logo_1{
		background:url("<%=path%>image/ht_zykgl.gif") no-repeat;
	}
	.sm_resource_icon_3 .sm_resource_logo_1{
		background:url("<%=path%>image/ht_ymnrgl.gif") no-repeat;
	}
	.sm_resource_2{
		margin-top:1px;
		margin-bottom:1px;
		background:url("<%=path%>image/ht_xlcd-2.gif") 30px 4px no-repeat #eff5fc;
	}
	.sm_resource_2_new{
		background:url("<%=path%>image/ht_xlcd-1.gif") 30px 4px no-repeat white;
	}
</style>
</head>
<body>
	<div class="sm_lead_left">
		<div class="sm_lead_title"></div>
		<div class="sm_lead_resource">
			<div class="sm_resource_1" id="sm_desktop" layer="1" name="我的桌面" 
				url="desktop.jsp">
				<div class="sm_resource_logo_1">我的桌面</div>
			</div>
			<%
				ResourceByDisplay resourceByDisplay = new ResourceByDisplay();
				List list = resourceByDisplay.findTreeByumresource(request,null);
				TreeInfo info = null;
				Map resourceMap = null;
				int j=0;
				for (int i = 0; i < list.size(); i++) {
					info = (TreeInfo) list.get(i);
			%>
			<div class="sm_resource_<%=info.getLayer()%> <%if(info.getLayer()==1) {%> sm_resource_icon_<%=j+=1%><%} %>"
				id="<%=info.getId()%>" layer="<%=info.getLayer()%>"
				name="<%=info.getName()%>"
				url="<%=path + Validate.isNullToDefault(info.getRemark(), "")%>">
				<div class="sm_resource_logo_<%=info.getLayer()%>"><%=info.getName()%></div>
			</div>
			<%
				}
			%>
		</div>
		<div class="sm_lead_title" style="display:none;"></div>
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
		//一级菜单点击事件
		sm_resource_1_click();
		//二级菜单点击事件
		sm_resource_2_click();
		//我的桌面点击事件
		sm_desktop_click();
		//左右变换点击事件
		sm_lead_middle_click();
 		$("#sm_desktop").trigger("click");
 		
	});
	function setPageSize(){
		setWidth($(".sm_lead_right"),$("body"),[$(".sm_lead_left"),$(".sm_lead_middle")]);
		setHeight($(".sm_lead_resource"),$(".sm_lead_left"),[$(".sm_lead_title")],3);
		setHeight($(".sm_lead_iframe"),$(".sm_lead_right"),[$(".sm_lead_remark")]);
	}
	//一级菜单点击事件
	function sm_resource_1_click(){
		$(".sm_resource_1").click(function(){
			var $this = $(this);
			$(".sm_resource_1_new").removeClass("sm_resource_1_new");
			$(".sm_resource_logo_1_new").removeClass("sm_resource_logo_1_new");
			$(".sm_display_block").removeClass("sm_display_block");
			$this.addClass("sm_resource_1_new");
			$this.find(".sm_resource_logo_1").addClass("sm_resource_logo_1_new");
			sm_resource_2_display($this);
		});
		//一级菜单的子节点展开
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
	//二级菜单点击事件
	function sm_resource_2_click(){
		$(".sm_resource_2").click(function(){
			var $this = $(this);
			$(".sm_resource_2_new").removeClass("sm_resource_2_new");
			$this.addClass("sm_resource_2_new");
			//清空三级菜单
			$(".optionBar").html("");
			var url = $this.attr("url");
			if(url=="<%=path%>"){
				//加载三级菜单
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
		//二级菜单的子节点展开
		function sm_resource_3_display($prev){
			var $this = $prev.next();
			var name = $this.attr("name");
			var id = $this.attr("id");
			var url = $this.attr("url");
			var layer = $this.attr("layer");
			if(layer == "3"){
				//添加三级标题
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
		var showStr="当前位置 ："+name+"<span style='display:none'>"+url+"</span>";
// 		var showStr="当前位置 ："+name+url;
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