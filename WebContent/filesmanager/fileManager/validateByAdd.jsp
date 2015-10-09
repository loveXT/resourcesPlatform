<%@page import="java.net.URLDecoder"%>
<%@page import="com.googosoft.exception.DBException"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	try {
		String tableName = request.getParameter("TABLENAME");
		String whereColumn1 = request.getParameter("WHERECOLUMN1");
		String whereColumn2 = request.getParameter("WHERECOLUMN2");
		String value1 = request.getParameter("VALUE1");
		//String value2 = request.getParameter("VALUE2");
		//String value2 = new String(request.getParameter("VALUE2").getBytes("iso-8859-1"),"utf-8");
		String value2=URLDecoder.decode(request.getParameter("VALUE2"),"utf-8");
		String sql = "select count(*) from " + tableName + " where "
				+ whereColumn1 + " ='" + value1 + "' AND "  + whereColumn2 + " ='" + value2 + "' ";
		DBHelper dbHelper = new DBHelper();
		int count = Integer.valueOf(dbHelper.queryForSingleValue(sql)
				.toString());
		response.getWriter().print(count);
	} catch (NumberFormatException e) {
		throw new DBException(e);
	}
%>