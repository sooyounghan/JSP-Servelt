<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 야호 출력</title>
</head>
<body>
	<c:forEach var = "cnt" begin = "1" end = "10">
	<%
		System.out.println("야호 ");
	%>
	</c:forEach>
</body>
</html>