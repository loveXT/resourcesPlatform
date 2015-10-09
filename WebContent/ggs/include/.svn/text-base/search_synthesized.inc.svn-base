<%@page import="com.googosoft.commons.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<tr>
		<td id="cn" colspan="4">
			<%=Validate.isNullToDefault(request.getParameter("query"),"") %>
			<div class="sm_clean"><%=Validate.isNullToDefault(request.getParameter("cn"),"") %></div>
			<input type="hidden" name="cn" class="sm_clean" value="<%=Validate.isNullToDefault(request.getParameter("cn"),"") %>">
			<input type="hidden" name="query" class="sm_clean" value="<%=Validate.isNullToDefault(request.getParameter("query"),"") %>">
		</td>
	</tr>
	<tr>
		<td id="nameTd">
			
		</td>
		<td>
			<select id="sign" class="sm_search_synthesized">
		  		<option value="LIKE">相似</option>
		  		<option value="NOT LIKE">不相似</option>
		  		<option value="=">=</option>
		  		<option value="<="><=</option>
		  		<option value=">=">>=</option>
		  		<option value="!=">!=</option>
		  	</select>
		</td>
		<td>
			<input type="text" id="value" value="">
		</td>
		<td><input type="button" class="add" value="添加"></td>
	</tr>
