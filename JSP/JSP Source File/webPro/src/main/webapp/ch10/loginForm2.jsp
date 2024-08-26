<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title> 로그인 </title>
	</head>

	<body>
		<a href = "<%=request.getContextPath()%>/index.jsp">Index</a>
		<!--  Model 내용 : ${errMSG} --> <br>
		<c:out value = "${model}"/>
		<c:if test = "${not empty errMSG}">
			<c:out value = "${errMSG}"/>
			<br>
		</c:if>
		
		<fieldset style = "width:400px;height:150px">
		<legend> Login </legend>
		<form action = "<%=request.getContextPath() %>/ch10/loginOk2.jsp" method = "post" id = "loginForm" name = "loginForm">
		
		<div>
			<div>
			아이디 <input type = "text" id = "id" name = "id" value = "">
			</div>
			<div>
			비밀번호 : <input type = "password" id = "password" name = "password">
			</div>		
			<div>
			<input type = "submit" name = "submit" value = "Login">
			<input type = "reset" name = "reset" value = "Cancel">
			</div>
			
		</form>
		</fieldset> 
	</body>
</html>