var W = screen.width;//取得屏幕分辨率宽度
var H = screen.height;//取得屏幕分辨率高度
function M(id){
return document.getElementById(id);//用M()方法代替document.getElementById(id)
}
function MC(t){
return document.createElement(t);//用MC()方法代替document.createElement(t)
};
//判断浏览器是否为IE
function isIE(){
   return (document.all && window.ActiveXObject && !window.opera) ? true : false;
}
//取得页面的高宽
function getBodySize(){
var bodySize = [];
with(document.documentElement) {
bodySize[0] = (scrollWidth>clientWidth)?scrollWidth:clientWidth;//如果滚动条的宽度大于页面的宽度，取得滚动条的宽度，否则取页面宽度
bodySize[1] = (scrollHeight>clientHeight)?scrollHeight:clientHeight;//如果滚动条的高度大于页面的高度，取得滚动条的高度，否则取高度
}
return bodySize;
}
//创建遮盖层
function popCoverDiv(){
if (M("cover_div")) {
//如果存在遮盖层，则让其显示
M("cover_div").style.display = 'block';
} else {
//否则创建遮盖层
var coverDiv = MC('div');
document.body.appendChild(coverDiv);
coverDiv.id = 'cover_div';
with(coverDiv.style) {
    position = 'absolute';
    background = '#CCCCCC';
    left = '0px';
    top = '0px';
    var bodySize = getBodySize();
    width = bodySize[0] + 'px';
    height = bodySize[1] + 'px';
    zIndex = 0;
    if (isIE()) {
   filter = "Alpha(Opacity=60)";//IE逆境
    } else {
   opacity = 0.6;
    }
}
}
}
//让登陆层显示为块
function showLogin()
{
var login=M("login");
       login.style.display = "block";
}
//设置DIV层的样式
function changePictrue(){
   var login = M("login");
   login.style.position = "absolute";
   login.style.border = "1px solid #CCCCCC";
   login.style.background ="#F6F6F6";
   var i=0;
   var bodySize = getBodySize();
   login.style.left = (bodySize[0]-i*i*1.8)/2+"px";
   login.style.top = (bodySize[1]-i*i*1.8)/2+"px";
   login.style.width =    i*i*1.8 + "px";
   login.style.height = i*i*1.8 + "px";
   popChange(i);
}
//让DIV层大小循环增大
function popChange(i){
   var login = M("login");
   var bodySize = getBodySize();
   login.style.left = (bodySize[0]-i*i*1.8)/2+"px";
   login.style.top = (bodySize[1]-i*i*1.8)/2+"px";
   login.style.width =    i*i*1.8 + "px";
   login.style.height = i*i*1.8+ "px";
   if(i<=10){
          i++;
          setTimeout("popChange("+i+")",10);//设置超时10毫秒
   }
}
//打开DIV层
function openPictrue(){
	changePictrue();
	showLogin();
	popCoverDiv();
	void(0);//不进行任何操作,如：<a href="#">aaa</a>
}
//关闭DIV层
function close(){
    M('login').style.display = 'none';
    M("cover_div").style.display = 'none';
void(0);
}