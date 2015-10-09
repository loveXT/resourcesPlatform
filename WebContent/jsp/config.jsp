<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>配置</title>
<%
	String path = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/xcConfirm.css"/>
<script src="<%=path%>/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=path%>/js/xcConfirm.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	$(function(){
		$("#btn7").click(function(){
			var txt=  "选择类别";
			var option = {
				title: "配置",
				btn: parseInt("0011",2),
				onOk: function(){
					console.log("确认");
				}
			}
			window.wxc.xcConfirm(txt, "custom", option);
			getNavigation();
		});
	});
	function getNavigation() {
		jQuery.ajax({
			type : "post",
			url : "<%=path%>/jsp/ajaxNavigation.jsp",
			async:false,
			dataType : "text",
			data : {
				parm : new Date().getTime()
			},
			success : function(result) {
				result=result.trim();
				if(result!=null && result!=""){
					
				jQuery(".xcConfirm .txtBox p").append("<select style='margin-left:10px;margin-left: 30px;height: 25px; width: 150px;' id='selectNavigation' ></select>");
				var resultArrays = eval("result.trim()").split(",");
					for ( var i = 0; i <resultArrays.length ; i++) {
						var dataArrays=resultArrays[i].split("%");
						jQuery("#selectNavigation").append("<option value='"+dataArrays[0]+"'>" + dataArrays[1] + "</option>");
					}
				}
			}
			});
		}
</script>
</head>
<body>
	<div class="config" style="height: 768px;">
		<div class="sgBtn" id="btn7">弹窗7(自定义)</div>
	</div>
</body>
</html>
