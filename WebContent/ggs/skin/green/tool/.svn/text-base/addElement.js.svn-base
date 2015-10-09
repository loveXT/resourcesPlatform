/*******************************************************************************
 * 
 * 使用说明<br>
 * 为要操作的对象内部加上iframe元素<br>
 * 
 * 使用示例<br>
 * ①addElement();<br>
 * 或 
 * ②addElement("[id^=xx]","name");<br>
 * 说明<br>
 * ①为简单新增<br>
 * ②把条件为[id^=xx]元素的name重命名（重命名规则：在原有名称之后添加当前时间串）<br>
 * 
 ******************************************************************************/

function addElement(where,setName) {
	var $copy,$parent,$this;
	var tr_index,index;
	$(".sm_copy").addClass("sm_copy_add").val("");
	$(".sm_copy_add").live("click",function(){
		$this = $(this);
		$parent = $this.parents(".sm_copy_parent");
		
		tr_index = $this.parents(".sm_copy_parent").find('[name=tr_index]').val();
		
		$copy = $parent.clone();
		if(where!=""){
//			alert(where);
			var setValue = $copy.find(where).attr(setName);
			var date = new Date();
			var time = date.getTime();
			setValue = setValue +"_"+ time;
			$copy.find(where).attr(setName,setValue);
			
			if(tr_index !=undefined){
//				alert(tr_index);
				index = parseInt(tr_index)+1;
				$copy.find('td').first().find('span').text(index);
				$copy.find('[name=tr_index]').val(index);
				$copy.find('td').first().find('span').append("<input type='hidden' name='tr_index' value='' />");
				$copy.find('[name=tr_index]').val(index);
			}
			
		}
		$copy.insertAfter($parent);
		$this.addClass("sm_copy_delete").val("");
		$(".sm_copy_delete").removeClass("sm_copy_add");
	});
	$(".sm_copy_delete").live("click",function(){
		$this = $(this);
		$parent = $this.parents("tr");
		$parent.remove();
	});
};

