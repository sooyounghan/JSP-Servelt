-----
### MemberJoinProc Controller 일부 변경
-----
1. MemberJoinProc에서 해당 회원 정보 데이터를 삽입 후, 회원 전체 보기로 이동
2. 따라서, MemberList.jsp로 바로 이동하는 것이 아닌 이를 처리할 MemberListProc.do Controller로 이동

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
			
			// MemberList JSP Page로 호출 전, 회원 가입된 Member에 대해 List를 출력하기 위한 Controller 처리
			
			RequestDispatcher rd = request.getRequestDispatcher("MemberListController.do");
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
### MemberListProc Controller
-----
```java
package Controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Member;
import Model.MemberDAO;

/*
 * MemberList 출력을 위해 처리할 Controller
 */
@WebServlet("/MemberListController.do")
public class MemberListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// DB에 연결, 회원의 모든 정보 전달
		MemberDAO memberDAO = new MemberDAO();
		
		List<Member> memberList = memberDAO.allMemberList();
		request.setAttribute("memberList", memberList);
		
		RequestDispatcher rd = request.getRequestDispatcher("MemberList.jsp");
		rd.forward(request, response);
	}
}
```
: MemberList JSP View Page로 회원 전체에 대한 정보를 추출 후, Forward

-----
### MemberDAO : allMemberList 구현
-----
```java
package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

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
	
	// 모든 회원의 정보 추출
	public List<Member> allMemberList() {
		List<Member> memberList = new ArrayList<Member>();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM MEMBER";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member member = new Member();
				
				member.setId(rs.getString(1));
				member.setPass1(rs.getString(2));
				member.setEmail(rs.getString(3));
				member.setTel(rs.getString(4));
				member.setHobby(rs.getString(5));
				member.setJob(rs.getString(6));
				member.setAge(rs.getString(7));
				member.setInfo(rs.getString(8));
				
				memberList.add(member);
			}
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return memberList;
	}
}

```

-----
### MemberList View Page
-----
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Member List</title>
	<style>
		* {
		    box-sizing:border-box;
		    padding:0;
		    margin:0;
		}
		
		.wrapper {
			margin:10px;
		    width:95%;
		    border:3px solid black;
		    display:flex;
		    flex-direction:column;
		    justify-content:center;
		    align-items:space-between;
		}
		
		.menu, .items {
			margin:10px;
		    display:flex;
		    flex-direction:row;
		    justify-content:flex-start;
		    align-items:center;
		}
		
		.name {
		    padding:10px;
		    margin:2px;
		    border:1px solid black;
		}
		
		.menu p {
		    font-size:12px;
		    font-weight:600;
		    text-align:center;
		}
		
		.items p {
		    font-size:10px;
		    font-weight:600;
		    text-align:center;
		}
		
		
		.id {
		    width:10%;
		}
		
		.email {
		    width:15%;
		}
		
		.tel {
		    width:15%;
		}
		
		.address {
		    width:15%;
		}
		
		.hobby {
		    width:15%;
		}
		
		.job {
		    width:10%;
		}
		
		.age {
		    width:10%;
		}
		
		.info {
		    width:20%;
		}
		
		.previous {
			padding:5px;
			margin:5px;
			width:70px;
			height:30px;
			border:2px solid black;
			border-radius:10%;
		}
		
		.button_box {
			display:flex;
			flex-direction:row;
			justify-content:center;
			align-items:center;
		}
	</style>
</head>

<body>
    <div class="wrapper">
        <div class="menu">
            <div class="name id"><p>ID</p></div>
            <div class="name email"><p>Email</p></div>
            <div class="name tel"><p>H.P.</p></div>
            <div class="name hobby"><p>Hobby</p></div>
            <div class="name job"><p>Job</p></div>
            <div class="name age"><p>Age</p></div>
            <div class="name info"><p>Info</p></div>
        </div>
	
		<c:forEach var="member" items="${memberList}">
        <div class="items">
            <div class="name id"><p>${member.id}</p></div>
            <div class="name email"><p>${member.email}</p></div>
            <div class="name tel"><p>${member.tel}</p></div>
            <div class="name hobby"><p>${member.hobby}</p></div>
            <div class="name job"><p>${member.job}</p></div>
            <div class="name age"><p>${member.age}</p></div>
            <div class="name info"><p>${member.info}</p></div>
        </div>
        </c:forEach>
    	
    	<div class="button_box"> 	   
		    <button onclick="location.href='MemberJoin.jsp'" class="previous">Previous</button>
		</div>
    </div>
</body>

</html>
```
1. JSTL 중 < c:forEach > 활용
   - 변수명은 member
   - items은 Controller에서 처리한 member정보를 EL로 가져옴

2. Previous Button을 통해 회원 가입 페이지로 다시 이동

<div align="center">
<img width="931" alt="20240320_163523" src="https://github.com/sooyounghan/Web/assets/34672301/ab398e61-cdb6-4c3a-86c2-c28bed6e68c0">
</div>

