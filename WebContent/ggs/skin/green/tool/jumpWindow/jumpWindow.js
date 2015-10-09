(function($) {
	$.fn
			.extend({
				jumpWinow : function(options) {
					options = $.extend({
						title : "弹窗示例",
						src : "",
						width : "",
						height : "",
						parent : ""
					}, options);
					// 初始化数据
					var $this = $(this);
					var width = delPx(options.width);
					var height = delPx(options.height);
					var src = options.src;
					var title = options.title;
					var parent = options.parent,$parent;
					var $left, $title, $min, $max, $revert, $close, $right;
					var $model, $main, $iframe;
					// 计算窗体位置
					var top,left;
					if(parent == ""){
						top = $this.height() / 2 - height / 2 - 50;
						left = $this.width() / 2 - width / 2;
						if (top <= 50) {
							top = 50;
						}
						if (left <= 100) {
							left = 100;
						}
					}else{
						$parent = $(parent);
						top = parseInt($parent.offset().top)+parseInt($parent.height())+5;
						left = $parent.offset().left;
					}
					
					width = width < 150 ? 150 : width;
					width = width > $this.width() ? $this.width() - 200 : width;
					height = height > $this.height() ? $this.height() - 100
							: height;
					// 创建模态
					$model = $("<div></div>").fadeTo(10, 0.1).addClass("model");
					// 创建主弹窗
					$main = $("<div></div>").css({
						"width" : width,
						"top" : top,
						'left' : left,
						"height" : parseInt(height) + 30
					}).addClass("jumpWindow_main");
					// 创建左侧部分
					$left = $("<div/>").addClass("jumpWindow_left");
					// 创建标题
					$title = $("<div></div>").addClass("jumpWindow_title")
							.width($main.outerWidth() - 115).html(title);
					// 创建最小化按钮
					$min = $("<div></div>").click(function() {
						$title.hide();
						$iframe.hide();
						$main.css({
							"top" : $("body").height() - 30,
							"left" : 0
						});
						$min.hide();
						$revert.show();
						$max.show();
					}).addClass("jumpWindow_min");
					// 创建还原按钮
					$revert = $("<div/>").click(function() {
						$main.css({
							"width" : width,
							"top" : top,
							'left' : left,
							"height" : parseInt(height) + 30
						});
						$title.show().width($main.width() - 115);
						$iframe.show().css({
							"width" : $main.width() - 12,
							"height" : height - 4
						});
						$min.show();
						$revert.hide();
						$max.show();
					}).addClass("jumpWindow_revert").hide();
					// 创建最大化按钮
					$max = $("<div/>").click(function() {
						$main.css({
							"top" : 0,
							"left" : 0,
							"width" : "100%",
							"height" : "100%"
						});
						$title.show().width($main.width() - 115);
						$iframe.show().css({
							"width" : $main.width() - 12,
							"height" : "100%"
						});
						$min.show();
						$revert.show();
						$max.hide();
					}).addClass("jumpWindow_max");
					// 创建关闭按钮
					$close = $("<div></div>").click(function() {
						try{
							beforeClose();
						}catch (Exception){
							
						}
						$main.remove();
						$model.remove();
					}).addClass("jumpWindow_close");
					$right = $("<div/>").addClass("jumpWindow_right");
					// 创建iframe
					$iframe = $("<iframe id='jumpWindow_iframe' frameborder='0'name='jumpWindow_iframe' src=''></iframe>").css({
						'width' : $main.outerWidth() - 12,
						"height" : height - 4
					}).addClass("jumpWindow_iframe").attr("src", src);
					if(parent == ""){
						// 添加模糊态
						$model.appendTo($this);
					}
					//添加拖动
					$title.css("cursor", "move");
					// 添加弹窗
					$main.drag({
						trigger : $title
					});
					$main.append($left).append($title).append($min).append(
							$revert).append($max).append($close).append($right)
							.append($iframe).appendTo($this);
					return this;
					// 去除px
					function delPx(i) {
						i += "";
						if (i.indexOf("px") != -1) {
							i = i.substring(0, i.indexOf("px"));
						}
						return i;
					}
				}
			});
})(jQuery);

// 弹窗应用
function jumpWindow(title, width, height, src) {
	$("body").jumpWinow({
		title : title,
		width : width,
		height : height,
		src : src,
		parent : ""
	});
};

// 提示型弹窗应用
function jumpRemark(bool,src,page) {
	src = src + "/ggs/view/share/"+page;
	if(bool=="true"){
		$("body").jumpWinow({
			title : "提示信息",
			src : src,
			width : "300",
			height : "80",
			parent : ""
		});
	}
};

//select型弹窗应用
function selectWindow(title,src,parent){
	$("body").jumpWinow({
		title : title,
		src : src,
		width : "250",
		height : "300",
		parent : parent
	});
}
//去除弹窗
function removeJumpWindow(){
	$(".jumpWindow_main").remove();
	$(".model").remove();
	
}

$(".selectJump").attr("readonly","readonly");
function selectWindowToValue(parentId,$infoTree,only,bottom){
	var bool = true;
	var $parent = $(window.parent.document);
	var $parentText = $parent.find(":text[id="+parentId+"]");
	var $parentHidden = $parent.find(":hidden[id="+parentId+"]");
	var inputType;
	if(only){
		inputType = "radio";
	}else{
		inputType="checkbox";
	}
	var $checkeds = $infoTree.find(":"+inputType).filter(":checked");
	var $this,$tree,flag,names=[],values=[];
	if(only && $checkeds.length != 1){
		alert("只能选择一条信息");
		bool = false;
		return;
	}
	$checkeds.each(function(){
		$this = $(this);
		if($this.val()=="basic"){
			$tree = $this.parent();
			names.push($.trim($tree.text()));
		}else{
			$tree = $this.parent().parent();
			flag = $tree.attr("flag");
			if(bottom==null||bottom=="null"){
				names.push($.trim($tree.text()));
			}else if(bottom==flag){
				names.push($.trim($tree.text()));
			}
		}
		values.push($this.val());
	});
	$parentText.val(names.join(","));
	$parentHidden.val(values.join(","));
	if(names.length==0){
		bool = false;
		alert("最少选择一条数据");
	}
	if(bool){
		window.parent.removeJumpWindow();
	}
}
function smListToValue(parentId,displayName){
	var $checkeds = $(".sm_list table").eq(1).find(":checkbox").filter(":checked");
	if($checkeds.length<1){
		alert("最少选择一条信息进行操作");
	}else{
		var values = [];
		var displayNames = [];
		var $this;
		$checkeds.each(function(){
			$this = $(this);
			values.push($this.val());
			displayNames.push($this.attr(displayName));
		});
		var $parent = $(window.parent.document);
		var $parentText = $parent.find(":text[id="+parentId+"]");
		var $parentHidden = $parent.find(":hidden[id="+parentId+"]");
		$parentText.val(displayNames.join(","));
		$parentHidden.val(values.join(","));
		window.parent.removeJumpWindow();
	}
}
