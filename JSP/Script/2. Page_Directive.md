-----
### JSP Page 설정 정보
-----
```jsp
<%@ page contentType = "text/html; charset = "UTF-8"%>
```

1. <%@ page %> : Page Directive (JSP 페이지에 대한 정보를 설정할 때 사용)
2. JSP가 생성할 문서는 HTML
3. 문서의 Character Set은 UTF-8

-----
### JSP Page 구성 요소
-----
1. Directive : JSP 페이지에 대한 설정 정보를 지정할 때 사용

       <%@ 디렉티브 속성1 = "값1", [속성2 = "값2"...] %>

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/07b6f891-239d-43fe-a7a4-77bc3a5080bc">
</div>

2. 스크립트 요소
   
     - 사용자 폼에 입력한 정보를 데이터 베이스에 저장할 수 있음
     - 표현식 (Expression) : 값을 출력
     - 스크립틀릿 (Scriptlet) : 자바 코드를 실행
     - 선언부 (Declaration) : 자바 메서드(함수) 선언

4. 기본 객체 : request, response, session, application
  
5. 표현 언어 : Java, EL

-----
### Page Directvie
-----

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/093b4e18-462b-495f-9605-0b5d65310695">
</div>

```jsp
<%@ page language = "java" contentType = "text/html; charset = UTF-8" pageEncoding = "EUC-KR"%>
```
: JSP 페이지에서 사용할 언어는 java, ContentType은 HTML, Character Set은 UTF-8

1. page 디렉티브를 사용하면 JSP 페이지가 어떤 문서를 생성하는지, 어떤 자바 클래스를 사용하는지
   세션에 참여하는지, 출력 버퍼의 존재 여부와 같이 JSP 페이지를 실행하는데 필요한 정보를 입력

2. contentType 속성은 JSP가 생성할 문서의 MIME 타입을 입력 (기본값 : text/hmtl)
3. import 속성은 여러 타입 지정이 가능하고, 각 타입은 콤마로 구분

```jsp
<%@ page import = "java.util.Calendar, java.util.Date" %>
```

4. buffer와 autoFlush
   - buffer : JSP 페이지의 출력 버퍼 크기를 지정 ("none"이면 출력 버퍼 사용 하지 않음, "8kb"라면 8kb 크기의 출력 버퍼 사용)
   - autoFlush : 출력 버퍼가 다 찼을 경우 자동으로 버퍼에 있는 데이터를 출력 스트림에 보내고 비울지 여부 확인
     * true이면, 버퍼의 내용을 웹 브라우저에 보낸 후 버퍼를 비움
     * false일 경우, 에러를 발생

5. info : JSP 페이지에 대한 설명

6. errorPage, isErrorPage
   - errorPage : JSP 페이지 실행 도중 에러 페이지가 발생하면, 보여줄 에러 페이지를 지정
   - isErrorPage : 현재 페이지가 에러가 발생할 때 보여지는 페이지인지 여부를 지정 (true이면 에러 페이지를 보여줌, false이면 에러 페이지를 보여주지 않음)

```jsp
<%@ page language = "java" contentType = "text/html; charset = UTF-8" pageEncoding = "EUC-KR" errorPage = "/error.jsp" isErrorPage = "true"%>
```

      * 현재 페이지에서 에러가 발생하면 /error.jsp로 이동하도록 설정 (isErrorpage = "true"이어야 함을 주의)


-----
### JSP Page Include Directive
-----
1. < jsp : include > 액션 태그와 동일하게 지정한 페이지를 현재 위치에 포함시킴
2. WAS는 다른 파일의 내용을 현재 위치에 삽입 후 JSP 파일을 자바 파일로 변환 후 컴파일
3. <%@ include file = "포함할 파일"%>
   - file 속성은 include 디렉티브를 사용해서 포함할 파일의 경로

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/64bb03f7-f941-48b2-a71b-1c906cf710fa">
</div>

4. 모든 JSP 페이지에서 사용하는 변수 지정 / 모든 페이지에서 중복되는 간단한 문장 삽입에 사용
5. 코드 조각 자동 포함 기능
   - web.xml에서의 설정
```jsp
<jsp-config>
  <jsp-property-group> // JSP의 프로퍼티 포함
       <url-pattern>/view/*</url-pattern> // 프로퍼티를 적용할 JSP 파일의 URL 패턴 지정
       <include-prelude>/common/variable.jspf</include-prelude> // URL 패턴에 적용하는 JSP 파일 앞에 삽입할 파일 지정
       <include-coda>/common/footer.jspf</include-coda> // URL 패턴에 적용하는 JSP 파일 뒤에 삽입할 파일 지정
  </jsp-property-group>

  <jsp-property-group>
       <url-pattern>*.jsp</url-pattern>  // URL 패턴에 모두 일치하는 패턴이면,
       <include-prelude>/common/variable2.jspf</include-prelude> // 위 삽입 - 아래 삽입 순서
       <include-coda>/common/footer2.jspf</include-coda>
  </jsp-property-group>
</jsp-config>
