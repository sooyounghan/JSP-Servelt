<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.util.*, java.util.stream.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title> list </title>
	</head>
	
	<body>
		<h2> 회원 명단 </h2>
		<h3> 프로토콜://IP주소(도메인네임):Port번호/Context Path/파일명.확장자 </h3>
		<h3> http://172.30.1.33:8081/webPro/cf/listEx01.jsp </h3>
		<% // Java Code Area
		// ArrayList 객체 생성하여 임의의 이름 5개를 저장하여 console 창에 출력
		List<String> nameList = new ArrayList<String>();
		
		nameList.add("A");
		nameList.add("B");
		nameList.add("C");
		nameList.add("D");
		nameList.add("E");
		
		nameList.stream().forEach((name) -> System.out.print(name));
		System.out.println();
		Stream<String> name = nameList.stream();
		name.forEach(System.out::print);
		
		%>
		
		<%=nameList%><br>

		<hr> 
		<h2> 회원명단 (ArrayList 구현 클래스 사용) </h2>
		<%
		for(int i = 0; i < nameList.size(); i++) {
			String str = nameList.get(i);
			%>
			<%=str %><br>
		<%	
		}
		%>
	</body>
</html>