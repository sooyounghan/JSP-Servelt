<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Link</title>
	</head>
	
	<body>
			<%
				String uri = request.getRequestURI();
				String contextPath = request.getContextPath();
				String path = uri.substring(contextPath.length());
				out.print(path + "</br>");
			%>
			<h4>http://localhost:8081/webPro/ch03/link.jsp</h4>
			<ul>
				<li type = "disc"><a href = "http://localhost:8081/webPro/ch03/request.jsp">request 기본객체 (절대경로)</a> </li>
				<li type = "disc"><a href = "./request.jsp">request 기본객체 (상대경로)</a> </li>
				<li type = "disc"><a href = "<%=request.getContextPath()%>/ch03/request.jsp">request 기본객체 (상대경로의 절대경로화 : request.getContextPath()/ch03/request.jsp)</a> </li>
				<li type = "disc"><a href = "><">request 기본객체 (상대경로 : request.getContextPath()/ch03/request.jsp)</a> </li>
			</ul>
	</body>
</html>