-----
### MVC 패턴 (Model-View-Controller)
-----
1. 클라이언트 요청에 따라 Contorller에서 데이터가 필요하면 Model을 통해 DB에 접근해 데이터를 가져옴
2. View에서 보여줄 화면을 데이터와 함께 만들어서 클라이언트 측에 제공 (데이터가 필요 없으면 바로 View로 제공)
3. MVC에 대한 표준이 없어서 등장한 것 : MVC FrameWork(Spring, SpringBoot)

-----
### Servlet (Server Application Let)
-----
참고 자료 : https://github.com/sksrpf1126/study/blob/main/Spring(Spring%20Boot)/Servlet.md

1. 동적 웹 페이지를 만들기 위해 사용되는 자바 기반의 웹 어플리케이션 기술
2. 웹 기반 요청에 대한 동적 처리가 가능한 하나의 클래스
3. 서블릿 구조 (인터페이스)
   
```java
public interface Servlet {

    public void init(ServletConfig config) throws ServletException;


    public ServletConfig getServletConfig();

    public void service(ServletRequest req, ServletResponse res)
            throws ServletException, IOException;

    public String getServletInfo();

    public void destroy();
}
```
4. 서블릿이 만들어지면, init이 호출되어 단 하나의 서블릿 객체만 만들어짐(Singleton Pattern)
5. service 메서드를 통해 서블릿 객체를 통해 실행할 코드 작성 (Servlet을 구현하는 HttpServlet 클래스를 통해 실행)
6. destory 메서드는 보통 서블릿 컨테이너가 종료될 때 실행되며, 해당 Servlet 인스턴스 제거

<div align = "center">
<src = "https://github.com/sooyounghan/JAVA/assets/34672301/81124f1f-d0a2-40ce-b4c4-17b27cf3f145">
</div>

-----
### Servlet과 Servlet Container
-----
  - 서블릿 : 동적인 웹 페이지를 만듬
  - 서블릿 컨테이너 : 서블릿을 관리하는 그릇 (Tomcat)
  - 일반적으로 앞단에 웹 서버를 두어 정적 컨텐츠를 처리, 동적인 컨텐츠는 웹 서버가 WAS로 전달하여 동적 컨텐츠 처리
    
<div align = "center">
<src = "https://github.com/sooyounghan/JAVA/assets/34672301/53bf4951-2b13-4bee-8497-0ef4b17e91fa">
</div>

1. 클라이언트가 /hello와 같은 url로 http 요청
2. 서블릿 컨테이너는 클라이언트의 요청에 따라 web.xml(서블릿 클래스의 경로 및 위치와 매핑되는 URL 정보가 기록된 파일)을 통해 요청에 맞는
   서블릿을 찾음 
3. 서블릿 객체가 존재하지 않으면, 객체 생성
4. 실행할 서블릿을 찾게 되면, 서블릿 컨테이너는 httpRequest, httpResponse 객체를 만들어서 해당 서블릿에 같이 전달
5. http 메서드에 맞는 do...메서드를 실행하며, 클라이언트에게 httpResponse를 전달 (Business Logic)

    - 하나의 요청에 하나의 서블릿이 매칭되는데, 하나의 쓰레드를 만들어서 실행
    - 즉, 여러 요청이 들어오면 각각 요청마다 쓰레드를 만들기 때문에 서블릿 컨테이너는 멀티 쓰레드 방식으로 동작
    - 단 하나의 서블릿 인스턴스만을 사용하므로 쓰레드 동기화를 고려해 만들어야함

6. 기본적인 흐름
<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/ebcbf8fe-7a2e-40dd-af03-8a2920ae9c7f">
<img src="https://github.com/sooyounghan/Web/assets/34672301/d6170a2c-a50c-414a-8ead-277578c380d7">
</div>

-----
### Servlet 과정
-----
<div align = "center">
<img width="640" alt="다운로드 (5)" src="https://github.com/sooyounghan/JAVA/assets/34672301/90c48e0b-6531-4d3c-bf30-4acc35edf552">
</div>   

1. Web Server는 HTTP request를 Web Conatiner(Servlet Container)에게 위임
   
  - web.xml 설정에서 어떤 URL과 매핑되는지 확인
  - 클라이언트의 요청 URL를 보고 적절한 Servlet 실행
   
2. Web Container는 service() 메서드를 호출하기 전 Servlet 객체를 메모리에 올림   
   - A. Web Container는 적절한 Servlet 파일을 컴파일(*.class 파일 생성)   
   - B. .class 파일을 메모리에 올려 Servlet 객체를 만듬   
   - C. 메모리에 로드될 때 Servlet 객체를 초기화하는 init() 메서드가 실행   

3. Web Container는 Request가 올 때마다 thread를 생성해 처리
   (각 thread는 Servlet의 단일 객체에 대한 service() 메서드를 실행)

-----
### Servlet Life Cycle
-----
<div align = "center">
<img width="640" alt="다운로드 (6)" src="https://github.com/sooyounghan/JAVA/assets/34672301/170896f6-ea87-4be1-8a90-71a7b3471c20">
</div>

1. 클라이언트의 요청이 들어오면 WAS는 해당 요청에 맞는 Servlet이 메모리에 있는지 확인
2. 만약 메모리에 없다면 해당 Servlet Class를 메모리에 올린 후, 즉 Servlet 객체를 생성한 후 init() 메서드를 실행 (Servlet Loading 과정)
3. 이후, Service()를 실행 [메모리에 있다면 바로 Service() 실행]

< init >   
      - 한 번만 수행되며, 클라이언트의 요청에 적절한 Servlet이 생성되고, 이 Servlet이 메모리에 로드되면 호출   
      - Servlet 객체를 초기화 (환경설정과 같이 초기에 필요한 작업 수행)   
      - 일반적인 init() 구현

```java
public void init(ServletConfig config) throws ServletException {
  this.config = config;
  this.init();
}

public init() throws ServletException {

}
```
    
     A. 서블릿 컨테이너는 서블릿 초기화를 위해 ServletConfig 파라미터를 갖는 init()메서드 실행
     B. 다시 파라미터가 없는 init() 메서드를 실행하므로 초기화가 필요한 서블릿은 이 메서드를 재정의


  * <load-on-startup>
    : 보통 초기화 작업은 상대적으로 시간이 오래 걸리므로, 웹 컨테이너를 처음 구동하는 시점에 초기화
   ```jsp
    <servlet> // 서블릿 클래스 등록
    	<servlet-name>DBCPInit</servlet-name> // 해당 서블릿을 참조할 때 사용할 이름
    	<servlet-class>jdbc.DBCPInit</servlet-class> // 서블릿으로 사용할 클래스의 완전한 이름
      <load-on-startup>1<load-up-startup> // 로딩 순서를 의미하며, 오름차순으로 서블릿 로딩
      <init-param>
        <param-name>jdbcdriver</param-name> // 코드를 직접 변경하지 않고 사용할 값을 변경 (초기화 파라미터 사용)
        <param-name>com.mysql.jdbc.Driver</param-value> 
      </init-param>
    </servlet>
```

< service(request, response) >   
    - 응답에 대한 모든 내용은 service()에 구현   
    - Servlet이 수신한 모든 request에 대해 service() 메서드가 호출
    
       * HttpServlet을 상속받은 Servlet 클래스(이하 하위 클래스)에서 service() 메서드를 오버라이딩하지 않았다면, 부모 호출
  - service() 메서드는 request의 type(Http Method : Get, Post, Put, Delete 등)에 따라 적절한 메서드 호출
  - 즉, 하위 클래스에서 오버라이드를 해두면 메서드 요청에 맞는 메서드를 알아서 호출할 수 있게 되는 것
  - 메서드가 return하면 해당 thread에 제거

< destory() >
  - 한 번만 수행
  - Web Application이 갱신되거나 WAS가 종료될 때 호출
  - Servlet 객체를 메모리에서 제거

< private static final long serialVersionUID = 1L >
  - 직렬화(implements Serializable)를 할 때 사용
  - Serializable을 상속하는 Class의 경우 Class의 versioning 용도로 사용하는 변수

        * 서블릿 클래스 : httpServlet 클래스를 상속
        * httpServlet에는 do.. 메서드가 다수 존재하는데, 여기에서는 그 중 doGet 메서드를 오버라이딩

-----
### Response를 이용한 웹 출력 방법 (Stream / Writer방법)
-----
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
		OutputStream os = response.getOutputStream();
		PrintStream out = new PrintStream(os, true);
		out.println("Hello Servlet!");

		PrintWriter out = response.getWriter();
		out.println("Hello Servlet!");
	}
}
```
 < PrintStream out = response.getWriter()의 동작 원리 (문자열 계열)>   
 
    - 클라이언트로부터 Servlet으로 요청이 들어오면 요청(Request)을 파악한 후 응답(Response)을 전달
    - Servlet으로 들어온 요청을 텍스트(HTML) 형태로 응답을 보내려면 아래와 같이 응답으로 내보낼 출력 스트림을 얻어야함
    - PrintWriter 클래스 : 바이트를 문자 형태를 가지는 객체로 바꿔줌   
                          클라이언트에게 문자 형태로 응답을 하고 싶기 때문에 out이라는 PrintWriter 클래스 객체를   
                          정의하고 getWriter() 메소드를 통해 인스턴스를 얻음
                          
    - getWriter() 메소드를 통해 응답으로 내보낼 출력 스트림을 얻어낸 후 out.print(HTML 태그) 형태로 작성하여 스트림에
      텍스트를 기록
    - 어떤 타입의 문서를 보낸다고 설정해주는 부분이 없다면, 그러면 웹 브라우저는 기본값으로 처리
    - 기본값 : text/html → 웹 브라우저는 응답받은 문자열을 모두 HTML 태그로 인식하여 처리
    
-----
### Annotation을 통한 매핑 : @WebServlet(urlPatterns = "/hello")
-----
1. @WebServlet Annotation은 urlPatterns 속성을 가짐 : 해당 서블릿과 매핑될 URL 패턴을 지정할 때 사용
2. /hello로 들어오는 URL을 HttpServlet이 처리하도록 설정
3. 두 개 이상 처리 예시 : @WebServlet(urlPattern = {"/hello", "/hello2"})
4. 초기화 파라미터 전달 방법
```java
 @WebServlet(urlPattern = {"/hello", "/hello2"}),
initParams = {
  @WebInitParams(name = "greetin", value = "Hello"),
  @WebInitParams(name = "title" value = "제목")
})
```
```java
import java.util.*;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * Browser에 현재 시간을 출력하는 웹 문서 (@WebServlet)
 */

// http://localhost:8081/webPro/hello
@WebServlet(urlPatterns = "/hello")
public class servlet_Ex extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet() 호출");
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset = UTF-8");
		
		PrintWriter out = resp.getWriter();
		out.println("<html>");
		out.println("<head><title> Servlet Document </title></head>");
		out.println("<body>");
		out.println("<h3> 현재시간 </h3>");
		out.println("<h4> Date 객체 : " + new Date() + " </h4>");
		Calendar cal = Calendar.getInstance();
		long millis = cal.getTimeInMillis();
		Date date = new Date(millis);
		out.println("<h4> Calendar 객체 생성 후 getTimeMillis() : " + cal.getTime() + " </h4>");
		out.println("<h4> Date 객체 생성 (매개변수 millis) : " + date + " </h4>");
		out.println("</body>");
		out.println("</html>");
	}
}
```
-----
### web.xml을 통한 매핑 
-----
```jsp
    <servlet>
        <servlet-name>default</servlet-name>
        <servlet-class>org.apache.catalina.servlets.DefaultServlet</servlet-class>
        <init-param>
            <param-name>debug</param-name>
            <param-value>0</param-value>
        </init-param>
        <init-param>
            <param-name>listings</param-name>
            <param-value>false</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>
    
    <!-- The mapping for the default servlet -->
    <servlet-mapping>
        <servlet-name>default</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
----------------------------------------------------------------------------------------
    <servlet>
        <servlet-name>jsp</servlet-name>
        <servlet-class>org.apache.jasper.servlet.JspServlet</servlet-class>
        <init-param>
            <param-name>fork</param-name>
            <param-value>false</param-value>
        </init-param>
        <init-param>
            <param-name>xpoweredBy</param-name>
            <param-value>false</param-value>
        </init-param>
        <load-on-startup>3</load-on-startup>
    </servlet>
    
    <!-- The mappings for the JSP servlet -->
    <servlet-mapping>
        <servlet-name>jsp</servlet-name> // jsp 서블릿으로 찾아감
        <url-pattern>*.jsp</url-pattern> // 파일명 무관하게 jsp파일로 끝나는 파일 모두에 대해
        <url-pattern>*.jspx</url-pattern>
    </servlet-mapping>
```

: web.xml
   ```jsp
    <servlet> // 서블릿 클래스 등록
    	<servlet-name>now</servlet-name> // 해당 서블릿을 참조할 때 사용할 이름
    	<servlet-class>ch17.servlet_Ex2</servlet-class> // 서블릿으로 사용할 클래스의 완전한 이름
    </servlet>
    
    <servlet-mapping> // 해당 서블릿이 어떤 URL을 처리할지에 대한 매핑 정보 등록
    	<servelt-name>now</servelt-name> // 매핑할 서블릿의 이름
    	<url-pattern>/now</url-pattern> // 매핑할 URL의 패턴
    	<url-pattern>/now2</url-pattern> // 매핑할 URL의 패턴 2(이럴 경우, 총 두 개의 서블릿 객체 생성)
    </servlet-mapping>
   ```
       <servlet>
               <servlet-name>서블릿 이름</servlet-name>
               <servlet-class>패키지명.클래스명</servlet-class>
       </servlet>    
       <servlet-mapping>
              <servlet-name>서블릿 이름</servlet-name>
              <url-pattern>URL 주소</url-pattern>
       </servletp-mapping>


-----
### RequestDispatcher
-----
1. Servlet에서 JSP페이지를 호출과 동시에 데이터를 동시에 JSP 페이지에 전송(Forward 방식)
2. 예제 코드
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
	
	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { // service()
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd"); // 요청 정보를 받아왔음 (더 나아가, DB에서 데이터를 가져올 수 있음)
		
		request.setAttribute("id", id);
		request.setAttribute("pwd", pwd); // request에 setAttribute를 통해 값을 전달할 준비
		RequestDispatcher rd = request.getRequestDispatcher("LoginProc.jsp"); // LoginProc.jsp 즉, JSP페이지에 forward 방식으로 reuqest의 parameter를 전달
		rd.forward(request, response);
	}
}
```

-----
### Context 사이트 추가 (server.xml)
-----
```jsp
<Host name="localhost"  appBase="webapps" unpackWARs="true" autoDeploy="true">
	<Context path="it" docBase="해당 Resoucres에 대한 전체 절대경로" privileged="true"/>
```
 1. Context 내 docBase에 설정된 디렉토리를 가상 디렉토리인 it로 연결
 2. 이 가상 디렉토리를 webapps 이하로 연결되는 형태가 되는 것
 3. 즉, localhost:portNumber/it/resources 로 연결

-----
### URL 패턴 매핑 규칙 
-----
1. /로 시작하고, /*로 끝나는 URL-Pattern : 경로 매핑을 위해 사용
2. *.로 시작하는 URL-Pattern : 확장자에 대한 매핑
3. 오직 /만 포함하는 경우 어플리케이션의 기본 서블릿으로 매핑
4. 나머지 다른 문자열은 정확한 매핑을 위해 사용
<div align = "center">
<img width="403" alt="제목 없음" src="https://github.com/sooyounghan/JAVA/assets/34672301/f18dd1c8-6a32-4986-a248-631c123dac48">
</div>

