<%@ page import = "java.util.*, java.util.stream.*, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
		<head>
			<meta charset="UTF-8">
			<title> ok </title>
		</head>
		
		<%-- Clinet의 요청을 받아서 Business Logic 처리하는 Server 측 문서  --%>
		<body>
			<h1> Login Sucess </h1>
			<h1> http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getRequestURI()%></h1>
			
			<%
				String userName = request.getParameter("userName");
				String userPwd = request.getParameter("userPwd");
				String userSns = request.getParameter("snsYN");
				String[] userSeason = request.getParameterValues("season");
				
				out.print("User Name : " + userName + "<br>");
				out.print("User Password : " + userPwd + "<br>");
				out.print("User SNS : " + userSns + "<br>");
				out.print("User Season : " + Arrays.toString(userSeason) + "<br>");

/* 				try {
					Stream.of(userSeason).forEach((season) -> out.print(season));
				} catch(Exception e) {
					out.print("예외 발생");
				} */

				out.print("User Season : ");
				if(userSeason != null) {
					for(String season : userSeason) {
						out.print(season + " ");
					}
					out.println("<br>");
				}
				else {
					out.print("미선택");
				}
			%>
			<%
				Enumeration<String> parameter = request.getParameterNames();
				
				out.print("Parameter : ");
				while(parameter.hasMoreElements()) {
					String element = parameter.nextElement();
					out.print(element + " ");
				}	
				
				out.print("<br>");
				out.print("<br>");
				
				Map<String, String[]> parameter_map = request.getParameterMap();
				
				Set<Map.Entry<String, String[]>> entrySet = parameter_map.entrySet();
				Iterator<Map.Entry<String, String[]>> iterator = entrySet.iterator();
				
				while(iterator.hasNext()) {
					Map.Entry<String, String[]> map_element = iterator.next();
					out.print("Paramter : " + map_element.getKey() + " -  " + Arrays.toString(map_element.getValue()) + "<br>");
				}
			%>
		</body>
</html>