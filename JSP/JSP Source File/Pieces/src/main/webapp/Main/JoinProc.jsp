<%@page import="org.apache.catalina.connector.Response"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Join Processing</title>
	</head>

	<body>
	<%
		if(request.getParameter("id").equals((String)session.getAttribute("id"))) {
			session.setAttribute("error_msg1", "이미 방문하신 적이 있습니다.");
			
			RequestDispatcher rd = request.getRequestDispatcher("Join.jsp");
			rd.forward(request, response);
		} else {
			if(!request.getParameter("pwd").equals(request.getParameter("re_pwd"))) {
				session.setAttribute("error_msg1", "암호가 틀린 것 같아요.");
				
				RequestDispatcher rd = request.getRequestDispatcher("Join.jsp");
				rd.forward(request, response);
	%>
			<Script>
			history.back();
			</Script>	
	<%	
			} else {
				session.setAttribute("error_msg1", "");
				session.setAttribute("id", request.getParameter("id"));
				session.setAttribute("pwd", request.getParameter("pwd"));
				session.setAttribute("birthday", (String)request.getParameter("birthday"));
				session.setAttribute("email", request.getParameter("email"));
				
				response.sendRedirect("./Diary.jsp");
			}
		}
	%>
		
	</body>
</html>