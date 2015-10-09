if($(".sm_list").length>0){
	//列表部分表头table样式
	$(".sm_list").children("table:even").wrap("<div class='sm_table_head'></div>");
	// 列表部分内容table样式
	$(".sm_list").children("table").wrap("<div class='sm_table_body'></div>");
	//隔行换色
	//$(".sm_table_body").children("table").find("tr:odd").addClass("sm_table_tr_color_change");
}
// list中设置全选
$(".sm_list .sm_table_head").click(function() {
	var $this = $(this);
	var $thisCheck = $this.find(".sm_index :checkbox");
	var $nextCheck = $this.next().find("table .sm_index :checkbox");
	var $nextTr = $this.next().find("table tr");
	var thisCheck = $thisCheck.attr("checked");
	$nextCheck.attr('checked', thisCheck);
	if(thisCheck){
		$nextTr.addClass("sm_table_tr_color_change");
	}else{
		$nextTr.removeClass("sm_table_tr_color_change");
	}
});
