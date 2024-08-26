<%@ page import = "java.util.*, java.util.stream.*, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
		<head>
			<meta charset="UTF-8">
			<title> ok </title>
		</head>
		
		<%-- Clinet의 요청을 받아서 Business Logic 처리하는 Server 측 문서  --%>
		<body>
			<h1> Login Success </h1>
			<h1> http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getRequestURI()%></h1>
			
			<%
				String userName = request.getParameter("user_name");
				String userPwd = request.getParameter("user_pwd");
				
				out.print("User Name : " + userName + "<br>");
				out.print("User Password : " + userPwd + "<br>");

			%>
		</body>
</html>