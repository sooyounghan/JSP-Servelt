<%@page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Board Write Processing</title>
</head>

<body>

<!-- 게시글에 작성한 데이터를 불러옴 -->
<jsp:useBean id="board" class="Board.Board">
	<jsp:setProperty name="board" property="*"/>
</jsp:useBean>

<%
	// DB쪽으로 데이터 전송
	BoardDAO boardDAO = new BoardDAO();

	// DB에 데이터 삽입
	boardDAO.insertBoard(board);
	
	// 게시글 저장이 완료되면, BoardList.jsp로 이동
	response.sendRedirect("BoardList.jsp");
%>
</body>
</html>