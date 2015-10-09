checkCheckTree();
function checkCheckTree(){
var //不止一条信息的情况
	$haveTopClose = '<span class="haveTopClose"></span>',
	$haveCenterClose = '<span class="haveCenterClose"></span>',
	$haveBottomClose = '<span class="haveBottomClose"></span>',
	$haveTopOpten = '<span class="haveTopOpten"></span>',
	$haveCenterOpten = '<span class="haveCenterOpten"></span>',
	$haveBottomOpten = '<span class="haveBottomOpten"></span>',
	//就一条信息的情况
	$haveOneClose = '<span class="haveOneClose"></span>',
	$haveOneOpten = '<span class="haveOneOpten"></span>',
	//关闭打开情况
	$haveClose = '<span class="haveClose"></span>',
	$haveOpten = '<span class="haveOpten"></span>',
	//文件
	$file = '<span class="file"></span>',
	$fileTop = '<span class="fileTop"></span>',
	$fileCenter = '<span class="fileCenter"></span>',
	$fileBottom = '<span class="fileBottom"></span>',
	//竖线 空格
	$line = '<span class="fileLine"></span>',
	$space = '<span class="fileSpace"></span>';
var infoCheckTree = $(".infoTree"),infoCheckTreeLg = infoCheckTree.length;
var checkTrees,checkTreesLg;
var $checkTree,checkTreeMath,checkTreeEndMath,checkTreeText,layer,setLay;
infoCheckTree.each(function(){
	//最大层数
	layer=0;
	//设置当前层
	setLay=1;
	//获取当前树
	checkTrees = $(this).find("[class^=checkTree_]");
	//获取当前树的节点个数
	checkTreesLg = checkTrees.length;
	//计算最大层数
	for( var i = 1; i < checkTreesLg; i++){
		//获取每个节点所在的层数
		checkTreeMath = $(checkTrees[i]).attr("class").substring(10,12);
		//设置最大层数
		if(checkTreeMath > layer){
			layer = checkTreeMath;
		}
	}
	//最大层数默认加2，防止意外
	layer = parseInt(layer) + 2;
	//设置每一层样式
	for(var i=1;i<=layer;i++){
		setLay = i;
		setLayer(setLay,layer,checkTrees,checkTreesLg);
	}
});

//给每一层设置样式
function setLayer(setLay,layer,checkTrees,checkTreesLg){
	//若当前层大于最大层，当前层等于最大曾
	if(setLay>layer){
		setLay = layer;
	//若当前层小于1，当前层等于1
	}else if(setLay<1){
		setLay = 1;
	}
	//循环获取当前树的所有节点
	for ( var i = 1; i < checkTreesLg; i++) {
		//获取当前树的单个节点
		$checkTree = $(checkTrees[i]);
		//获取当前节点所在的层数
		checkTreeMath = $checkTree.attr("class").substring(10,12);
		//获取当前节点的内容
		checkTreeText = '<div class="text">'+$checkTree.html()+'</div>';
		//若该节点所在层数等于要设计层的层数
		if(checkTreeMath == setLay){
			//清空数据
			$checkTree.html("");
			if(i == checkTreesLg-1){
				//若本节点是最后一个节点
				getLast($checkTree,checkTreeMath,checkTreeText);
			}else{
				//若本节点不是最后一个节点
				//为本节点添加空格或竖线
				getLineSpace($checkTree,checkTrees,checkTreesLg,checkTreeMath,i,checkTreeText);
				//为本节点设置样式
				getHaveFile($checkTree,checkTrees,checkTreeMath,checkTreesLg,i,checkTreeText);
			}
			$checkTree.addClass("tree");
			$checkTree.find("span").addClass("span");
		}
	}
}
/**
 * 为每个节点设置样式
 * @param $checkTree
 */
function setCheckTreeStyle($checkTree,checkTrees,checkTreesLg,i){
	//获取当前节点的层数
	checkTreeMath = $checkTree.attr("class").substring(10,12);
	//获取当前节点的美容
	checkTreeText = '<div class="text">'+$checkTree.html()+'</div>';
	$checkTree.html("");
	if(i == checkTreesLg-1){
		//若本节点是最后一个节点
		getLast($checkTree,checkTreeMath,checkTreeText);
	}else{
		//若本节点不是最后一个节点
		//为本节点添加空格或竖线
		getLineSpace($checkTree,checkTrees,checkTreesLg,checkTreeMath,i,checkTreeText);
		//为本节点设置样式
		getHaveFile($checkTree,checkTrees,checkTreeMath,checkTreesLg,i,checkTreeText);
	}
	$checkTree.addClass("tree");
	$checkTree.find("span").addClass("span");
}
/**
 * 为本节点添加空格或竖线
 */
function getLineSpace($checkTree,checkTrees,checkTreesLg,checkTreeMath,i,checkTreeText){
	//循环本节点的层数，为每层逐个添加空格或竖线
	for(var k = 1; k < checkTreeMath; k++){
		//循环本节点以后的每个节点
		for(var j = i+1;j < checkTreesLg;j++){
			checkTreeEndMath = $(checkTrees[j]).attr("class").substring(10,12);
			if(checkTreeEndMath  == k){
				//本节点下方有当前循环的层数的节点，在本节点的基础上加【竖线】
				$checkTree.html($checkTree.html()+$line);
				break;
			}else if(checkTreeEndMath  == k-1 || j == checkTreesLg-1){
				//本节点下方没有当前循环的层数的节点，在本节点的基础上加【空格】
				$checkTree.html($checkTree.html()+$space);
				break;
			}
		}
	}
}
/**
 * 为本节点设置样式
 */
function getHaveFile($checkTree,checkTrees,checkTreeMath,checkTreesLg,i,checkTreeText){
	//获取下一个节点
	checkTreeEndMath = $(checkTrees[i+1]).attr("class").substring(10,12);
	if(checkTreeEndMath == checkTreeMath){
		//下一个节点是同级节点，则把本节点【文件居中、文件】格式
		//有下一个同级节点，但没有子节点
		$checkTree.html($checkTree.html()+$fileCenter+$file+checkTreeText);
	}else if(checkTreeEndMath > checkTreeMath){
		//下一个节点是本节点的子节点
		//循环本节点以后的节点
		for(var j = i+1;j < checkTreesLg;j++){
			checkTreeEndMath = $(checkTrees[j]).attr("class").substring(10,12);
			if(checkTreeEndMath == checkTreeMath){
				//本节点有同级节点【文件夹居中、文件夹】
				$checkTree.html($checkTree.html()+$haveCenterClose+$haveClose+checkTreeText);
				break;
			}else if(checkTreeEndMath < checkTreeMath || j == checkTreesLg-1){
				//本节点有上级级节点【文件夹居下、文件夹】
				$checkTree.html($checkTree.html()+$haveBottomClose+$haveClose+checkTreeText);
				break;
			}
		}
	}else{
		//下一个节点是本节点上级节点，则把本节点【文件中、文件】格式
		$checkTree.html($checkTree.html()+$fileBottom+$file+checkTreeText);
	}
}
function getLast($checkTree,checkTreeMath,checkTreeText){
	//本节点为最后一层，在本节点前面加上空格
	for(var k = 1;k < checkTreeMath ; k++){
		$checkTree.html($checkTree.html()+$space);
	}
	//样式为【文件居下、文件】
	$checkTree.html($checkTree.html()+$fileBottom+$file+checkTreeText);
}
$("[class^=checkTree_]").hide();
$(".checkTree_0,.checkTree_1").show();
var maxWidth=0,width,spanWidth,fontSize,fontNum;
function setOverflow(infoCheckTree,$checkTree,lay){
	infoCheckTree.width(maxWidth);
	spanWidth = $checkTree.find("span").width();
	fontSize = $checkTree.css("font-size").replace("px","");
	fontNum = $checkTree.text().length-8;
	width =spanWidth*lay+fontSize*fontNum;
	if(width>maxWidth){
		maxWidth = width;
		infoCheckTree.width(maxWidth);
		infoCheckTree.parent().css("overflow","auto");
	}
}
/**
 * 上面部分把页面初始化完毕
 * 下面为页面事件
 */
/**
 * 页面点击事件
 */
$("[class^=checkTree_] span").live("click",function(){
	//获取当前节点
	var $this = $(this).parent();
	//获取当前节点内容
	var html = $this.html();
	//获取当前节点的下级节点的层数
	layer = parseInt($this.attr("class").substring(10,12))+1;
	//获取当前节点所在的树
	infoCheckTree = $this.parent();
	//获取所在树所有的节点
	checkTrees = infoCheckTree.find("[class^=checkTree_]");
	//获取所在树所有的节点的个数
	checkTreesLg = checkTrees.length;
	//获取所在树的第一个节点
	var $checkTree_frist = infoCheckTree.children(".checkTree_0");
	//获取当前节点在所在树种的索引值
	var nowIndex = $this.index() - $checkTree_frist.index();
	//记录当前点击的行是否选中
	var check = ":checkbox";
	var thisbool = $this.find(":checkbox").attr("checked");
	if(thisbool==undefined){
		check = ":radio";
		thisbool = $this.find(check).attr("checked");
	}
	//存取循环节点的选中状态
	var bool;
	//判断点击的是否是标题，若是标题则取消点击事件
	if(nowIndex == 0){
		return false;
	}
	maxWidth = infoCheckTree.parent().width();
	//存放循环本节点后面节点的层数
	var lay;
	//若当前状态为关闭状态
	if(html.indexOf("Close") != -1){
		//循环本节点后面的节点
		for(var i = nowIndex+1; i < checkTreesLg ;i++){
			//获取循环的当前节点
			$checkTree = $(checkTrees[i]);
			//获取循环的当前节点的层数
			lay = $checkTree.attr("class").substring(10,12);
			//获取当前点击状态
			bool = $checkTree.find(check).attr("checked");
			//若是本节点的下级子节点，则打开此节点
			if( lay == layer){
				if($checkTree.html().indexOf("span") == -1){
					//设置样式
					setCheckTreeStyle($checkTree,checkTrees,checkTreesLg,i);
				}
				$checkTree.show();
				//将当前的点击状态再重新赋值，若无此操作，则点击是为未选中
				$checkTree.find(check).attr("checked",bool);
			}else if(lay < layer){
				//遇到本节点的上级节点或同级节点，则取消遍历
				break;
			}
		}
		for(var i = 0; i < checkTreesLg ;i++){
			$checkTree = $(checkTrees[i]);
			lay = $checkTree.attr("class").substring(10,12);
			if($checkTree.css("display")=="block"){
				setOverflow(infoCheckTree,$checkTree,lay);
			}
		}
		//更改当前节点的状态为打开
		html = html.replace("Close","Opten")
		.replace("Close","Opten");
	}else{
		//当前状态为展开状态
		for(var i = nowIndex+1; i < checkTreesLg ;i++){
			$checkTree = $(checkTrees[i]);
			lay = $checkTree.attr("class").substring(10,12);
			//获取当前点击状态
			bool = $checkTree.find(check).attr("checked");
			if(lay >= layer && $checkTree.css("display") == "block"){
				//关闭本节点的所有子节点
				$checkTree.hide();
				checkTreehtml = $checkTree.html();
				checkTreehtml = checkTreehtml.replace("Opten","Close")
				.replace("Opten","Close");
				$checkTree.html(checkTreehtml);
				//将当前的点击状态再重新赋值，若无此操作，则点击是为未选中
				$checkTree.find(check).attr("checked",bool);
			}else if(lay < layer){
				//遇到本节点的上级节点或同级节点，则取消遍历
				break;
			}
		}
		for(var i = 0; i < checkTreesLg ;i++){
			$checkTree = $(checkTrees[i]);
			lay = $checkTree.attr("class").substring(10,12);
			if($checkTree.css("display")=="block"){
				setOverflow(infoCheckTree,$checkTree,lay);
			}
		}
		//设置本节点的状态为关闭
		html = html.replace("Opten","Close")
		.replace("Opten","Close");
	}
	$this.html(html);
	//将当前的点击状态再重新赋值，若无此操作，则点击是为未选中
	$this.find(check).attr("checked",thisbool);
});

/**
 * 添加背景色
 * checkbox点击事件
 */
$("[class^=checkTree_]").live("click",function(){
	var $this = $(this);
	$(".tree_newColour").removeClass("tree_newColour");
	$this.addClass("tree_newColour");
});
$("[class^=checkTree_] .text div").live("click",function(){
	var $this = $(this).parent();
	var $select = $this.find("[name=select]");
	$select.attr("checked",!$select.attr("checked"))
	checkboxClick($this.find(":checkbox"));
});
$("[class^=checkTree_] :checkbox").live("click",function(){
	checkboxClick($(this));
});
/**
 * 全部展开事件
 */
function allOpten(){
	for(var i = 1 ; i < checkTreesLg ;i++){
		$checkTree = $(checkTrees[i]);
		if($checkTree.html().indexOf("span")==-1){
			setCheckTreeStyle($checkTree,checkTrees,checkTreesLg,i);
		}
		var html = $checkTree.html();
		html = html.replace("Close","Opten")
		.replace("Close","Opten");
		$checkTree.html(html).show();
	}
}
/**
 * 全部关闭事件
 */
function allClose(){
	var lay;
	for(var i = 0 ; i < checkTreesLg ;i++){
		$checkTree = $(checkTrees[i]);
		var html = $checkTree.html();
		lay = $checkTree.attr("class").substring(10,12);
		if(lay > 1 && $checkTree.css("display") == "block"){
			html = html.replace("Opten","Close")
			.replace("Opten","Close");
			$checkTree.html(html).hide();
		}else if(lay <= 1){
			html = html.replace("Opten","Close")
			.replace("Opten","Close");
			$checkTree.html(html);
		}
	}
}
/**
 * checkbox点击事件内核
 */
function checkboxClick($click){
	//获取当前节点
	var $this = $click.parent().parent();
	//获取当前节点的下级节点的层数
	var layer = parseInt($this.attr("class").substring(10,12))+1;
	//获取当前节点所在的树
	infoCheckTree = $this.parent();
	//获取所在树所有的节点
	checkTrees = infoCheckTree.find("[class^=checkTree_]");
	//获取所在树所有的节点的个数
	checkTreesLg = checkTrees.length;
	//获取所在树的第一个节点
	var $checkTree_frist = infoCheckTree.children(".checkTree_0");
	//获取当前节点在所在树种的索引值
	var nowIndex = $this.index() - $checkTree_frist.index();
	//记录当前点击的行是否选中
	var bool = $this.find(":checkbox").attr("checked");
	//判断点击的是否是标题，若是标题则取消点击事件
	if(nowIndex == 0){
		return false;
	}
	var lay;
	//循环本节点后面的节点
	for(var i = nowIndex+1; i < checkTreesLg ;i++){
		$checkTree = $(checkTrees[i]);
		lay = $checkTree.attr("class").substring(10,12);
		if( lay >= layer){
			//若是本节点的下级子节点，则选中此节点
			$checkTree.find(":checkbox").attr("checked",bool);
		}else if(lay < layer){
			//遇到本节点的上级节点或同级节点，则取消遍历
			break;
		}
	}
	var upTreeCheck = true;
	//循环本节点后面的节点
	for(var i = nowIndex+1; i < checkTreesLg ;i++){
		$checkTree = $(checkTrees[i]);
		lay = $checkTree.attr("class").substring(10,12);
		if( lay == layer-1){
			//若是本节点的同级子节点没有选中，则终止判断
			if(!$checkTree.find(":checkbox").attr("checked")){
				upTreeCheck = false;
				break;
			}
		}else if(lay < layer-1){
			//遇到本节点的上级节点，则取消遍历
			break;
		}
	}
	//循环本节点前面的节点，前提是本节点后面的同级节点全部选中
	if(upTreeCheck){
		for(var i = nowIndex-1; i >= 0 ;i--){
			$checkTree = $(checkTrees[i]);
			if($checkTree.attr("class").substring(10,12)=="0"){
				return ;
			}
			lay = $checkTree.attr("class").substring(10,12);
			if( lay == layer-1){
				//若是本节点的同级子节点没有选中，则终止判断
				if(!$checkTree.find(":checkbox").attr("checked")){
					upTreeCheck = false;
					break;
				}
			}else if(lay < layer-1 && upTreeCheck && bool){
				//遇到本节点的上级节点，并且同级节点全部选中，则选中，并取消遍历
				upTreeCheck = false;
				$checkTree.find(":checkbox").attr("checked",true);
				checkboxClick($checkTree.find(":checkbox"));
				break;
			}
		}
	}
	if(!bool){
		//循环本节点前面的节点
		for(var i = nowIndex-1; i >= 0 ;i--){
			$checkTree = $(checkTrees[i]);
			lay = $checkTree.attr("class").substring(10,12);
			if( lay < layer-1){
				//若是本节点的上级子节点，则取消选中
				$checkTree.find(":checkbox").attr("checked",bool);
				if(lay == 1){
					break;
				}
			}
		}
	}
}
(function($){
	$.fn.extend({
		checkTreeClick:function(options){
			options=$.extend({
 				handler:function(){},
 				dblhandler:function(){}
 			},options);
			$("[class^=checkTree_] span").live("click",function(){
 				var $click = $(this);
 				if($click.attr("id").length == 0){
 					return false;
 				}
			});
 			$(this).bind("click",options.handler);
 			$(this).live("dblclick",options.dblhandler);
 		}
 	});
 })(jQuery);

}
