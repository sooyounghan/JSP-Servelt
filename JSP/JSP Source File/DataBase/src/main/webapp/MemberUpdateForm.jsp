<%@page import="Model.Member, Model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<meta charset="UTF-8">
	<title>Member Update</title>
	<style>
	
		h2 {
		display:flex;
		flex-direction:row;
		justify-content:center; 
		align-items:center;
		}
		
		div {
			display:flex;
			flex-direction:row;
			justify-content:center; 
			align-items:center;
		}
		
		table {
			width:600px;
			height:300px;
			text-align:center;
			border:1px solid black;
		}
		
		td, tr {
			border:1px solid black;
			font-size:13px;
		}
		
		.menu input {
			display:inline-block;
		}
		
	</style>

</head>
<body>

	<%
	// 1. MemberList에서 통해 전달받은 ID 값 받기
	String id = request.getParameter("id");
	
	// 2. 데이터베이스에서 한 회원의 정보를 가져옴
	MemberDAO mDAO = new MemberDAO();
	
	// 3. 해당하는 ID의 회원 정보 반환
	Member member = mDAO.oneMemberList(id); 
	%>
	<!-- 3. Table 태그를 이용해 화면에 회원의 정보 출력 -->
	
	<h2>Member Update</h2>
	
	<div>
	<table>
	<form action = "MemberUpdateProc.jsp" method = "post">
		<tr>
			<td>ID</td>
			<td><%=member.getId() %></td>
		</tr>
		<tr>
			<td>PassWord</td>
			<td> <input type="password" name="pass1" size="40" required = "required"></td>
		</tr>
		<tr>
			<td>Email</td>
			<td><input type="email" name="email" value="<%=member.getEmail()%>" size="40" placeholder="Ex) abc@naver.com"></td>
		</tr>
		<tr>
			<td>H.P.</td>
			<td><input type="tel" name="tel" size="40" value="<%=member.getTel()%>" placeholder="Ex) 010-1234-5678"></td>
		</tr>
		<tr>
			<td>Hobby</td>
			<td><%=member.getHobby() %></td>
		</tr>
		<tr>
			<td>Job</td>
			<td><%=member.getJob() %></td>
		</tr>
		<tr>
			<td>Age</td>
			<td><%=member.getAge() %></td>
		</tr>
		<tr>
			<td>Info.</td>
			<td><textarea rows="2" cols="40" name="info" placeholder = "Write Your Information."><%=member.getInfo()%></textarea></td>
		</tr>
		
		<tr class = "menu">
			<td colspan="2">
				<input type="hidden" value="<%=member.getId()%>">
				<input type="submit" value="Member Update"></form>
				<button name="memberList" onclick="location.href='MemberList.jsp'">Member List</button>
			</td>
		</tr>	
	</table>
	</div>
</body>
</html>