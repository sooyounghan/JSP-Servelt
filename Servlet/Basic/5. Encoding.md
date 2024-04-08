-----
### 웹 환경
-----
1. Internet Explorer, Edge : 기본적으로 html 문서로 판단
2. Chrome : 기본적으로 text 문서로 판단
3. 따라서, 웹 브라우저마다 콘텐츠 형식을 지정해주지 않으면 자의적 해석으로 인해 다른 결과 출력

-----
### 한글 및 콘텐츠 형식 출력
-----
1. 기본적인 인코딩 형식 : ISO-8859-1
   - 한글을 지원하지 않는 인코딩 형식
   - 클라이언트로 전송 시 1byte단위로 전송하게 되어 한글의 기본 단위인 2byte에 대해서는 문자가 깨지는 오류 발생
   - Tomcat의 경우 request, response 모두 이 인코딩 형식을 기본으로 설정이었으나 UTF-8로 모두 변경
     
2. 서버에서는 UTF-8로 설정해서 보냈으나 브라우저에서 다른 환경에서 설정하여 받는 경우에도 깨지는 오류 발생한다면, 다음과 같이 처리
```java
import java.util.*;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * Browser에 문자열 출력 웹 문서 (@WebServlet)
 */

// http://localhost:8081/webPro/hello
@WebServlet(urlPatterns = "/hello")
public class servlet_Ex extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");

	    PrintWriter out = response.getWriter();

	    for(int i = 0; i < 100; i++) {
  		  out.println((i+1) + ": 안녕 Servlet!");
	    }
	}
}
```
