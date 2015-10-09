// 查询样式
$(".sm_search").append($("<div></div>").addClass("sm_goSearch"));
$(".sm_goSearch")
.append($("<table/>").append($(".sm_search table").html()))
.append($("<div/>").addClass("sm_goSearch_go").html("查询"))
.append($("<div/>").addClass("sm_goSearch_back").html("清空"));
$(".sm_search").find("table").eq(0).remove();
//综合查询
var $name = $(".sm_search #name");
$(".sm_search #nameTd").append($name.clone());
$name.parent().parent().remove();
