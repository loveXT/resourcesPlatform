// 本验证支持【空，数字，正整数，小数，电话号码，手机，邮编，邮箱，身份证，日期，图片】
(function($) {
	$.fn
			.extend({
				validate : function(options) {
					options = $.extend({
						type : "",
						minLength : "",
						maxLength : "",
						minValue : "",
						maxValue : ""
					}, options);
					var $this = $(this);
					var type = options.type;
					var error = $("<div id='validate'></div>");
					error.addClass("validate_div").fadeTo(300, 0.7);
					if (type != null) {
						validate(type, $this);
					}
					error.parent().click(function() {
						$(this).children("#validate").remove();
						$this.trigger("focus");
					});
					return this;
					// 添加验证
					function validate(type, $this) {
						var numMatch = "^([+-]?)\\d*\\.?\\d+$";
						var integeMatch = "^([+]?)\\d+$";
						//var floatMatch = "^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$";
						var floatMatch =  "^(-?\\d+)(\\.\\d+)?$";
						var telephoneMatch = "(\\d{3}-|\\d{4}-)?(\\d{8}|\\d{7})";
						var mobileMatch = "^(13|15|18)[0-9]{9}$";
						var emailMatch = "^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$";
						var idCardMatch = "([\\d]{6}(19|20)[\\d]{2}((0[1-9])|(10|11|12))([0|1|2][\\d]{1}|(30|31))[\\d]{3}[xX\\d{1}])|(^[0-9]{8}((0[1-9])|(10|11|12))([0|1|2][0-9]|(30|31))[0-9]{3}$)";
						var dateMatch = "^\\d{4}(\\-|\\/|\.)\\d{1,2}\\1\\d{1,2}$";
						var pictureMatch = "(.*)\\.(jpg|bmp|gif|ico|pcx|jpeg|tif|png|raw|tga)$";
						if (type == "sqlValidate") {
							error.html("“'”输入不合法").insertAfter($this);
						}else if (type == "null" && $.trim($this.val()).length < 1) {
							error.html("空验证不通过").insertAfter($this);
						} else if (type == "num"
								&& !$this.val().match(numMatch)) {
							error.html("数字验证不通过").insertAfter($this);
						} else if (type == "intege"
								&& !$this.val().match(integeMatch)) {
							error.html("正整数验证不通过").insertAfter($this);
						} else if (type == "float"
								&& !$this.val().match(floatMatch)) {
							error.html("浮点数验证不通过").insertAfter($this);
						} else if (type == "telephone"
								&& !$this.val().match(telephoneMatch)) {
							error.html("电话验证不通过").insertAfter($this);
						} else if (type == "mobile"
								&& !$this.val().match(mobileMatch)) {
							error.html("手机号验证不通过").insertAfter($this);
						} else if (type == "zipCode"
								&& !$this.val().match("^\\d{6}$")) {
							error.html("邮编验证不通过").insertAfter($this);
						} else if (type == "email"
								&& !$this.val().match(emailMatch)) {
							error.html("邮件验证不通过").insertAfter($this);
						} else if (type == "idCard"
								&& !$this.val().match(idCardMatch)) {
							error.html("身份证验证不通过").insertAfter($this);
						} else if (type == "date"
								&& !$this.val().match(dateMatch)) {
							error.html("日期验证不通过").insertAfter($this);
						} else if (type == "userName"
								&& !$this.val().match("^\\w+$")) {
							error.html("用户名验证不通过").insertAfter($this);
						} else if (type == "picture"
								&& !$this.val().match(pictureMatch)) {
							error.html("图片验证不通过").insertAfter($this);
						} else if (options.minLength != ""
								&& $this.val().length < options.minLength) {
							error.html("超短验证不通过").insertAfter($this);
						} else if (options.maxLength != ""
								&& $this.val().length > options.maxLength) {
							error.html("超长验证不通过").insertAfter($this);
						} else if (options.minValue != ""
								&& parseFloat($this.val()) < parseFloat(options.minValue)) {
							error.html("最小验证不通过").insertAfter($this);
						} else if (options.maxValue != ""
								&& parseFloat($this.val()) > parseFloat(options.maxValue)) {
							error.html("最大验证不通过").insertAfter($this);
						}
						error.css({
							"width" : $this.width() + 3,
							"height" : $this.height() + 4,
							"top" : $this.offset().top - 1,
							"left" : $this.offset().left - 1
						});
					}
				}
			});
})(jQuery);
// 加载提交时的验证
function validateBySubmit($this) {
	sqlValidate($this);
	var validateTypes = [ "null", "num", "intege", "float", "telephone",
			"mobile", "zipCode", "email", "idCard", "date", "picture" ];
	var validateType;
	for ( var i = 0; i < validateTypes.length; i++) {
		validateType = validateTypes[i];
		$this.find("." + validateType).each(function() {
			var $this = $(this);
			if (validateType == "null") {
				$this.validate({
					type : [ validateType ]
				});
			} else if ($.trim($this.val()) != "") {
				$this.validate({
					type : [ validateType ]
				});
			}
		});
	}
	validateTypes = [ "minLength", "maxLength", "minValue", "maxValue" ];
	for ( var i = 0; i < validateTypes.length; i++) {
		validateType = validateTypes[i];
		$this.find("[class*=" + validateType + "]").each(
				function() {
					var $this = $(this);
					if ($this.val() != "") {
						var classes = $this.attr("class");
						classes = classes.substring(classes
								.indexOf(validateType), classes.length);
						classes = classes.substring(classes.indexOf(":") + 1,
								classes.indexOf("num"));
						if ("maxLength" == validateType) {
							$this.validate({
								maxLength : classes
							});
						}
						if ("minLength" == validateType) {
							$this.validate({
								minLength : classes
							});
						}
						if ("minValue" == validateType) {
							$this.validate({
								minValue : classes
							});
						}
						if ("maxValue" == validateType) {
							$this.validate({
								maxValue : classes
							});
						}
					}
				});
	}
	if ($this.find("[id=validate]").length == 0) {
		return true;
	} else {
		return false;
	}
	;
}
function sqlValidate($from){
	var formChildType = "input,textarea,select";
	var sqlValidate = "'";
	var $this;
	for(var i = 0;i<formChildType.split(",").length;i++){
		$from.find(formChildType.split(",")[i]).each(function(){
			$this = $(this);
			for(var i=0;i<sqlValidate.split(",").length;i++){
				if($this.val().indexOf(sqlValidate.split(",")[i])!=-1){
					$this.validate({
						type : "sqlValidate"
					});
				}
			}
		});
	}
}
