<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String name = request.getParameter("a");
String[] hobby = request.getParameterValues("c");

out.print(name);

if(hobby != null && hobby.length > 0) {
	for(int i = 0; i < hobby.length; i++) {
		out.println(hobby[i] + " ");
	}
}
%>
</body>
</html>