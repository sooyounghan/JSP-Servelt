-----
### MVC 
-----

<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/22b17049-6089-4d31-a9a3-43e21d6f4933">
</div>

1. Model : 비즈니스 영역의 로직을 처리 (JavaBean, Logic 처리 Class)
2. View : 비즈니스 영역에 대한 사용자가 보게 될 결과 화면을 담당 (JSP Page)
3. Controller : 사용자의 입력 처리와 흐름 제어를 담당 (Servlet)
4. 비즈니스 로직을 처리하는 Model과 결과 화면을 보여주는 View를 분리
   - Model의 내부 로직이 변경되더라도 View의 영향을 받지 않음
   - View와 Model이 직접 연결되어 있지 않으므로 내부 구현 로직에 상관없이 View 변경 가능
5. 어플리케이션의 흐름 제어나 사용자의 처리 요청은 Controller에 집중
   - Controller는 사용자의 요청에 대해 알맞은 Model을 사용
   - 사용자에게 보여줄 View를 선택 

-----
### MVC Controller : Servlet
-----
<div align ="center">
<img src ="https://github.com/sooyounghan/Web/assets/34672301/ff45a3f8-699e-4411-87ac-83170efdab41">
</div>

1. 웹 브라우저가 전송한 HTTP 요청을 받아 서블릿의 doGet() 메서드나 doPost() 메서드가 호출
2. 웹 브라우저가 어떤 기능을 요청했는지 분석
3. Model을 사용해 요청한 기능을 수행
4. Model로부터 전달받은 결과물을 알맞게 가공한 후, request나 session의 setAttribute() 메서드를 사용해 결과값을 속성에 저장 (JSP에서 사용)
5. 웹 브라우저에 결과를 전송할 JSP를 선택한 후, 해당 JSP View Page로 Forwarding 또는 Redirect
6. View Page 내 Controller 호출 : 절대경로 사용 (/ContextPath/Servelt URL Pattern)
-----
### 전형적인 Controller Servlet의 구현
-----
```java
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SimpleController extends HttpServlet {
  // 1. 1단계 : HTTP의 요청을 받음
  	@Override
  	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  		  service(request, response);
  	}
  	
  	@Override
  	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  		  service(request, response);
  	}
  	
    // 2. 2단계 : 요청 분석 (request 객체로부터 사용자의 요청을 분석)
  
    // 3. 3단계 : Model을 사용해 요청한 기능 수행
  
    // 4. 4단계 : request나 session에 처리 결과를 저장
  	request.setAttribute("result", resultObject);
  		

    // 5단계 : RequestDispatcher를 사용해 알맞은 View로 Forwarding 또는 Redirect
		RequestDispatcher dispatcher = req.getRequestDispatcher(viewPage);
		dispatcher.forward(req, res);
	}
}
```

-----
### MVC View : JSP
-----
1. Controller에서 request 또는 session 기본 객체에 저장된 데이터를 사용해 웹 브라우저에 알맞은 결과를 출력
2. 웹 브라우저가 요청한 결과를 보여주는 역할, Controller에게 전달해주는 매개체 역할
3. View Page 은닉
   - WEB-INF 디렉토리 : 외부에서 서비스 되지 않는 파일(View Page)들을 저장할 수 있음
   - WEB-INF 디렉토리 : 설정 파일 / 라이브러리 / 뷰 파일 은닉 목적
   - Controller Forwarding 예시 : /WEB-INF/view/notice/list.jsp"
   - 
-----
### MVC Model
-----
1. 비즈니스 로직을 처리해주는 것
2. 즉, 제공해줘야 하는 기능은 웹 브라우저의 요청을 처리하는 데 필요한 기능
<div align ="center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/5d7e3507-bb33-44ce-8b93-b82035b9ff95">
</div>

3. Model의 기능은 Controller Servlet이 웹 브라우저의 요청을 분석해 알맞은 Model을 호출하면서 모델의 기능 시작
4. Model은 Controller가 요청한 작업을 처리한 후 알맞은 결과를 Controller에게 전달하는데, 이 때 처리한 결과값을 저장하는 객체로 JavaBean 이용
5. Model은 Service 클래스나 DAO 클래스를 이용해 비즈니스 로직 수행

-----
### 간단한 로그인 데이터 받기
-----
1. 로그인 폼 (Request)
```html
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>

	<body>
	<form action = "LoginProc" method = "post">
	<table border = "1" align = "center">
		<tr height = "40">
			<td width = "120" align = "center">아이디</td>
			<td width = "180" align = "center"><input type = "text" name = "id"></td>
		</tr>
		<tr height = "40">
			<td width = "120" align = "center">비밀번호</td>
			<td width = "180" align = "center"><input type = "password" name = "pwd"></td>
		</tr>
		<tr height = "40">
			<td colspan = "2" align = "center"><input type = "submit" value = "로그인"></td>
		</tr>
	</table>	
	</form>
	</body>
</html>
```

2. LoginProc Servlet (Controller)
```java
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginProc")
public class LoginProc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}
	
	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		request.setAttribute("id", id);
		request.setAttribute("pwd", pwd);
		RequestDispatcher rd = request.getRequestDispatcher("LoginProc.jsp");
		rd.forward(request, response);
	}
}
```

3. LoginProc.jsp (View)
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	넘어온 데이터 : ${id} / ${pwd}
</body>
</html>
```
