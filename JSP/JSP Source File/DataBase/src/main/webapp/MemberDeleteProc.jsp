<%@page import="Model.Member, Model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Member Delete Processing</title>
</head>
<body>

<!-- useBean 이용 Member 객체를 선언 후, UpdateForm에 작성된 정보 받아옴 -->
<jsp:useBean id = "member" class = "Model.Member">
	<jsp:setProperty name = "member" property = "*"/>
</jsp:useBean>

<%
	MemberDAO mDAO = new MemberDAO();
	
	// Password 값 받아오기
	String password = mDAO.getPass(member.getId());
	
	// DB에 저장된 Password와 입력된 Password 비교
	if(member.getPass1().equals(password)) {
		// 회원 정보 삭제 (아이디만을 비교해서 삭제)
		mDAO.deleteMember(member.getId());
		
		// 완료되면, MemberList 페이지로 이동
		response.sendRedirect("MemberList.jsp");
		
	} else {
		// 일치하지않으면, 오류창 발생 후 전 페이지로 이동
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