<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
	<%-- 로그인 전 화면 --%>
	<%
		if(session.getAttribute("AUTH_USER_ID") == null) {
	%>	
		<h1>Main Page(index.jsp)</h1>
		http://localhost:8081<%=request.getContextPath()%>/index.jsp
		<ul>
			<li><a href = "<%=request.getContextPath()%>/ch10/loginForm.jsp">로그인 폼</a></li>
			<li><input button = "button" value = "회원가입" id = "user_join"></li>
		</ul>	
	<%
		} else {
	%> 
	<%-- 로그인 후 화면 --%>
			<li><%=(String)session.getAttribute("AUTH_USER_ID")%>님 어서오세요.
			<%=request.getContextPath() %>
			<a href = "<%=request.getContextPath()%>/ch10/logOut.jsp">Log-out</a></li>
	<%
		}
	 %>
	</body>
</html>