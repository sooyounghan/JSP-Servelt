<%@page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Board Update Processing</title>
</head>

<body>

<jsp:useBean id="board" class="Board.Board">
	<jsp:setProperty name="board" property="*"/>
</jsp:useBean>

<%
	BoardDAO boardDAO = new BoardDAO();
	
	String password = boardDAO.getPass(board.getBoard_num());
	
	if(board.getContent_password().equals(password)) {
		boardDAO.updateBoard(board);
		
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