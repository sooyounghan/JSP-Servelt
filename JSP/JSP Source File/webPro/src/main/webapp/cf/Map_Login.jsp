<%@ page import="java.util.*"%> <!-- Map, Scanner를 위한 Package import -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

	<head>
		<meta charset="UTF-8">
		<title> 로그인 구현 </title>
	</head>

	<body>
		<h2> Login 처리 화면 </h2>
		
		<!-- html 주석문 -->
		<%-- jsp 주석문 
			1. Client의 Data를 입력한 내용을 받아서 처리하는 서버측 페이지
		    2. Client가 전송한 Data를 받아 회원 정보를 비교한 후 결과 출력--%>
		
		<% // Login 처리 코드
			Map<String, String> user = new Hashtable<String, String>();
		
			user.put("aid", "123");
			user.put("bid", "1234");
			user.put("cid", "12345");
			user.put("did", "123456");
			
			String id = request.getParameter("user_id"); // get 방식으로 넘어오는 데이터를 request 내장 객체의 getParameter() 메서드를 통해 ID 저장
			String password = request.getParameter("user_pw"); // get 방식으로 넘어오는 데이터를 request 내장 객체의 getParameter() 메서드를 통해 Password 저장
				
			if(id.equals("")) { // ID 미입력
				out.print("아이디를 입력하지 않았습니다. ");
				out.print("다시 아이디를 입력해주시길 바랍니다. ");
			}
			
			else {
				if(user.containsKey(id)) { // ID가 존재하는 경우
					if(password.equals("")) { // 비밀번호를 입력하지 않은 경우
						out.print("비밀번호를 입력하지 않았습니다. "); 
						out.print("다시 입력해주시길 바랍니다. ");
					}
					
					else { // 비밀번호 입력한 경우
						if(user.get(id).equals(password)) { // ID와 비밀번호가 일치하는 경우
							out.print("로그인에 성공했습니다. ");
						}
						
						else if(!password.equals(user.get(id))){ // 비밀번호가 일치하지 않는 경우
							out.print("로그인에 실패했습니다. ");
							out.print("사유 : 비밀번호가 틀립니다.");
						}
					}
				}
				
				else if(!user.containsKey(id)){ // ID가 없는 경우
					out.print("로그인에 실패했습니다. ");
					out.print("사유 : ID가 존재하지 않거나 틀립니다.");
				}
			}
		%>

		<h3> 프로토콜://IP주소(도메인네임):Port번호/Context Path/파일명.확장자 (= 프로토콜://IP주소(도메인네임):Port번호/Directory(경로))</h3>
		<h3> http://172.30.1.33:8081/webPro/cf/Map_Login.jsp </h3>
		
		<a href = "http://172.30.1.33:8081/webPro/cf/LoginForm.jsp"> 로그인 페이지로 이동 (절대 경로) </a> <br>
		<a href = "LoginForm.jsp"> 로그인 페이지로 이동 (상대 경로 1) </a> <br>
		<a href = "./LoginForm.jsp"> 로그인 페이지로 이동 (상대 경로 2) </a> <br>
		<a href = "../cf/LoginForm.jsp"> 로그인 페이지로 이동 (상대 경로 3) </a> <br>
	</body>
	
</html>