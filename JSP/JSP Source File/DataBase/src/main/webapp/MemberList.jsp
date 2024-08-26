<%@ page import="Model.Member,Model.MemberDAO, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Member List</title>
	
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
			height:150px;
			text-align:center;
			border:1px solid black;
		}
		
		td, tr {
			border:1px solid black;
			font-size:13px;
		}
		
		a {
			color:black;
			font-weight:600;
			text-decoration:none;
		}
	
	</style>
	
</head>

<body>

	<!-- 1. DB에서 모든 회원의 정보
		 2. 화면에 회원정보 출력 -->
	<%
	MemberDAO mDAO = new MemberDAO();
	
	// ArrayList 또는 Vector 이용
	List<Member> memberList = mDAO.allMemberList();
	
	%>
	
	<h2>All Member Information</h2>
	
	<div>
	<table>
		<tr>
			<td>ID</td>
			<td>Password</td>
			<td>Email</td>
			<td>H.P.</td>
		</tr>
		
	<%
	
	for(int i = 0; i < memberList.size(); i++) {
		Member member = memberList.get(i);

	%>
		<tr>
			<td>
			<!-- 회원 ID를 클릭하면, 그 회원의 정보 페잊지로 이동 -->
			<a href = "MemberInfo.jsp?id=<%=member.getId()%>"><%=member.getId()%></a></td>
			<td><%=member.getPass1()%></td>
			<td><%=member.getEmail()%></td>
			<td><%=member.getTel()%></td>
		</tr>
		<%
		
	}
	
		%>
		
	</table>
	</div>
		
</body>
</html>