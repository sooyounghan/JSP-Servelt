<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<meta charset="UTF-8">
	<title>Member Delete Processing</title>
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
		
		.menu input {
			display:inline-block;
		}
		
	</style>

</head>
<body>

	<h2>Member Delete</h2>
	
	<div>
	<table>
	<form action = "MemberDeleteProc.jsp" method = "post">
		<tr>
			<td>ID</td>
			<td><%=request.getParameter("id")%></td>
		</tr>
		
		<tr>
			<td>PassWord</td>
			<td> <input type="password" name="pass1" size="40" required = "required"></td>
		</tr>
		
		<tr class = "menu">
			<td colspan="2">
				<input type="hidden" name = "id" value="<%=request.getParameter("id")%>">
				<input type="submit" value="Member Delete"></form>
				<button name="memberList" onclick="location.href='MemberList.jsp'">Member List</button>
			</td>
		</tr>	
	</table>
	</div>
</body>
</html>