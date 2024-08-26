<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Login Processing</title>
	</head>

	<body>
	<%		
		if(request.getParameter("id").equals((String)session.getAttribute("id"))) {
			if(request.getParameter("pwd").equals((String)session.getAttribute("pwd"))) {
				session.setAttribute("error_msg2", null);
				response.sendRedirect("./Diary.jsp");
			}
			else {
				session.setAttribute("error_msg2", "방문자명이나 암호가 틀린 것 같아요. 다시 한 번 확인해주세요.");
				
				RequestDispatcher rd = request.getRequestDispatcher("LoginPage.jsp");
				rd.forward(request, response);	
			}
		}
		else {
			session.setAttribute("error_msg2", "방문자명이나 암호가 틀린 것 같아요. 다시 한 번 확인해주세요.");
						
			RequestDispatcher rd = request.getRequestDispatcher("LoginPage.jsp");
			rd.forward(request, response);
		}
	%>
		<Script>
		history.back();
		</Script>	
	</body>
</html>