<%@page import="RentCar.RentCarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Member Login Processing</title>
</head>

<body>
	<%
		String id = request.getParameter("id");
		String password = request.getParameter("pwd");
		
		RentCarDAO rentCarDAO = new RentCarDAO();
		
		// 해당 회원의 여부를 숫자로 확인
		int result = rentCarDAO.getMember(id, password);
		
		if(result == 0) {
	%>			
			<script>
				alert("Not Match ID or Password");
				location.href="RentCarMain.jsp?center=MemberLogin.jsp"
			</script>
	<%
		} else {
			session.setAttribute("id", id);
			response.sendRedirect("RentCarMain.jsp");
		}
	%>
	
</body>
</html>