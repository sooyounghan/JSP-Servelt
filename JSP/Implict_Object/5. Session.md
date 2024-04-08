-----
### Session과 Cookie
-----
<div align = "center" >
<img src="https://github.com/sooyounghan/Web/assets/34672301/63dc715b-e388-48e9-81b7-6844e1b5fde8">
</div>   

1. 보안 : 쿠키 < 세션              
    - 쿠키의 이름이나 데이터는 네트워크를 통해 전달 (HTTP 특성 상 중간에 쿠키의 값을 읽을 수 있음)
    - 세션의 값은 오직 서버에만 저장되므로 중요한 데이터를 저장할 수 있음   

2. 웹 브라우저마다 쿠키를 막는 경우 존재하지만, 세션은 쿠키 설정 여부 상관 없이 사용 가능
3. 세션은 여러 서버에서 공유 가능 (쿠키는 반면에 도메인을 이용해 쿠키를 여러 도메인에서 공유 가능)
   
-----
### Session (javax.servlet.http.HttpSession)
-----
1. 클라이언트와 웹 서버 간 상태를 지속적 유지
2. 웹 서버만에서만 접근 가능하므로 보안 유지에 유리, 데이터 저장에 한계가 없음
3. 오직 웹 서버에만 존재하는 객체 (서버측 데이터 보관소)
4. 웹 컨테이너는 기본적으로 한 웹 브라우저마다 한 세션을 생성 :  웹 서버의 서비스를 제공받는 사용자를 구분하는 단위가 됨
5. 웹 브라우저마다 세션이 따로 존재하므로, 세션은 웹 브라우저와 관련된 정보를 저장
6. 웹 브라우저를 닫기 전까지 웹 페이지를 이동하더라도 사용자의 정보가 웹 서버에 보관되어 있어 정보를 잃지 않음
    * 사용 예) 웹 브라우저에서 어떠한 정보를 계속 유지하고 싶을 때 (쇼핑몰에 장바구니 목록, 로그인 유지 등)
      
<div align = "center" >
<img src="https://github.com/sooyounghan/Web/assets/34672301/6f78ed3b-4754-4e42-9c1e-0e23c1d64463">
</div>

-----
### Session 메서드
-----
<div align = "center" >
<img src = "https://github.com/sooyounghan/Web/assets/34672301/41115fb1-6975-4bb6-a365-ffcd525ce680">
</div>

1. 세션 속성 값 설정하기 : void setAttribute(String name, Object value)
   - session 내장 객체의 setAttribute() 메서드 사용 [MVC에서 Model 역할]
   - 세션의 속성을 설정하면 계속 세션 상태 유지 가능
   - 동일한 세션 속성 이름으로 세션을 생성하면, 마지막에 설정한 것이 세션 속성 값
   
         * name : 세션에서 사용할 세션 속성의 이름, 세션에 저장된 특정한 값 찾아오기 위한 키로 사용
         * value : 세션의 속성값 (Object 타입으로, 형변환 필요)

```jsp
<%
 session.setAttribute("memberId", "admin");
%>
```

2. 세션 속성 값 가져오기 : Object getAttribute(String name)
   - 세션에 저장된 하나의 세션 속성 이름에 대한 속성 값 가져오기
   - 반환 타입은 Object형 : 형변환 필요 (중요!)
   - 해당 속성에 이름이 없는 경우 null 반환

3. 다중 세션 정보 얻기 : java.util.Enumeration getAttributeNames()
   : 세션에 저장된 여러 개 세션 속성 이름에 대한 속성 값 반환
   
-----
### Session 생성
-----
1. page 디렉티브 이용

```jsp
<%@ page session = "true" %>
```
  - page 디렉티브의 session 속성은 기본값이 항상 true
  - session 속성값을 false로 지정하지 않으면, 세션이 생성

2. 세션은 웹 브라우저가 처음 접속할 때 세션을 생성하고, 이후로는 이미 생성된 세션을 사용
3. request.getSession()을 이용하는 방법
   - request.getSession() : 현재 요청과 관련된 session 객체 반환 (단, page 디렉티브의 session 속성 값은 false)
   - 해당 session이 존재하면 해당 session을 반환, 존재하지 않으면 새롭게 session을 생성해 반환
     
```jsp
<%@ page session = "false"%>

<%
HttpSession httpSession = reuqest.getSession();
List list = (List)httpSession.getAttribute("list");
list.add(productId);
%>
```

-----
### Session 기본 객체
-----
1. session을 사용하는 것 = session 기본 객체를 사용하는 것
2. session 기본 객체는 웹 브라우저의 여러 요청을 처리하는 JSP 페이지 사이에서 공유
3. Session ID : 세션마다 고유 ID를 할당
   - 웹 서버는 웹 브라우저에게 세션 ID를 전송
   - 웹 브라우저는 웹 서버에 연결할 때 마다 매번 Session ID를 보냄
   - 웹 서버에서는 어떤 세션을 사용할 수 있을지 판단

4. 웹 서버는 Session ID를 통해 웹 브라우저를 위한 세션을 찾음
5. 웹 브라우저와 웹 서버가 세션 ID를 공유할 수 있는 방법 필요 : 쿠키 (세션 ID를 공유하기 위함)
   - JSESSIONID쿠키 : 세션 ID를 공유할 때 사용하는 쿠키

-----
### Session 종료
-----
1. session.invaildate() : 세션을 종료
2. 세션을 종료하면 현재 사용 중인 session 기본 객체를 삭제
3. session 기본 객체에 저장된 속성 목록도 함께 삭제
4. 세션을 종료하면 기존 session 객체는 제거, 세션 종료 후 다음 요청에서 session을 사용하면 새로운 session 기본 객체 생성
   
-----
### Session 유효 시간 
-----
1. 한 번 생성된 Session은 지정한 유효 시간 동안 유지 (세션 유지를 위한 세션의 일정 시간)
2. 웹 브라우저에 마지막 접근 시간부터 일정 시간 이내 다시 웹 브라우저에 접근하지 않으면 자동 세션 종료
   
       * 최근 session 기본 객체에 접근한 시간 : session.getLastAccessedTime()
       * 웹 브라우저가 JSP 페이지를 실행할 때마다 session 기본 객체에 접근하게 되면서. 최근 접근 시간이 변경 

3. 세션 유효 시간 설정 : void setMaxInactiveInterval(int interval)
   - interval : 세션 유효 시간
   - 세션 유효 시간 기본값 : 1,800초 (초 단위 설정)

```jsp
<%
session.setMaxInactiveInterval(60 * 60)
%>
```

4. WEB-INF\web.xml 내 <Session-Config>에서 유효 시간 설정 (분 단위)
```html
<session-config>
  <session-timeout>50</session-timeout>
</session-config>
```

5. 세션 유효 시간이 0 또는 음수 : 세션 유효 시간이 없는 상태
   (세션 삭제했을 때, session.invalidate()를 호출하지 않으면, 세션 속성이 웹 서버에서 제거 되지 않고 유지)
   
6. session.invaildate() 메서드를 명시적으로 실행하지 않으면, 이 세션 떄문에 메모리 부족현상 발생 가능


-----
### Session을 이용한 다른 페이지 이동 시에도 아이디와 비밀번호 정보 유지
-----
< Login Form >
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<form action = "<%=request.getContextPath()%>/ex/SessionLoginProc.jsp" method = "post">
		<table border = "1" align = "center">
			<tr height = "50">
				<td width = "150" align = "center"> 아이디 </td>
				<td width = "150" align = "center"> <input type = "text" name = "id" size = "40"> </td>
			</tr>
			<tr height = "50">
				<td width = "150" align = "center"> 비밀번호 </td>
				<td width = "150" align = "center"> <input type = "password" name = "pwd" size = "40"> </td>
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

< 화면 1에서 정보 확인 >
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<%
	String id = request.getParameter("id");
	session.setAttribute("id", id);
	String pwd = request.getParameter("pwd");
	session.setAttribute("pwd", pwd);
	session.setMaxInactiveInterval(60);
	%>
	
	<h2>ID = <%=id%> </h2><br>
	<h2>Password = <%=pwd%></h2>
	
	<a href = "<%=request.getContextPath()%>/ex/CookieLoginProc2.jsp">다음 페이지로 이동</a> 
</body>
</html>
```
< 화면 2에서 정보 확인 > : 여기에서는 request getParameter() 사용 시, null 값 반환
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<%
	String id = (String)session.getAttribute("id");
	String pwd = (String)session.getAttribute("pwd");
	%>
	
	<h2>ID = <%=id%> </h2><br>
	<h2>Password = <%=pwd%></h2>
</body>
</html>
```
