/*******************************************************************************
 * 
 * 使用说明：<br>
 * 为操作的元素添加鼠标划入划出时改变背景色的功能
 * 
 * 使用示例<br>
 * $("table tr").hoverColor({ newColor : "yellow" });
 * 
 ******************************************************************************/


(function($) {
	$.fn.extend({
		hoverColor : function(options) {
			options = $.extend({
				newColor : "red"
			}, options);
			var oldColor;
			var $this = $(this);
			var newColor = options.newColor;
			$this.hover(function() {
				$this = $(this);
				// 如果新赋值颜色与当前颜色不一样，那么就保存当前颜色
				if (newColor != $this.css("background-color")) {
					oldColor = $this.css("background-color");
				}
				// 把本行的颜色换成新颜色
				$this.css("background-color", newColor);
			}, function() {
				if (oldColor != undefined) {
					$this.css("background-color", oldColor);
				}
			});
			return this;
		}
	});
})(jQuery);
$(".sm_list table tr").hoverColor({ newColor : "yellow" });