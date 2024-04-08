-----
### Servlet에서의 Application 객체
-----
1. JSP에서의 appliocation 내장 객체와 동일
2. Servlet에서는 서블릿 컨택스트 (Servlet Context)라는 저장 공간을 의미
3. request.getServletContext()를 통해 application 객체 받아올 수 있음
4. 예시
```java
package ServletEx;

package ServletEx;


import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hello")
public class ServletEx extends HttpServlet {
  	private static final long serialVersionUID = 1L;
         
  	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  	    ServletContext application = request.getServletContext();
  	    application.setAttribute("id", new String("id"));
  	    application.setAttribute("pwd", new String("pwd"));
  	}
  }
}

```

3. 즉 ServletContext(Application)의 객체를 생성 후, 이를 이용하는 것 : JSP에서 Application과 동일

-----
### Servlet에서의 Session 객체
-----
1. JSP에서의 Session 내장 객체와 동일
2. Session은 Servlet에서 HttpSession Interface 내에 존재
3. request.getSession()를 통해 session 객체 받아올 수 있음
4. 예시
```java
package ServletEx;

import javax.servlet.http.HttpSession;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/hello")
public class ServletEx extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    session.setAttribute("id", new String("id"));
	    session.setAttribute("pwd", new String("pwd"));
	}
}
```

-----
### SessionID (SID)
-----
1. Session (객체) 마다 가지고 있는 고유한 ID를 의미

2. SessionID와 Session에 대한 접근을 가지는 과정
<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/560dd8e8-debf-44bf-9c83-93de56fa4dfd">
</div>

  - Browser에서 처음 WAS에게 request (해당 Browser에 대한 SID는 없으므로 Session 접근 불가)
  - Application만 접근이 가능하며, 이에 대해 request에 대한 response로 WAS는 이 Browser에 대한 SID 생성
  - Browser는 다음 request 요청에 부여받은 SID를 통해 Session에 접근할 수 있게 됨
  - SID의 기준은 하나의 Web Browser이며, 여러 개의 Broswer에 대해서는 WAS는 서로 다른 User로 판단하여 각각의 SID를 부여

-----
### Servlet에서 사용할 수 있는 상태 저장소
-----
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/1840bed1-123b-4197-aab8-ce1718980afd">
</div>

-----
### Session / Cookie / Application
-----
1. Application
   - 사용 범위 : 전역 범위에서 사용하는 저장 공간
   - 생명 주기 : WAS의 시작 ~ 종료
   - 저장 위치 : WAS 서버의 메모리
  
2. Session
   - 사용 범위 : Session 범위에서 사용하는 저장 공간
   - 생명 주기 : Session의 시작 ~ 종료
   - 저장 위치 : WAS 서버의 메모리

3. Cookie
   - 사용 범위 : Web Browser별 지정한 path 범주 공간
   - 생명 주기 : Browser에 전달한 시간 ~ 만료 시간
   - 저장 위치 : Web Broswer의 메모리 또는 파일
