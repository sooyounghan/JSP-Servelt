-----
### EL(Expression Language)
-----
1. 값을 표현하는데 사용되는 스크립트 언어
2. $와 괄호({ }) 그리고 표현식 사용하여 값을 표현
   - ${expr} 같이 표현
   - 표현 언어가 정의한 문법에 따라 값을 표현하는 식
   - JSTL의 속성값으로 사용 가능

3. 표현식으로는 Attribute나 Parameter 등 JSP파일에서 출력할 용도로 사용
   - 변수 이름으로는 출력이 불가능
   - Attribute : ${Attribute_name}
   - Parameter : ${param.이름} 또는 {paramValue.이름[인덱스]}의 형태

          <%= %> : 데이터, 변수 등 화면에 출력하는 용도로 사용
          ${ } : Attribute, Parameter 등 객체의 값을 얻어와 출력하는 용도로 사용

4. 즉, View를 위한 데이터 추출 표현식
5. 저장 객체에서 값을 추출해서 출력하는 표현식

```jsp
<%
i = 3
request.setAttribute("i_a", 3);
%>
i = ${i_a};
i = ${i_a > 4};
i = ${i_a ne 4};
```

```jsp
${param.id}, $[param.password} // Parameter에서의 id와 password 값을 받아올 수 있음
```

6. EL 연산자
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/fd58faa0-b098-495f-b7a4-60453c75bece">
</div>

-----
### EL(Expression Language) : ${} / #{}
-----
1. ${ } :구문을 분석할 때 곧바로 값을 계산
```jsp
<%
  Member m = new Member();
  m.setName("이름1");
%>

<c:set var = "m" value = <%=m%>"/>
<c:set var = "name" value = "${m.name}"/> <%-- 이 시점에서 바로 값 계산 --%>
<% m.setName("이름2");>
${name} <%-- name의 이름 값은 "이름1" --%>
```

  - 한 번 할당한 이후, 어떠한 갑슬 변경하더라도 name 변수의 값은 변경되지 않음

2. #{} : 실제로 값을 사용할 때 계산
   - 값이 필요할 때 계산을 수행하므로 Deferred Expression이라고 부름
   - 곧바로 생성되는 것이 아니므로 JSP 템플릿 텍스트에서 사용 불가 (예) < c:out >와 같이 허용되는 곳만 가능)
   
```jsp
<%
  Member m = new Member();
  m.setName("이름1");
%>

<c:set var = "m" value = <%=m%>"/>
<c:set var = "name" value = "#{m.name}"/> <%-- 이 시점에서 값을 계산하지 않음 --%>
<% m.setName("이름2");>
#{name} <%-- 사용될 때 계산하므로 이름2 --%>
<% m.setName("이름3");>
#{name} <%-- 사용될 때 계산하므로 이름3 --%>
```

-----
### EL(Expression Language) 기본 객체
-----
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/b2e32486-0ed4-418d-8a1e-4e03777a11d0">
</div>

 
-----
### EL(Expression Language) 수치 연산자 중 주의사항
-----
1. 사칙 연산자 중 + 연산자 / 문자열 연결 += 연산자 (중요)
   - EL에서는 '수치 연산자' 이므로 "문자열" + 숫자 / 숫자 + "문자열"일지라도, 문자열을 숫자로 변환하고 다음 연산 수행
   - 하지만, 변환할 수 없는 숫자는 에러 발생
```jsp
${"10" + 1} <!-- 10 + 1 -->
${"일" + 1} <!-- "일" 변환 불가 : 에러 -->
```

  - (+) 연산자는 피연산자를 숫자로 변환한 뒤에 연산을 수행
  - 이를 구분하기 위해 문자열 연결 연산자로 (+=) 사용

```jsp
<%=request.setAttribute("title", "JSP"); %>
${"문자" += "열" += "연결"} : 문자열연결
${"제목 : " += title} : 제목 : JSP
```
  
2. 비교 연산자
    - 숫자의 경우 자바 연산자와 동일
    - 문자열 비교 : String.compareTo() 메서드를 사용

          ${someValue == "2004"}
          : someValue.compareTo("2004") == 0의 의미

    - 비교 선택 연산자 : 자바의 삼항 연산자와 동일 (<수식> ? <값1> : <값2>)
      
3. empty 연산자
   - 텅빈 객체인지 검사하기 위해 사용
   - empty <값>
  
         A. <값>이 null이면 true
         B. <값>이 빈 문자열("")이면 true
         C. <값>이 길이가 0인 배열이면 true
         D. <값>이 빈 Map / Collection이면 true
         E. 이 외의 경우는 모두 false

4. Collection
   - List : ${[원소1, 원소2, 원소3]}
   - List에서 요소 접근 : ${var[index]}
     
         <c:set var = "vals" value = "${[1, 2, 3, 5]}"/ >
         ${vals[2]} = 5

   - Map : ${'Key1' : 'Value1', key2 : value2]}  

         * 중괄호 사이 (키, 값) 쌍을 ,로 지정
         * 키와 값은 :으로 구분
     
         <c:set var = "mem" value = "${['name' : '홍길동', 'age' : 20]}"/ >
         ${mem.name}, ${mem.age}

   - Set : ${{원소1, 원소2, 원소3}}
  
         <c:set var = "hangul" value = "${{'가', '나', '다'}}"/ >
         ${hangul}

  5. 세미콜론(;) 연산자
     - ${ A ; B} : A값은 출력되지 않고, B값만 출력

           ${1 + 1; 10 + 10} : 20
       
-----
### EL(Expression Language) 객체 접근
-----
< 예 : Cookie 클래스의 ID에 해당하는 value 접근 방법 >
```jsp
${cookie.ID.value}
```
< 예 : pageContext.getRequest().getMethod() >
```jsp
${pageContext.request.method}
```

1. 객체에 저장된 값에 접근 할 떄 점(.)이나 대괄호([]) 사용 (동일한 연산자)
   : cookie.name은 cookie['name']과 동일
   
3. <표현1>.<표현2> 또는 <표현1>[<표현2>]

        A. <표현1>을 <값1>로 변환
        B. <값1>이 null이면 null 반환
        C. <값1>이 null이 아니면 <표현2>를 <값2>로 변환(만약, null이면 null return)
        D. <값1>이 List, Map, 배열이면,
           - <값1>이 Map이면, <값1>.containsKey<값2>가 false이면 null return
                                                      true이면 <값1>.get(<값2>) return
           - <값1>이 List나 배열이면, <값2>가 정수값인지 확인 (아닌 경우 에러 발생)
                                     <값1>.get(<값2>) 또는 Arrays.get(<값1>, <값2>) return
           - <값1>이 다른 객체면, <값2>를 문자열로 변환
                                 <값1> 객체가 <값2>를 이름으로 갖는 읽기 가능한 프로퍼티를 가지면, 프로퍼티 값 리턴
                                 그렇지 않으면 에러 발생

4. EL에서 page, request, session, application 영역에 저장된 속성에 접근할 때는
   pageScope, requestScope, sessionScope, applicationScope 기본 객체 사용

        예를 들어, ${name}으로만 지정하면, 위의 네 영역에 name 속성이 존재하는지 확인하고, 존재하면 그 속성 값 사용



-----
### EL 예제
-----
<계산기 폼>
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<h2>계산기</h2>
	<form action = "ElCulProc.jsp" method = "post">
		<table>
			<tr height = "40">
				<td align = "center" width = "10"><input type = "text" name = "exp1"></td>
				<td><select name = "exp2">
					<option value = "+">+</option>
					<option value = "-">-</option>
					<option value = "*">*</option>
					<option value = "/">/</option>					
				</select>
				</td>
				<td align = "center" width = "10"><input type = "text" name = "exp3"></td>
				<td align = "center" width = "10"> = </td>
				<td align = "center" width = "10"><input type = "text" name = "exp4"></td>					
				<td align = "center" width = "10"><input type = "submit" value = "결과보기"></td>				
			</tr>
		</table>
	</form>
</body>
</html>
```

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<h2> 결과보기 </h2>
<%
	String exp2 = request.getParameter("exp2");

	switch(exp2) {
		case "+" : 
%>
	결과는 ${param.exp1} ${param.exp2} ${param.exp3} = ${param.exp1 + param.exp3}
<%
		break;
		case "-" :
%>
	결과는 ${param.exp1} ${param.exp2} ${param.exp3} = ${param.exp1 - param.exp3}
<%
		break;
		case "*" :
%>
	결과는 ${param.exp1} ${param.exp2} ${param.exp3} = ${param.exp1 * param.exp3}
<%
		break;
		case "/" :
%>
	결과는 ${param.exp1} ${param.exp2} ${param.exp3} = ${param.exp1 div param.exp3} 
<%
		break;
		default : break;
	}
%>
</body>
</html>
```

< 계산 홈페이지에서 피 연산자의 값과 결과값 유지 >
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<h2>계산기</h2>
<form action = "ElCul.jsp" method = "post">
<table>
   <tr height = "40">
      <td align = "center" width = "10"><input type = "text" name = "exp1" value = "${param.exp1}"></td> <!-- 값을 입력받으면 유지 -->
      <td><select name = "exp2">
         <option value = "+">+</option>
         <option value = "-">-</option>
         <option value = "*">*</option>
         <option value = "/">/</option>					
      </select>
      </td>
      <td align = "center" width = "10"><input type = "text" name = "exp3" value = "${param.exp3}"></td> <!-- 값을 입력받으면 유지 -->
      <td align = "center" width = "10"> = </td>
	<%
	String exp2 = request.getParameter("exp2");
	
	if(exp2 == null) { <!-- exp2의 값이 없으면 입력 칸 유지 -->
	%>
		<td align = "center" width = "10"> <input type = "text" name = "exp4"></td>
	<%
	}
	else { <!-- epx2 값을 입력받으면 맞는 사칙연산 수행 -->
		switch(exp2) {
			case "+" : 
		%>
			<td align = "center" width = "10"><input type = "text" name = "exp4" value = "${param.exp1 + param.exp3}"></td>
		<%
			break;
			case "-" :
		%>
			<td align = "center" width = "10"><input type = "text" name = "exp4" value = "${param.exp1 - param.exp3}"></td>
		<%
			break;
			case "*" :
		%>
			<td align = "center" width = "10"><input type = "text" name = "exp4" value = "${param.exp1 * param.exp3}"></td>
		<%
			break;
			case "/" :
		%>
			<td align = "center" width = "10"><input type = "text" name = "exp4" value = "${param.exp1 div param.exp3}"></td>
		<%
			break;
		}
	}
	%>
				
   <td align = "center" width = "10"><input type = "submit" value = "결과보기"></td>				
</tr>
</table>
</form>
</body>
</html>
```
