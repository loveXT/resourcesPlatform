// JScript 文件
Ext.BLANK_IMAGE_URL =  "/resourcesPlatform/ggs/Ext/resources/images/black/s.gif";
/*
页面树监听
*/
var listeners = {
   click:function(node, event){
        if (node.isLeaf()){
            var id = node.attributes.id;
            var p = disktop.getItem(id);
            if (p)
            {
                disktop.setActiveTab(id);
                //window.frames["iframe_"+id].location.reload();   
                document.getElementById("iframe_"+id).contentWindow.document.getElementById("leadFrame").contentWindow.location.href= '/resourcesPlatform/'+node.attributes.url;   
//                document.getElementById("iframe_"+id).contentWindow.location.href= '/resourcesPlatform/'+node.attributes.url; 
              // $("#div_ifram").innerHTML="<iframe frameborder='0' id='iframe_"+id+"' width='100%' height='100%' scrolling='auto' src='" + node.attributes.url+"'></iframe>";
            }
            else {
            	var rrr = encodeURI(node.attributes.url);
                p = new Ext.Panel({
                    id:id,
                    title: node.attributes.text,
                    closable: true,
                    autoScroll: true,
//                    html:"<div id='div_ifram'style='width:100%;height:100%'><iframe frameborder='0' id='iframe_"+id+"' width='100%' height='100%' scrolling='auto' src='" + node.attributes.url+"'></iframe></div>"
//                    html:"<iframe frameborder='0' id='iframe_"+id+"' width='100%' height='100%' scrolling='auto' src='/resourcesPlatform/" + node.attributes.url+"'></iframe>"
                       html:"<iframe frameborder='0' id='iframe_"+id+"' width='100%' height='100%' scrolling='auto' src='/resourcesPlatform/" + node.attributes.url+"'></iframe>"
//                    html:"<iframe frameborder='0' id='iframe_"+id+"' width='100%' height='100%' scrolling='auto' src='/resourcesPlatform/ggs/view/ggs/homeManager/blue/lead.jsp'></iframe>"
//                    html:"<iframe frameborder='0' id='iframe_"+id+"' width='100%' height='100%' scrolling='auto' src='/resourcesPlatform/ggs/view/ggs/homeManager/menuToDesk.jsp?url="+rrr+"'></iframe>"
//                    ,listeners:{  
//                        "activate":function(tab){  
//                            window.frames["iframe_"+tab.id].location.reload();    
//                        } 
//                    }
                });
//                $.ajax({				
// 					url:"/JavaGDZC/gdzc/xtsq/validateUrl.jsp?id="+id+"&url="+node.attributes.url,
// 					type:"post",
// 					success:function(b){
// 									
//  					}
//  				});
                disktop.add(p);
                disktop.setActiveTab(id);
            }
        } 
        else {
            node.toggle();
        } 
    }
};

//待办事项的跳转
function Dbsy_page(id,url,mkmc){
            var id = id;
            var p = disktop.getItem(id);
            if (p)
            {
                disktop.setActiveTab(id);
//                document.getElementById("iframe_"+id).contentWindow.location.href="../"+url; 
                document.getElementById("iframe_"+id).contentWindow.location.href=url; 
//                document.getElementById("iframe_"+id).contentWindow.document.getElementById("leadFrame").contentWindow.location.href= url;
            }
            else {
            	var rrr = encodeURI(url);
                p = new Ext.Panel({
                    id:id,
                    title: mkmc,
                    closable: true,
                    autoScroll: true,
                    html:"<iframe frameborder='0' id='iframe_"+id+"' width='100%' height='100%' scrolling='auto' src='" +url+"'></iframe>"
//                      html:"<iframe frameborder='0' id='iframe_"+id+"' width='100%' height='100%' scrolling='auto' src='/resourcesPlatform/ggs/view/homeManager/menuToDesk.jsp?url="+rrr+"'></iframe>"
                });
//                $.ajax({				
// 					url:"/JavaGDZC/gdzc/xtsq/validateUrl.jsp?id="+id+"&url="+node.attributes.url,
// 					type:"post",
// 					success:function(b){
// 									
//  					}
//  				});
                disktop.add(p);
                disktop.setActiveTab(id);
            }
    }


/*
页面主显示区域
*/
var disktop = new Ext.TabPanel({
    split: true,
    region: "center",
    enableTabScroll:true,
    items: [{
            id:"desktop",
            title:"桌面",
           //iconCls:"index",
            autoScroll:true,
            html:"<iframe frameborder='0' id='iframe_desktop' width='100%' height='100%' scrolling='auto' src='desktop.jsp'></iframe>",
            listeners:{  
                "activate":function(tab){  
//                    document.getElementById("iframe_"+tab.id).contentWindow.location.href='desktop.jsp';   
                    document.getElementById("iframe_"+tab.id).contentWindow.location.href='/resourcesPlatform/ggs/view/ggs/homeManager/desktop.jsp'; 
                    
                } 
            }
        }
      ] 
});
$(function(){
    var getJson = function(){
        var json = $("#hid_czqx").val();
        json = json.replace(/[\r]/g,"").replace(/[\n]/g,"");
        return (new Function("return " + json))() || {}; 
    };
    var vpoint = new Ext.Viewport({
        layout: "border",
        items: [
        //北
        new Ext.Panel({
              region:"north",
              ctCls:"",
              contentEl:"header"
          }),
          new Ext.Panel({
        	  region:"south",
        	  ctCls:"",
        	  height :25,
        	  contentEl:"haveSome"
          }),
        new Ext.Panel({
            region: "west", //导航菜单
            autoScroll: true,
            collapsible:true,
            split: false,
            width: 200,
            title:"管理菜单",
            layout:"accordion",
			layoutConfig : {
				activeOnTop : false,//设置打开的子面板置顶
				fill : true,//子面板充满父面板的剩余空间
				hideCollapseTool: false,//显示“展开收缩”按钮
				titleCollapse : true,//允许通过点击子面板的标题来展开或收缩面板
				animate:false//使用动画效果
			},
            items:getJson()
        }),
        disktop
        ]
    });
    disktop.setActiveTab("desktop"); //默认显示首页
});

 $().ready(function(){
          $("#ibtn_exit").click(function(){
             Exit();
          });
          $("#ibtn_search").click(function(){
             Search();
          });
          $("#ibtn_reLogin").click(function(){
             ChSkin();
          });
           //常用功能
//          $("#ibtn_common").click(function(){
//             Common();
//          });
          ////时间
          setInterval(GetDate,1000);
          
           $("#ibtn_help").click(function(){
            Ext.Msg.confirm("下载","下载帮助文档?",function(obj){
                if (obj == "ok" || obj == "yes")
                {
                 window.open("Excel/系统使用说明.doc");
                }
            });
          });
       }); 
        //搜索
        function Search()
        {
            openWin = new Ext.Window({title:"搜索",height:500,width:900,resizable:true,modal:true, autoScroll:true,html:"<iframe width='899' height='450' scrolling='auto' frameborder='0' src='xzgn/ss/ss.aspx'></iframe>"});
            openWin.show();
        }
        //退出
        function Exit()
        {
            Ext.Msg.confirm("提示","确定要退出吗？",function(val){
                 if(val=="yes")
                 {
                        var target="";
                        if(navigator.appName.toLowerCase()=="netscape")
                        {
                            //firefox
                            target="_self";
                        }
                        window.opener = null;
                    	
                        if (window.ActiveXObject || window.openDatabase)
	                    {
	                        //IE   safari
	                        window.open("","_self");
	                    }
	                    window.close();
                 }
            });
        }
        //重新登录
        function ChSkin()
        {
            window.location.href="ggs/view/ggs/homeManager/login.jsp";

//            openWin = new Ext.Window({title:"更换皮肤",height:360,width:600,resizable:false,modal:true,autoScroll:true,html:"<iframe width='100%' height='100%' frameborder='0' src=''></iframe>"});
//            openWin.show();
        }
          //常用功能
        function Common()
        {
            openWin = new Ext.Window({title:"常用功能",height:500,width:900,resizable:false,modal:true,html:"<iframe width='100%' height='100%' frameborder='0' src=''></iframe>"});
            openWin.show();
        }
        //获取日期时间
        function GetDate()
        {
            var _date = new Date();
            var _y = _date.getFullYear();
            var _m = _date.getMonth()+1;
            _m = (_m<=9?"0"+_m:_m);
            var _d = _date.getDate();
            _d = (_d<=9?"0"+_d:_d);
            var _h = _date.getHours();
            _h = (_h<=9?"0"+_h:_h);
            var _mi = _date.getMinutes();
            _mi = (_mi<=9?"0"+_mi:_mi);
            var _mm = _date.getSeconds();
            _mm = (_mm<=9?"0"+_mm:_mm); 
            $("#sp_date").html("当前时间："+_y+"年"+_m+"月"+_d+"日  星期"+ GetDay(_date.getDay()));
            $("#sp_time").html(_h+":"+_mi+":"+_mm);

        }
        //获取星期
        function GetDay(_day)
        {
            switch(_day)
            {
                case 0:
                    return "日";
                    break;
                case 1:
                    return "一";
                    break;
                case 2:
                    return "二";
                    break;
                case 3:
                    return "三";
                    break;
                case 4:
                    return "四";
                    break;
                case 5:
                    return "五";
                    break;
                case 6:
                    return "六";    
                    break;
            }
}