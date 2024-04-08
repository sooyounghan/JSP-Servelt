-----
### Service method
-----
1. JSP PAGE 내에서 FORM을 통해 GET / POST 방식으로 받게 되었을 때, doGet(request, response)과 doPost(request, response) 방식으로 처리할 수 있음
2. 하지만, service(request, response) 내에서 GET / POST 방식에 대해 처리도 가능
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
	    if(request.getMethod().equals("GET") {
	        ...
	    } else if(request.getMothod().equals("POST") {
	        ...
	    }
	}
}
```

3. service 메서드 내에서 request에 대해 getMethod()를 호출하면, request로 전달받은 FORM에 대한 method 방식에 대한 String 값을 얻을 수 있음
4. 이에 대해 equals() 함수를 이용해 GET / POST 방식을 확인하여 나눠서 처리 가능
   - 단, GET / POST는 대문자로 작성
   - equalsIgnoreCase() 메서드를 사용 : 대 / 소문자 구분 없이 처리 가능

-----
### super.service(reqeust, response) = HttpServlet.service의 동작 순서
-----
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/b04175a1-a123-49a4-a480-0800f4a1e20f">
</div>

1. 클라이언트로부터 들어오는 HTTP 요청을 처리하는 메서드
2. 클라이언트의 HTTP 요청을 분석해 요청 메서드(GET, POST, PUT, DELETE 등)을 확인
3. 요청 메서드에 따라 doXXX() 메서드를 호출
4. 만약, 해당하는 doXXX() 메서드가 존재하지 않거나 오버라이딩 되지 않은 경우, 해당 요청에 대해 405 오류 발생
5. doXXX가 호출되면, 클라이언트의 요청에 대한 실제 처리가 이루어짐

-----
### Http Status 405의 의미
-----
1. 해당 메서드를 지원할 수 없다는 의미 = 즉, 클라이언트로부터 받은 요청을 처리할 수 없다는 의미
2. 즉, 만약 서블릿이 특정 HTTP 메서드에 대한 요청을 처리할 준비가 되어있지 않다면, 해당 메서드를 제공하지 않는다는 의미
3. 그러므로, 클라이언트가 특정 HTTP 메서드로 요청을 보내면, 해당하는 서블릿이 그 요청을 처리할 수 있는 적절한 메서드를 제공해야 함
4. 예를 들어, 클라이언트가 GET 요청을 보냈는데 서블릿이 doGet(request, response) 메서드를 오버라이딩하지 않았다면, 이는 해당 서블릿이 GET 요청을 처리할 수 없다는 것을 의미하며, 따라서 서블릿 컨테이너는 클라이언트에게 "Method Not Allowed(405)" 오류를 반환
   
-----
### super.service(reqeust, response)
-----
1. 위의 코드의 경우에는 service Method를 HttpServlet으로부터 상속받아 오버라이딩 한 것
2. 그렇다면, 오버라이딩을 하지 않고 사용한다면? (즉, super.service(request, response) 호출)
   - 사용자로부터 request가 발생하면, doGet / doPost 방식만을 오버라이딩을 하면, 해당 오버라이딩 부분에 대해 처리가 가능
   - 하지만, doGet / doPost 방식을 오버라이딩 하지 않는다면, 오류가 발생 (Http status 405 - 허용되지 않는 메서드 오류 발생)

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
	    if(request.getMethod().equals("GET") {
	        ...
	    } else if(request.getMothod().equals("POST") {
	        ...
	    }
      	    super.service(request, response);
	}
}
```
   - 즉, 위와 같이 service를 통해 GET / POST 방식에 대해 처리했으나, super.service(request, response)를 만나게 되면, 오버라이딩된 doGet(request, response)과 doPost(request, response)를 확인 (오버라이딩이 되지 않은 doGet(request, response)과 doPost(request, response)는 기본적으로 아무런 동작을 수행하지 않으나 호출은 가능)
   - 하지만, 오버라이딩된 메서드가 없으므로, Http status 405 오류 발생

5. 다음과 같이, doGet(request, response), doPost(request, response)를 오버라이딩하면, 오류 미발생
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
	    if(request.getMethod().equals("GET") {
        ...
      } else if(request.getMothod().equals("POST") {
        ...
      }
      super.service(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  ...  
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  ...  
	}
}
```
   - super.service(request, response)는 GET / POST 방식에 따라 오버라이딩된 doGet(request, response) / doPost(request, response) 방식에 맞춰 처리
