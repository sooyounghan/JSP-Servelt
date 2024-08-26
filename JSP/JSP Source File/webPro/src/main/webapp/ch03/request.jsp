<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<title>request 객체</title>
		
	</head>
	
	<body>
		<h3>request 객체</h3>
		<h3>http://localhost:8081/webPro/ch03/request.jsp</h3>
		<hr>
		<%
			String uri = request.getRequestURI();
			String contextPath = request.getContextPath();
			
			out.print(uri.substring(contextPath.length() + 1));
		%>
		<li> request.getRemoteAddr() : <%=request.getRemoteAddr() %> </li>
		<li> request.getContentLength() : <%=request.getContentLength() %> </li>
		<li> request.getCharacterEncoding() : <%=request.getCharacterEncoding() %> </li>
		<li> request.getContentType() : <%=request.getContentType() %> </li>
		<li> request.getProtocol() : <%=request.getProtocol() %> </li>
		<li> request.getMethod() : <%=request.getMethod() %> </li>
		<li> request.getRequestURI() : <%=request.getRequestURI() %> </li>
		<li> request.getContextPath() : <%=request.getContextPath() %> </li>
		<li> request.getServerName() : <%=request.getServerName() %> </li>
		<li> request.getServerPort() : <%=request.getServerPort() %> </li>
	</body>
</html>