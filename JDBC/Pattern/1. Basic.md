-----
### JSP-DB 연동 Pattern
-----
1. Data에 대해 JSP 내에서 DB 연동
2. JSP로 Data를 입력 받아 DAO(Data Access Object)를 이용해 DB 연동
3. Connection Pool 개념을 적용하여 DB와 연동

-----
### 순서
-----
1. 회원가입 JSP Page 생성
2. 회원가입 관련 DB TABLE 생성
3. 처리해주는 DAO Class 생성 - DB와 연동 후 저장 (MemberDAO Pattern 적용)
4. response.sendRedirect()를 통한 회원 전체 보기 구성
5. 회원 수정 및 삭제

-----
### Pattern 1 : JSP 내에서 DB 연동
-----
    * DB TABLE 구성 : 아이디(id) / 비밀번호 (pwd) [비밀번호 확인(repwd)은 중복되므로 제외] / 이메일(email) / 전화번호(tel) / 관심분야 (hobby) / 직업 (job) / 연령(age) / 하고싶은 말 (info)
    * 여기서 관심 분야 (hobby)는 다중 선택이 가능하므로, 해당 값을 배열로 받을 것

1. MemberJoin JSP Page
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Join</title>
	<style>
		
		td, input{
			font-size:13px;	
		}
		
		h2 {
			display:flex;
			flex-direction:row;
			justify-content:center; 
			align-items:center;
		}
		
		form {
			display:flex;
			flex-direction:row;
			justify-content:center; 
			align-items:center;
		}
		
		table {
			width:600px;
			height:450px;
			text-align:center;
			border:1px solid black;
		}
		
		td, tr {
			border:1px solid black;
		}
		
		.menu {
			text-align:center;
		}
		
		.menu input {
			display:inline-block;
		}
		
	</style>
</head>

<body>

	<h2>Member Join</h2>
	<form action="MemberJoinProc.jsp" method = "post">
	<table>
		<tr>
			<td>ID</td>
			<td><input type="text" name="id" size="40" placeholder="ID" required = "required"></td>
		</tr>
		
		<tr>
			<td>Password</td>
			<td> <input type="password" name="pass1" size="40" placeholder="Passwrod : Only Number and English" required = "required"></td>
		</tr>
		
		<tr>
			<td>Password</td>
			<td><input type="password" name="pass1" size="40" placeholder="Passwrod : Only Number and English" required = "required"></td>
		</tr>
		
		<tr>
			<td>E-Mail</td>
			<td><input type="email" name="email" size="40" placeholder="Ex) abc@naver.com"></td>
		</tr>
		
		<tr>
			<td>H.P.</td>
			<td><input type="tel" name="tel" size="40" placeholder="Ex) 010-1234-5678"></td>
		</tr>
		
		<tr>
			<td>Hobby</td>
			<td>
				<input type="checkbox" name="hobby" value="camping">Camping 
				<input type="checkbox" name="hobby" value="hiking">Hiking 
				<input type="checkbox" name="hobby" value="book">Book 
				<input type="checkbox" name="hobby" value="etc">etc  	
			</td>
		</tr>
		
	   <tr>
			<td>Job</td>
			<td>
				<select name="job">
				<option value="teacher">Teacher</option>
				<option value="doctor">Doctor</option>
				<option value="lawyer">Lawyer</option>
				<option value="etc">etc</option>
				</select>				
			</td>
		</tr>
		
		<tr>
			<td>Age</td>
			<td>
				<input type="radio" name="age" value="10">10's
				<input type="radio" name="age" value="20">20's
				<input type="radio" name="age" value="30">30's
				<input type="radio" name="age" value="40">40's			
			</td>
		</tr>
		
		<tr>
			<td>Info.</td>
			<td><textarea rows="2" cols="40" name="info" placeholder = "Write Your Information."></textarea></td>
		</tr>
			
		<tr class = "menu">
			<td colspan="2">
				<input type="submit" value="Join">	
				<input type="reset" value="Cancel">			
			</td>
		</tr>	
	</table>
	</form>	
</body>
</html>
```

2. Member Class 생성
```java
package Model;

/* 
 * Member(회원)의 정보를 가지고 있는 클래스
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

3. MemberJoin Table 생성
```sql
CREATE TABLE MEMBER (
ID VARCHAR2(10) CONSTARINT MEMBER_ID_PK PRIMARY KEY,
PASS1 VARCHAR2(20) NOT NULL,
EMAIL VARCHAR2(50),
TEL VARCHAR2(20),
HOBBY VARCHAR2(60), 
JOB VARCHAR2(15),
AGE VARCHAR2(10), 
INFO VARCHAR(500)
);
```
  - 테이블 구성도 (테이블, 제약조건, ERD)
<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/410843ba-a97e-452a-828e-4c6873b073af">
<img src="https://github.com/sooyounghan/Web/assets/34672301/f9d7a9a2-3b5b-42af-bbc7-5a8653eb8346">
<img src="https://github.com/sooyounghan/Web/assets/34672301/9e1b9584-3055-499e-a214-498a8e480463">

</div>

4. JSP Page 내에서 DB 연동

   		Oracle JDBC URL : "jdbc:oracle:thin:@localhost:1521:xe"
```jsp
<%
	// Oracle 접속 소스 작성
	String id = "dbPractice"; // ID
	String password = "1234"; // 비밀번호
	String url = "jdbc:oracle:thin:@localhost:1521:xe"; // 접속 URL
	
	try {
		// 1. 해당 데이터 베이스 사용하는 것을 선언 (클래스 등록 = 오라클 사용)
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		// 2. 해당 데이터 베이스에 접속
		Connection conn = DriverManager.getConnection(url, id, password);
		
		// 3. 접속 후 쿼리를 준비
		String sql = "INSERT INTO MEMBER VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
		
		// 4. 쿼리를 사용하도록 설정
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		// 5. ?에 맞게 데이터를 변경
		pstmt.setString(1, memberBean.getId());
		pstmt.setString(2, memberBean.getPass1());
		pstmt.setString(3, memberBean.getEmail());
		pstmt.setString(4, memberBean.getTel());
		pstmt.setString(5, memberBean.getHobby());
		pstmt.setString(6, memberBean.getJob());
		pstmt.setString(7, memberBean.getAge());
		pstmt.setString(8, memberBean.getInfo());
		
		
		// 9. 오라클에서 쿼리 실행
		pstmt.executeUpdate(); // Insert, Update, Delete에서 사용 메서드
		
		// 10. 자원 반납
		conn.close();
		
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
```

