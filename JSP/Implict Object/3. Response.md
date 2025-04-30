-----
### response 기본 객체 (javax.servlet.http.HttpServletResponse)
-----
1. response  내장 객체
	- request 기본 객체와 반대의 기능 수행
	- 웹 브라우저에 보내는 응답 정보를 담음
	- 헤더 정보 입력, 리다이렉트 하기와 같은 기능 제공
	- 사용자의 요청을 처리한 결과를 서버에서 웹 브라우저로 전달하는 정보를 저장하고, 서버는 응답 헤더와 요청 처리 결과 데이터를 웹 브라우저로 보냄
	- JSP 컨테이너는 서버에서 웹 브라우저로 응답하는 정보 처리를 위해 javax.servlet.http.HttpServletResponse 객체 타입의 내장 객체를 사용해 사용자 요청에 응답

 2. 페이지 이동 (Redirection)
	- 사용자가 새로운 페이지를 요청할 때 같이 페이지를 강제 이동하는 것
	- 서버는 웹 브라우저에 다른 페이지로 강제 이동하도록 redirection 메서드 제공
	- 페이지 이동 시 문자 인코딩을 알맞게 설정해야함
<div align = "center">
<img src = "https://github.com/sooyounghan/JAVA/assets/34672301/db886e28-d96e-47b2-ba4f-2fca5ce4690b">
</div>

3. 쿠키 추가 : void addCookie(Cookie cookie)
   : Clinet에게 쿠키 정보를 제공

-----
### response 객체 : 웹 브라우저에 헤더 정보 전송하기
-----
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/2f4770a2-6a30-43da-b400-18830d2b58d4">
</div>

1. addDateHeader(String name, long date) : name 헤더에 date 추가 (date : 1970/1/1 이후 흘러간 시간을 1/1000초 단위)
2. addHeader(String name, String value) : name 헤더에 value값 추가
3. addIntHeader(String name, int value) : name 헤더에 정수 값 value 값 추가
4. setDateHeader(String name, long Date) : name 헤더 값을 date로 지정
    
   	      * setDateHeader는 System.currentTimeMillis 나 Date 객체의 getTime로부터 반환되는 값을 GMT 시간 문자열 변경
5. setHeader(String name, String value) : name 헤더의 값을 value로 저장
6. setIntHeader(String name, int value) : name 헤더의 값을 정수 값 value로 저장
7. containsHeader(String name) : 이름이 name인 헤더를 포함하면 true, 그렇지 않으면 false

-----
### 캐시 (Cache)
-----
1. 웹 브라우저 WAS에 a.jsp 실행 요청 후 다시 한 번 a.jsp 실행 요청을 하면, 두 요청 사이에 출력한 결과에 차이가 없다면
   웹 브라우저는 불필요하게 동일한 응답 결과를 두 번 요청
2. 동일한 데이터를 중복해서 로딩하지 않도록 사용
3. 웹 브라우저는 첫 요청 시 응답 결과를 로컬 PC의 임시 보관소인 캐시에 저장하고, 이후 동일 URL에 대한 요청이
   있으면 WAS에 접근하지 않고 로컬 PC에 저장된 응답 결과를 웹 브라우저에 출력
4. 변경이 발생하지 않는 JSP의 응답 결과나 이미지, 정적 HTML 등은 캐시에 보관함으로 웹 브라우저의 속도를 향상시키기 가능

-----
### response 기본 객체 콘텐츠 관련 메서드
-----
: 웹 브라우저 응답을 위해 MIME 유형, 문자 인코딩, 오류 메시지, 상태 코드 등 설정하고 가져오는 응답 콘텐츠 관련 메서드 제공
<div align = "center">
<img src = "https://github.com/sooyounghan/JAVA/assets/34672301/5792cc11-c1f0-4954-819d-00cbc8b648cf">
</div>

-----
### Redirect
-----
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/92c2435d-f41e-4e80-befe-f7ef65dbb63c">
</div>

1. 웹 서버가 웹 브라우저에게 다른 페이지로 이동하라고 응답 (2번의 요청, 2번의 응답)
2. 웹 서버 측에서 웹 브라우저에게 어떤 페이지로 이동하라고 지정
3. Redirect가 되는 순간, 기존 출력 버퍼에 있던 내용은 소멸
   
```jsp
<%
	final String FORM_VIEW = "loginForm.jsp"; // Redirect 주소를 상수로 지정
	
	if(request.getMethod().equalsIgnoreCase("GET")) { // GET 방식이면,
		response.sendRedirect(FORM_VIEW); // Redirect을 통해 로그인 폼 페이지로 이동
		// = out.print("<br><a href = 'loginForm.jsp'> 로그인 폼 이동 </a>");
	}
	else if(request.getMethod().equalsIgnoreCase("POST")) { // POST 방식이면,
		out.print(request.getMethod() + " : 로그인 처리 방식으로 이동");
	}
%>
```

3. 예제  : link_response_sendRedirect.jsp에서 name과 age의 값을 전달 -> a.jsp 전달 -> b.jsp로 redirect
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<body>
	<a href = "a.jsp?name=a&age=20" target = "_self">a.jsp</a>
	</body>
</html>
```
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<% 
	System.out.println("redirecting");
	System.out.println(request.getParameter("name"));
	System.out.println(request.getParameter("age"));
	response.sendRedirect("b.jsp");
	<!-- name : a / age : 20 -->
	%>
</body>
</html>
```
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<%
	System.out.println(request.getParameter("name"));
	System.out.println(request.getParameter("age"));
	<!-- name : null / age : null -->
	%>
	<h3>b.jsp</h3>
</body>
</html>
```

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/836839ae-c4e2-47d8-8c69-5507a5e58926">
</div>   

-----
### Redirect - 다른 페이지 이동 방법
-----
1. html
```html
   <a href = "URL" target = "_self">URL</a>
   <a href = "URL" target = "_blank">URL</a>
```

2. javaScript
```javascript
  <span onclick = "location.href = 'URL'"></span>
  <span onclick = "window.open('URL')"></span>
```

3. JSP / Servlet
```jsp
<jsp:forward = "URL">
- pageContext.forward("URL");
- requestDispatcher rd = request.getRequestDispatcher("URL");
  rd.forward(reqeust, resopnse);
```

