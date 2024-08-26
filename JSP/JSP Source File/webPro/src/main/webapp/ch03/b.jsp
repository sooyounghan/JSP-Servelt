<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<%
		System.out.println(request.getParameter("name"));
		System.out.println(request.getParameter("age"));
		%>
		<h3>b.jsp</h3>
	</body>
</html>