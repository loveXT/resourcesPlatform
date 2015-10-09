// JScript 文件
var CalendarData = new Array(100);
var madd = new Array(12);
var tgString = "甲乙丙丁戊己庚辛壬癸";
var dzString = "子丑寅卯辰巳午未申酉戌亥";
var numString = "一二三四五六七八九十";
var monString = "正二三四五六七八九十冬腊";
var weekString = "日一二三四五六";
var sx = "鼠牛虎兔龙蛇马羊猴鸡狗猪";
var cYear, cMonth, cDay, TheDate;
CalendarData = new Array(0xA4B, 0x5164B, 0x6A5, 0x6D4, 0x415B5, 0x2B6, 0x957, 0x2092F, 0x497, 0x60C96, 0xD4A, 0xEA5, 0x50DA9, 0x5AD, 0x2B6, 0x3126E, 0x92E, 0x7192D, 0xC95, 0xD4A, 0x61B4A, 0xB55, 0x56A, 0x4155B, 0x25D, 0x92D, 0x2192B, 0xA95, 0x71695, 0x6CA, 0xB55, 0x50AB5, 0x4DA, 0xA5B, 0x30A57, 0x52B, 0x8152A, 0xE95, 0x6AA, 0x615AA, 0xAB5, 0x4B6, 0x414AE, 0xA57, 0x526, 0x31D26, 0xD95, 0x70B55, 0x56A, 0x96D, 0x5095D, 0x4AD, 0xA4D, 0x41A4D, 0xD25, 0x81AA5, 0xB54, 0xB6A, 0x612DA, 0x95B, 0x49B, 0x41497, 0xA4B, 0xA164B, 0x6A5, 0x6D4, 0x615B4, 0xAB6, 0x957, 0x5092F, 0x497, 0x64B, 0x30D4A, 0xEA5, 0x80D65, 0x5AC, 0xAB6, 0x5126D, 0x92E, 0xC96, 0x41A95, 0xD4A, 0xDA5, 0x20B55, 0x56A, 0x7155B, 0x25D, 0x92D, 0x5192B, 0xA95, 0xB4A, 0x416AA, 0xAD5, 0x90AB5, 0x4BA, 0xA5B, 0x60A57, 0x52B, 0xA93, 0x40E95);
madd[0] = 0;
madd[1] = 31;
madd[2] = 59;
madd[3] = 90;
madd[4] = 120;
madd[5] = 151;
madd[6] = 181;
madd[7] = 212;
madd[8] = 243;
madd[9] = 273;
madd[10] = 304;
madd[11] = 334;
function GetBit(m, n) {
    return (m >> n) & 1;
}
function e2c() {
    TheDate = (arguments.length != 3) ? new Date() : new Date(arguments[0], arguments[1], arguments[2]);
    var total, m, n, k;
    var isEnd = false;
    var tmp = TheDate.getYear();
    if (tmp < 1900) {
        tmp += 1900;
    }
    total = (tmp - 1921) * 365 + Math.floor((tmp - 1921) / 4) + madd[TheDate.getMonth()] + TheDate.getDate() - 38;

    if (TheDate.getYear() % 4 == 0 && TheDate.getMonth() > 1) {
        total++;
    }
    for (m = 0; ; m++) {
        k = (CalendarData[m] < 0xfff) ? 11 : 12;
        for (n = k; n >= 0; n--) {
            if (total <= 29 + GetBit(CalendarData[m], n)) {
                isEnd = true; break;
            }
            total = total - 29 - GetBit(CalendarData[m], n);
        }
        if (isEnd) break;
    }
    cYear = 1921 + m;
    cMonth = k - n + 1;
    cDay = total;
    if (k == 12) {
        if (cMonth == Math.floor(CalendarData[m] / 0x10000) + 1) {
            cMonth = 1 - cMonth;
        }
        if (cMonth > Math.floor(CalendarData[m] / 0x10000) + 1) {
            cMonth--;
        }
    }
}

function GetcDateString() {
    var tmp = "";
    if (cMonth < 1) {
        tmp += "(闰)";
        tmp += monString.charAt(-cMonth - 1);
    } else {
        tmp += monString.charAt(cMonth - 1);
    }
    tmp += "月";
    tmp += (cDay < 11) ? "初" : ((cDay < 20) ? "十" : ((cDay < 30) ? "廿" : "三十"));
    if (cDay % 10 != 0 || cDay == 10) {
        tmp += numString.charAt((cDay - 1) % 10);
    }
    return tmp;
}

function GetLunarDay(solarYear, solarMonth, solarDay) {
    if (solarYear < 1921 || solarYear > 2020) {
        return "";
    } else {
        solarMonth = (parseInt(solarMonth) > 0) ? (solarMonth - 1) : 11;
        e2c(solarYear, solarMonth, solarDay);
        return GetcDateString();
    }
}


/*
显示时间
*/
var SetTime = function() {
    var strminute = $("#tool_time").text();
    var strtime = strminute.split(":");
    var hour = parseInt(strtime[0], 10);
    var minute = parseInt(strtime[1], 10);
    var second = parseInt(strtime[2], 10);
    second = second + 1;
    if (second == 60) {
        minute = minute + 1;
        second = 0;
    }
    if (minute == 60) {
        hour = hour + 1;
        minute = 0;
    }
    if (hour == 24) {
        hour = 0;
    }
    hour = (hour >= 0 && hour <= 9 ? "0" + hour : hour);
    second = (second >= 0 && second <= 9 ? "0" + second : second);
    minute = (minute >= 0 && minute <= 9 ? "0" + minute : minute);
    $("#tool_time").text(hour + ":" + minute + ":" + second);
    var timearea = "早上";
    if (hour < 6) 
        timearea = "凌晨";
    else if (hour < 9) 
        timearea = "早上";
    else if (hour < 12)
        timearea = "上午";
    else if (hour < 14)
        timearea = "中午";
    else if (hour < 17)
        timearea = "下午";
    else if (hour < 19)
        timearea = "傍晚";
    else if (hour < 22)
        timearea = "晚上";
    else 
        timearea = "深夜";
    $("#timearea").text($("#username").text()+' '+timearea + "好,祝你工作顺利");
};
$(function(){
	 /********************设置时间*******************/
    var _time_days = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
    var _time_date = new Date();
    var _time_hour = (_time_date.getHours() >= 0 && _time_date.getHours() <= 9 ? "0" + _time_date.getHours() : _time_date.getHours());
    var _time_minute = (_time_date.getMinutes() >= 0 && _time_date.getMinutes() <= 9 ? "0" + _time_date.getMinutes() : _time_date.getMinutes());
    var _time_second = (_time_date.getSeconds() >= 0 && _time_date.getSeconds() <= 9 ? "0" + _time_date.getSeconds() : _time_date.getSeconds());
    var yy = _time_date.getFullYear();
    var mm = _time_date.getMonth() + 1;
    var dd = _time_date.getDate();
    var ww = _time_date.getDay();
    var ss = parseInt(_time_date.getTime() / 1000);
    if (yy < 100) yy = "19" + yy;
    
    /********************设置时间*******************/
    $("#date_time").text(""+_time_date.getFullYear() + "年" + (_time_date.getMonth() + 1) + "月" + _time_date.getDate() + "日 " + " "+_time_days[_time_date.getDay()] );
    $("#tool_time").text(_time_hour + ":" + _time_minute + ":" + _time_second);
    window.setInterval("SetTime()", 1000);
    $("div#sys-navigation-body ul li").hover(function(evt){
        var classname = $(this).attr("class");
        if(classname == "menu-body")
            $(this).attr("class","menu-body-hover");
        else
            $(this).attr("class",classname + " active");
        $(this).find("div.sys-menu-group").eq(0).css("display","block");
    },function(evt){
        var classname = $(this).attr("class");
        if(classname == "menu-body-hover")
            $(this).attr("class","menu-body");
        else
            $(this).attr("class",classname.replace(" active",""));
        $(this).find("div.sys-menu-group").eq(0).css("display","none");
    });
});
function getNavigation(layoutName,path,navigationId) {
	jQuery.ajax({
		type : "post",
		url : path+"/jsp/ajaxNavigation.jsp",
		async:false,
		dataType : "text",
		data : {
			parm : new Date().getTime()
		},
		success : function(result) {
			result=result.trim();
			if(result!=null && result!=""){
			jQuery(".xcConfirm .txtBox p").append("<form action='' method='post' id='"+layoutName+"Form' style='float: right;width: 200px; margin-right: 100px;'><input type='hidden' name='"+layoutName+"Flag' value=''><select style='margin-left: 30px;height: 25px; width: 150px;' name='"+layoutName+"Select' ></select></form>");
			var resultArrays = eval("result.trim()").split(",");
				for ( var i = 0; i <resultArrays.length ; i++) {
					var dataArrays=resultArrays[i].split("%");
					jQuery("[name='"+layoutName+"Select']").append(function(){
						var str = "<option value='"+dataArrays[0];
						if(dataArrays[0]==navigationId){
							str+= "' selected='selected'";
						}
						str+="'>"+ dataArrays[1] + "</option>";
						return str;
					})
				}
			}
		}
	});
}	