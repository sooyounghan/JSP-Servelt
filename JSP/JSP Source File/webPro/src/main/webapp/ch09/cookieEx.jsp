<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
		<head>
			<meta charset="UTF-8">
			<title> Cookie </title>
		</head>
		<!-- 웹 서버에서 Cookie 생성 후 response에 담아 client에게 전달 -->
		<body>
		<%
		// 1.Cookie 생성
		Cookie cookie = new Cookie("ID", "java");
		// 2. Path 지정 (Root DIrectory로 설정, 미설정 시 현재 쿠키를 생성한 path로 지정)
		cookie.setPath("/");
		// 3. MaxAge 설정 (하루 단위로 지정, 0이면 쿠키 삭제 의미)
		cookie.setMaxAge(60 * 60 * 24);
		// 4. 만들어진 Cookie를 Client에게 전달
		response.addCookie(cookie);
		
		Cookie name = new Cookie("NAME", "han");
		// cookie의 특정 값을 변경 가능
		name.setValue("nah");
		response.addCookie(name);
		%>
		<a href = "<%=request.getContextPath()%>/ch09/cookieEx02.jsp">Go</a>
		<p> 쿠키 생성 완료 </p>
		</body>
</html>