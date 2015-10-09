<%@page import="java.io.File"%>
<%@page import="com.googosoft.filesManager.fileManager.JpegTool"%>
<%@page import="com.googosoft.filesManager.viewManager.StringConstant"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.googosoft.filesManager.netresvindicate.MajorType"%>
<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="java.util.List"%>
<%@page import="com.googosoft.filesManager.fileManager.SelectFilesManager"%>
<%@page import="java.util.Map"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>热门资源</title>
<% String path = request.getContextPath(); %>
<style type="text/css">
	.hotResource{
		width:100%;
		height:auto;
		margin:0px auto;
	}
	.hotResource .title{
		height:30px;
		width:100%;
		background: url('<%=path%>/image/zxzy_1.gif') repeat-x;
	}
	.hotResource .title_text {
		height: 28px;
		width: 100%;
		float: left;
		margin-left:10px;
		background: url('<%=path%>/image/zxzy_2.gif') left center no-repeat;
	}
	
	.hotResource .title_text span {
		font-size: 14px;
		color: #026ad3;
		font-weight: bold;
		line-height: 28px;
		padding-left: 17px;
	}
	.hotResource .content{
		width:100%;
		height:auto;
		float:left;
	}
	.hotResource .title .title_text a{
		color:#084a99;
	}
</style>
</head>
<body>
	<div class="hotResource">
		<div class="title">
			<div class="title_text">
				<span>热门资源</span>
				<span style="margin-left: 220px;">
				<a target="_blank" style="font-size:12px;" href="<%=path%>/filesmanager/fileManager/myFiles/mainPicture.jsp?Type_Id=browsetime">更多>></a>
				</span>
			</div>
		</div>
		<div class="content">
			<table  style="margin-top:7px;">
			<%
				String toPath = request.getContextPath()+"/"+ IUploadImgContants.IMGPATH;
				String spath = request.getContextPath();
				String sp = File.separator;
				String topicPath = request.getRealPath(sp)+ IUploadImgContants.IMGPATH;
				String serverPath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()
					+ spath;
				String imagePath = serverPath + "/ggs/common/ggs/upload/";
				SelectFilesManager sm = new SelectFilesManager();
				MajorType majorType = new MajorType();
				List<String> ImagesList = Arrays.asList(StringConstant.Images);
				List<String> VediosList = Arrays.asList(StringConstant.Vedios);
				List list = sm.findListByDownLoad();
				Map map;
				if(list.size()<1){%>
					<tr>
					</tr>
					<tr>
					</tr>
			<% 	}else if(list.size()<=3){
			%>
				<tr>
					<%
						for(int i=0;i<list.size();i++){
						map = (Map)list.get(i);
						String image=majorType.findImageByExtendName(Validate.isNullToDefault(map.get("EXTENDNAME"), "").toString());
					%>
						<td style="width:120px;text-align: center;border-bottom:1px dashed #325FFA;padding-left: 5px;" title="<%=Validate.isNullToDefault(map.get("REALNAME"), "") %>">
							<%
							//图片
							if(ImagesList.contains(map.get("EXTENDNAME"))){
								String smallImageUrl = topicPath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"));
								String imageUrl = Validate.isNullToDefault(map.get("FILENAME"), "").toString();
								JpegTool j = new JpegTool();
								j.SetScale(0.6);
								j.SetSmallHeight(200);
								j.doFinal(topicPath+Validate.isNullToDefault(map.get("FILENAME"),""),smallImageUrl);
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=imagePath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"))%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
								<%}
							//视频
							}else if(VediosList.contains(map.get("EXTENDNAME"))){
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){
							%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
								<%}
							}else{ 
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){
							%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=path%>/image/<%=image%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
							<%	
								}
							}
							%>
							<div style="font-size: 13px;font-weight: bold;width:120px;color: #325FFA;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;color:grey ">
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>"><%=Validate.isNullToDefault(map.get("REALNAME"),"")%><%=Validate.isNullToDefault(map.get("EXTENDNAME"),"")%></a>
							</div>
							<div style="font-size: 12px;color:gray;line-height:20px;">&nbsp;<%=Validate.isNullToDefault(map.get("UPLOADER"), "") %></div>
						</td>
					<%	}%>
					</tr>
						<%}else if(list.size()>3 && list.size()<=6){
							%>
					<tr>
						<% 
							for(int i=0;i<3;i++){
							map = (Map)list.get(i);	
							String image=majorType.findImageByExtendName(Validate.isNullToDefault(map.get("EXTENDNAME"), "").toString());
						%>	
							<td style="width:120px;text-align: center;border-bottom:1px dashed #325FFA;padding-left: 5px;" title="<%=Validate.isNullToDefault(map.get("REALNAME"), "") %>">
								<%
							//图片
							if(ImagesList.contains(map.get("EXTENDNAME"))){
								String smallImageUrl = topicPath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"));
								String imageUrl = Validate.isNullToDefault(map.get("FILENAME"), "").toString();
								JpegTool j = new JpegTool();
								j.SetScale(0.6);
								j.SetSmallHeight(200);
								j.doFinal(topicPath+Validate.isNullToDefault(map.get("FILENAME"),""),smallImageUrl);
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=imagePath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"))%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
								<%}
								//视频
							}else if(VediosList.contains(map.get("EXTENDNAME"))){
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){
							%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
								<%}
							}else{ 
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){
							%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=path%>/image/<%=image%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
							<%	
								}
							}
							%>
								<div style="font-size: 13px;font-weight: bold;width:120px;color: #325FFA;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;color:grey ">
									<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>"><%=Validate.isNullToDefault(map.get("REALNAME"),"")%><%=Validate.isNullToDefault(map.get("EXTENDNAME"),"")%></a>
								</div>
								<div style="font-size: 12px;color:gray;line-height:20px;">&nbsp;<%=Validate.isNullToDefault(map.get("UPLOADER"), "") %></div>
							</td>	
						<%		}%>
					</tr>
					<tr>
						<%
						for(int i=3;i<list.size();i++){
						map = (Map)list.get(i);	
						String image=majorType.findImageByExtendName(Validate.isNullToDefault(map.get("EXTENDNAME"), "").toString());
						%>
						<td style="width:120px;text-align: center;padding-top:3px;padding-left: 5px;" title="<%=Validate.isNullToDefault(map.get("REALNAME"), "") %>">
							<%
							//图片
							if(ImagesList.contains(map.get("EXTENDNAME"))){
								String smallImageUrl = topicPath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"));
								String imageUrl = Validate.isNullToDefault(map.get("FILENAME"), "").toString();
								JpegTool j = new JpegTool();
								j.SetScale(0.6);
								j.SetSmallHeight(200);
								j.doFinal(topicPath+Validate.isNullToDefault(map.get("FILENAME"),""),smallImageUrl);
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=imagePath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"))%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
								<%}
								//视频
							}else if(VediosList.contains(map.get("EXTENDNAME"))){
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){
							%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
								<%}
							}else{ 
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){
							%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=path%>/image/<%=image%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
							<%	
								}
							}
							%>
							<div style="font-size: 13px;font-weight: bold;width:120px;color: #325FFA;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;color:grey ">
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>"><%=Validate.isNullToDefault(map.get("REALNAME"),"")%><%=Validate.isNullToDefault(map.get("EXTENDNAME"),"")%></a>
							</div>
							<div style="font-size: 12px;color:gray;line-height:20px;">&nbsp;<%=Validate.isNullToDefault(map.get("UPLOADER"), "") %></div>
						</td>	
						<%	}%>
					</tr>
				<%}else if(list.size()>6){%>
					<tr>
						<%
						for(int i=0;i<3;i++){
						map = (Map)list.get(i);	
						String image=majorType.findImageByExtendName(Validate.isNullToDefault(map.get("EXTENDNAME"), "").toString());
						%>	
						<td style="width:120px;text-align: center;border-bottom:1px dashed #325FFA;padding-left: 5px;" title="<%=Validate.isNullToDefault(map.get("REALNAME"), "") %>">
							<%
							//图片
							if(ImagesList.contains(map.get("EXTENDNAME"))){
								String smallImageUrl = topicPath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"));
								String imageUrl = Validate.isNullToDefault(map.get("FILENAME"), "").toString();
								JpegTool j = new JpegTool();
								j.SetScale(0.6);
								j.SetSmallHeight(200);
								j.doFinal(topicPath+Validate.isNullToDefault(map.get("FILENAME"),""),smallImageUrl);
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=imagePath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"))%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
								<%}
								//视频
							}else if(VediosList.contains(map.get("EXTENDNAME"))){
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){
							%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
								<%}
							}else{ 
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){
							%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=path%>/image/<%=image%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
							<%	
								}
							}
							%>
							<div style="font-size: 13px;font-weight: bold;width:120px;color: #325FFA;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;color:grey ">
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>"><%=Validate.isNullToDefault(map.get("REALNAME"),"")%><%=Validate.isNullToDefault(map.get("EXTENDNAME"),"")%></a>
							</div>
							<div style="font-size: 12px;color:gray;line-height:20px;">&nbsp;<%=Validate.isNullToDefault(map.get("UPLOADER"), "") %></div>
						</td>	
					<%	}%>
					</tr>
					<tr>
						<%
						for(int i=3;i<6;i++){
						map = (Map)list.get(i);	
						String image=majorType.findImageByExtendName(Validate.isNullToDefault(map.get("EXTENDNAME"), "").toString());
						%>	
						<td style="width:120px;text-align: center;padding-top:3px;padding-left: 5px;" title="<%=Validate.isNullToDefault(map.get("REALNAME"), "") %>">
							<%
							//图片
							if(ImagesList.contains(map.get("EXTENDNAME"))){
								String smallImageUrl = topicPath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"));
								String imageUrl = Validate.isNullToDefault(map.get("FILENAME"), "").toString();
								JpegTool j = new JpegTool();
								j.SetScale(0.6);
								j.SetSmallHeight(200);
								j.doFinal(topicPath+Validate.isNullToDefault(map.get("FILENAME"),""),smallImageUrl);
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=imagePath+String.valueOf("pic_"+map.get("SWFPATH")+map.get("EXTENDNAME"))%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
								<%}
								//视频
							}else if(VediosList.contains(map.get("EXTENDNAME"))){
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){
							%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=imagePath +String.valueOf(map.get("SWFPATH")+".jpg")%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
								<%}
							}else{ 
								if("".equals(Validate.isNullToDefault(map.get("FILENAME2"), ""))){
							%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"), "") %>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=path%>/image/<%=image%>">
								</a><br/>
								<%}else{%>
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>">
									<img style="width:60px;height:60px;margin-left:15px;" src="<%=toPath %><%=Validate.isNullToDefault(map.get("FILENAME2"), "") %>">
								</a><br/>
							<%	
								}
							}
							%>
							<div style="font-size: 13px;font-weight: bold;width:120px;color: #325FFA;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;color:grey ">
								<a target="_blank" href="<%=path%>/jsp/content.jsp?fileId=<%=Validate.isNullToDefault(map.get("FILEID"),"")%>"><%=Validate.isNullToDefault(map.get("REALNAME"),"")%><%=Validate.isNullToDefault(map.get("EXTENDNAME"),"")%></a>
							</div>
							<div style="font-size: 12px;color:gray;line-height:20px;">&nbsp;<%=Validate.isNullToDefault(map.get("UPLOADER"), "") %></div>
						</td>	
					<%	}%>
					</tr>
					<%
					}
					%>
			</table>
		</div>
	</div>
</body>
</html>