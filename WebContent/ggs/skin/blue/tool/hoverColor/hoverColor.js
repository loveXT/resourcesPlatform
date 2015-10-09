/*******************************************************************************
 * 
 * 使用说明：<br>
 * 为操作的元素添加鼠标划入划出时改变背景色的功能
 * 
 * 使用示例<br>
 * $("table tr").hoverColor();
 * 
 ******************************************************************************/


(function($) {
	$.fn.extend({
		hoverColor : function() {
			var $this = $(this);
			$this.hover(function() {
				$this = $(this);
				$this.addClass("hoverColor");
			}, function() {
				$(".hoverColor").removeClass("hoverColor");
			});
			return this;
		}
	});
})(jQuery);
$(".sm_list table tr").hoverColor();