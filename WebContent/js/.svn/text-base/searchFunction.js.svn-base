function f1(){
		var str = $("#type").val();
		var src = "mainPicture.jsp";
		src += "?Type_Id="+str;
		$("[name=Type_Id]").val(str);
		$("[name=src]").val(src);
		$("#type_form").submit();
}
$(".input_button").live("click",function(){
	var str = $("#type").val();
	var src = "mainPicture.jsp";
	var biaoti=$("[name=REALNAME]").val();
	if("01"==str){
		biaoti=$("#keyWord").val();
	}
	src += "?Type_Id="+str+"&biaoti="+biaoti;
	$("[name=Type_Id]").val(str);
	$("[name=biaoti]").val(biaoti);
	var typeName = $("#keyWord").find("option:selected").text();
	$("[name=typename]").val(typeName);
	$("[name=src]").val(src);
	$("#type_form").submit();
//	window.location.href=src;
});