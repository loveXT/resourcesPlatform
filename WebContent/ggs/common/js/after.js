//整个系统默认
$(":text").addClass("sm_inputText");

if($.browser.msie) {
	//IE
    $("table").css("border-collapse","collapse");
 }else if($.browser.opera) {
    alert("这是一个opera浏览器");
 }else if($.browser.mozilla) {
	 //火狐
    $("table").css("border-spacing","0px");
 }else if($.browser.safari) {
	 //谷歌
    $("table").css("border-spacing","0px");
 }else{
	 alert("这是一个未知浏览器");
 }
$("body").css("display","block");
