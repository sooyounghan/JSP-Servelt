<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title> 조각집 </title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/main.css">
	</head>
	<body>
	<div class="background">
		<div class = "outer-circle">
			<%
				if((session.getAttribute("id") == null) && (session.getAttribute("pwd") == null)) {
			%>
					<a href = "<%=request.getContextPath()%>/Main/LoginPage.jsp" class ="inner-circle"></a>
			<%		
				} else {
			%>
					<a href = "<%=request.getContextPath()%>/Main/Diary.jsp" class ="inner-circle"></a>			
			<%
				}
			%>
		</div>
	</div>
	</body>
</html>