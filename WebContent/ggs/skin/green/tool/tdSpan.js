/*******************************************************************************
 * 
 * 使用说明<br>
 * 为要操作的对象内部加上span元素
 * 
 * 使用示例<br>
 * $(".list").find("td").tdSpan();
 * 
 ******************************************************************************/


(function($) {
	$.fn.extend({
		tdSpan : function() {
			$tds = $(this);
			$tds.each(function() {
				var $this = $(this);
				var style = $this.attr("style");
				var ifwidth;
				if (style == null) {
					ifwidth = -1;
				} else if (style.indexOf("WIDTH") != -1) {
					// 支持谷歌浏览器
					ifwidth = style.indexOf("WIDTH");
				} else {
					// 支持IE浏览器
					ifwidth = style.indexOf("width");
				}
				var width;
				if (ifwidth == -1) {
					width = $this.width();
				} else {
					width = style.substring(ifwidth + 5, style.length);
					width = width.substring(width.indexOf(":") + 1, width
							.indexOf("px"));
				}
				if ($this.html().indexOf("td-span") == -1) {
					var $span = $("<span class=td-span></span>").css({
						"width" : width - 1,
						"padding-left" : "1px"
					});
					$this.wrapInner($span);
				}
			});
		}
	});
})(jQuery);
$(".sm_list").find("td").tdSpan();
