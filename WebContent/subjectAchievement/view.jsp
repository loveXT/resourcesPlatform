<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%String path = request.getContextPath(); %>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/journal/journal.css">
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
<title>学科成果</title>
</head>
<body>
	<!--top  -->
	<jsp:include page="../common/top/head.jsp"></jsp:include>
	<!-- content -->
	<div class="jounalContent" >
		<div class="wrapper">
			<div class="content"> 
				<div class="search">
					<jsp:include page="search.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
	<!-- bottom -->
	<jsp:include page="../common/bottom/footer.jsp"></jsp:include>
</body>
</html>