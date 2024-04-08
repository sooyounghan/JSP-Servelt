<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/508b2d26-c845-4076-b33a-6ebdb3e539b1">
</div>

-----
### jsp : include
-----
1. 위치한 부분에 지정한 페이지를 포함

<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/107865b6-15e6-4f7a-8c30-c83e426d57ce">
</div>

      A. main.jsp가 웹 브라우저의 요청을 받음
      B. 출력 내용 A를 출력 버퍼에 저장
      C. <jsp:include>가 실행되면 실행 흐름을 sub.jsp로 이동
      D. 출력 내용 B를 출력 버퍼에 저장
      E. sub.jsp의 실행이 끝나면, 요청 흐름이 다시 main.jsp의 <jsp:include>로 회귀
      F. 이후 부분인 출력 내용 C를 버퍼에 저장
      G. 출력 버퍼의 내용을 응답 데이터로 전송

2. <jsp:include page = "포함할 페이지" autoflush = "true"/>
   - page : 포함할 JSP페이지의 경로 지정
   - flush : 지정한 JSP 페이지를 실행하기 전 출력 버퍼를 플러시할지 여부 결정 (기본값 : false)

         출력 버퍼를 flush하는 것은 출력 내용 A를 <jsp:include>가 실행하는 시점에 출력 버퍼의 내용을 flush하고,
         sub.jsp 페이지의 흐름으로 이동하는 것을 의미. 출력 버퍼의 내용을 flush하게 되면, http 응답 헤더가 웹 브라우저와
         함께 전송되므로, 이후 새롭게 추가되는 헤더 정보는 반영되지 않음

3. 공통 영역을 포함할 수 있음

-----
### jsp : param
-----
1. < jsp : inlcude > 태그를 이용해 포함할 JSP 페이지에 파라미터 추가 가능
2. 자식 태그로 추가하는 의미 (name과 value로 이름과 값을 포함 가능)
3. String 타입 값만 전달 가능 (따라서, 다양한 객체 값을 위해서는 기본 객체 속성을 이용하는 것이 좋음)
   
```jsp
<jsp:include page = "/top.jsp" flush = "false">
  <jsp:param name = "param1" value = "value1"/>
  <jsp:param name = "param2" value = "value2"/>
</jsp:include>
````

4. 이미 동일한 이름의 파라미터가 존재하면 기존 파라미터 값을 유지하며 새로운 값을 추가 (include directive와의 차이점)
<div align = "center">
<img width="808" alt="image (5)" src="https://github.com/sooyounghan/Web/assets/34672301/2c75beeb-bf0f-4c78-ad57-9fbff77780f5">
</div>

  - < jsp:param > 액션 태그로 추가한 파라미터가 기존 파라미터보다 우선
  - body_sub.jsp에서 request.getParameterValues("name") : 기존 값과 추가된 값 모두 출력
  - 단, < jsp : param > 으로 추가한 파라미터는 < jsp : include > 액션 태그로 포함한 페이지에서만 유효

4. < jsp:include > 액션 태그와 include Directive의 차이점
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/ab23d7b8-c468-42fe-aec1-af1790ca9b56">
</div>


-----
### jsp : forward
-----
1. 하나의 JSP 페이지에서 다른 JSP 페이지로 요청 처리를 전달할 때 사용 (1번의 요청, 1번의 응답)

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/9fb149e8-cf24-4487-a808-261f4df8f9dc">
</div>

      A. 웹 브라우저의 요청을 from.jsp에 전달
      B. from.jsp는 <jsp:forward> 액션 태그 실행
      C. <jsp:forward> 액션 태그를 실행하면 요청 흐름이 to.jsp로 이동
      D. 요청 흐름이 이동할 때 from.jsp에서 사용한 request 기본 객체와 response 기본 객체가 to.jsp로 전달 (중요)
      E. to.jsp가 응답 결과를 생성
      F. to.jsp가 생성한 결과가 웹 브라우저에 전달 (중요)
        * 주소는 from.jsp 그대로임을 주의

2. < jsp:forward page = "이동할 페이지" />
3. < jsp:forward >는 웹 컨테이너 내에서 요청 흐름을 이동시키기 때문에, 웹 브라우저는 다른 JSP를 요청 처리했다는 사실을 알지 못함

4. < jsp:forward > 와 출력 버퍼와의 관계
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/15df2bea-2947-4904-9bc7-6f3554398f98">
</div>    

   - 중요한 점은 < jsp : forward > 가 실행하기 전에 출력 버퍼를 비우므로, 이전에 출력 버퍼에 저장한 내용은 웹 브라우저에 미전송
   - 따라서, < jsp : forward > 액션 태그에 위치한 코드는 실행조차 되지 않음
   - 올바르게 동작하기 위해서는 액션 태그를 실행하기 전 웹 브라우저에 데이터가 전송되면 안 됨

            flush한 이후거나, flush = "none"으로 설정하면, 오류 발생

5. < jsp : param > 액션 태그를 이용해 이동할 페이지에 파라미터 추가 [이 경우, request의 값과 중복되면, param이 값이 우선]
```jsp
<jsp:forward page = "/top.jsp" flush = "false">
  <jsp:param name = "param1" value = "value1"/>
  <jsp:param name = "param2" value = "value2"/>
</jsp:forward>
````

-----
### forward 방식 예제
-----
1. link_forward_actionTag.jsp에서 name과 age의 값을 전달 -> c.jsp -> forward d.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
      <meta charset="UTF-8">
      <title>Insert title here</title>
</head>

<body>
      <a href = "c.jsp?name=a&age=20" target = "_self">c.jsp</a>
</body>
</html>
```

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
      <meta charset="UTF-8">
      <title>Insert title here</title>
</head>

<body>
      <%
      System.out.println("forwarding");
      out.println("name = " + request.getParameter("name"));
      out.println("age = " + request.getParameter("age")); // 출력 버퍼에서 사라지므로 미출력
       %>
      <jsp:forward page = "d.jsp" /> // d.jsp로 흐름 이동 (request, response 객체 값 같이 전달)
</body>
</html>
```
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
      <meta charset="UTF-8">
      <title>Insert title here</title>
</head>

<body>
      <%
      out.println(request.getParameter("name")); // 값 출력 ok
      out.println(request.getParameter("age")); // 값 출력 ok
       %>
</body>
</html>
```

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/71d068e6-7df3-4f44-b906-65832ec4ac95">
</div>

2. Servlet에서의 forward 예
 ```jsp
<jsp:forward = "URL">
- pageContext.forward("URL");
- requestDispatcher rd = request.getRequestDispatcher("URL");
  rd.forward(reqeust, resopnse);
```

-----
### jsp : useBean
-----
1. 자바빈 (JavaBean)
   - 속성(데이터), 이벤트 변경, 객체 직렬화를 위한 표준 : JSP에서는 속성을 표현하기 위한 용도
   - 자바빈 규약을 따르는 클래스
   - JSP와 DataBase 간의 데이터를 쉽게 접근하고, 전달할 수 있도록 설정한 클래스
     
```java
public class BeanClassName imeplements java.io.Serializable {
      /* 값을 저장하는 필드 */
      private String value;

      /* BeanClassName 기본 생성자 */
      public BeanClassNmae() { }

      /* 필드의 값을 가져오는 값 */
      public String getValue() {
            return value;
      }

      /* 필드의 값을 변경하는 값
      public void setValue()  {
            this.value = value;
      }
}
```

2. 자바빈 프로퍼티
   - Property : 자바빈에 저장되는 값
   - Property의 값을 변경하는 메서드 : set + Property명
   - Porperty의 값을 읽어오는 메서드 : get + Property명

         property 타입이 boolean : is / set
     
   - 프로퍼티 이름과 필드 이름이 항상 같을 필요는 없음

3. < jsp : useBean > 액션 태그
   - JSP 페이지의 주된 기능은 데이터를 보여주는 것인데, 일반적으로 클래스에 담아서 값을 보여줌
   - JSP 페이지에서 사용할 자바빈 객체를 지정할 때 사용
   - JavaBean과 일치하는 클래스를 제작해야 하며, JSP 페이지의 값들과 일치되어야함
   
```jsp
<jsp:useBean id = ["빈이름"] class = ["자바빈 클래스 이름"] scope = "[범위]"/>

<jsp:useBean id = "info" class[type] = "ch09.member.MemberInfo" scope = "request"/>
<%-- MembeInfo 클래스의 객체 생성 : 이름이 info인 변수에 할당 -> request 기본 객체의 info 속성을 값으로 생성된 객체를 저장-->
```
   - id 속성 : JSP 페이지에서 자바빈 객체에 접근할 때 사용할 이름
   - class 속성 : 패키지 이름을 포함한 자바빈 클래스의 완전한 이름
   - type 속성 : 지정한 영역에 이미 객체가 존재한다고 가정하고, 존재하지 않으면 객체를 생성하지 않고 에러 발생
   - scope : 자바빈 객체를 저장할 영역(page, request, session, application

4. < jsp: useBean > 액션 태그는 지정한 영역에 이미 id 속성에 지정한 이름의 객체가 존재하면, 객체를 생성하지 않고 기존 존재한 객체 그대로 사용   
   : 즉, 같은 영역을 사용하는 JSP 페이지 내에서 공유

< 예제 - Member>
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<h2 align = "center"> 회원 가입 </h2>
<form action = "<%=request.getContextPath()%>/ex/RequestJoinProc.jsp" method = "post">
      <table border = "1" align = "center">
            <tr height = "50">
                  <td width = "150" align = "center"> 아이디 </td>
                  <td width = "150" align = "center"> <input type = "text" name = "id" size = "40"> </td>
            </tr>
            <tr height = "50">
                  <td width = "150" align = "center"> 비밀번호 </td>
                  <td width = "150" align = "center"> <input type = "password" name = "pwd" size = "40"> </td>
            </tr>
            <tr height = "50">
                  <td width = "150" align = "center"> 비밀번호 확인 </td>
                  <td width = "150" align = "center"> <input type = "password" name = "pwd_check" size = "40"> </td>
            </tr>			
            <tr height = "50">
                  <td width = "150" align = "center"> E-mail </td>
                  <td width = "150" align = "center"> <input type = "email" name = "email" size = "40"> </td>
            </tr>
            <tr height = "50">
                  <td width = "150" align = "center"> 전화번호 </td>
                  <td width = "150" align = "center"> <input type = "tel" name = "tel" size = "40"> </td>

            </tr>
      </table>
</form>
</body>
</html>
```

< JavaBean - Member [Member의 데이터와 일치해야함] >
```java
public class MemberBean {
	private String id;
	private String pwd;
	private String email;
	private String tel;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
}
```

```jsp
<jsp:useBean id = member class = bean.MemberBean scope = "request"/>
<jsp:setProperty name = "member" property = "*"/> <!-- member에 모든 property를 같은 이름을 갖는 parameter와 매핑하여 저장-->
<jsp:setProperty name = "member" property = "id" value = <%=member.getId()%>/> <!-- id 프로퍼티만 매핑 -->

<%=member.getId()%>
<jsp:getProperty name = "member" property = "id"/> <!--같은 문장 -->

<%=member.getPwd()%>
<jsp:getProperty name = "member" property = "pwd"/> <!--같은 문장 -->
```

-----
### jsp : setProperty
-----
1. 생성한 자바빈 객체의 Property 값을 변경

```jsp
<jsp:setProperty name = "[자바빈]" property = "이름" value = "[값]"/>
```
   - name 속성 : 프로퍼티의 값을 변경할 자바빈 객체의 이름 (= useBeans 액션 태그에서 id)
   - property 속성 : 값을 지정할 프로퍼티 이름 지정
   - value 속성 : 프로퍼티의 값 지정 (표현식<%= %> / EL(${}) 가능)
   - param 속성 : value와 동시에 사용할 수 없으며, 파라미터 값을 프로퍼티 값으로 지정할 때 사용

2. property = "*"
   : 각 Property의 값을 같은 이름을 갖는 Parameter의 값으로 설정

-----
### jsp : getProperty
-----
1. 자바빈 객체의 Property 값을 출력
```jsp
<jsp:getProperty name = "[자바빈]" property = "이름"/>
```
   - name 속성 : < jsp:useBeans >의 id 속성에서 지정한 자바빈 객체의 이름
   - proeprty 속성 : 출력할 프로퍼티의 이름

 2. property 값은 그 타입에 맞게 자동으로 값이 변환 (값이 ""이면 기본값)

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/b3d09780-4543-4545-9a56-057b2fd0a361">
</div>

