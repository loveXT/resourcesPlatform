<%@page import="com.googosoft.commons.IUploadImgContants"%>
<%@page import="com.googosoft.oa.teacherinfo.TeacherInfoManager"%>
<%@page import="java.io.File"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.ggs.userManager.DepartmentManager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.googosoft.commons.CodeHelper"%>
<%@page import="com.googosoft.zapi.CUDHelper"%>
<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增信息</title>
<%@include file="/ggs/include/css.inc" %>
<style type="text/css">
table tr{
	width:100%;
	height:30px;
}
table tr td{
	width:100px;
	height:30px;
}
table input{
	border:0px;
	height:32px;
}
table select{
	width:100%;
	height:30px;
	border:0px;
}
#MC{
	background-color:#efefef;
	text-align:right;
	width:130px;
}
#fileQueue {
	position: relative;
	border: 0px solid #999999;
	width: 100px;
	height: 100px;
	top: 5px;
	bottom: 5px;
	overflow: auto;
	background-color: #E1E1E1; 
}
table{
	border:solid 1px #BBCDDB;
	border-right:solid 0px #BBCDDB;
	border-bottom:solid 0px #BBCDDB;
}
</style>
</head>
<%
	String path = request.getContextPath();
	String toPath = request.getContextPath()+"/"+ IUploadImgContants.IMGPATH;
	String operateType = request.getParameter("operateType");
	String ID = request.getParameter("Id") ;
	TeacherInfoManager tm = new TeacherInfoManager();
	DepartmentManager dm = new DepartmentManager();
	Map updateMap = tm.findMapByID(ID);
	String status = Validate.isNullToDefault(updateMap.get("STATUS"), "").toString();
	String zp = Validate.isNullToDefault(updateMap.get("ZP"), "").toString();
	Boolean bool = false;
	if(Validate.noNull(operateType)){
		bool = new CUDHelper(request,"_",null).execute();
	}
%>
<body>
<div class="tool">
</div>
<center>
	<form style="margin-top:5px;" method="post" action="">
		<input type="hidden" name="operateType">
		<input type="hidden" name="P_TEACHERSINFO_ID_S_WU" value="<%=ID%>">
		<input type="hidden" name="P_TEACHERSINFO_STATUS_S_S">
		<input type="hidden" name="P_TEACHERSINFO_ZP_S_S" value="<%=Validate.isNullToDefault(updateMap.get("ZP"), "") %>">
		<div class="table">
		<span style="font-size: 24px;font-weight:bold;">教师基本信息</span>
		<table style="margin-top:10px;">
			<tr>
				<td id="MC">编号:<span style="color:#F00">*</span></td>
				<td>
					<input class="null" name="P_TEACHERSINFO_DABH_S_S" value="<%=Validate.isNullToDefault(updateMap.get("DABH"), "") %>">
				</td>
				<td id="MC">在岗情况:<span style="color:#F00">*</span></td>
				<td>
					<select name="P_TEACHERSINFO_ZGQK_S_S" class="null">
						<option value="">选择类别</option>
						<option value="0"<%if("0".equals(updateMap.get("ZGQK"))){%> selected="selected"<%} %>>在岗</option>
						<option value="1"<%if("1".equals(updateMap.get("ZGQK"))){%> selected="selected"<%} %>>离岗</option>
						<option value="2"<%if("2".equals(updateMap.get("ZGQK"))){%> selected="selected"<%} %>>退休</option>
					</select>
				</td>
				<td rowspan="4" id="MC">个人照片:</td>
				<td rowspan="4" align="center" style="width:120px;height:120px;">
				<img style="width:144px;height:118px;margin-top:2px;" id="tu" src="<%=toPath%><%=updateMap.get("ZP")%>">
					<input type="hidden"  id="fileInput" />
					<div id="fileQueue" style="display: none;" ></div>
				</td>
			</tr>
			<tr>
				<td id="MC">姓名:<span style="color:#F00">*</span></td>
				<td>
					<input class="null" name="P_TEACHERSINFO_XM_S_S" value="<%=Validate.isNullToDefault(updateMap.get("XM"), "") %>">
				</td>
				<td id="MC">性别:<span style="color:#F00">*</span></td>
				<td>
					<select name="P_TEACHERSINFO_XBM_S_S" class="null">
						<option value="">选择性别</option>
						<option value="0"<%if("0".equals(updateMap.get("XBM"))){%> selected="selected"<%} %>>男</option>
						<option value="1"<%if("1".equals(updateMap.get("XBM"))){%> selected="selected"<%} %>>女</option>
					</select>
				</td>
			</tr>
			<tr>
				<td id="MC">民族:<span style="color:#F00">*</span></td>
				<td>
					<select name="P_TEACHERSINFO_MZM_S_S" class="null">
						<option value="">选择民族</option>
						<%
						List mzList = tm.findMapByNormCode("ZGGMZMCDM");
						Map mzMap;
						for(int i=0;i<mzList.size();i++){
							mzMap = (Map)mzList.get(i);
							String mzDM = Validate.isNullToDefault(mzMap.get("DM"), "").toString();
						%>
						<option value="<%=mzMap.get("DM") %>"<%if(mzDM.equals(updateMap.get("MZM"))){%>selected="selected"<%} %>><%=mzMap.get("MC") %></option>
						<%
						}
						%>
					</select>
				</td>
				<td id="MC">出生年月:<span style="color:#F00">*</span></td>
				<td>
					<input class="Wdate null" name="P_TEACHERSINFO_CSRQ_D_S" value="<%=Validate.isNullToDefault(updateMap.get("CSRQ"), "") %>">
				</td>
			</tr>
			<tr>
				<td id="MC">籍贯:<span style="color:#F00">*</span></td>
				<td>
					<input class="null" name="P_TEACHERSINFO_JG_S_S" value="<%=Validate.isNullToDefault(updateMap.get("JG"), "") %>">
				</td>
				<td id="MC">本人身份:<span style="color:#F00">*</span></td>
				<td>
					<select name="P_TEACHERSINFO_BRSF_S_S" class="null">
						<option value="">选择类别</option>
						<option value="0"<%if("0".equals(updateMap.get("BRSF"))){%> selected="selected"<%} %>>干部</option>
						<option value="1"<%if("1".equals(updateMap.get("BRSF"))){%> selected="selected"<%} %>>聘干</option>
						<option value="2"<%if("2".equals(updateMap.get("BRSF"))){%> selected="selected"<%} %>>工人</option>
					</select>
				</td>
			</tr>
			<tr>
				<td id="MC">参加工作时间:</td>
				<td>
					<input class="Wdate" name="P_TEACHERSINFO_CJGZNY_D_S" value="<%=Validate.isNullToDefault(updateMap.get("CJGZNY"), "") %>">
				</td>
				<td id="MC">身份证号:<span style="color:#F00">*</span></td>
				<td>
					<input class="null" name="P_TEACHERSINFO_SFZJH_S_S" value="<%=Validate.isNullToDefault(updateMap.get("SFZJH"), "") %>">
				</td>
				<td id="MC">住址:<span style="color:#F00">*</span></td>
				<td>
					<input class="null" name="P_TEACHERSINFO_APPENDADDRESS_S_S" value="<%=Validate.isNullToDefault(updateMap.get("APPENDADDRESS"), "") %>">
				</td>
			</tr>
			<tr>
				<td id="MC">联系电话:<span style="color:#F00">*</span></td>
				<td>
					<input class="null" name="P_TEACHERSINFO_LXDH_S_S" value="<%=Validate.isNullToDefault(updateMap.get("LXDH"), "") %>">
				</td>
				<td id="MC">电子邮箱:</td>
				<td>
					<input name="P_TEACHERSINFO_EMAIL_S_S" value="<%=Validate.isNullToDefault(updateMap.get("EMAIL"), "") %>">
				</td>
				<td id="MC">其他联系方式:</td>
				<td>
					<input name="P_TEACHERSINFO_BGDH_S_S" value="<%=Validate.isNullToDefault(updateMap.get("BGDH"), "") %>">
				</td>
			</tr>
			<tr>
				<td id="MC">政治面貌:<span style="color:#F00">*</span></td>
				<td>
					<select name="P_TEACHERSINFO_ZZMMM_S_S" class="null">
						<option value=""></option>
						<%
						List zzmmList = tm.findMapByNormCode("ZZMMDM");
						Map zzmmMap;
						for(int i=0;i<zzmmList.size();i++){
							zzmmMap = (Map)zzmmList.get(i);
							String zzmmDM = Validate.isNullToDefault(zzmmMap.get("DM"), "").toString();
						%>
						<option value="<%=zzmmMap.get("DM") %>"<%if(zzmmDM.equals(updateMap.get("ZZMMM"))){%>selected="selected"<%} %>><%=zzmmMap.get("MC") %></option>
						<%
						}
						%>
					</select>
				</td>
				<td id="MC">加入时间:</td>
				<td>
					<input class="Wdate" name="P_TEACHERSINFO_RDTIME_D_S" value="<%=Validate.isNullToDefault(updateMap.get("RDTIME"), "") %>">
				</td>
				<td id="MC">所属党支部:</td>
				<td>
					<input name="P_TEACHERSINFO_SZDZB_S_S" value="<%=Validate.isNullToDefault(updateMap.get("SZDZB"), "") %>">
				</td>
			</tr>
			<tr>
				<td id="MC">编制类别:<span style="color:#F00">*</span></td>
				<td>
					<select name="P_TEACHERSINFO_BZLBM_S_S" class="null">
						<option value="">选择类别</option>
						<option value="0"<%if("0".equals(updateMap.get("BZLBM"))){%> selected="selected"<%} %>>事业</option>
						<option value="1"<%if("1".equals(updateMap.get("BZLBM"))){%> selected="selected"<%} %>>人事代理</option>
					</select>
				</td>
				<td id="MC">来校时间:</td>
				<td>
					<input class="time" readonly="readonly" name="P_TEACHERSINFO_LXRQ_S_S" value="<%=Validate.isNullToDefault(updateMap.get("LXRQ"), "") %>">
				</td>
				<td id="MC">主要岗位类别:<span style="color:#F00">*</span></td>
				<td>
					<select name="P_TEACHERSINFO_JZGLBM_S_S" class="null">
						<option value="">选择类别</option>
						<option value="0"<%if("0".equals(updateMap.get("JZGLBM"))){%> selected="selected"<%} %>>教学</option>
						<option value="1"<%if("1".equals(updateMap.get("JZGLBM"))){%> selected="selected"<%} %>>工勤</option>
						<option value="2"<%if("2".equals(updateMap.get("JZGLBM"))){%> selected="selected"<%} %>>管理</option>
					</select>
				</td>
			</tr>
			<tr>
				<td id="MC">所属部门:<span style="color:#F00">*</span></td>
				<td>
					<select name="P_TEACHERSINFO_ORGANIZATIONID_S_S" class="null">
						<option value="">选择部门</option>
						<%
						List list = dm.findListByDepartment();
						Map map;
						for(int i=0;i<list.size();i++){
							map = (Map)list.get(i);
							String deptId = Validate.isNullToDefault(map.get("UMDEPARTMENTID"), "").toString();
						%>
						<option value="<%=map.get("UMDEPARTMENTID") %>"<%if(deptId.equals(updateMap.get("ORGANIZATIONID"))){%>selected="selected"<%} %>><%=map.get("UMDEPARTMENTNAME") %></option>
						<%
						}
						%>
					</select>
				</td>
				<td id="MC">兼职部门:</td>
				<td>
					<select name="P_TEACHERSINFO_JZBM_S_S">
						<option value="">选择部门</option>
						<%
						List list1 = dm.findListByDepartment();
						Map map1;
						for(int i=0;i<list1.size();i++){
							map1 = (Map)list1.get(i);
							String deptId = Validate.isNullToDefault(map1.get("UMDEPARTMENTID"), "").toString();
						%>
						<option value="<%=map1.get("UMDEPARTMENTID") %>"<%if(deptId.equals(updateMap.get("JZBM"))){%>selected="selected"<%} %>><%=map1.get("UMDEPARTMENTNAME") %></option>
						<%
						}
						%>
					</select>
				</td>
				<td id="MC">所属教研组:</td>
				<td>
					<input name="P_TEACHERSINFO_SSJYZ_S_S" value="<%=Validate.isNullToDefault(updateMap.get("SSJYZ"), "") %>">
				</td>
			</tr>
			<tr>
				<td id="MC">现任职务:<span style="color:#F00">*</span></td>
				<td>
					<select name="P_TEACHERSINFO_XRZW_S_S" class="null">
						<option value="">选择职务</option>
						<option value="0"<%if("0".equals(updateMap.get("XRZW"))){%> selected="selected"<%} %>>校级领导</option>
						<option value="1"<%if("1".equals(updateMap.get("XRZW"))){%> selected="selected"<%} %>>主任</option>
						<option value="2"<%if("2".equals(updateMap.get("XRZW"))){%> selected="selected"<%} %>>副主任</option>
						<option value="3"<%if("3".equals(updateMap.get("XRZW"))){%> selected="selected"<%} %>>职员</option>
						<option value="4"<%if("4".equals(updateMap.get("XRZW"))){%> selected="selected"<%} %>>教师</option>
					</select>
				</td>
				<td id="MC">任教专业:</td>
				<td>
					<select name="P_TEACHERSINFO_RJZY_S_S">
						<option value="">选择专业</option>
						<%
						TeacherInfoManager fm = new TeacherInfoManager();
						List fmList = fm.findListByMAJOR();
						Map fmmap;
						for(int i=0;i<fmList.size();i++){
							fmmap = (Map)fmList.get(i);
							String MID = Validate.isNullToDefault(fmmap.get("MAJOR_ID"), "").toString();
						%>
						<option value="<%=fmmap.get("MAJOR_ID") %>"<%if(MID.equals(updateMap.get("RJZY"))){%>selected="selected"<%} %>><%=fmmap.get("MAJOR_NAME") %></option>
						<%}%>
					</select>
				</td>
				<td id="MC">任教科目:</td>
				<td>
					<input name="P_TEACHERSINFO_RKZKM_S_S" value="<%=Validate.isNullToDefault(updateMap.get("RKZKM"), "") %>">
				</td>
			</tr>
			<tr>
				<td id="MC">现专业技术职务:</td>
				<td>
					<input name="P_TEACHERSINFO_ZYJSZC_S_S" value="<%=Validate.isNullToDefault(updateMap.get("ZYJSZC"), "") %>">
				</td>
				<td id="MC">评审通过时间:</td>
				<td>
					<input class="Wdate" name="P_TEACHERSINFO_PDTIME_D_S" value="<%=Validate.isNullToDefault(updateMap.get("PDTIME"), "") %>">
				</td>
				<td id="MC">首聘时间:</td>
				<td>
					<input  class="Wdate" name="P_TEACHERSINFO_SPTIME_D_S" value="<%=Validate.isNullToDefault(updateMap.get("SPTIME"), "") %>">
				</td>
			</tr>
			<tr>
				<td id="MC">教师资格证书类别:</td>
				<td>
					<input name="P_TEACHERSINFO_JSZGZSLB_S_S" value="<%=Validate.isNullToDefault(updateMap.get("JSZGZSLB"), "") %>">
				</td>
				<td id="MC">教师资格证书取得时间:</td>
				<td>
					<input class="Wdate" name="P_TEACHERSINFO_JSZGZSQDSJ_D_S" value="<%=Validate.isNullToDefault(updateMap.get("JSZGZSQDSJ"), "") %>">
				</td>
				<td id="MC">教师资格证书编号:</td>
				<td>
					<input name="P_TEACHERSINFO_JSZGZSBH_S_S" value="<%=Validate.isNullToDefault(updateMap.get("JSZGZSBH"), "") %>">
				</td>
			</tr>
			<tr>
				<td id="MC">非教师系列职业<br/>资格证书名称:</td>
				<td>
					<input style="width:100%; height:40px; border:0px;" name="P_TEACHERSINFO_FJSZGZSMC_S_S" value="<%=Validate.isNullToDefault(updateMap.get("FJSZGZSMC"), "")%>">
				</td>
				<td id="MC">非教师系列职业<br/>资格证书取得时间:</td>
				<td>
					<input style="width:100%; height:40px;" class="Wdate" name="P_TEACHERSINFO_FJSZGZSQDSJ_D_S" value="<%=Validate.isNullToDefault(updateMap.get("FJSZGZSQDSJ"), "")%>">
				</td>
				<td id="MC">非教师系列职业<br/>资格证书编号:</td>
				<td>
					<input style="width:100%; height:40px;border:0px;" name="P_TEACHERSINFO_FJSZGZSBH_S_S" value="<%=Validate.isNullToDefault(updateMap.get("FJSZGZSBH"), "")%>">
				</td>
			</tr>
			<tr>
				<td id="MC">外语水平:</td>
				<td colspan="2">
					<input style="width:100%;" name="P_TEACHERSINFO_WYSP_S_S" value="<%=Validate.isNullToDefault(updateMap.get("WYSP"), "") %>">
				</td>
				<td id="MC">计算机水平:</td>
				<td colspan="2">
					<input style="width:100%;" name="P_TEACHERSINFO_JSJSP_S_S" value="<%=Validate.isNullToDefault(updateMap.get("JSJSP"), "") %>">
				</td>
			</tr>
			<tr>
				<td id="MC">社会兼职:</td>
				<td colspan="5">
					<textarea style="width:100%; height:50px; border:0px;" name="P_TEACHERSINFO_SHJZ_S_S"><%=Validate.isNullToDefault(updateMap.get("SHJZ"), "")%></textarea>
				</td>
			</tr>
		</table>
		</div>
	</form>
</center>
<%@include file="/ggs/include/js.inc" %>
<script type="text/javascript">
	$(function() {
		jumpRemark("<%=bool%>","<%=request.getContextPath()%>","doneByParent.jsp");
		$(".tool").toolBar([{
			text : "修改后保存",
			width : 50,
			position : "-20px -160px",
			handler : function() {
				var status = "<%=status%>";
				if(status!=0 && status!=2 && status!=4){
					alert("已提交不能修改");
				}else{
					if(validateBySubmit($("form"))){
						checkDS();
						$("[name=operateType]").val("U");
						$("[name=P_TEACHERSINFO_STATUS_S_S]").val(status);
						$("form").submit();
					}
				}
			}
		}]);
		$(document).ready(function(){
			<%
			String sp = File.separator;
			toPath = request.getRealPath(sp)+ IUploadImgContants.IMGPATH;
			toPath = toPath.replace(sp,sp+sp);
			%>
		    $('#fileInput').uploadify({
		    	'uploader': '<%=pathSkinTool%>/tool/uploadify/uploadify.swf',
			    'script': '<%=request.getContextPath()%>/UploadServlet?TOPATH=<%=toPath.replace('\\', '/')%>',	//指定服务端处理类的入口 
			 	'cancelImg' : '<%=pathSkinTool%>/tool/uploadify/cancel.png',
			    'queueID': 'fileQueue',
			    'fileDataName': 'fileInput',//和input的name属性值保持一致
			    'auto': true,//是否选取文件后自动上传   
			    'multi': false,//是否支持多文件上传
			    'simUploadLimit' : 1,//每次最大上传文件数
			    'removeCompleted' : false,
				'buttonImg':'<%=pathSkinTool%>/tool/uploadify/sctp.png',
			    'width': 75,
			 	'height': 22,
			 	'fileExt' : '*.jpg;*.jpeg;*.gif;*.png;*.bmp', //设置可以选择的文件的类型，格式如：
			 	'fileDesc':'请选择文件上传',
			 	'displayData': 'percentage', //有speed和percentage两种，一个显示速度，一个显示完成百分比
			 	'onComplete': function(event, ID, fileObj, response, data) {
			 		var zp = "<%=zp%>";
					var resultArray=response.split(",");
					var fileName = resultArray[0];
					var file = resultArray[1];
					var html='<img name="'+file+'" style="width: 16px;height:16px; float:right; "  class="delimp" src="<%=path%>/ggs/skin/default/image/delete.bmp"/>';
					$(html).prependTo("#fileInput"+ID);
			 		var realName=fileName.substring(32,fileName.lastIndexOf("."));
			 		var extendName=fileName.substring(fileName.lastIndexOf("."));
			 		var updateName=fileName.substring(0,32);
					$("#filesize").val(fileObj.size/1024);
			 		$("[name=P_TEACHERSINFO_ZP_S_S]").val(updateName+extendName);
			 		var src = "<%=path%>/image/";
			 		src += updateName+extendName;
			 		$('#tu').attr("src",src);
			 		window.parent.desktopManager(resultArray[0]);
			 	} ,
			 	'onCancel': function(event,ID,fileObj,data) {
			 	}
		    }); 
		});
		setPageSize();
	});
	$(".time").click(function(){
		WdatePicker({
			dateFmt:"yyyy-MM"
		});
	});
	function checkDS(){
		$("[name$='D_S']").each(function(){
			var status = $(this).val();
			if(status==null||status==""){
				$(this).attr("name","");
			}
		});
	}
	function setPageSize() {
		setWidth($(".table"),$("body"));
		setHeight($(".table"),$("body"),[$(".tool")],35);
	}
	</script>
</body>
</html>