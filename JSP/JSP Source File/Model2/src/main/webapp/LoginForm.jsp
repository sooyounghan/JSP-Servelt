<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>

	<body>
	<form action = "LoginProc" method = "post">
	<table border = "1" align = "center">
		<tr height = "40">
			<td width = "120" align = "center">아이디</td>
			<td width = "180" align = "center"><input type = "text" name = "id"></td>
		</tr>
		<tr height = "40">
			<td width = "120" align = "center">비밀번호</td>
			<td width = "180" align = "center"><input type = "password" name = "pwd"></td>
		</tr>
		<tr height = "40">
			<td colspan = "2" align = "center"><input type = "submit" value = "로그인"></td>
		</tr>
	</table>	
	</form>
	</body>
</html>