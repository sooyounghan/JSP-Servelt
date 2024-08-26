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
		session.invalidate(); // session의 정보를 유지하고 싶지 않다면 실행 (로그아웃 의미에서는 이 부분이 반드시 포함)
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
		rd.forward(request, response);
		out.print("Log-Out");
		%>	
		<h4>로그아웃 기능 구현을 담당하는 LogoutHandler 작업</h4>
	</body>
</html>