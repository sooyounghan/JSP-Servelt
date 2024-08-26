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
		out.println(request.getParameter("name"));
		out.println(request.getParameter("age"));
		 %>
	</body>
</html>