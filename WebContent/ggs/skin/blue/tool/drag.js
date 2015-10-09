/*******************************************************************************
 * 
 * 使用说明<br>
 * 为要操作的元素加上拖动功能
 * 
 * 使用示例<br>
 * $(".drag").drag();
 * 
 ******************************************************************************/
(function($) {
	$.fn.extend({
		drag : function(options) {
			options = $.extend({
				// 触发事件的容器
				trigger : null,
				// 允许拖动的方向
				// 可以是：'x','y','all'
				direction : 'all',
				// 是否显示原窗口
				reserve : false,
				// 窗体的透明度
				// 取值范围：0 <= opacity <= 1
				opacity : 1
			}, options);
			var config = $.extend(true, $.fn.drag.defaults, options);	
			var target = $(this), doc = $(document), body = $('body');
			// 获取触发拖动事件的容器
			var trigger = null;
			if(config.trigger==null){
				trigger = target;
			}else{
				trigger = $(config.trigger).parent();
			}
			trigger.mousedown(function(e) {
				var pageX = e.clientX - target.offset().left;
				var pageY = e.clientY - target.offset().top;
				var $targetCopy = target.clone(true).html("");
				target.data('left', e.clientX - pageX);
				target.data('top', e.clientY - pageY);
				$targetCopy.css({
					border : '3px solid black',
					position : 'absolute',
					display : 'block',
					left : target.data('left'),
					top : target.data('top'),
					height : target.height()
				});
				// 是否显示原窗口
				if (config.reserve) {
					var targetFilter = 'alpha(opacity = '
							+ (config.opacity * 100) + ')';
					target.css({
						'filter' : targetFilter,
						'-moz-opacity' : config.opacity,
						'opacity' : 1
					});
				} else {
					
				}
				
				doc.mousemove(function(e) {
					docMousemove($targetCopy, e, config, target, body, pageX,
							pageY);
				});
				doc.mouseup(function() {			
					docMouseup($(this), doc, e, $targetCopy, target);
				});

			});
			function docMousemove($targetCopy, e, config, target, body, pageX,
					pageY) {
				target.hide();
				$targetCopy.appendTo(body).fadeTo(10, 0.1);
				var wd = target.outerWidth(), bdwd = body.width();
				var ht = target.outerHeight(), bdht = body.height();
				var left = target.data('left'), top = target.data('top');
				if (config.direction === 'all') {
					if ((e.clientX - pageX) < 0) {
						// 自身坐标<0
						left = 0;
					} else if ((e.clientX - pageX + wd) > bdwd) {
						// 自身坐标超出屏幕
						left = bdwd - wd;
					} else {
						left = e.clientX - pageX;
					}
					if ((e.clientY - pageY) < 0) {
						top = 0;
					} else if ((e.clientY - pageY + ht) > bdht) {
						top = bdht - ht;
					} else {
						top = e.clientY - pageY;
					}
				} else if (config.direction === 'x') {
					if ((e.clientX - pageX) < 0) {
						left = 0;
					} else if ((e.clientX - pageX + wd) > bdwd) {
						left = bdwd - wd;
					} else {
						left = e.clientX - pageX;
					}
				} else if (config.direction === 'y') {
					if ((e.clientY - pageY) < 0) {
						top = 0;
					} else if ((e.clientY - pageY + ht) > bdht) {
						top = bdht - ht;
					} else {
						top = e.clientY - pageY;
					}
				}
				$targetCopy.css({
					left : left,
					top : top
				});
			}
			function docMouseup($this, doc, e, $targetCopy, target) {
				$this.stop(true, true);
				doc.unbind('mousemove');
				doc.unbind('mouseup');
				if ($targetCopy.offset().left != 0) {
					var targetLeft = $targetCopy.offset().left
							- target.parent().offset().left - 1;
					var targetTop = $targetCopy.offset().top
							- target.parent().offset().top - 1;
					target.css({
						'filter' : 'alpha(opacity = 100)',
						'-moz-opacity' : 1,
						'opacity' : 1,
						'cursor' : 'default',
						'left' : targetLeft,
						'top' : targetTop
					});
					target.show();
				}
				$targetCopy.remove();
			}
		}
	});
})(jQuery);
