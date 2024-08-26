<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<h3> out 내장 객체</h3>
		<%
		out.println("개행 출력");
		out.println("줄바꿈 출력");
		out.print("그대로 출력");
		out.newLine();
		out.print("그대로 출력");
		%>
	</body>
</html>