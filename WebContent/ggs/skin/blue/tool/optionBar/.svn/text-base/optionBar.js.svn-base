
(function($) {
	$.fn.extend({
		optionBar : function(options) {
			options = $.extend([ {
				text : "",
				width : "",
				handler : function() {
				}
			} ], options);

			$(this).addClass("optionBar_div");
			// 插入对象
			var op,$span;
			for ( var i = 0; i < options.length; i++) {
				op = options[i];
				$span = $("<input type='button'/>");
				$span.css({
					"width" : op.width
				});
				$span.addClass("optionBar_button");
				$span.addClass("optionBar_button_oldColor");
				$span.val(op.text).appendTo($(this));
				$span.click(op.handler);
				$span.click(function() {
					var $sib = $(this).siblings();
					$sib.removeClass("optionBar_button_newColor");
					$sib.addClass("optionBar_button_oldColor");
					$(this).addClass("optionBar_button_newColor");
				});
				if (i == 0) {
					$span.addClass("optionBar_button_newColor");
				}
			}
			return this;
		}
	});
})(jQuery);

