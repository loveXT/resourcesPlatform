

function addWindowsListening(){
	// 监听窗口大小是否改变
	var oldHeight = 0,oldWidth = 0;
	function windowsListen(){
		//递归查找更换滚动条
		function changeIframePageSize($iframes){
			for(var i = 0;i < $iframes.length; i++){
				var $this = $iframes[i];
				var src = $($this).attr("src");
				if(src != "" && src != undefined && src.indexOf(".jsp") != -1 ){
					try{
						$this.contentWindow.setPageSize();
					} catch(Exception){
						alert("页面"+src+"不含有setPageSize()方法");
					}
					changeIframePageSize($($this).contents().find("iframe"));
				}
			}
		}
		var newHeight,newWidth,bool=false;
		newHeight = $("body").height();
		newWidth = $("body").width();
		if(oldHeight != 0 && oldHeight != newHeight){
			bool = true;	
		}
		if(oldWidth != 0 && oldWidth != newWidth){
			bool = true;	
		}
		if(bool){
			setPageSize();
			changeIframePageSize($("iframe"));
		}
		oldWidth = $("body").width();
		oldHeight = $("body").height();
		setTimeout(windowsListen, 100);
	}
	windowsListen();
}
// addWindowsListening();