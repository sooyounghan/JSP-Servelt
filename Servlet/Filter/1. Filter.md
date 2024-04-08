-----
### Filter
-----
<div align="center">
<img src ="https://github.com/sooyounghan/Web/assets/34672301/668fa0db-8e4f-479d-b1fa-7224dd79a0d7">
</div>

1. HTTP Requst와 Response을 변경할 수 있는 재사용 가능한 클래스
2. 객체의 형태로 존재하며, 클라이언트에서 오는 Request와 최종 자원(JSP, Servlet 등) 사이에 위치해 클라이언트의 요청 정보를 알맞게 변경
3. 최종 자원과 클라이언트로의 Response 사이에 위치하여 최종 자원의 요청 결과를 알맞게 변경 가능
4. 실제 자원이 받는 요청 정보는 필터가 변경한 요청 정보가 되며, 클라이언트가 보는 응답 정보는 필터가 변경한 응답 정보
5. 클라이언트와 자원 사이에 한 개의 필터만 존재하는 것이 아니며, 여러 개의 필터가 모여 하나의 Filter Chain을 형성
6. 정보를 변경할 뿐만 아니라 흐름도 변경할 수 있음
   - 클라이언트의 Request를 Filer Chain의 다음 단계에 보내는 것이 아니라 다른 자원의 결과를 클라이언트에게 전송할 수 있음
   - 사용자 인증이나 권한 검사와 같은 기능을 구현할 때 용이하게 사용
     
-----
### Filter Chain
-----
<div align="center">
<img src ="https://github.com/sooyounghan/Web/assets/34672301/4123a38d-a98f-4a26-9c3c-783b7154d460">
</div>


1. 여러 개의 Filter가 모여서 하나의 Chain을 형성할 때, 첫 번째 Filter가 변경하는 요청 정보는 클라이언트의 Request 정보가 됨
2. Chain의 두 번째 Filter가 변경하는 요청 정보는 첫 번째 Filter를 통해 변경된 요청 정보
3. 요청 정보는 변경에 변경을 거듭하게 되는 것
4. 응답 정보의 경우도 요청 정보와 비슷한 과정을 거치는데, 적용 순서가 요청 때와는 반대 순서

-----
### 기본적인 웹 서버 - WAS - Servlet Container의 Logic
-----
<div align ="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/ebcbf8fe-7a2e-40dd-af03-8a2920ae9c7f">
<img src="https://github.com/sooyounghan/Web/assets/34672301/d6170a2c-a50c-414a-8ead-277578c380d7">
</div>

1. 웹 서버(=WAS)는 Cilent의 request에 따라 해당 WAS Container에서 URL Mapping을 통해 해당되는 Servlet을 Maaping
2. 해당되는 Servlet을 발견 후, 이에 대해 처리 후 reponse 해주는 방식이 기본적인 방식
3. 그렇다면, UTF-8과 같이 한글 문서가 들어간 부분에 대해서는 setCharacterEncoding을 공통적으로 처리해줘야하는 부분을 공통적으로 처리할 방법은?

-----
### Servlet Filter
-----
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/02225e7f-08ac-482a-bc96-dc271cc2d751">
</div>

1. Servler Container로 request가 진입되기 전, Filter 역할을 통해 먼저 그 조건에 대해 확인 
2. 실행된 후에, 해당 Servlet이 실행될 여부까지 유효성 검사 까지 가능
3. Servlet이 처리된 후 response로 전송되기 전에도 다시 한 번 유효성 검사까지 가능

-----
### Filter의 구현
-----
1. javax.servlet.Filter Interface : 클라이언트와 최종 자원 사이 위치하는 필터를 나타내는 객체가 구현해야 하는 인터페이스
2. javax.servlet.ServletRequestWrapper 클래스 : 필터가 요청을 변경한 결과를 저장하는 Wrapper
3. javax.servlet.ServletResponseWrapper 클래스 : 필터가 응답을 변경하기 위해 사용하는 Wrapper

-----
### Filter Interface
-----
1. 다음과 같은 메서드를 선언, Filter 기능을 제공할 클래스는 이를 알맞게 구현
2. public void init(FilterConfig filterConfig) throws ServletException : Filter 초기화 시 호출
3. public void doFilter(ServletRequest request, ServletResponse, FilterChain chian) throws java.io.IOException, ServletException
   - Filter 기능을 수행하며, chian을 이용해 Chain의 다음 필터로 처리 전달 가능
   - Filter의 역할을 하는 메서드
   - 즉, 서블릿 컨테이너는 사용자가 특정 자원을 요청했을 때, 그 자원 사이에 필터가 존재하는 경우 Filter 객체의 doFilter() 메서드 호출
   - 이 시점부터 필터가 적용되기 시작
     
4. public void destroy() : Filter가 Web Container에서 삭제될 때 호출
5. 기본적인 구현 예시
```java
package ServletEx.MyFilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class MyFilter implements Filter {
	public void init(FilterConfig filterConfig) throws ServletException {
		// Filter 초기화 작업
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// 1. request 파라미터를 이용해 요청 Filter 작업 수행

		// 2. Chain의 다음 Filter 처리
		chian.doFilter(request, response);

		// 3. response를 이용해 응답의 Filtering 작업 수행
	}

	public void destory() {
		// 주로 필터가 사용한 자원 반납
	}
}

```

   - Filter Interface의 doFilter()는 요청이 있을 때 마다 매번 실행
   - 예를 들어, 클라이언트가 요청한 자원이 필터를 거치면, 클라이언트의 요청이 있을 때마다 호출되며, JSP/Servlet과 마찬가지로 요청에 대해 필요 작업 처리
   - FilterChain 객체 : 클라이언트가 요청한 자원에 이르기까지 클라이언트의 요청을 거쳐 가게 되는 FilterChain을 의미 (즉, Chain에 있는 다음 Filter에 변경한 요청과 응답을 전달)
   - 즉, 요청을 Filtering한 객체가 또 다시 응답을 Filtering

 	     + request Parameter를 이용해 클라이언트의 요청을 Filtering (1에서 RequestWrapper 클래스를 사용해 클라이언트 요청 변경)
	     + chain.doFilter() 메서드 호출 (2에서 요청의 Filtering 결과를 다음 필터에 전달)
	     + response Parameter를 이용해 클라이언트로 가는 응답을 Filtering (3에서 Chain을 통해 전달된 응답 데이터를 변경해 그 결과를 클라이언트에게 전송)

-----
### init()
-----
1. inti() 메서드의 FilterConfig 매개변수는 필터의 초기화 파라미터를 읽어올 때 사용
2. 제공 메서드
   - String getFilterName() : 설정 파일에서 < filter-name >에 지정한 필터의 이름 return
   - String getInitParameter() : 설정 파일의 < init-param >에서 지정한 초기화 파라미터 값을 읽어옴 (존재하지 않으면 null 반환)
   - Enumeration< String > getInitparamterNames() : 초기화 파라미터 이름 목록을 구함
   - ServletContext getServletContext() : ServletContext 객체를 구함
   
-----
### Servlet Filter 예제
-----
1. 다음과 같이 ServletEx Serlvet 있다고 하자. (Package명 : ServletEx)
```java
import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// http://localhost:8081/webPro/hello
@WebServlet(urlPatterns = "/hello")
public class ServletEx extends HttpServlet {
	private static final long serialVersionUID = 1L;

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

2. 이 Servlet에 Filter를 적용하고 싶다면, 해당 Filter Class(MyFilter)를 생성
   - Filter Class가 속한 Package의 이름 : ServletEx.MyFilter.MyFilter
   - Filter Class 이름 : MyFilter
   - Interface 추가 : javax.servlet.Filter
   - Filter Interface의 추가로 다음과 같이 클래스 생성
     
```java
package ServletEx.MyFilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class MyFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("Filter!");
	}
}

```

3. Filter 설정을 하면, request에 대해 Filter 처리를 위해 실행
4. WAS가 처음 실행될 때, 해당 WAS Continaer에 Filter 적재

-----
### Servlet Filter 설정 - Web.xml
-----
1. web.xml 설정 (웹 브라우저의 요청이 동시에 여러 개 필터 매핑에 적용되는 경우, 표시한 순서대로 적용)
   - 기본 형식
```jsp
<filter>
	<filter-name>FilterName</filter-name>
	<filter-class>PackageName.FilterPackageName.FilterClass</filter-class>
	<init-param>
		<param-name>paramName</param-name>
		<param-value>value</param-name>
	</init-param>
</filter>

<filter-mapping>
	<filter-name>FilterName</filter-name>
	<url-pattern>*.jsp</url-pattern>
</filter-mapping>
```

   - < filter > : 웹 어플리케이션에서 사용할 필터 지정
   - < filter-mapping > : 특정 자원에 대해 어떤 필터를 사용할지 지정
   - < init-param > : 필터를 초기화할 때, 즉 필터의 init() 메서드를 호출할 때 전달할 Parameter 설정 (주로, 필터 사용 전 초기화 작업에 필요한 정보 제공)
   - < url-pattern > : 클라이언트가 요청한 특정 URI에 대해 Filtering 할 때 사용
   - < url-pattern > 대신 < servlet-name > 태그를 사용하면, 특정 서블릿에 대한 요청에 대해 Filter 적용
   - < dispatcher > 태그를 사용하면 필터가 적용되는 시점 설정 가능
     
```jsp
<filter>
	<filter-name>FilterName</filter-name>
	<filter-class>PackageName.FilterPackageName.FilterClass</filter-class>
	<init-param>
		<param-name>paramName</param-name>
		<param-value>value</param-name>
	</init-param>
</filter>

<filter-mapping>
	<filter-name>FilterName</filter-name>
	<servlet-name>ServletName</servlet-name>
	<dispatcher>INCLUDE</dispatcher>
</filter-mapping>
```
   - < dispatcher > 태그
     	+ 실행되는 자원을 클라이언트가 요청한 것인지, RequestDispatcher의 forward()를 통해서 요청한 것인지, include()를 통해 포함된 것인지에 따라 필터를 적용하도록 지정 가능
     	+ REQUEST : 클라이언트의 요청인 경우 필터를 적용 (기본값)
     	+ FORWARD : forward()를 통해 제어 흐름을 이동하는 경우 필터를 적용
     	+ INCLUDE : include()를 통해 포함되는 경우 필터를 적용

   - 하나의 < filter-mapping >에서 한 개 이상의 < url-pattern >과 < serlvet-name > 태그 설정 가능
```jsp
<filter-mapping>
	<filter-name>FilterName</filter-name>
	<url-pattern>*.jsp</url-pattern>
	<servlet-name>ServletName</servlet-name>
	<url-pattern>*.do</url-pattern>
	<servlet-name>ServletName2</servlet-name>
</filter-mapping>
```

2. 설정 방법
   - 전체적으로 설정해야 할 Filter라면, Servers의 web.xml에 설정
   - 특정 프로젝트에 설정할 것이라면, 특정 프로젝트의 web.xml에 설정
   - 위의 MyFilter의 경우에는 해당 프로젝트가 속한 Filter 프로젝트의 web.xml에 다음과 같이 설정

```jsp
<filter>
	<filter-name>MyFilter</filter-name>
	<filter-class>ServletEx.MyFilter.MyFilter</filter-class>
</filter>

<filter-mapping>
	<filter-name>MyFilter</filter-name>
	<url-pattern>/*</url-pattern>
</filter-mapping>
```

+ filter 태그 내에는 해당 Filter의 이름, 속한 패키지명.클래스명을 명시
+ filter-mapping은 해당 Filter의 이름에 대해 어떠한 URL의 요청을 받았을 때, Filter가 적용될 지 결정

2. 해당 Servlet Filter가 설정되어 실행되면, 어떠한 URL에 대해 요청해도 Filter가 실행되나, 현재 Filter에는 특정 Filter 또는 Servlet으로 전이시킬지 표시하지 않았으므로, 해당 Filter에서 계속 유지

3. FilterChain : Servlet의 흐름을 결정하는 역할
   
4. 다음과 같이 FilterChain chain에 대해 설정하면,
```java
package ServletEx.MyFilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class MyFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		chain.doFilter(request, response);
		System.out.println("Filter!");
	}
}
```

+ Filter의 흐름을 다음 filter나 Servlet이 실행되도록 설정하는 것이며, 해당 페이지로 request를 전달 (즉, 조건을 통해 설정 부분 설정 가능)
+ 이에 따라 처리 후 그 결과를 response로 다시 전달받음
+ 그리고 다음 문장인 콘솔 출력 문장 실행

5. 조금 더 명확한 흐름을 보기 위해 다음과 같이 설정하면,
```java
package ServletEx.MyFilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class MyFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("Before Filter!");
		chain.doFilter(request, response);
		System.out.println("After Filter!");
	}
}
```
+ Before Filter! 출력 - 다음 Filter 또는 Servlet으로 request 전달 - 처리 후 response 전달 - After Filter! 출력
  

-----
### Character Encoding Filter
-----
1. Encoding 작업 Filter를 통해서 하고 싶다면, 다음과 같이 가능
```java
package ServletEx.MyFilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class MyFilter implements Filter {
	private String endcoding;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		encoding = filterConfig.getInitParamter("encoding");
		if(encoding == null) {
			encoding = "UTF-8";
		}
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		request.setCharcterEncoding(encoding);
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		
	}
}
```

2. 즉, 다음 Servlet 또는 Filter로 이동하기 전에 request에 해당 characterEncoding 타입을 결정하여 전달

3. web.xml 설정
```jsp
<filter>
	<filter-name>MyFilter</filter-name>
	<filter-class>ServletEx.MyFilter.MyFilter</filter-class>
	<init-param>
		<param-name>encoding</param-name>
		<param-value>UTF-8</param-value>
	</init-param>
</filter>

<filter-mapping>
	<filter-name>MyFilter</filter-name>
	<url-pattern>/*</url-pattern>
</filter-mapping>
```

-----
### Servlet Filter 설정 - Annotation
-----
1. web.xml에 설정하지 않고도, Annotation을 이용해 가능한데, 다음과 같이 설정
```java
package ServletEx.MyFilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter(filterName="MyFilter", urlPatterns="/*")
public class MyFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		chain.doFilter(request, response);
	}
}
```

2. Annotation을 설정하면 web.xml을 통해 설정한 방법과 동일
3. 두 개 이상의 URL Pattern에 지정하고 싶다면, @WebFilter(filterName="MyFilter", urlPatterns={"/*.jsp", "/*.do"})
4. 주요 속성
   - urlPatterns : 필터를 적용할 URL 패턴 목록 지정
   - servletName : 필터를 지정할 서블릿 이름 목록 지정
   - filterName : 필터의 이름 지정
   - initParams : 초기화 파라미터 목록 지정
   - dispatcherTypes : 필터를 적용할 범위 지정 (열거타입인 DispatcherType에 정의된 값 사용 / 기본값 : DisptacherType.REQUEST)
     
