/**
 * 查询功能
 */
function sm_goSearch() {
	$(".sm_search").slideToggle(300);
	$(".sm_goSearch_go").live("click", function() {
		if ($("form[class='sm_search']").attr("action") != undefined) {
			if(validateBySubmit($("form[class='sm_search']"))){
				$(".sm_search").slideUp(300);
				$("form[class='sm_search']").submit();
			}
		}
		return false;
	});
	$(".sm_goSearch_back").live("click", function() {
		$(".sm_search").find(":text").val("");
		$(".sm_search").find(".sm_clean").val("");
		$(".sm_search").find(".sm_clean").html("");
		$(".sm_search").find("select").each(function(){
			var $this = $(this);
			$this.find("option").attr("selected",false);
			$this.find("option").eq(0).attr("selected",true);
		});
		return false;
	});
}
//综合查询
//点击事件
var i=$(".sm_search_synthesized").length-1;
$(".add").live("click",function(){
	var $name = $("#name");
	var $sign = $("#sign");
	var value = $("#value").val();
	if($.trim(value)==""){
		return false;
	}
	var name_cn,sign_cn;
	name_cn = $("[id=name]").find("option").filter(":selected").text();
	sign_cn = $("[id=sign]").find("option").filter(":selected").text();
	var cn = name_cn+"  "+sign_cn+"  "+value;
	var old = $("#cn [name=cn]").val();
	if(i!=0&&i%3==0){
		old += "&nbsp;&nbsp;，<br>"
	}
	if(i%3!=0&&old!=""){
		old += "&nbsp;&nbsp;，&nbsp;&nbsp;"
	}
	i++;
	$("#cn [name=cn]").val(old+cn)
	$("#cn div").html($("#cn [name=cn]").val());
	var name = "P_Q_"+$sign.val()+"_"+$name.val();
	var query = "<input type='hidden' class='sm_search_synthesized' name='"+name+"' value='"+value+"'>";
	$("#pageForm #cn [name=query]").val($("#cn [name=query]").val()+query);
	$("#pageForm #cn").append(query);
});