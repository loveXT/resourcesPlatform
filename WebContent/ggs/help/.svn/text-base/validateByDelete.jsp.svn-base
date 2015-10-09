<%@page import="com.googosoft.exception.DBException"%>
<%@page import="com.googosoft.zapi.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	try {
		String tableName = request.getParameter("TABLENAME");
		String tableRelate = request.getParameter("RELATECOLUMN");
		String value = request.getParameter("VALUE");
		String sql = "select count(*) from " + tableName + " where "
				+ tableRelate + " in ('" + value + "') ";
		DBHelper dbHelper = new DBHelper();
		int count = Integer.valueOf(dbHelper.queryForSingleValue(sql)
				.toString());
		response.getWriter().print(count);
	} catch (NumberFormatException e) {
		throw new DBException(e);
	}
%>