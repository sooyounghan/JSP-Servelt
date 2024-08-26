<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

	<head>
		<meta charset="UTF-8">
		<title> 로그인 화면 </title>
	</head>

	<body>
		<xmp>
			<a href = ""> Text 또는 이미지 등 가능한 형태 </a>
		</xmp>
		
		<h2> 로그인 화면(LoginForm.jsp) </h2>
		
		<form name = "Login Form" action = "./Map_Login.jsp", method = "get">
			아이디  : <input type = "text" name = "user_id" value = "ID" required = "required"><br>
			비밀번호 : <input type = "password" name = "user_pw" value = "1234" required = "required"><br><br>
			<input type = "submit" value = "로그인">
			<input type = "reset" value = "취소">
		</form>
		<br>
		<hr>
		<br>
		
		<pre> 
			절대 경로
			현재 문서 URL : http://172.30.1.33:8081/webPro/cf/LoginForm.jsp 
			이동 문서 URL : http://172.30.1.33:8081/webPro/cf/Map_Login.jsp
			
			상대 경로
			- . : 현재 Directory
			- .. : 상위 Directory
			현재 문서 URL : http://172.30.1.33:8081/webPro/cf/LoginForm.jsp 
			이동 문서 URL : 1. Map_Login.jsp
			              2. ./Map_Login.jsp (.은 현재 디렉토리 = 여기서는 cf Directory)
			              3. ../cf/Map_Login.jsp (..은 상위 디렉토리 = 여기서는 webPro)
		</pre>
		<hr>
		
		<a href = "http://172.30.1.33:8081/webPro/cf/Map_Login.jsp"> 절대 경로 : Map_Login</a> <br>
		
		<a href = "Map_Login.jsp"> 상대 경로 1 : Map_Login</a> <br>
		<a href = "./Map_Login.jsp"> 상대 경로 2  : Map_Login</a><br>
		<a href = "../cf/Map_Login.jsp"> 상대 경로 3 : Map_Login</a>
	</body>
	
</html>