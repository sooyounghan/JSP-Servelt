-----
### jar 파일 추가
-----
: src - webapp - WEB-INF - lib

-----
### JSTL (Java Standard Tag Library)
-----
1. 논리적 판단, 반복 처리, 포맷 처리를 위한 커스텀 태그를 표준으로 정의한 것
   
2. JSTL 제공 태그 라이브러리 종류 (코어, 국제화, 함수 주로 사용)
<div aling = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/1980d4da-6568-45ac-a949-977cd6faaaa4">
</div>

    - 접두어는 JSP페이지가 커스텀 태그 호출 시 사용
    - 관련 URI는 JSTL이 제공하는 커스텀 태그를 구분해주는 식별자

3. 특징 : 항상 위의 태그가 붙어있어야 함
```jsp
<%@ taglib prefix="uri 주소를 대체할 접두사" uri="JSTL 태그 사용 주소"%>

<http://java.sun.com/jsp/jstl/core:out value = "내용"/>
```
```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- uri 주소를 c로 대체 -->
<c:out value = "내용"/>
```
-----
### Core Tag
-----
1. 변수 설정, 반복문, 조건문 에 해당하는 기능 제공
<div aling = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/9988ebb1-711d-486b-b8b8-a396b5dd34ca">
</div>

2. Core Tag
```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- uri 주소를 c로 대체 -->
<c:out value = "내용"/>
```

-----
### Core Tag - 변수 지원 태그
-----
1. < c:set > 태그
  - EL 변수의 값이나 EL 변수의 프로퍼티 값을 지정할 때 사용
  - < c:set var = "변수명" scope = "영역" value = "값"/> : var 이름에 해당하는 변수를 선언하고, 그 영역과 값을 지정   
    (= < c:set var = "변수명" scope = "영역">값</c:set>)

        A. var : 값을 지정할 EL 변수 이름 지정
        B. value : 변수의 값 지정(표현식 , EL, 정적 텍스트 사용해 값 지정 가능)
        C. scope : 변수를 지정할 영역 (page[기본값], request, session, application)

```jsp
<c:set var = "salary" scope = "session" value = "${2000*2}"/>
<c:out value = "${salary}"/>
```
  : session.setAttribute("salary", 2000*2)와 동일한 의미

  - < c:set target = "대상" property = "프로퍼티이름" value = "값"/> : target에 해당하는 대상 객체에 설정할 프로퍼티에 값을 지정  
    (= < c:set target = "대상" property = "프로퍼티이름">값</c:set>)
      
        A. target : 프로퍼티 값을 설정할 대상 객체 (표현식이나 EL 변수로 가능)
        B. property : 설정할 프로퍼티 이름 (자바빈 객체의 경우 프로퍼티 이름에 해당하는 setㅁ서드 제공)
        C. value : 프로퍼티의 값을 지정

```jsp
<% Member member = new Member(); %>
<c:set target="<%=member%>" property="name" value = "값1"/> <!--member.setName("값1")과 동일-->
<!-- target 설정 : 스크립틀릿에서 선언한 변수를 바로 받아옴 -->

<c:set var="m" value = <%=member%>/> <!--setName()과 동일-->
<c:set target="${m}" property="name" value = "값1"/> <!--member.setName("값1")과 동일-->
<!-- var로 변수에 대해 받아오고, 그 다음 target 설정 : set을 통해 받아왔으므로 EL 적용 -->

<% Map<String, String> prop = new HashMap<String, String>();
<c:set target="<%=prop%>" property="host" value = localhost"/> <!--prop.set("host", "localhost")와 동일-->
```

2. < c:remove > 태그
  - < c:remove var = "변수명" scope = "영역" value = "값"> : var에 해당하는 변수를 삭제
  - scope를 지정하지 않으면, 동일한 이름으로 저장된 모든 영역의 변수가 삭제

```jsp
<c:remove var = "salary"/> <!-- 모든 영역의 salary 삭제 -->
<c:remove var = "salary" scope = "request"/> <!-- request 영역의 salary 삭제 -->
```

-----
### Core Tag - 흐름 지원 태그
-----
1. < c:if > 태그
   - < c:if test = "조건식" > 조건식이 참 < /c:if >: if문에 해당 
   - 조건식에는 EL이나 정적 문자열만 가능하며, Deferred Expression은 불가능
   
```jsp
<c:if test = "${salary > 2000}">
<p>My salary is:  <c:out value = "${salary}"/><p>
</c:if>
```

2. < c:choose >, < c:when >, < c:otherwise > 태그
  - < c:choose > ~ < /c : choose > : switch 구문과 if ~ else 문의 혼합 (다수의 < c:when > 태그 중첩 
  - < c:when test = "조건식" > ~ < /c:when > : 조건식에 해당하면 진입
  - < c:otherwise > ~ < /c:otherwise > : 어떠한 조건식에도 일치하지 않으면, 진입 (else)

  ```jsp
<c:choose>
         
  <c:when test = "${salary <= 0}">
    Salary is very low to survive.
  </c:when>
         
  <c:when test = "${salary > 1000}">
     Salary is very good.
  </c:when>
         
  <c:otherwise>
     No comment sir...
  </c:otherwise>

</c:choose>
```

3. < c:foreach > 태그
   - 배열, Collection, Map에 저장되어 있는 값들을 순차적 처리할 때 사용
   - < c:forEach var = "변수명" begin = "시작포인트" end = "종료포인트" step = "증가분"> ~ < /c:forEach > : 반복문 (시작 포인트 ~ 종료 포인트)
   - < c:forEach var = "변수명" items = "항목명" begin = "시작포인트" end = "종료포인트"> ~ < /c:forEach>
   - forEach 태그 몸체에서 현재 사용하는 항목의 인덱스 값을 사용하고 싶으면, varStatus = "status명" 속성 이용 [varStatus : 루프 상태를 저장할 EL 변수]

         * index : 루프 실행에서 현재 인덱스
         * count : 루프 실행 횟수
         * begin : begin 속성값
         * end : end 속성값
         * step : set 속성값
```jsp
<c:forEach var = "i" begin = "1" end = "5">
      Item <c:out value = "${i}"/><p>
</c:forEach>
```

< 다중 for문 >
```jsp
<c:forEach var = "i" begin = "1" end = "5">
   <c:forEach var = "j" begin = "1" end = "5">
      Item <c:out value = "${i, j}"/><p>
   </c:forEach>
</c:forEach>
```

<1부터 10까지의 합 구하기>
```jsp
<c:set var = "sum" value = "0"/>

<c:forEach var = "i" start = "1" end = "10">
<c:set var ="sum" value = "${sum = sum + i}"/>
</c:forEach>
```

<1부터 10까지 2씩 건너뛰며 총합 구하기>
```jsp
<c:set var = "sum" value = "0"/>

<c:forEach var = "i" start = "1" end = "10" step = "${i = i+2}">
<c:set var = "sum" value = "${sum = sum + i}"/>
</c:forEach>
```

<별 찍기>
```jsp
<c:forEach var = "i" begin = "1" end = "5">
   <c:forEach var = "j" begin = "1" end = "${5 - i}">
   &nbsp; 
   </c:forEach>
   <c:forEach var = "j" begin = "1" end = "${2 * i - 1}">
   <c:out value = "*"/>     
   </c:forEach>
   <br> 
</c:forEach>
```

4. < c:forTokens > 태그
  - 값들의 묶음에 대해 구분자로 구분해 변수명 var에 저장
  - 텍스트와 같이 대량의 데이터를 저장할 때 구분자로 사용
  - < c:forTokens items = "값1, 값2, 값3,..." delims = "구분자", var = "name" > ~ < /c:forTokens > 
  - begin, end, step, varStatus 동일하게 지원
                
```jsp
<c:forTokens items = "Zara,nuha,roshy" delims = "," var = "name">
    <c:out value = "${name}"/><p>
</c:forTokens>
```

-----
### Core Tag - URL 처리 태그
-----
1. URL 생성 : < c:url > 태그
  - < c:url value = "URL" var = "varName" scope = "영역" > ~ < /c:url >
  - var 속성 생략 : 현재 위치에서 생성한 URL 출력
  - < c:param > 태그를 이용해 파라미터를 URL에 추가 가능  

        < c:param name = "name" value = "value"> : URL 태그와 import 태그가 동시에 사용되며, URI에 정보를 전송할 때, 해당 parameter를 같이 전송
```jsp
<c:url value = "/index.jsp" var = "myURL">
   <c:param name = "trackingId" value = "1234"/>
   <c:param name = "reportType" value = "summary"/>
</c:url>
<c:import url = "${myURL}"/>
```
      결과 : "/index.jsp?trackingId=1234;reportType=summary" : <c:param ..>의 정보가 같이 담김
      
2. 리다이렉트 처리 : < c:redirect > 태그
  - < c:redirect url = "URL" context = "컨텍스트 경로" > ~ < /c:redirect >
```jsp
<c:redirect url = "/use_c_set.jsp"/> <!-- 현재 컨텍스트 경로에서 리다이렉트 -->
   <c:param name = "trackingId" value = "1234"/>
   <c:param name = "reportType" value = "summary"/>
</c:redirect>

<c:redirect url = "/use_c_set.jsp" context = "/abc" /> <!-- abc 컨텍스트 경로에서 리다이렉트 -->
   <c:param name = "trackingId" value = "1234"/>
   <c:param name = "reportType" value = "summary"/>
</c:redirect>
```

  - < c:redirect > 태그를 실행하면 그 이후의 코드는 미실행


-----
### Core Tag - 기타 코어 태그
-----
1. < c:out > 태그
   - < c:out value = "내용" > : 브라우저에 출력해주는 태그문
   - out.print(< %= % >) = < c:out value = "내용">

         out : JSP 내장 객체를 이용해 브라우저로 출력
         < c:out value = "내용" > : JSTL의 core의 out 태그를 이용해 브라우저 출력 (JSP 표현식 이용)
      
          예시) < c:out value = "${'<tag> , &'}" > : &{ }에서 ' '안에 내용을 브라우저에 출력 (1회성)
       
-----
### 국제화 태그
-----
1. 숫자, 날짜, 시간을 Formatting 하는 기능과 국제화, 다국어 지원 기능을 제공
2. 태그 : < fmt >

       <%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

-----
### formatNumber : 숫자를 양식에 맞춰서 출력
-----
1. 기본 양식
```jsp
<fmt:formatNumber value="수치 데이터" [type = "{number | currency | percent}"] [pattern = "패턴"] [currencySymbol="화폐 단위"]
[groupingUsed="{true | false}"] [var="변수 이름"] [scope="{page | request | session | application}"] >
```
2. 속성 설명
   - value : 형식화할 수치 데이터
   - type : 숫자, 통화, % 중 어느 형식으로 표시할 지정
   - pattern : 사용자가 지정한 형식 패턴
   - currencySymbol : 통화 기호, 통화 형식(type = "currency")일 때만 적용
   - groupingUsed : ,와 같이 단위를 구분할 때 사용하는 기호 표시 여부 결정 (true : 구분 기호 사용 / false : 구분 기호 미사용)
   - var : 형식 출력 결과 문자열을 담는 변수 이름
   - scope : 변수의 영역 지정

```jsp
<fmt:formatNumber value="1234567.89" pattern="#,#00.0#"/> : 결과 : 1,234,567.89
<fmt:formatNumber value="1234567.89" groupingUsed="false"/> : 결과 : 1234567.89
<fmt:formatNumber value="10000" type="currency"/> 결과 : \10,000
<fmt:formatNumber value="10000" type="currency" currencySymbol="$"/> : 결과 : $10,000
```

```jsp
      <h3>Number Format:</h3>
      <c:set var = "balance" value = "120000.2309" />
         
      <p>Formatted Number (1): <fmt:formatNumber value = "${balance}" type = "currency"/></p>

      <!-- 정수 세자리 -->
      <p>Formatted Number (2): <fmt:formatNumber type = "number" maxIntegerDigits = "3" value = "${balance}" /></p>

      <!-- 소수점 세자리 -->
      <p>Formatted Number (3): <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${balance}" /></p>

      <!-- 120,000에서 ,제거 -->
      <p>Formatted Number (4): <fmt:formatNumber type = "number" groupingUsed = "false" value = "${balance}" /></p>

      <!-- 100을 곱한 후 (%) 정수 세자리 %-->
      <p>Formatted Number (5): <fmt:formatNumber type = "percent" maxIntegerDigits="3" value = "${balance}" /></p>

      <!-- 100을 곱한 후 (%) 소수점 10자리 (빈공간은 0) %-->
      <p>Formatted Number (6): <fmt:formatNumber type = "percent" minFractionDigits = "10" value = "${balance}" /></p>

      <!-- 100을 곱한 후 (%) 정수 세자리 -->
      <p>Formatted Number (7): <fmt:formatNumber type = "percent" maxIntegerDigits = "3" value = "${balance}" /></p>

      <!-- pattern 형태로 표현-->
      <p>Formatted Number (8): <fmt:formatNumber type = "number" pattern = "###.###E0" value = "${balance}" /></p>
   
      <!-- 원화 표시 // setLocale vale = "지역" // type = "화폐 -->
      <p>Currency in USA : <fmt:setLocale value = "en_US"/> <fmt:formatNumber value = "${balance}" type = "currency"/>
```

-----
### formaDate : 날짜 정보를 담고 있는 객체를 Formatting하여 출력할 때 사용 (Date 객체 -> Format)
-----
1. value 속성에 date를 넣어 처리하기 위해 java.util.Date 클래스로 객체를 생성하는 것이 필수적
   
```jsp
 <fmt:formatDate value="date" [type = "{time | date | both}"] [dateStyle="{default | short | medium | long | full}"]
[timeStyle="{default | short | medium | long | full}"] [pattern="customPattern"] [timeZone="timeZone"]
[var="변수 이름"] [scope="{page | request | session | application}"] >
```

2. 속성
   - value : 형식화될 Date와 Time
   - type : 형식화될 데이터 타입 셋 중 하나 지정 (time / date / 모두)
   - dateStyle : 미리 정의된 날짜 형식 중 하나 지정
   - timeStyle : 미리 정의된 날짜 형식 중 하나 지정
   - pattern : 사용자 지정 형식 스타일
   - var : 형식 출력 결과 문자열을 담는 변수 이름
   - scope : 변수의 영역 지정

```jsp
<fmt:formatNumber value="$ {now}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초"/> : 결과 : 2016년 03월 15일 07시 52분 24초
```

```jsp
      <h3>Date Number Format:</h3>
      <c:set var = "now" value = "<% = new java.util.Date()%>" />

      <!-- 현재 시간 출력 -->
      <p>Formatted Date (1): <fmt:formatDate type = "time" value = "${now}" /></p>

      <!-- 연월일 출력 -->      
      <p>Formatted Date (2): <fmt:formatDate type = "date" value = "${now}" /></p>

      <!-- 연월일, 현재시간 출력-->
      <p>Formatted Date (3): <fmt:formatDate type = "both" value = "${now}" /></p>

      <!-- 연월일, 현재시간 출력 2/29/24, 2:50 PM -->
      <p>Formatted Date (4): <fmt:formatDate type = "both" dateStyle = "short" timeStyle = "short" value = "${now}" /></p>

      <!-- 연월일, 현재시간 출력 Feb 29, 2024, 2:50:34 PM -->
      <p>Formatted Date (5): <fmt:formatDate type = "both" dateStyle = "medium" timeStyle = "medium" value = "${now}" /></p>

      <!-- 연월일, 현재시간 출력 February 29, 2024 at 2:50:34 PM KST -->
      <p>Formatted Date (6): <fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${now}" /></p>

      <!-- pattern에 맞게 출력 -->
      <p>Formatted Date (7): <fmt:formatDate pattern = "yyyy-MM-dd" value = "${now}" /></p>
```

-----
### parseDate : 문자열을 날짜로 Parsing (String의 날짜 형식 -> Parsing)
-----
1. 문자열로 표시된 날짜 및 시간 값을 java.util.Date로 Parsing
```jsp
<fmt:parseDate value = "날짜값" [type = "타입"] [dateStyle = "날짜스타일"] [timeStyle = "시간스타일"] [pattern = "패턴"]
[timeZone = "타임존"][parseLocale = "로케일"] [var = "변수 명"][scope = "영역"]/>
```

2. 예시
```jsp
<fmt:parseDate value = "2009-03-01 13:00:59" pattern = "yyyy-MM-dd HH:mm:ss" var = "date"/> : 2009-03-01 13:00:59
<fmt:parseDate value = "2009-03-01 13:00:59" pattern = "yyyy-MM-dd" var = "date"/> : 2009-03-01
```

-----
### parseNumber : 문자열을 수치로 Parsing
-----
1. 문자열을 숫자(Number) 타입으로 변환해 주는 기능
```jsp
<fmt:parseNumber value = "값" [type = "값타입"] [pattern = "패턴"] [parseLocale = "통화코드"] [integerOnly = "true|fasle"]
[var = "변수명"][scope = "영역"]/>
```

2. 속성
   - value : Parsing할 문자열
   - type : value 속성의 문자열 타입 지정 (number[기본값], currency, percentage가 올 수 있음)
   - pattern : 직접 parsing할 때 사용 양식
   - integerOnly : 정수 부분만 파싱할 지 여부 지정 (기본값 : false)
   - var : Parsing 결과를 지정할 변수명
   - scope : 변수를 지정할 영역 지정
     
```jsp
 <fmt:parseNumber value = "1,100.12" pattern = "0,000.00" var = "num"/> : 1,100.12
 <fmt:parseNumber value = "1,100.12" var = "num" integerOnly="true"/> : 1,100
```
