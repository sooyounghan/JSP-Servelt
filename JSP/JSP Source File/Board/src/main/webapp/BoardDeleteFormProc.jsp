<%@page import="Board.BoardDAO, Board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Board Delete Form Processing</title>
</head>

<body>
	<%
		String password = request.getParameter("content_password");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		BoardDAO boardDAO = new BoardDAO();
		
		String password_content = boardDAO.getPass(board_num);
		
		if(password_content.equals(password)) {
			boardDAO.deleteBoard(board_num);
			
			response.sendRedirect("BoardList.jsp");
		} else {
	%>
		<script>
			alert("Not Match Password!");
			history.go(-1);
		</script>
	<%
		}
	%>
</body>
</html>