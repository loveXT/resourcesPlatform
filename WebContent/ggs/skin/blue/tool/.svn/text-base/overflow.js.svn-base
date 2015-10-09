/*******************************************************************************
 * 
 * 使用说明： <br>
 * 为当前操作的元素添加滚动条<br>
 * 
 * 
 * 使用示例：<br>
 * setHeight($("当前操作对象"),$("总对象"),[$("要减去的对象")],另减去的数值);
 * setWidth($("当前操作对象"),$("总对象"),[$("要减去的对象")],另减去的数值);
 * 
 ******************************************************************************/
// 设置元素高度
function setHeight(now, parent, minus, fig) {
	// fig大于0
	now.setHeight({
		parent : parent,
		minus : minus,
		fig : fig
	});
}
function setWidth(now, parent, minus, fig) {
	// fig大于0
	now.setWidth({
		parent : parent,
		minus : minus,
		fig : fig
	});
}

(function($) {
	$.fn.extend({
		"setHeight" : function(options) {
			options = $.extend({
				parent : "",
				minus : [],
				fig : 0
			}, options);
			// 获取页面传入数据
			var $this = $(this);
			var $minus = options.minus;
			var $parent = options.parent;
			var fig = pF(delPx(options.fig));
			// 存储本对象border高度
			var thisBorderHeight = $this.outerHeight() - $this.height();
			// 存储本对象页面父元素高度
			var thisParentHeight = $this.parent().height();
			// 存储最大高度
			var maxHeight;
			// 如果页面传入的父元素元素不存在，则取父元素的值
			if ($parent == "") {
				maxHeight = thisParentHeight;
			} else {
				maxHeight = $parent.height();
			}
			// 计算减去的元素的高度
			var $minu;
			var h = 0;
			for ( var i = 0; i < $minus.length; i++) {
				$minu = $minus[i];
				h += $minu.outerHeight();
			}
			maxHeight = maxHeight - h;
			// 计算减去输入的高度和本元素的border高度
			maxHeight = maxHeight - fig - thisBorderHeight;
			// 赋值给本对象
			$this.height(maxHeight).css("overflow", "auto");
			function delPx(i) {
				i += "";
				if (i.indexOf("px") != -1) {
					i = i.substring(0, i.indexOf("px"));
				}
				return i;
			}
			function pF(i) {
				if (i == null || i == "") {
					i = 0;
				}
				return parseFloat(i);
			}
		},
		"setWidth" : function(options) {
			options = $.extend({
				parent : "",
				minus : [],
				fig : 0
			}, options);
			// 获取页面传入数据
			var $this = $(this);
			var $minus = options.minus;
			var $parent = options.parent;
			var fig = pF(delPx(options.fig));
			// 存储本对象页面父元素宽度
			var thisParentWidth = $this.parent().width();
			// 存储本对象border宽度
			var thisBorderWidth = $this.outerWidth() - $this.width();
			// 存储最大高度
			var maxWidth;
			// 如果页面传入的父元素元素不存在，则取wrap元素的值
			if ($parent == "") {
				maxWidth = thisParentWidth;
			} else {
				maxWidth = $parent.width();
			}
			// 计算减去的元素的高度
			var $minu;
			var h = 0;
			for ( var i = 0; i < $minus.length; i++) {
				$minu = $minus[i];
				h += $minu.outerWidth();
			}
			maxWidth = maxWidth - h;
			// 计算减去输入的高度和本元素的border高度
			maxWidth = maxWidth - fig - thisBorderWidth;
			$this.width(maxWidth).css("overflow", "auto");
			function delPx(i) {
				i += "";
				if (i.indexOf("px") != -1) {
					i = i.substring(0, i.indexOf("px"));
				}
				return i;
			}
			function pF(i) {
				if (i == null || i == "") {
					i = 0;
				}
				return parseFloat(i);
			}
		}
	});
})(jQuery);
