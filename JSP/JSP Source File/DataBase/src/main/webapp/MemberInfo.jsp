<%@page import="Model.Member, Model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Member Information</title>

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
	
	<h2>Member Information</h2>
	
	<div>
	<table>
		<tr>
			<td>ID</td>
			<td><%=member.getId() %></td>
		</tr>
		<tr>
			<td>PassWord</td>
			<td><%=member.getPass1() %></td>
		</tr>
		<tr>
			<td>Email</td>
			<td><%=member.getEmail() %></td>
		</tr>
		<tr>
			<td>H.P.</td>
			<td><%=member.getTel() %></td>
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
			<td><%=member.getInfo() %></td>
		</tr>
		
		<tr>
			<td colspan = "2">
				<button name = "update" onclick = "location.href='MemberUpdateForm.jsp?id=<%=member.getId()%>'">Member Update</button>
				<button name="memberDelete" onclick="location.href='MemberDeleteForm.jsp?id=<%=member.getId()%>'">Member Delete</button>
				<button name="memberList" onclick="location.href='MemberList.jsp'">Member List</button>
				<button name="memberJoin" onclick="location.href='MemberJoin.jsp'">Member Join</button>
			</td>
		</tr>
	</table>
	</div>
	
</body>
</html>