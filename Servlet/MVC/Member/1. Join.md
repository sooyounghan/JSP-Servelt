-----
### 회원가입 - MVC 적용
-----
-----
### 사전 작업 - DBCP 연동
-----
<Server의 Server.xml>
```jsp
<Context docBase="MemberMVC" path="/MemberMVC" reloadable="true" source="org.eclipse.jst.jee.server:MemberMVC">
   <Resource auth="Container" driverClassName="oracle.jdbc.driver.OracleDriver" loginTimeout="10" maxWaits="5000" name="jdbc/pool" password="1234" type="javax.sql.DataSource" url="jdbc:oracle:thin:@localhost:1521:xe" username="dbPractice"/>
</Context>
```

-----
### 회원가입 View (MemberJoin JSP Page)
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
	    padding:30px;
	    display:flex;
	    flex-direction:row;
	    justify-content:center;
	    align-items:center; 
	}
	.container {
	    background-color:#dddddd;
	    width:600px;
	    height:900px;
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
	
	.content .id, .password, .email, .tel, .address, .submit_button, .hobby, .job, .age, .info {
	    width:100%;
	    padding:10px 0;
	    display:flex;
	    flex-direction:row;
	    justify-content:space-around;
	    align-items:center;
	}
	
	.hobby_box, .job_box, .age_box, .info_box {
	    font-size:12px;
	    font-weight:600;
	}
	
	.age_check {
	    margin-left:20px;
	}
	.job_check {
	    width:200px;
	    height:25px;
	    font-size:12px;
	    font-weight:600;
	}
	
	.info_text {
	    width:200px;
	    height:100px;
	    resize:none;
	    font-size:12px;
	    font-weight:600;
	    padding:10px;
	}
	.name {
	    font-size:14px;
	    font-weight:600;
	}
	
	.input {
	    margin:10px;
	}
	
	.input_content {
	    width:200px;
	    height:25px;
	    font-size:10px;
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
            <form action="MemberJoinProc.do" method="post">
            <div class="content">
                <div class="id">
                    <div class="name"><p>ID : </p></div>
                    <div class="input"><input type="text" name="id" class="input_content" placeholder="  ID" required = "required"></div>
                </div>

                <div class="password">
                    <div class="name"><p>PassWord : </p></div>
                    <div class="input"><input type="password" name="pass1" class="input_content" placeholder="  Passwrod : Only Number and English" required = "required"></div>
                </div>

                <div class="password">
                    <div class="name"><p>PassWord : </p></div>
                    <div class="input"><input type="password" name="pass2"  class="input_content" placeholder="  Passwrod : Only Number and English" required = "required"></div>
                </div>

                <div class="email">
                    <div class="name"><p>Email : </p></div>
                    <div class="input"><input type="email" name="email" class="input_content" placeholder=" Ex) abc@naver.com"></div>
                </div>

                <div class="tel">
                    <div class="name"><p>H.P. : </p></div>
                    <div class="input"><input type="tel" name="tel" id="tel" class="input_content"/></div>
                </div>

                <div class="address">
                    <div class="name"><p>Address : </p></div>
                    <div class="input"><input type="text" name="address" id="address" class="input_content"/></div>
                </div>

                <div class="hobby">
                    <div class="name"><p>Hobby : </p></div>
                    <div class="hobby_box input">		
                        <input type="checkbox" name="hobby" value="camping"> Camping 
                        <input type="checkbox" name="hobby" value="hiking"> Hiking 
                        <input type="checkbox" name="hobby" value="book"> Book 
                        <input type="checkbox" name="hobby" value="etc" checked="checked"> etc  	
                    </div>
                </div>

                <div class="job">
                    <div class="name"><p>Job : </p></div>
                    <div class="job_box input">		
                        <select name="job" class="job_check">
                            <option value="teacher"> Teacher</option>
                            <option value="doctor"> Doctor</option>
                            <option value="lawyer"> Lawyer</option>
                            <option value="etc"> etc</option>
                        </select>	
                    </div>
                </div>

                <div class="age">
                    <div class="name"><p>Age : </p></div>
                    <div class="age_box input">		
                        <input type="radio" name="age" value="10" class="age_check" checked="checked">10's
                        <input type="radio" name="age" value="20" class="age_check">20's
                        <input type="radio" name="age" value="30" class="age_check">30's
                        <input type="radio" name="age" value="40" class="age_check">40's	
                    </div>
                </div>

                <div class="info">
                    <div class="name"><p>Info : </p></div>
                    <div class="info_box input">		
                        <textarea name="info" placeholder = " Write Your Information." class="info_text" ></textarea>	
                    </div>
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

<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/700fc8a8-8709-4dc3-b45b-41a739833481">
</div>

-----
### 회원가입 Model (Member Bean Class)
-----
```java
package Model;

/*
 * 회원가입 정보를 저장하는 Member 클래스 (Model)
 */
public class Member {
	private String id; 
	private String pass1;
	private String pass2;
	private String email;
	private String tel;
	private String hobby;
	private String job;
	private String age;
	private String info;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPass1() {
		return pass1;
	}
	
	public void setPass1(String pass1) {
		this.pass1 = pass1;
	}
	
	public String getPass2() {
		return pass2;
	}
	
	public void setPass2(String pass2) {
		this.pass2 = pass2;
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
	
	public String getHobby() {
		return hobby;
	}
	
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	
	public String getJob() {
		return job;
	}
	
	public void setJob(String job) {
		this.job = job;
	}
	
	public String getAge() {
		return age;
	}
	
	public void setAge(String age) {
		this.age = age;
	}
	
	public String getInfo() {
		return info;
	}
	
	public void setInfo(String info) {
		this.info = info;
	}
}
```

-----
### 회원가입 DAO (Model : MemberDAO)
-----
```java
package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/*
 * 회원 가입 정보를 DB와 연결한 DAO 생성 (MemberDAO)
 */
public class MemberDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// DBCP 연동
	public void getConnection() {
		try {
			
			Context initcnx = new InitialContext();
			Context envcnx = (Context)initcnx.lookup("java:comp/env");
			DataSource ds = (DataSource)envcnx.lookup("jdbc/pool");
			
			conn = ds.getConnection();
			
		} catch(NamingException ne) {
			ne.printStackTrace();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
	
	// 회원 한 명의 정보를 DB에 저장
	public void insertMember(Member member) {
		try {
			
			getConnection();
			
			String sql = "INSERT INTO MEMBER VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass1());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getHobby());
			pstmt.setString(6, member.getJob());
			pstmt.setString(7, member.getAge());
			pstmt.setString(8, member.getInfo());
			
			pstmt.executeUpdate();
			
			conn.close();
			
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
}
```

-----
### 회원가입 Controller (MemberJoinProc)
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
import Model.MemberDAO;

/*
 * 회원가입 기능 처리 (Controller)
 */
@WebServlet("/MemberJoinProc.do")
public class MemberJoinProc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	public void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member member = new Member();
		
		String[] hobbys = request.getParameterValues("hobby");
		String hobby = "";
		
		for(String hobbies : hobbys) {
			hobby += hobbies + " ";
		}
		
		member.setId(request.getParameter("id"));
		member.setPass1(request.getParameter("pass1"));
		member.setPass2(request.getParameter("pass2"));
		member.setEmail(request.getParameter("email"));
		member.setTel(request.getParameter("tel"));
		member.setHobby(hobby);
		member.setJob(request.getParameter("job"));
		member.setAge(request.getParameter("age"));
		member.setInfo(request.getParameter("info"));
		
		// PassWord가 동일한 경우에만 DB에 저장
		if(member.getPass1().equals(member.getPass2())) {
			MemberDAO memberDAO = new MemberDAO();
			memberDAO.insertMember(member);
			
			RequestDispatcher rd = request.getRequestDispatcher("MemberList.jsp");
			rd.forward(request, response);
		} 
		
		else {
			request.setAttribute("ErrMsg", "PassWord가 일치하지 않습니다.");
			
			RequestDispatcher rd = request.getRequestDispatcher("LoginError.jsp");
			rd.forward(request, response);
		}
	}
}
```

-----
### LoginError JSP Page
-----
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login Error</title>
</head>

<body>

	<script>
		alert("패스워드가 일치하지 않습니다. 다시 확인해주세요.");
		location.href="MemberJoin.jsp";
	</script>

</body>
</html>
```
