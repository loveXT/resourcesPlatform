<%@page import="java.io.File"%>
<%@page import="com.googosoft.filesManager.fileManager.ProcessFileUtil"%>
<%@page import="com.googosoft.filesManager.fileManager.JpegTool"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.oa.webContent.WebContentManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图片新闻</title>
<% 
	String sp = File.separator;
	String path = request.getContextPath();
	String layoutName="imageNews";//需要修改的地方
	WebContentManager webContentManager = new WebContentManager();
	
	Map map = webContentManager.findMapByLayoutName(layoutName);
	String navigationId = Validate.isNullToDefault(map.get("NAVIGATIONID"), "").toString();
	List list=webContentManager.findListByNAVIGATIONID(navigationId); 
	Map contentMap=null;
	String toPath = request.getRealPath(sp)+ IUploadImgContants.IMGPATH;
	String ID[] = new String[6];
	String title[] = new String[6];
	String image[] = new String[6];
	String smallPicture[] = new String[6];
	JpegTool j = new JpegTool();
	String picture="";
	StringBuffer datas = new StringBuffer("");
	if(list.size()<6 && list.size()>0){
		for(int i=0;i<list.size();i++){
			contentMap = (Map)list.get(i);
			ID[i] = Validate.isNullToDefault(contentMap.get("ID"),"").toString();
			title[i] = Validate.isNullToDefault(contentMap.get("TITLE"),"").toString();
			picture = Validate.isNullToDefault(contentMap.get("PICTURE"),"").toString();
			image[i] = toPath + picture;
			smallPicture[i] = toPath+"pic_"+picture;
			boolean flag=webContentManager.checkPictureExists(picture,request);
			if(flag){
				j.SetSmallWidth(320);
				j.doFinal(image[i],smallPicture[i]);
			}
			image[i] = path +"/"+IUploadImgContants.PIC_PICTUREPATH + picture;
			smallPicture[i] = path +"/"+IUploadImgContants.PIC_PICTUREPATH+"pic_" + picture;
			datas.append(smallPicture[i]+"%"+path+"/jsp/viewWebContent.jsp?webContentId="+ID[i]+"%"+title[i]+",,");
		}
		if(datas.length()>0){
			datas.deleteCharAt(datas.length()-1);
		}
	}
%>
</head>
<body>
<div style="width:320px; height:240px;float:left;padding:5px">
<script type=text/javascript>
var pic_width=320; //图片宽度
var pic_height=240; //图片高度
var button_pos=4; //按扭位置 1左 2右 3上 4下
var stop_time=3000; //图片停留时间(1000为1秒钟)
var show_text=0; //是否显示文字标签 1显示 0不显示
var txtcolor="000000"; //文字色
var bgcolor="DDDDDD"; //背景色
var imag=new Array();
var link=new Array();
var text=new Array();
var datas="<%=datas.toString()%>".split(",,");
for(var i=0; i<datas.length && i<6; i++){
	var data = datas[i].split("%");
	imag[i] = data[0];
	link[i] = data[1];
	text[i] = data[2];
}
//可编辑内容结束
var swf_height=show_text==1?pic_height+20:pic_height;
var pics="", links="", texts="";
for(var i=0; i<imag.length; i++){
	pics=pics+("|"+imag[i]);
	links=links+("|"+link[i]);
	texts=texts+("|"+text[i]);
}
pics=pics.substring(1);
links=links.substring(1);
texts=texts.substring(1);
document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cabversion=6,0,0,0" overstretch="true" width="'+ pic_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=path%>/flash/focus.swf">');
document.write('<param name="stretchToFit" value="1"> ');
document.write('<param name="quality" value="high"><param name="wmode" value="opaque">');
document.write('<param name="FlashVars" value="pics='+pics+'&links='+links+'&texts='+texts+'&pic_width='+pic_width+'&pic_height='+pic_height+'&show_text='+show_text+'&txtcolor='+txtcolor+'&bgcolor='+bgcolor+'&button_pos='+button_pos+'&stop_time='+stop_time+'">');
document.write('<embed overstretch="true" src="<%=path%>/flash/focus.swf" wmode="transparent" FlashVars="pics='+pics+'&links='+links+'&texts='+texts+'&pic_width='+pic_width+'&pic_height='+pic_height+'&show_text='+show_text+'&txtcolor='+txtcolor+'&bgcolor='+bgcolor+'&button_pos='+button_pos+'&stop_time='+stop_time+'" quality="high" width="'+ pic_width +'" height="'+ swf_height +'" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
document.write('</object>');
</script>
</div>
</body>
</html>