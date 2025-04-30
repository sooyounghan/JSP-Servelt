-----
### Request / Response Wrapper Class
-----
1. 요청 정보를 변경해 최종 자원인 Servlet/JSP/HTML/기타 자원에 전달
2. 최종 자원으로부터 응답을 변경해 새로운 응답 정보를 클라이언트에게 전달
3. Servlet의 Request / Response Wrapper를 만들려면 javax.Servlet에 있는 ServletReqeust와 ServletResponse를 상속받아 구현
4. 대부분, HTTP 프로토콜에 맞게 요청과 응답 필터링을 하므로 이를 알맞게 구현한 HttpServletReqeustWraaper / HttpServletReponseWrapper 클래스를 상속받아 구현하는 것이 좋음
5. Filter를 통해 변경하고 싶은 요청 정보가 있다면, HttpServletReqeustWraaper 클래스를 상속받은 클래스를 만들고, 그 정보를 추출하는 메서드를 알맞게 정의
   - 변경한 정보를 제공하도록 FilterChian의 doFilter() 메서드를 통해 전달

-----
### 기본적인 필터의 응용 - 로그인 검사
-----
: session에 "MEMBER" 속성이 존재하면, 로그인한 것으로 판단하는 LoginCheckFilter 클래스 작성
```java
package ServletEx.Filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LoginCheckFilter implements Filter {
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession(false);
		
		boolean login = false;
		
		if(session != null) {
			if(session.getAttribute("MEMBER") != null) {
				login = true;
			}
		}
		
		if(login) {
			chain.doFilter(request, response);
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/loginForm.jsp");
			dispatcher.forward(request, response);
		}
	}
	
	@Override
	public void destroy() {
		
	}
}
```

```jsp
<filter>
  <filter-name>LoginCheck</filter-name>
  <filter-class>ServletEx.Filter.LoginCheckFilter</filter-class>
</filter>

<filter-mapping>
  <filter-name>LoginCheck</filter-name>
  <url-pattern>/board/*</url-pattern>
</filter-mapping>
```
