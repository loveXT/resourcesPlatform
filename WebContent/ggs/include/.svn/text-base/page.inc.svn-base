<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String smPage = (String)session.getAttribute("sm");
	String pathPage = request.getContextPath() + "/ggs/skin/blue/tool/page/images";
	if (pageInfo == null) {
		pageInfo = new PageInfo();
	}
%>
<script type="text/javascript"> 

 //	第几页
 	function pageAction (val){
 		if(val == undefined){
	 		document.getElementById("nowPage").value=document.getElementById("gotoPage").value; 
 		}else{
	 		document.getElementById("nowPage").value=val; 
 		}
 		document.getElementById('pageForm').submit();	 
 	} 
//  	每页显示多少条
 	function perPageColSizeAction (){ 
 		var regNum = /^[0-9]*[1-9][0-9]*$/; 
 		var	val = document.getElementById("viewPageColSize").value; 
 		if (val == '' ||val == '0' || !regNum.test(val)){  
 			alert("请输入有效数字"); 
 			document.getElementById("viewPageColSize").value = 
 			document.getElementById("pageSize").value; 
 			return; 
 		} 
 		else {
 			document.getElementById("nowPage").value=document.getElementById("gotoPage").value; 
 			document.getElementById("pageSize").value = val; 
 			document.getElementById('pageForm').submit(); 
 		} 
 	} 
  </script>

<div class="page">
	<div class="pgToolbar">
		<div class="pgPanel">
			<div>每页显示 <input class="pgPerSize" type="text" value="<%=pageInfo.getPageSize()%>" onchange="perPageColSizeAction()" size="2" id="viewPageColSize" /> 条记录&nbsp;</div>
			<div class="separator"></div>
			<div class="pgBtn pgFirst" id="pgFirst" title="首页">
				<%
					if (pageInfo.getNowPage() != 1) {
				%>
				<img src="<%=pathPage%>/first.gif" onclick="pageAction(1);" />
				<%
					} else {
				%>
				<img src="<%=pathPage%>/first_disabled.gif" />
				<%
					}
				%>
			</div>

			<div class="pgBtn pgPrev" id="pgPrev" title="上页">
				<%
					if (pageInfo.getNowPage() != 1) {
				%>
				<img src="<%=pathPage%>/prev.gif"
					onclick="pageAction(<%=pageInfo.getLastPage()%>);" />
				<%
					} else {
				%>
				<img src="<%=pathPage%>/prev_disabled.gif" />
				<%
					}
				%>
			</div>
			<div class="separator"></div>

			<div>
				第 <select class="pageSelect" id="gotoPage" onchange="pageAction()">
					<%
						for (int i = 1; i <= pageInfo.getAllPage(); i++) {
					%>
					<option value="<%=i%>" <%if (i == pageInfo.getNowPage()) {%>
						selected="selected" <%}%>><%=i%></option>
					<%
						}
					%>
				</select> 页 / 共&nbsp;<%=pageInfo.getAllPage()%>&nbsp;页
			</div>
			<div class="separator"></div>
			<div class="pgBtn pgNext" id="pgNext" title="下页">
				<%
					if (pageInfo.getNowPage() != pageInfo.getAllPage()) {
				%>
				<img src="<%=pathPage%>/next.gif"
					onclick="pageAction(<%=pageInfo.getNextPage()%>);" />
				<%
					} else {
				%>
				<img src="<%=pathPage%>/next_disabled.gif" />
				<%
					}
				%>
			</div>
			<div class="pgBtn pgLast" id="pgLast" title="尾页">
				<%
					if (pageInfo.getNowPage() != pageInfo.getAllPage()) {
				%>
				<img src="<%=pathPage%>/last.gif"
					onclick="pageAction(<%=pageInfo.getAllPage()%>);" />
				<%
					} else {
				%>
				<img src="<%=pathPage%>/last_disabled.gif" />
				<%
					}
				%>
			</div>
			<div class="separator"></div>
			<%
				if (pageInfo.getAllBand() != 0) {
					int start = pageInfo.getStartBand();
					int end = pageInfo.getEndBand();
					if (end > pageInfo.getAllBand()) {
						end = pageInfo.getAllBand();
					}
			%>
			<div class="pgSearchInfo">
				检索到&nbsp;<%=pageInfo.getAllBand()%>&nbsp;条记录, 显示第&nbsp;<%=start%>&nbsp;条&nbsp;-&nbsp;第&nbsp;<%=end%>&nbsp;条记录
			</div>
			<%
				} else {
			%>
			<div class="pgSearchInfo">
				检索到&nbsp;<%=pageInfo.getAllBand()%>&nbsp;条记录
			</div>
			<%
				}
			%>
			<hr class="cleanFloat" />
		</div>
	</div>
</div>
