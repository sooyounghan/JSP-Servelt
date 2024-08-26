<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> 현재 날짜와 시간 출력 </title>
</head>

<body>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss a");
	Date date = new Date();
%>
현재 날짜와 시간 : <%=sdf.format(date)%>
</body>
</html>