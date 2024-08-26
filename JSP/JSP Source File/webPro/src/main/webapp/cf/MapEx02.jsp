<%@ page import = "java.util.*, java.util.stream.*, java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title> HashTable </title>
	</head>
	
	<body>
		<h2> 회원 명단 </h2>
		<h3> 프로토콜://IP주소(도메인네임):Port번호/Context Path/파일명.확장자 </h3>
		<h3> http://172.30.1.33:8081/webPro/cf/MapEx02.jsp </h3>
		<% // Java Code Area
		// ArrayList 객체 생성하여 임의의 이름 5개를 저장하여 console 창에 출력
		Hashtable<String, String> hashtable = new Hashtable<>();
		
		hashtable.put("001", "abc");
		hashtable.put("002", "bcd");
		hashtable.put("003", "cde");
		hashtable.put("004", "efg");
		hashtable.put("005", "hij");;
		hashtable.put("001", "jkm");;
	
		%>

		<hr> 
		<h2> 회원명단 (HashTable 구현 클래스 사용) </h2>
		<%
		hashtable.entrySet().stream().forEach((e) -> System.out.println(e.getKey() + " : " +e.getValue())); // Stream을 이용한 Console 출력
		System.out.println();
		
		Set<String> keySet = hashtable.keySet(); // keySet 이용
		Iterator<String> iter = keySet.iterator();
		
		while(iter.hasNext()) {
			String key = iter.next();
			out.println(key + " : " + hashtable.get(key) + "<br>"); // KeySet을 이용한 key, value web에 출력
		}
		System.out.println();
		
		Collection<String> c = hashtable.values(); // values() 이용
		out.println(c + "<br>"); // Web에 value 출력
		
		Set<Map.Entry<String, String>> entrySet = hashtable.entrySet();
		Iterator<Map.Entry<String, String>> it = entrySet.iterator();
		while(it.hasNext()) {
			Map.Entry<String, String> e = (Map.Entry<String, String>)it.next();
			System.out.println(e.getKey() + " : " + e.getValue()); // Console에 출력
			out.print(e.getKey() + " : " + e.getValue() + "<br>"); // Web에 출력
		}
		%>
	</body>
</html>