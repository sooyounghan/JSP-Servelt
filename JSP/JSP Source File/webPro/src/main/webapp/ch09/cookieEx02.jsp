<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
		<head>
			<meta charset="UTF-8">
			<title> Cookie Ex </title>
		</head>
		<!-- 웹 서버에서 Cookie 생성 후 response에 담아 client에게 전달 -->
		<body>
		<%
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null && cookies.length > 0) { // 유효성 검사 : Client의 쿠키 삭제 여부
			// 쿠키는 존재하지만, Server가 원하는 정보가 없을 수 있음
			
			for(int i = 0; i < cookies.length; i++) {
				Cookie temp = cookies[i];
				
				if(cookies[i].getName().equals("nAME")) {
					out.print(cookies[i].getName() + " : " + cookies[i].getValue() + "<br>");
				}
				else if(cookies[i].getName().equals("ID")) {
					out.print(cookies[i].getName() + " : " + cookies[i].getValue() + "<br>");
				}
				else if(cookies[i].getName().equals("JSESSIONID")) continue;
				
				else {
					out.print("Cookie" + cookies[i].getName() + " isn't exist." + "<br>");
				}

				// out.print(cookies[i].getName() + " : " + cookies[i].getValue() + "<br>");
			}			
		}
		else {
			out.print("Not Cookie!");
		}
		%>
		<p> 쿠키 생성 완료 </p>
		</body>
</html>