/*******************************************************************************
 * 
 * 使用说明<br>
 * 为要操作的对象内部加上iframe元素<br>
 * 
 * 使用示例<br>
 * $(".iframeMain").addIframe({<br>
 * src:"src is null",<br>
 * iframeId : "iframeId"<br>
 * });<br>
 * 或 addIframe($(".iframeMain"),src);
 * 
 ******************************************************************************/

(function($) {
	$.fn.extend({
		
		addIframe : function(options) {
			options = $.extend({
				src : "src-is-null",
				iframeId : "iframeId",
				target:''
			}, options);
			var $this = $(this);
			var src = options.src;
			var iframeId = options.iframeId;
			var target =options.target;
			$iframe = $('<iframe id="" frameborder="0"></iframe>');
			$iframe.attr("id", iframeId);
			$iframe.attr("src", src);
			if(target!=null&&target!=""){
				$iframe.attr("target", target);
			}
			$this.append($iframe);
		}
		
	});
})(jQuery);

function addIframe($parent, iframeId, src) {
	$parent.addIframe({
		src : src,
		iframeId : iframeId
	});
};
function addIframe1($parent, iframeId, src,target){
	$parent.addIframe({
		src : src,
		iframeId : iframeId,
		target:target
	});
}

