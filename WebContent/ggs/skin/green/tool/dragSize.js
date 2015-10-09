/*******************************************************************************
 * 
 * 使用说明：<br>
 * 为table中td添加更改宽度功能<br>
 * 更改tableHead中td的宽度tableBody中的对应的td宽度也改变<br>
 * 对td进行此操作时，先确保此td的宽度不被浏览器默认修改
 * 
 * 使用示例<br>
 *function dragSize() {<br>
 *	$(".list table:even").find("td").each(function() {<br>
 *		var $this = $(this);<br>
 *		var thisTable = $this.parent("tr").parent("tbody").parent("table");<br>
 *		var nextTable = thisTable.parent(".tableHead").next(".tableBody");<br>
 *		if ($this.attr("colspan") == 1) {<br>
 *			$this.dragSize({<br>
 *				nextTable : nextTable<br>
 *			});<br>
 *		}<br>
 *	});<br>
 *}<br>
 * 
 ******************************************************************************/


(function($) {
	$.fn.extend({
		dragSize : function(options) {
			options = $.extend({
				// 触发事件的容器
				nextTable : ""
			}, options);
			var config = $.extend(true, $.fn.dragSize.defaults, options);
			var target = $(this), doc = $(document), body = $('body');
			var nextTable = options.nextTable;
			// 获取触发拖动事件的容器
			var trigger = target;
			trigger.bind('mousedown.dragSize', function(e) {
				var pageX = e.clientX;
				var $targetCopy = target.clone(true).html("");
				target.data('left', target.offset().left);
				target.data('top', target.offset().top);
				target.data('width', target.width());
				target.data('height', target.height());
				$targetCopy.css({
					border : '3px solid black',
					position : 'absolute',
					left : target.data('left'),
					top : target.data('top'),
					width : target.data('width'),
					height : target.data('height') + nextTable.height()
				});
				doc.bind('mousemove.dragSize', function(e) {
					$targetCopy.appendTo(body).fadeTo(10, 0.1);
					left = e.clientX - pageX;
					$targetCopy.css({
						width : left + target.data('width')
					});
				});
				doc.bind('mouseup.dragSize', function() {
					$(this).stop(true, true);
					doc.unbind('mousemove.dragSize');
					doc.unbind('mouseup.dragSize');
					target.find("span").css({
						'width' : $targetCopy.width() - 1
					});
					target.css({
						'width' : $targetCopy.width()
					}).show();
					nextTable.find("tr").each(
							function() {
								var nextTd = $(this).find("td").eq(
										target.index());
								nextTd.find("span").css('width',
										$targetCopy.width() - 1);
								nextTd.css('width', $targetCopy.width());
							});
					$targetCopy.remove();
				});
			});
		}

	});
})(jQuery);

$(".sm_list .sm_table_head").find("td").each(function() {
	var $this = $(this);
	var thisTable = $this.parent("tr").parent("tbody").parent("table");
	var nextTable = thisTable.parent(".sm_table_head").next(".sm_table_body");
	if ($this.attr("colspan") == 1) {
		$this.dragSize({
			nextTable : nextTable
		});
	}
});
