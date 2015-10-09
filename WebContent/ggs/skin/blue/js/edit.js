//编辑部分
$(function(){
	smEditWidth();
	insertRed();
});
function smEditWidth() {
	var $this;
	var height = 0;
	var width = 0, thisWidth;
	$(".sm_edit_tr").each(function() {
		$this = $(this);
		height += $this.outerHeight();
		thisWidth = 0;
		$this.children("div").each(function() {
			$this = $(this);
			thisWidth += $this.outerWidth();
			if (width < thisWidth) {
				width = thisWidth;
			}
		});
	});
	$(".sm_edit_center").find("form").width(width);
//	$(".sm_edit_center").find("form").height(height);
	$(".sm_edit_tr").width(width);
}
function insertRed() {
	var $red = $('<font color="red">*</font>');
	var $sm_edit_td_name = $(".null").parent(".sm_edit_td_value").prev(
			".sm_edit_td_name");
	$sm_edit_td_name.append($red);
}
