-----
### out 기본 객체 (javax.servlet.jsp.JspWriter)
-----
1. JSP 페이지가 생성하는 모든 내용은 out 객체를 통해 전송
2. JSP 컨테이너는 JSP 페이지에 사용되는 모든 표현문 태그와 HTML, 일반 텍스트 등을 out 내장 객체를 통해 웹 브라우저에 그대로 전달
3. 웹 브라우저에 데이터를 전송하는 출력 스트림으로, JSP가 생성한 데이터를 출력
4. JSP 페이지가 사용하는 버퍼는 실제로 out 기본 객체가 내부적으로 사용하고 있는 버퍼

        기본적으로 16kb 크기의 버퍼를 내부적으로 사용
    
<div align = "center">
<img src = "https://github.com/sooyounghan/JAVA/assets/34672301/6c88b74e-d38d-4056-8e23-97d65cfb3d5d">
</div>

-----
### pageContext 기본 객체
-----
1. JSP 페이지와 일대일로 연결된 객체

2. 주요 메서드
<div align = "center">
<img width="886" alt="image (1)" src="https://github.com/sooyounghan/Web/assets/34672301/9b74e13f-04d5-49dc-a77a-440391af1840">
</div>

-----
### application 기본 객체 (javax.servlet.ServletContext)
-----
1. 모든 JSP 페이지는 하나의 Application 기본 객체를 공유 
2. 웹 어플리케이션 전반에 사용되는 정보 포함
3. 웹 어플리케이션 초기화 파라미터 읽어오기

        - 서블릿 규약은 웹 어플리케이션에 걸쳐 사용할 수 있는 초기화 파라미터 정의 (WEB-INF\web.xml)
        - web.xml : 웹 어플리케이션을 위한 설정 정보를 담고 있음

```jsp
<context-param>
  <description>파라미터 설명(필수가 아님)</description>
  <param-name>파라미터이름</param-name>
  <param-value>파라미터값</param-value>
</context-param>
```

4. 웹 어플리케이션 초기화 파라미터 관련 메서드 (web.xml 파일에 파라미터를 추가해야함)
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/c6359c98-ebf2-4bf2-b41d-c88da57f932a">
</div>

5. 서버 정보 읽어오기
   - String getServerInfo() : 서버 정보를 구함
   - String getMajorVersion() : 서버가 지원하는 서블릿 규약의 메이저 버전 구함 (정수부)
   - String getMinorVersion() : 서버가 지원하는 서블릿 규약의 마이너 버전 구함 (소수부)

6. 로그 메세지 기록
   - void log(String msg) : msg를 로그에 남김
   - void log(String msg, Throwable throwable) : msg를 로그에 남기며, exception 정보도 함께 로그에 기록
  
         application.log(msg) : 로그 메세지 기록
         log(msg): JSP 페이지가 제공하는 로그 메세지 기록(jsp : 로그 메세지 기록)

7. 웹 어플리케이션 자원 구하기
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/96f2696b-b00c-40d8-9ae6-3526c3aee016">
</div>

    * URL 클래스 
     - URL 추상화 클래스로, 상속 불가(final Class)
     - InputStream openStream() : 사이트의 정보를 불러오는 메서드


    * 상태 유지를 위한 5가지 방법
        - Application, Session, Cookie
        - Input Hidden, Query String
