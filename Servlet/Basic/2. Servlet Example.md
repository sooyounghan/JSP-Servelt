-----
### Servlet을 활용 예제
-----
1. HelloWord Servlet
```java
package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * Servlet implementation class HelloWorld
 */
@WebServlet("/HelloWorld") // Web Serlvet Annotation 
public class HelloWorld extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);
	}

	// doGet, doPost 두 방식에 대해 모두 service()에서 처리
	protected void service(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		String msg = "Hello World";
		Integer data = 12;
		
		// DAO를 통해 DB에서데이터 추출해 request에 연결 가능
		request.setAttribute("msg", msg);
		request.setAttribute("data", data);
		
		RequestDispatcher rd = request.getRequestDispatcher("HelloWorld.jsp");
		rd.forward(request, response);
	}

}
```

2. HelloWorld.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

<body>

	<h2>결과 보기</h2>
	MSG : ${msg} <br>
	Data : ${data}
	
</body>
</html>
```
<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/3a6bdbce-574a-4b22-ae21-7788859b31fc">
</div>

  - 현재 URL은 /HelloWorld로 Mapping
  - 따라서, /HelloWorld URL에 대해 위의 코드가 실행
  - 실제 실행 주소 : http://localhost:8081/Servlet_Ex/HelloWorld
  - 그렇다면, /Hello로 Mapping 한다면? Serlvet은 /Hello URL로 Mapping하므로 그 주소는 http://localhost:8081/Servlet_Ex/Hello
  - 즉, Mapping URL이 핵심
