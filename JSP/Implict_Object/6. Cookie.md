-----
### Session과 Cookie
-----
<div align = "center" >
<img src="https://github.com/sooyounghan/Web/assets/34672301/63dc715b-e388-48e9-81b7-6844e1b5fde8">
</div>

-----
### Cookie
-----
1. 쿠키는 세션과 달리 정보를 웹 서버가 아닌 클라이언트(웹 브라우저)에 저장
2. 클라이언트와 웹 서버 간 상태를 지속적 유지하는 방법
     - 웹 브라우저는 웹 서버에 요청을 보낼 때 쿠키를 함께 전송
     - 웹 서버는 웹 브라우저가 전송한 쿠키를 사용해 필요한 데이터를 읽을 수 있음
     - 하나의 웹 브라우저는 여러 개의 쿠키를 가질 수 있음
        
       		예) 웹 사이트를 처음 방문한 사용자가 로그인 인증을 하고 나면, 아이디/비밀번호를 기록한 쿠키 생성
   		        그 다음부터 사용자가 그 웹 사이트에 접속하면 별도의 절차를 거치지 않고 쉽게 접속할 수 있음

3. 쿠키는 웹 서버 / 웹 브라우저 모두 생성이 가능 (JSP에서는 웹 서버에서 생성하는 쿠키)
   
4. 장점 : 클라이언트의 일정 폴더에 정보를 저장하므로 웹 서버의 부하를 줄일 수 있음
5. 단점 : 웹 브라우저가 접속했던 웹 사이트에 대한 정보의 개인정보가 기록되므로 보안 문제 발생
   
<div align = "center" >
<img src = "https://github.com/sooyounghan/Web/assets/34672301/ca8c0dd2-d26f-4714-a576-5e3cc7046054">
</div>

-----
### Cookie 동작 방식
-----
1. 쿠키 생성 단계 : 웹 서버 측에서 쿠키를 생성해 Response 데이터 헤더에 저장해 웹 브라우저에 전송
2. 쿠키 저장 단계 :  웹 브라우저는 응답 데이터에 포함된 쿠키를 쿠키 저장소에 보관 (쿠키 종류에 따라 메모리 / 파일에 저장)
3. 쿠키 전송 단계 : 웹 브라우저는 저장된 쿠키를 요청이 있을 때마다 웹 서버에 전송


-----
### Cookie 구성
-----
1. 이름 : 각각의 쿠키를 구별하는데 사용되는 이름
2. 값 : 쿠키의 이름과 관련된 값
3. 유효 시간 : 쿠키의 유지 시간
4. 도메인 : 쿠키를 전송할 도메인
5. 경로 : 쿠키를 전송할 요청 경로

-----
### Cookie 관련 메서드
-----
<div align = "center" >
<img src = "https://github.com/sooyounghan/Web/assets/34672301/196dfaf2-c403-4247-ac93-785b304282a0">
</div>

        쿠키의 도메인과 경로는 도메인 간에 또는 특정 요청 경로 간에 위치한 JSP 간 쿠키 공유할 때 필요

-----
### Cookie 생성하기
-----
1. Cookie 클래스 이용 : Cookie Cookie(String name, String value) - response.addCookie(cookie_name)
   - name : 쿠키 식별 이름
   - value : 쿠키 값

2. 쿠키를 생성한 후에는 반드시 response 내장 객체의 addCookie() 메서드로 쿠키 설정해 웹 브라우저에 쿠키 정보 전송

```jsp
<%
Cookice cookie = new Cookie("memberId", "admin");
response.addCookie(cookie);
%>
```
3. JSESSIONID : JSP/Servlet에서 세션 관리를 위해 사용되는 쿠키
   
-----
### Cookie 값 읽기
-----
1. 쿠키 객체 얻기 : Cookie[] request.getCookies()
    - 항상 쿠키 객체를 얻을 때는 쿠키가 존재하는지 확인 (클라이언트나 전송 간 위조 및 소실 여부를 위해) (중요!)
    - 쿠키 객체가 여러 개일 때, 배열 형태로 가져옴
    - 읽어올 쿠키가 없으면 null 반환 (null 반환된 쿠키 사용 : NullPointerException 발생)
```jsp
<%
Cookie[] cookies = request.getCookies();

if(cookies != null && cookies.length > 0) { // 유효성 검사
...
} else {
...
}
%>
```

2. 쿠키 객체 정보 얻기 : 쿠키 객체에 저장된 쿠키 이름과 값을 가져오기 위해 getName(), getValue() 메서드 사용

```jsp
<%
Cookie[] cookies = request.getCookies();
for(int i = 0; i < cookies.length; i++) {
	out.println(cookies[i].getName() + " : " + cookies[i].getValue() + "<br>");
}
%>
```

-----
### Cookie 값 변경 및 삭제하기
-----
1. 쿠키 값 변경
  - 같은 이름의 쿠키를 새로 생성해서 응답 데이터로 보내면 됨
  - 쿠키의 값을 변경한다는 것 : 기존의 존재하는 쿠키의 값을 변경
```jsp
<%
Cookice cookie = new Cookie("memberId", "user1");
response.addCookie(cookie);
%>
```

2. 쿠키 삭제
  - 쿠키는 별도로 삭제하는 기능이 없음
  - 쿠키의 유효 기간을 결정 : setMaxAge() 메서드에 유효 기간 설정 후, 응답 헤더에 추가
  - 0으로 설정한 뒤, 응답 헤더에 추가하면, 웹 브라우저가 관련 쿠키 삭제

```jsp
Cookie cookie = new Cookie("memberId", "admin);
cookie.setMaxAge(0);
response.addCookie(cookie);
```

                        쿠키 확인 : F12(개발자 도구) - Application - Cookie

-----
### Cookie의 도메인
-----
1. 기본적으로 쿠키는 그 쿠키를 생성한 서버에서만 전송
2. void setDomain(String url) : 같은 도메인을 사용하는 모든 서버에 쿠키를 보내야 할 때 사용 (도메인 범위 지정)
  - .somehost.com : .으로 시작하는 경우 관련 도메인에 모든 쿠키를 전송 (mail/www/javacan 등 모두 전송)
  - www.somehost.com : 특정 도메인에 대해서만 전송

3. 현재 서버의 도메인 및 상위 도메인으로만 전송 가능 (다른 주소 값으로는 불가)

4. 웹 브라우저가 타 도메인으로 지정한 쿠키를 받지 않는 이유
   - 임의의 다른 서버에서 해당 쿠키에 대한 값을 마음대로 변경하게 되면, 보안은 뚫림
   - 보안적 문제로 허용하지 않음


-----
### Cookie의 경로
-----
1. 쿠키를 공유할 기준 경로 지정 (디렉토리 수준의 경로)
2. 쿠키 경로를 지정하지 않으면, 실행한 URL의 경로 부분으로 사용

3. void setPath(String path) : URL에서 도메인 이후 부분이 path에 해당
4. 쿠키는 웹 어플리케이션과 포함된 다수의 JSP와 Servlet에서 사용되므로 쿠키 경로를 일반적으로 '/'로 설정
5. 예제
<div align = "center" >
<img src = "https://github.com/sooyounghan/Web/assets/34672301/8c98140e-0d09-46d8-8960-5f313f00e0ff">
</div>

  - 현재 JSP 실행 경로 : /chap09/path1 경로에 위치
  - 1번 : /chap09/path1 경로 기준쿠키 전송
  - 2번 : 지정하지 않았으므로 현재 URL 실행 경로(/chap09/path1)에 기준 쿠키 전송 
  - 3번 : /(Root Directory) 경로 기준 쿠키 전송
  - 4번 : /chap09/path2 경로 기준 쿠키 전송

-----
### Cookie의 유효 시간
-----
1. 쿠키는 유효시간을 가지며, 지정하지 않으면 웹 브라우저를 종료할 때 함께 삭제
2. 웹 브라우저 종료 후 다시 웹 브라우저를 실행하면 삭제한 쿠키는 서버에 전송되지 않음
3. 쿠키의 유효 시간을 지정해 놓으면, 웹 브라우저가 종료되도 유효시간이 지나지 않았으면, 쿠키는 삭제되지 않음
4. void setMaxAge(int num) : 초 단위로 설정 (0으로 설정하고, 쿠키를 응답 헤더에 추가하면 그 쿠키는 소멸)

-----
### Cookie와 Header
-----
1. response.addCookie()로 쿠키를 추가하면 실제로 Set-Cookie를 통해 전달
2. 한 개의 Set-Cookie 헤더는 한 개의 쿠키 값을 전달
3. 쿠키도 헤더에 추가되어 전송되므로, 출력 버퍼가 flush된 이후에 새롭게 추가할 수 없음
   
       쿠키이름=쿠키값; Domain=도메인값; Path=경로값; Expires=GMT형식 만료일시
       Set-Cookie : id=madvirus; Domain=.somehost.com
   
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
  <body>
  <%
  Cookie cookie = new Cookie("ID", "java");
  cookie.setPath("/");
  cookie.setMaxAge(60 * 60 * 24);
  response.addCookie(cookie);
  
  Cookie name = new Cookie("NAME", "han");
  name.setValue("nah");
  response.addCookie(name);
  %>

  <a href = "<%=request.getContextPath()%>/ch09/cookieEx02.jsp">Go</a>
  </body>
</html>
```

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <body>
  if(cookies != null && cookies.length > 0) { // 유효성 검사 : Client의 쿠키 삭제 여부
    // 쿠키는 존재하지만, Server가 원하는 정보가 없을 수 있음
    
    for(int i = 0; i < cookies.length; i++) {
      Cookie temp = cookies[i];
      
      else if(cookies[i].getName().equals("ID")) {
        out.print(cookies[i].getName() + " : " + cookies[i].getValue() + "<br>");
      }
    }			
  }
  else {
    out.print("Not Cookie!");
  }
  </body>
</html>
```

-----
### Cookie를 이용한 ID 정보 기억하기
-----
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<%
	Cookie[] cookies = request.getCookies();
	String id = "";
	
	if(cookies != null && cookies.length > 0) {
		for(int i = 0; i < cookies.length; i++) {
			if(cookies[i].getName().equals("id")) {
				id = cookies[i].getValue();
				break;
			}
		}
	}
%>

<form action = "<%=request.getContextPath()%>/ex/CookieLoginProc.jsp" method = "post">
	<table border = "1" align = "center">
		<tr height = "50">
			<td width = "150" align = "center"> 아이디 </td>
			<td width = "150" align = "center"> <input type = "text" name = "id" size = "40" value = "<%=id%>"> </td> // Cookie로 부터 받은 ID가 있다면 그 정보 저장
		</tr>
		<tr height = "50">
			<td width = "150" align = "center"> 비밀번호 </td>
			<td width = "150" align = "center"> <input type = "password" name = "pwd" size = "40"> </td>
		</tr>
		<tr height = "50">
			<td colspan = "2" align = "center"><input type = "checkbox" id = "save" name = "save" value = "save"> ID 저장 </td>
			<td></td>
		</tr>	
		<tr height = "50">
			<td colspan = "2" width = "150" align = "center"> 
				<input type = "submit" name = "submit" value = "가입">
				<input type = "reset" name = "reset" value = "취소">
			</td>
			<td></td>
		</tr>
	</table>
</form>
</body>
</html>
```

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<body>
<%
	String id = request.getParameter("id");
	Cookie cookie = new Cookie("id", id);
	response.addCookie(cookie);
	cookie.setMaxAge(60 * 60);
	out.println("ID = " + id);
%>
</body>
</html>
```
