<%@ page import="RentCar.RentCarDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

<body>

<%
	String id = request.getParameter("id");
	String reserve_day = request.getParameter("reserve_day");
	
	RentCarDAO rentCarDAO = new RentCarDAO();
	
	rentCarDAO.reserveCarRemove(id, reserve_day);
	
	response.sendRedirect("RentCarMain.jsp");
%>
</body>
</html>