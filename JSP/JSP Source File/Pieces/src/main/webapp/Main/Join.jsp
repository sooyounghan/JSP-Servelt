<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title> 조각집 </title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/Join.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	</head>
	<body>
	<div class="background">
		<form action = "<%=request.getContextPath()%>/Main/JoinProc.jsp" method = "post">
		<div class = "join">
			<div class = "join_margin"></div>
			<div class = "id_section">
				<div class = "icon_id">방문자 이름 </div>
				<div class = "input_id">
					<input type = "text" id = "input_id_text" name = "id" placeholder = "방문자 이름" required = "required">
				</div>
			</div>
		
			<div class = "pwd_section">
				<div class = "icon_pwd">암 호</div>
				<div class = "input_pwd">
					<input type = "password" id = "input_pwd_text" name = "pwd" placeholder = "암 호" required = "required">
				</div>
			</div>
		
			<div class = "repwd_section">
				<div class = "icon_repwd">암호 확인</div>
				<input type = "password" id = "input_repwd_text" name = "re_pwd" placeholder = "암 호" required = "required">
			</div>
			
			<div class = "birth_section">
				<div class = "icon_birth">생 일</div>
					<input type = "date" id = "birthday" name = "birthday">
			</div>
			
			<div class = "email_section">
				<div class = "icon_email">이메일</div>
					<input type = "email" id = "email" name = "email">
			</div>
			<div>
				<input type = "submit" id = "submit" name = "submit" value = "기록자 되기">
				<input type = "button" id = "back" name = "back" value = "돌아가기" onclick = "location.href='LoginPage.jsp'">
			</div>
				<%
				if(((String)session.getAttribute("error_msg1")) == null) {
					} else {
				%>
						<p id = "error_msg"><%=session.getAttribute("error_msg1")%></p>
				<%
					session.setAttribute("error_msg1", null);
					}
				%>
		</div>	
		</form>
	</div>
	</body>
</html>