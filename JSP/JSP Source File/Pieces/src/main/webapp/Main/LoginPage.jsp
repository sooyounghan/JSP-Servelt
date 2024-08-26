<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title> 조각집 </title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/LoginPage.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	</head>
	<body>
	<div class="background">
		<form action = "<%=request.getContextPath()%>/Main/LoginProc.jsp" method = "post">
		<div class = "login">
		<div class = "login_message">
			<a href = "<%=request.getContextPath()%>/Main/Describe.jsp" id = "main_describe">조각집</a>
		</div>
		<div class = "id_section">
			<div class = "icon_id">방문자</div>
			<div class = "input_id">
				<input type = "text" id = "input_id_text" name = "id" placeholder = "방문자 이름">
			</div>
		</div>
		
		<div class = "pwd_section">
			<div class = "icon_pwd">암 호</div>
				<input type = "password" id = "input_pwd_text" name = "pwd" placeholder = "암 호">
			<div class = "input_pwd"></div>
			<a href = "<%=request.getContextPath()%>/Main/Join.jsp" id = "join_user">방문자가 되는 방법</a>
			<a href = "<%=request.getContextPath()%>/Main/SearchUser.jsp" id = "user_search">방문자 기록 찾기</a>
		</div>
				<%
				if(((String)session.getAttribute("error_msg2")) == null) {
					
				} else {
				%>
						<p id = "error_msg"><%=session.getAttribute("error_msg2")%></p>
				<%
					session.setAttribute("error_msg2", null);
					}
				%>
				<input type = "submit" id = "submit" name = "submit" value = "기록 남기기">
				<img src="/Pieces/imgs/palette.png" class = "palette"/>
				<p class="today">"인간의 이타성은 그것마저도 이기적인 토대 위에 있다."</p>
		</div>	
		</form>
	</div>
	</body>
</html>