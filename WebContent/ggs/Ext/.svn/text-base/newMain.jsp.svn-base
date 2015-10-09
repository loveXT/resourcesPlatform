<%@page import="com.googosoft.commons.Validate"%>
<%@page import="com.googosoft.commons.ISessionContants"%>
<%@page import="com.googosoft.commons.CookieHelper"%>
<%@page import="com.googosoft.ggs.homeManager.ExtJSMenu"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String path = request.getContextPath();
System.out.println("###"+path);
String smRequest = request.getParameter("sm");
String smCookie = CookieHelper.getCookie(request,ISessionContants.SM);
smCookie = Validate.isNullToDefault(smCookie,"blue").toString();
String sm = Validate.isNullToDefault(smRequest,smCookie).toString();
	System.out.println("$$$"+sm);
	ExtJSMenu extJSMenu = new ExtJSMenu();
	String result = extJSMenu.initMenu(request);
	System.out.println(result);
	//String result = "[{title:'收费处理',autoScroll:true,iconCls:'menuicon-jbxx',items:[{xtype:'treepanel',border:false,useArrows:true,listeners:listeners,rootVisible:false,root:{expanded:true,children:[{text:'院系专业设置',id:'010103',iconCls:'tree-icon',url:'jcsz/yxzySet.aspx?mkbh=010103',leaf:true},{text:'班级信息设置',id:'010104',iconCls:'tree-icon',url:'jcsz/bjxxSet.aspx?mkbh=010104',leaf:true},{text:'收费项目设置',id:'010101',iconCls:'tree-icon',url:'jcsz/sfxmSet.aspx?mkbh=010101',leaf:true},{text:'收费任务设置',id:'010102',iconCls:'tree-icon',url:'jcsz/Rw_Frmset.aspx?mkbh=010102',leaf:true},{text:'现场收费',id:'010105',iconCls:'tree-icon',url:'sfgl/sfSet.aspx?mkbh=010105',leaf:true},{text:'大额收费',id:'010106',iconCls:'tree-icon',url:'sfgl/sfdesfList.aspx?mkbh=010106',leaf:true}]}}]},{title:'学生信息管理',autoScroll:true,iconCls:'menuicon-sh',items:[{xtype:'treepanel',border:false,useArrows:true,listeners:listeners,rootVisible:false,root:{expanded:true,children:[{text:'学生信息',id:'030102',iconCls:'tree-icon',url:'sfgl/xsxxSet.aspx?mkbh=030102',leaf:true}]}}]},{title:'查询分析',autoScroll:true,iconCls:'menuicon-cx',items:[{xtype:'treepanel',border:false,useArrows:true,listeners:listeners,rootVisible:false,root:{expanded:true,children:[{text:'收费信息查询',id:'070101',iconCls:'tree-icon',url:'search/sfmxFrm.aspx?mkbh=070101',leaf:true},{text:'收费统计',id:'070102',iconCls:'tree-icon',url:'search/sftjFrm.aspx?mkbh=070102',leaf:true},{text:'学生收费统计',id:'070103',iconCls:'tree-icon',url:'search/sftj_xs_nj.aspx?mkbh=070103',leaf:true},{text:'新生收费统计',id:'070104',iconCls:'tree-icon',url:'search/sftj_new.aspx?mkbh=070104',leaf:true},{text:'当天收费统计',id:'070105',iconCls:'tree-icon',url:'search/sftj_date.aspx?mkbh=070105',leaf:true}]}}]},{title:'收费权限管理',autoScroll:true,iconCls:'menuicon-xtwh',items:[{xtype:'treepanel',border:false,useArrows:true,listeners:listeners,rootVisible:false,root:{expanded:true,children:[{text:'用户设置',id:'0902',iconCls:'',url:'',leaf:false,children:[{text:'人员信息设置',id:'090201',iconCls:'tree-icon',url:'SystemSet/ry_frm.aspx?mkbh=090201',leaf:true},{text:'修改密码',id:'090202',iconCls:'tree-icon',url:'SystemSet/PwChange.aspx?mkbh=090202',leaf:true}]},{text:'权限管理',id:'0901',iconCls:'',url:'',leaf:false,children:[{text:'操作权限设置',id:'090102',iconCls:'tree-icon',url:'SystemSet/czqxSet.aspx?mkbh=090102',leaf:true},{text:'管理权限设置',id:'090101',iconCls:'tree-icon',url:'SystemSet/glqxSet.aspx?mkbh=090101',leaf:true}]}]}}]}]";
%>
    <title>固定资产系统</title>
    <link href="<%=path%>/ggs/Ext/resources/css/ext-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/ggs/Css/fram/frame.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/ggs/Css/fram/menuicon.css" rel="stylesheet" type="text/css" />
    <script src="<%=path%>/ggs/Ext/ext-base.js" type="text/javascript"></script>

    <script src="<%=path%>/ggs/Ext/ext-all.js" type="text/javascript"></script>

    <script src="<%=path%>/ggs/Ext/ext-lang-zh_CN.js" type="text/javascript"></script>
    
    <script src="<%=path%>/ggs/common/js/jquery-1.5.1.js" type="text/javascript"></script>

    <script src="<%=path%>/ggs/common/js/index.js" type="text/javascript"></script>
    
</head>
<body>


    <div id="header">
       
        <div id="titlebg">
            <div id="bgleft">
            </div>
           <div id="bgright">
            </div>
        </div>

       <div id="title">
            <strong style="">固定资产系统</strong>
           </div>
        <div id="toolbar">
            <a id="ibtn_help" href="#"><span>帮助</span></a><%--<a id="ibtn_common" href="#"><span>常用功能</span></a>--%><a
                id="ibtn_reLogin" href="#"><span>重新登录</span></a><a id="ibtn_exit" href="#"><span>注销</span></a>
        </div>
        <div id="dtime">
            <span id="sp_czr">当前人员：<span class="red">选领养</span></span><span id="sp_date">当前时间:</span><span id="sp_time" style="color:Red" class="red"></span></div>
     
     </div>
    <input type="hidden" id="hid_czqx" runat="server" value="<%=result%>"/>
</body>
</html>
