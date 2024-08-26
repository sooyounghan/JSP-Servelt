<%@ page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

<body>

<jsp:useBean id="board_reply" class="Board.Board">
	<jsp:setProperty name="board_reply" property="*"/>
</jsp:useBean>

	<%
		BoardDAO boardDAO = new BoardDAO();
		
		boardDAO.reWriteBoard(board_reply);
		
		response.sendRedirect("BoardList.jsp");
	%>
</body>
</html>