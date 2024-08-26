<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Member LogOut</title>
</head>

<body>
<%
	session.invalidate();

	response.sendRedirect("RentCarMain.jsp");
%>
</body>
</html>