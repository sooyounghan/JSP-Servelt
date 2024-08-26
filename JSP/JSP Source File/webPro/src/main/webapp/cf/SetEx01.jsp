<%@ page import = "java.util.*, java.util.stream.*, java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title> Set </title>
	</head>
	
	<body>
		<h2> 회원 명단 </h2>
		<h3> 프로토콜://IP주소(도메인네임):Port번호/Context Path/파일명.확장자 </h3>
		<h3> http://172.30.1.33:8081/webPro/cf/SetEx01.jsp </h3>
		<% // Java Code Area
		// ArrayList 객체 생성하여 임의의 이름 5개를 저장하여 console 창에 출력
		Set<String> hashSet = new HashSet<>();
		
		hashSet.add("라");
		hashSet.add("가");
		hashSet.add("다");
		hashSet.add("마");
		hashSet.add("바");
		hashSet.add("바");
		
		hashSet.stream().forEach((name) -> System.out.print(name));
		System.out.println();
		Stream<String> name = hashSet.stream();
		name.forEach(System.out::print);
		System.out.println();
		
		%>
		
		<%=hashSet%><br>

		<hr> 
		<h2> 회원명단 (HashSet 구현 클래스 사용) </h2>
		<%
		Iterator<String> it = hashSet.iterator();
		while(it.hasNext()) {
			String str = it.next();
			System.out.print(str + " "); // Console에 출력
			out.print(str + "<br>"); // 브라우저에 출력 (줄 바꿈 : "<br>")
		}
		%>
	</body>
</html>