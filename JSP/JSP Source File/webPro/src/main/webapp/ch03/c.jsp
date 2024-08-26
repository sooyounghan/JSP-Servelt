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
		System.out.println("forwarding");
		out.println("name = " + request.getParameter("name"));
		out.println("age = " + request.getParameter("age"));
		 %>
		<jsp:forward page = "d.jsp" />
	</body>
</html>