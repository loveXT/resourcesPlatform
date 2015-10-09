var // 不止一条信息的情况
	$haveTopClose = '<span class="haveTopClose"></span>',
	$haveCenterClose = '<span class="haveCenterClose"></span>',
	$haveBottomClose = '<span class="haveBottomClose"></span>',
	$haveTopOpten = '<span class="haveTopOpten"></span>',
	$haveCenterOpten = '<span class="haveCenterOpten"></span>',
	$haveBottomOpten = '<span class="haveBottomOpten"></span>',
	// 就一条信息的情况
	$haveOneClose = '<span class="haveOneClose"></span>',
	$haveOneOpten = '<span class="haveOneOpten"></span>',
	// 关闭打开情况
	$haveClose = '<span class="haveClose"></span>',
	$haveOpten = '<span class="haveOpten"></span>',
	// 文件
	$file = '<span class="file"></span>',
	$fileTop = '<span class="fileTop"></span>',
	$fileCenter = '<span class="fileCenter"></span>',
	$fileBottom = '<span class="fileBottom"></span>',
	// 竖线 空格
	$line = '<span class="fileLine"></span>',
	$space = '<span class="fileSpace"></span>';
var infoTree = $(".infoTree"),infoTreeLg = infoTree.length;
var trees,treesLg;
var $tree,treeMath,treeEndMath,treeText,layer,setLay;
infoTree.each(function(){
	// 最大层数
	layer=0;
	// 设置当前层
	setLay=1;
	// 获取当前树
	trees = $(this).find("[class^=tree_]");
	// 获取当前树的节点个数
	treesLg = trees.length;
	// 计算最大层数
	for( var i = 1; i < treesLg; i++){
		// 获取每个节点所在的层数
		treeMath = $(trees[i]).attr("class").substring(5,6);
		// 设置最大层数
		if(treeMath > layer){
			layer = treeMath;
		}
	}
	// 最大层数默认加2，防止意外
	layer = parseInt(layer) + 2;
	// 设置第一层样式
	setLayer(setLay,layer,trees,treesLg);
});

// 给每一层设置样式
function setLayer(setLay,layer,trees,treesLg){
	// 若当前层大于最大层，当前层等于最大曾
	if(setLay>layer){
		setLay = layer;
	// 若当前层小于1，当前层等于1
	}else if(setLay<1){
		setLay = 1;
	}
	// 循环获取当前树的所有节点
	for ( var i = 1; i < treesLg; i++) {
		// 获取当前树的单个节点
		$tree = $(trees[i]);
		// 获取当前节点所在的层数
		treeMath = $tree.attr("class").substring(5,6);
		// 获取当前节点的内容
		treeText = '<div class="text">'+$tree.html()+'</div>';
		// 若该节点所在层数等于要设计层的层数
		if(treeMath == setLay){
			// 清空数据
			$tree.html("");
			if(i == treesLg-1){
				// 若本节点是最后一个节点
				getLast($tree,treeMath,treeText);
			}else{
				// 若本节点不是最后一个节点
				// 为本节点添加空格或竖线
				getLineSpace($tree,trees,treesLg,treeMath,i,treeText);
				// 为本节点设置样式
				getHaveFile($tree,trees,treeMath,treesLg,i,treeText);
			}
			$tree.addClass("tree");
			$tree.find("span").addClass("span");
		}
	}
}
/**
 * 为每个节点设置样式
 * 
 * @param $tree
 */
function setTreeStyle($tree,trees,treesLg,i){
	// 获取当前节点的层数
	treeMath = $tree.attr("class").substring(5,6);
	// 获取当前节点的美容
	treeText = '<div class="text">'+$tree.html()+'</div>';
	$tree.html("");
	if(i == treesLg-1){
		// 若本节点是最后一个节点
		getLast($tree,treeMath,treeText);
	}else{
		// 若本节点不是最后一个节点
		// 为本节点添加空格或竖线
		getLineSpace($tree,trees,treesLg,treeMath,i,treeText);
		// 为本节点设置样式
		getHaveFile($tree,trees,treeMath,treesLg,i,treeText);
	}
	$tree.addClass("tree");
	$tree.find("span").addClass("span");
}
/**
 * 为本节点添加空格或竖线
 */
function getLineSpace($tree,trees,treesLg,treeMath,i,treeText){
	// 循环本节点的层数，为每层逐个添加空格或竖线
	for(var k = 1; k < treeMath; k++){
		// 循环本节点以后的每个节点
		for(var j = i+1;j < treesLg;j++){
			treeEndMath = $(trees[j]).attr("class").substring(5,6);
			if(treeEndMath  == k){
				// 本节点下方有当前循环的层数的节点，在本节点的基础上加【竖线】
				$tree.html($tree.html()+$line);
				break;
			}else if(treeEndMath  == k-1 || j == treesLg-1){
				// 本节点下方没有当前循环的层数的节点，在本节点的基础上加【空格】
				$tree.html($tree.html()+$space);
				break;
			}
		}
	}
}
/**
 * 为本节点设置样式
 */
function getHaveFile($tree,trees,treeMath,treesLg,i,treeText){
	// 获取下一个节点
	treeEndMath = $(trees[i+1]).attr("class").substring(5,6);
	if(treeEndMath == treeMath){
		// 下一个节点是同级节点，则把本节点【文件居中、文件】格式
		// 有下一个同级节点，但没有子节点
		$tree.html($tree.html()+$fileCenter+$file+treeText);
	}else if(treeEndMath > treeMath){
		// 下一个节点是本节点的子节点
		// 循环本节点以后的节点
		for(var j = i+1;j < treesLg;j++){
			treeEndMath = $(trees[j]).attr("class").substring(5,6);
			if(treeEndMath == treeMath){
				// 本节点有同级节点【文件夹居中、文件夹】
				$tree.html($tree.html()+$haveCenterClose+$haveClose+treeText);
				break;
			}else if(treeEndMath < treeMath || j == treesLg-1){
				// 本节点有上级级节点【文件夹居下、文件夹】
				$tree.html($tree.html()+$haveBottomClose+$haveClose+treeText);
				break;
			}
		}
	}else{
		// 下一个节点是本节点上级节点，则把本节点【文件中、文件】格式
		$tree.html($tree.html()+$fileBottom+$file+treeText);
	}
}
function getLast($tree,treeMath,treeText){
	// 本节点为最后一层，在本节点前面加上空格
	for(var k = 1;k < treeMath ; k++){
		$tree.html($tree.html()+$space);
	}
	// 样式为【文件居下、文件】
	$tree.html($tree.html()+$fileBottom+$file+treeText);
}
$("[class^=tree_]").hide();
$(".tree_0,.tree_1").show();
var maxWidth=0,width,spanWidth,fontSize,fontNum;
function setOverflow(infoTree,$tree,lay){
	infoTree.width(maxWidth);
	spanWidth = $tree.find("span").width();
	fontSize = $tree.css("font-size").replace("px","");
	fontNum = $tree.text().length-8;
	width =spanWidth*lay+fontSize*fontNum;
	if(width>maxWidth){
		maxWidth = width;
		infoTree.width(maxWidth);
		infoTree.parent().css("overflow","auto");
	}
}
/**
 * 上面部分把页面初始化完毕 下面为页面事件
 */
/**
 * 页面点击事件
 */
$("[class^=tree_] span").live("click",function(){
	// 获取当前节点
	var $this = $(this).parent();
	// 获取当前节点内容
	var html = $this.html();
	// 获取当前节点的下级节点的层数
	layer = parseInt($this.attr("class").substring(5,6))+1;
	// 获取当前节点所在的树
	infoTree = $this.parent();
	// 获取所在树所有的节点
	trees = infoTree.find("[class^=tree_]");
	// 获取所在树所有的节点的个数
	treesLg = trees.length;
	// 获取所在树的第一个节点
	var $tree_frist = infoTree.children(".tree_0");
	// 获取当前节点在所在树种的索引值
	var nowIndex = $this.index() - $tree_frist.index();
	// 判断点击的是否是标题，若是标题则取消点击事件
	if(nowIndex == 0){
		return false;
	}
	maxWidth = infoTree.parent().width();
	// 存放循环本节点后面节点的层数
	var lay;
	// 若当前状态为关闭状态
	if(html.indexOf("Close") != -1){
		// 循环本节点后面的节点
		for(var i = nowIndex+1; i < treesLg ;i++){
			// 获取循环的当前节点
			$tree = $(trees[i]);
			// 获取循环的当前节点的层数
			lay = $tree.attr("class").substring(5,6);
			// 若是本节点的下级子节点，则打开此节点
			if( lay == layer){
				if($tree.html().indexOf("span") == -1){
					// 设置样式
					setTreeStyle($tree,trees,treesLg,i);
				}
				
				$tree.show();
			}else if(lay < layer){
				// 遇到本节点的上级节点或同级节点，则取消遍历
				break;
			}
		}
		for(var i = 0; i < treesLg ;i++){
			$tree = $(trees[i]);
			lay = $tree.attr("class").substring(5,6);
			if($tree.css("display")=="block"){
				setOverflow(infoTree,$tree,lay);
			}
		}
		// 更改当前节点的状态为打开
		html = html.replace("Close","Opten")
		.replace("Close","Opten");
	}else{
		// 当前状态为展开状态
		for(var i = nowIndex+1; i < treesLg ;i++){
			$tree = $(trees[i]);
			lay = $tree.attr("class").substring(5,6);
			if(lay >= layer && $tree.css("display") == "block"){
				// 关闭本节点的所有子节点
				$tree.hide();
				treehtml = $tree.html();
				treehtml = treehtml.replace("Opten","Close")
				.replace("Opten","Close");
				$tree.html(treehtml);
			}else if(lay < layer){
				// 遇到本节点的上级节点或同级节点，则取消遍历
				break;
			}
		}
		for(var i = 0; i < treesLg ;i++){
			$tree = $(trees[i]);
			lay = $tree.attr("class").substring(5,6);
			if($tree.css("display")=="block"){
				setOverflow(infoTree,$tree,lay);
			}
		}
		// 设置本节点的状态为关闭
		html = html.replace("Opten","Close")
		.replace("Opten","Close");
	}
	$this.html(html);
});
/**
 * 添加背景色
 */
$("[class^=tree_]").live("click",function(){
	var $this = $(this);
	$this.siblings().removeClass("tree_newColour");
	$this.addClass("tree_newColour");
});
/**
 * 全部展开事件
 */
function allOpten(){
	for(var i = 1 ; i < treesLg ;i++){
		$tree = $(trees[i]);
		if($tree.html().indexOf("span")==-1){
			setTreeStyle($tree,trees,treesLg,i);
		}
		var html = $tree.html();
		html = html.replace("Close","Opten")
		.replace("Close","Opten");
		$tree.html(html).show();
	}
}
/**
 * 全部关闭事件
 */
function allClose(){
	var lay;
	for(var i = 0 ; i < treesLg ;i++){
		$tree = $(trees[i]);
		var html = $tree.html();
		lay = $tree.attr("class").substring(5,6);
		if(lay > 1 && $tree.css("display") == "block"){
			html = html.replace("Opten","Close")
			.replace("Opten","Close");
			$tree.html(html).hide();
		}else if(lay <= 1){
			html = html.replace("Opten","Close")
			.replace("Opten","Close");
			$tree.html(html);
		}
	}
}
(function($){
	$.fn.extend({
		treeClick:function(options){
			options=$.extend({
 				handler:function(){alert("请输入jQuery方法");}
 			},options);
			$("[class^=tree_] span").live("click",function(){
 				var $click = $(this);
 				if($click.attr("id").length == 0){
 					return false;
 				}
			});
 			$(this).live("click",options.handler);
 		}
 	});
 })(jQuery);
// 检索事件
function treeSearch($search,type){
	var treeFirst,layerNumBegin,layerNumEnd;
	var $infoTree;
	if(type=="tree"){
		treeFirst = ".tree_1";
		layerNumBegin = 5;
		layerNumEnd = 7;
		$infoTree = $search.parent().parent();
	}else if(type=="checkTree"){
		treeFirst = ".checkTree_1";
		layerNumBegin = 10;
		layerNumEnd = 12;
		$infoTree = $search.parent().parent().parent();
	}
	// 回车事件
	$search.keydown(function(e){
		if(e.keyCode === 13){
			if($search.val()!=""){
				treegogo($search);
			}
		}
	});

	function treegogo($search){
		var search = $search.val();
		var treeSearchLayer;
		// 去除上次查询选中样式
		$infoTree.find(".treeSearch").removeClass("treeSearch");
		// 全部关闭
		$infoTree.find(treeFirst).each(function(){
			var $this = $(this);
			// 点击当前节点（若当前节点已展开。则进行点击事件，将当前节点关闭）
			if($this.find("[class*=Close]").length == 0){
				$this.find("span").trigger("click");
			}
		});
		// 执行查询
		$infoTree.find("[search*="+search+"]").each(function(){
			var $this = $(this);
			treeSearchLayer = $this.attr("class").substring(layerNumBegin,layerNumEnd);
			gogolayer($this);
			$this.addClass("treeSearch");
		});
		// 去除点击样式
		$infoTree.find(".tree_newColour").removeClass("tree_newColour");
		// 查询方法内核
		function gogolayer($this){
			var layer = $this.attr("class").substring(layerNumBegin,layerNumEnd);
			// 若所选节点不在第一层位置上
			if(layer != 1){
				gogoprev($this);
			}
			// 若所选节点为关闭状态则进行点击事件
			if(layer < treeSearchLayer){
				if($this.find("[class*=Opten]").length==0){
					$this.find("span").trigger("click");
				}
			}
			// 遍历所选节点的前方节点
			function gogoprev($this){
				// 获取所选节点的上一个节点
				var $prev = $this.prev();
				var prev = $prev.attr("class").substring(layerNumBegin,layerNumEnd);
				// 若上一个节点的层数等于所选节点的层数则继续获取上一个节点直至与所选节点的层数不相等
				if(prev >= layer){
					gogoprev($prev);
				}else if(prev < layer){
					// 若上一个节点的层数不等于本节点的层数
					// 并且是所选节点的父节点
					// 则模拟选中此节点
					gogolayer($prev);
				}
			}
		}
	}
}