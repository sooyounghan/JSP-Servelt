<%@ page import = "java.util.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<a href = "<%=request.getContextPath()%>/index.jsp">Index</a>
		<h4> Client가 보낸 ID, PW을 받아 처리하는 Server 측 페이지 </h4>
		<%
			// MVC 패턴 : Client - 요청(Request) - Sever (Server는 요청에 따라 Business Logic 수행) : Controller 호출
			// Controller의 역할
			//	1. getParameter
			String id = (String)request.getParameter("id");
			String pwd = (String)request.getParameter("password");
			//  2. 비즈니스 로직 수행 (Service <>-> DAO <>-> DB) [회원 DB의 ID를 java / PW를 qwert라 하고, 이를 모두 만족하면 세션에 정보를 저장]
			// 둘중 하나라도 불일치하면, ID 또는 PWD가 불일치함을 표시
			String db_id = "java";
			String db_pwd = "qwert";

			//	3. Model - Session 이용
			if(db_id.equals(id) && db_pwd.equals(pwd)) {
				session.setAttribute("AUTH_USER_ID", (String)request.getParameter("id"));
				session.setAttribute("AUTH_USER_PWD", (String)request.getParameter("password")); // Session에서 비밀번호를 포함하지 않는 것이 웹 보안 관행
			%>
			<ol>
 			<li> session에 저장된 ID : <%=session.getAttribute("AUTH_USER_ID") %></li>
 			<li> <%=session.getAttribute("AUTH_USER_ID")%>님 <a href = "<%=request.getContextPath() %>/index.jsp">Log-out</a></li> <!-- ../index.jsp -->
 			</ol>
			<% 
			} 	
			else {
				//	3. Model - request 이용
				//	4. View 지정
				request.setAttribute("errMSG", "ID or PassWord Mismatch");
				RequestDispatcher rd = request.getRequestDispatcher("loginForm2.jsp"); // 2번. forward : 본래 요청 주소 존속 (요청 주소 : loginForm.jsp)
				rd.forward(request, response);
				System.out.println(request.getAttribute("errMSG"));

				// redirect의 경우 model은 session으로 전달 
				//session.setAttribute("errMSG", "ID or PassWord Mismatch");
				//response.sendRedirect(request.getContextPath()+"/ch10/loginForm.jsp"); //1번. redirect : 본래 요청 주소 소멸  마지막 응답 주소 (주소 : loginForm.jsp)
			}
			
			long ct = session.getCreationTime();
			Date session_date = new Date(ct);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
	 	%>
 		<ul>
 			<li> session ID 출력 : <%=session.getId() %></li>
 			<li> session 생성 시간 : <%=session.getCreationTime() %></li>
 			<li> session 생성 시간 : <%=session_date %></li>
 			<li> session 생성 시간 : <%=sdf.format(session_date) %></li>
 			<li> session 접근 시간 : <%=sdf.format(new Date(session.getLastAccessedTime())) %> </li>
 			<li> request ID : <%=request.getParameter("id") %>
 		</ul>
 		
	</body>
</html>