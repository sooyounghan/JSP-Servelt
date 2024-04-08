-----
### Servlet Parameter 처리
-----
1. JSP Form Data에서 입력받은 데이터에 대해 Bean 클래스를 통해 저장
2. Bean 클래스를 Servlet를 통해 한 번에 JSP Page에 View

-----
### 회원가입 페이지 : MemberJoin JSP Page
-----
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Member Join</title>
	<style>
	* {
	    box-sizing:border-box;
	    padding:0;
	    margin:0;
	}
	
	.wrapper {
	    display:flex;
	    flex-direction:row;
	    justify-content:center;
	    align-items:center; 
	}
	.container {
	    background-color:#dddddd;
	    width:400px;
	    height:500px;
	    padding:30px;
	    border-radius:10%;
	    border:3px solid black;
	
	    display:flex;
	    flex-direction:column;
	    justify-content:center;
	    align-items:center;
	}
	
	.title p {
	    font-size:20px;
	    font-weight:600;
	}
	
	.content {
	    padding:15px;
	}
	
	.content .id, .password, .email, .tel, .address, .submit_button {
	    width:100%;
	    padding:10px;
	    display:flex;
	    flex-direction:row;
	    justify-content:space-around;
	    align-items:center;
	}
	
	.input {
	    margin:10px;
	}
	
	.submit {
	    width:100px;
	    height:30px;
	    border:2px solid black;
	}
	</style>
</head>

<body>
    <div class="wrapper">
        <div class="container">
            <div class="title"><p>회원 가입</p></div>
            <form action="<%=request.getContextPath()%>/MemberJoinProc" method="post">
            <div class="content">
                <div class="id">
                    <div class="name"><p>ID</p></div>
                    <div class="input"><input type="text" name="id" id="id" class="input_content" placeholder="ID" required="required"/></div>
                </div>

                <div class="password">
                    <div class="name"><p>PassWord</p></div>
                    <div class="input"><input type="password" name="password" id="password" class="input_content" placeholder="Only Number and English" required="required"/></div>
                </div>

                <div class="email">
                    <div class="name"><p>Email</p></div>
                    <div class="input"><input type="email" name="email" id="email" class="input_content"/></div>
                </div>

                <div class="tel">
                    <div class="name"><p>Tel</p></div>
                    <div class="input"><input type="tel" name="tel" id="tel" class="input_content"/></div>
                </div>

                <div class="address">
                    <div class="name"><p>Address</p></div>
                    <div class="input"><input type="text" name="address" id="address" class="input_content"/></div>
                </div>

                <div class="submit_button">
                    <input type="submit" value="Join" class="submit">
                </div>      
            </div>
            </form>
        </div>
    </div>
</body>
</html>
```

1. 기존 Model1 : form의 액션은 JSP 웹 페이지로 바로 Action
2. Model2 (MVC) : 해당 일을 처리할 Controller가 존재하는 Servlet으로 전달
   - 단, action을 취할 Servlet의 URL과 일치해야함 (Servlet Class 이름과 무관)
   - 단, 해당 Controller가 위치한 ContextPath까지 명시 필요 (이 과정이 귀찮다면, Context Path 설정을 /로 변경하는 것도 좋은 방법!)

<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/7a94c018-f9ab-4721-8cb3-becec9cd3008">
</div>

-----
### 회원정보에 대한 Bean Class : Member Bean Class (Model)
-----
```java
package Model;

/*
 * 회원 가입 정보를 담는 클래스 (Model)
 */
public class Member {
	private String id;
	private String password;
	private String email;
	private String tel;
	private String address;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
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
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
}
```

-----
### 회원정보 처리 : MemberJoinProc Controller 
-----
```java
package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Member;

/*
 * 회원 가입 처리 (Controller)
 */
@WebServlet("/MemberJoinProc")
public class MemberJoinProc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Member Class 객체 생성
		Member member = new Member();
		member.setId(request.getParameter("id"));
		member.setPassword(request.getParameter("password"));
		member.setEmail(request.getParameter("email"));
		member.setTel(request.getParameter("tel"));
		member.setAddress(request.getParameter("address"));
		
		// request에 정보 저장
		request.setAttribute("member", member);
		
		RequestDispatcher rd = request.getRequestDispatcher("MemberView.jsp");
		rd.forward(request, response);
	}
}
```

-----
### 회원정보를 처리하여 보여줄 페이지 : MemberView JSP Page
-----
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Member View</title>
	<style>
		* {
	    box-sizing:border-box;
	    padding:0;
	    margin:0;
	}
	
	.wrapper {
	    display:flex;
	    flex-direction:row;
	    justify-content:center;
	    align-items:center; 
	}
	.container {
	    background-color:#dddddd;
	    width:400px;
	    height:500px;
	    padding:30px;
	    border-radius:10%;
	    border:3px solid black;
	
	    display:flex;
	    flex-direction:column;
	    justify-content:center;
	    align-items:center;
	}
	
	.title p {
	    font-size:20px;
	    font-weight:600;
	}
	
	.content {
	    padding:15px;
	}
	
	.content .id, .password, .email, .tel, .address, .submit_button {
	    width:100%;
	    padding:10px;
	    display:flex;
	    flex-direction:row;
	    justify-content:space-around;
	    align-items:center;
	}

	</style>
</head>

<body>
    <div class="wrapper">
        <div class="container">
            <div class="title"><p>회원 정보</p></div>
            <div class="content">
                <div class="id">
                    <div class="name"><p>ID : </p></div>
                    <div class="input">${member.getId()}</div>
                </div>

                <div class="password">
                    <div class="name"><p>PassWord : </p></div>
                    <div class="input">${member.getPassword()}</div>
                </div>

                <div class="email">
                    <div class="name"><p>Email : </p></div>
                    <div class="input">${member.getEmail()}</div>
                </div>

                <div class="tel">
                    <div class="name"><p>Tel : </p></div>
                    <div class="input">${member.getTel()}</div>
                </div>

                <div class="address">
                    <div class="name"><p>Address : </p></div>
                    <div class="input">${member.getAddress()}</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
```
: Servlet에서 선언한 Model의 Bean Class 객체에 대해 EL(Expression Language) 가능

<div align="center">
<img src= "https://github.com/sooyounghan/Web/assets/34672301/08532fa9-96d1-464f-b2bf-79203deea9e2">
</div>
