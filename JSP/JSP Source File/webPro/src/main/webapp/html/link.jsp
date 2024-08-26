<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
		<head>
		<meta charset="UTF-8">
		<title> Link Ex </title>
		
		</head>

		<body>
			<h4> Link Ex </h4>
			http a 태그 이용 : <a href = "http://www.naver.com" target = "_blank"> 네이버 </a>
			<br>
			<br>
			자바스크립트 이용 : <span onclick = "location.href = 'http://www.naver.com'"> 네이버 </span>
			자바스크립트 이용 : <span onclick = "location.href = '<%=request.getContextPath()%>/html/formEx.jsp'"> 네이버 </span>
			<br>
			자바스크립트 이용 : <span onclick = "window.open('http://www.naver.com')"> 네이버 </span>
			
		<iframe name = "inner" src = "http://www.daum.com">다음</iframe>
		</body>
</html>