<%@page import="Model.Member, Model.MemberDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Member Join Processing</title>
</head>

<body>
<%
String[] hobby = request.getParameterValues("hobby"); // Hobby : Multi-choice, 배열 단위
	
	String text_hobby = ""; // Hobby를 하나의 String으로 결합
	for(int i = 0; i < hobby.length; i++) {
		text_hobby += hobby[i] + " ";
	}
%>

<!-- useBean : MemberJoin Data 저장 -->
<jsp:useBean id = "member" class = "Model.Member">
	<jsp:setProperty name = "member" property ="*"/>
</jsp:useBean>

<%
	member.setHobby(text_hobby); // 하나의 String으로 결합된 Hobby를 Member 객체에 저장

	// 1. 데이터베이스 객체 생성
	MemberDAO mDAO = new MemberDAO();
		
	// 2. DB에 데이터 삽입
	mDAO.insertMember(member);
	
	// 3. 회원 가입이 되었으면, 회원 정보 페이지로 이동 시킴
	response.sendRedirect("MemberList.jsp");
%>
</body>
</html>