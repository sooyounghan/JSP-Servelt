<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
		<head>
			<meta charset="UTF-8">
			<title> Form Tag </title>
		</head>
		
		<body>
			<h3> Form 요소 </h3>
			<h4> http://172.30.1.36:8081/webPro/ch03/form.jsp </h4>
			<h4> Context Path : <%=request.getContextPath() %></h4>
			<h4> URI : <%=request.getRequestURI() %></h4>
			<h4> URI - Context Path : <%=request.getRequestURI().substring(request.getContextPath().length()) %></h4>
			<h4> Server Port : <%=request.getServerPort()%></h4>
			
			<hr>
			
			<form name = "login" action = "http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/ch03/ok.jsp" method = "get">
				<li> Name : <input type = "text" name = "userName" id = "userName" value = "dummy_name" required = "required"> </li>
				<li> Password : <input type = "password" name = "userPwd" id = "userPwd" value = "dummy_pwd" required = "required"> </li>
				<li> SNS : 
				<!-- name에 snsYN을 중복 적용을 통해 수신 허용, 불허했는지에 대한 파라미터 값을 얻기 가능 // name은 중복 가능하지만. id는 중복 불가 -->
					<input type = "radio" name = "snsYN" id = "snsY" value = "Y" checked = "checked"> 수신허용
					<input type = "radio" name = "snsYN" id = "snsN" value = "N"> 수신불허 
				</li>
				
				<!-- 현재 같은 이름 name에 모두 선택 시 봄, 여름, 가을, 겨울이 들어감 = getParameterValues()를 하면 모두 출력 -->
				<li> 좋아하는 계절 : 
					<input type = "checkbox" name = "season" id = "spring" value = "spring" checked = "checked"> 봄
					<input type = "checkbox" name = "season" id = "summer" value = "summer"> 여름
					<input type = "checkbox" name = "season" id = "autumn" value = "autumn"> 가을
					<input type = "checkbox" name = "season" id = "winter" value = "winter"> 겨울</li>
					
				<input type = "submit" name = "submit" id = "submit" value = "로그인"> 
				<input type = "reset" name = "reset" id = "reset" value = "취소">
			</form>
		</body>
</html>