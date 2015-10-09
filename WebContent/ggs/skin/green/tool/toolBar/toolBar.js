
(function($) {
	$.fn.extend({
		toolBar : function(options) {
			options = $.extend([ {
				text : "",
				width : "",
				model : "",
				position : "",
				handler : function() {
				}
			} ], options);

			$(this).addClass("toolBar_div");
			var $span;
			var $img;
			// 插入对象
			for ( var i = 0; i < options.length; i++) {
				var op = options[i];
				var model = op.model;
				if (model != undefined) {
					if (model.split("_").length != 2) {
						alert(model + "权限格式书写错误");
						return false;
					}
					var mod = model.split("_")[0];
					var mods = model.split("_")[1];
					if (mods.indexOf(mod) == -1) {
						continue;
					}
				}
				$div = $("<div/>");

				$img = $("<div/>").addClass("toolBar_Img").css({
					"background-position" : op.position
				});
				if (op.position != null && op.position.length > 0) {
					$img.appendTo($div);
				}
				$span = $("<div/>").addClass("toolBar_Content").appendTo($div)
						.text(op.text);

				$div.css({
					"width" : op.width
				}).addClass("toolBar_span");
				$div.hover(function() {
					var $this = $(this);
					$this.siblings().removeClass("toolBar_span_newColor");
					$this.addClass("toolBar_span_newColor");
					$this.width($this.width() - 2);
				}, function() {
					var $this = $(this);
					$this.removeClass("toolBar_span_newColor");
					$this.css({
						"width" : $this.width() + 2
					});
				});
				$div.appendTo($(this)).click(op.handler);
			}
			return this;
		}
	});
})(jQuery);
