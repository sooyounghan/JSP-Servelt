-----
### BoardWriteForm JSP Page
-----
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Board Write Form</title>

	<style>
		* {
			box-sizing:border-box;
		}
		
		h2 {
			text-align:center;
			font-size:20px;
			font-weight:600;
		}

		.wrapper {
			width:100%;
			display:flex;
			flex-direction:row;
			justify-content:center;
			align-items:center;
						
		}
				
		.container {
			width:600px;
			display:flex;
			flex-direction:column;
			justify-content:center;
			align-items:center;
			
			border:3px solid black;
		}
		
		.form {
			width:100%;		
			height:50px;
			
			display:flex;
			flex-direction:row;
			justify-content:flex-start;
			align-items:center;
			
			border:1px solid black;
		}
		
		.writer_name, .password_name, .email_name, .title_name, .content_name {
			padding:10px;
			width:100px;
			display:flex;
			flex-direction:row;
			justify-content:center;
			align-items:center;
		}
		
		.content_form {
			height:200px;
		}
		
		.writer, .password, .email, .title, .content {
			width:100%;
			text-area:center;
			
			display:flex;
			flex-direction:row;
			justify-content:center;
			align-items:center;
		}
		
		input {
			width:50%;
			border:none;
			border-bottom:1px solid black;
		}
		
		textarea {
			width:75%;
			height:50%;
			resize:none;
			border:1px solid black;
		}
		
		.button_zip {
			display:flex;
			flex-direction:row;
			justify-content:center;
			align-items:center;
		}
		
		.button {
			margin:10px;
			display:inline-block;
			width:100px;
			height:30px;
			border:2px solid black;
		}
	</style>
</head>

<body>
	<h2> Board </h2>
	
	<div class = "wrapper">
	<form action = "BoardWriteProcController.do" method = "post">
		<div class = "container">
			<div class = "writer_form form">
				<div class = "writer_name">Writer</div>
				<div class = "writer">
				<input type = "text" name = "writer" required = "required"/>
				</div>
			</div>
			
			<div class = "password_form form">
				<div class = "password_name">Password</div>
				<div class = "password">
				<input type = "password" name = "content_password" required = "required"/>
				</div>
			</div>
			
			<div class = "title_form form">
				<div class = "title_name">Title</div>
				<div class = "title">
				<input type = "text" name = "subject" required = "required"/>
				</div>
			</div>
			
			<div class = "email_form form">
				<div class = "email_name">Email</div>
				<div class = "email">
				<input type = "email" name = "email"/>
				</div>
			</div>
			
			<div class = "content_form form">
				<div class = "content_name">Content</div>
				<div class = "content">
				<textarea name = "content" rows = "10"></textarea>
				</div>
			</div>
		</div>
		<div class="button_zip">
			<input type="submit" class="button" value="Write">
			<input type="reset" class="button" value="Reset"></form>
			<button class="button" onclick="location.href='BoardListController.do'">Board List</button>
		</div>
	</div>
</body>
</html>
```
  - 해당 뷰에 대한 요청을 처리할 Controller(BoardWriteProcController.do)로 이동
  - 전체 글 목록으로 이동하기 위해 Controller(BoardListController.do)로 이동

-----
### BoardWriteProcController 
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

import Model.Board;
import Model.BoardDAO;

/*
 * Board Write 기능을 처리할 Servlet
 */
@WebServlet("/BoardWriteProcController.do")
public class BoardWriteProcController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Board board = new Board();
		BoardDAO boardDAO = new BoardDAO();
		
		board.setWriter(request.getParameter("writer"));
		board.setContent_password(request.getParameter("content_password"));
		board.setSubject(request.getParameter("subject"));
		board.setEmail(request.getParameter("email"));
		board.setContent(request.getParameter("content"));
		
		boardDAO.insertBoard(board);
		
		RequestDispatcher rd = request.getRequestDispatcher("BoardListController.do");
		rd.forward(request, response);
	}
}
```

-----
### BoardDAO : insertBoard 구현
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
 * DB에서 데이터와 연동할 클래스
 */
public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// DBCP-DB 연동
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
	
	// 총 게시글의 수를 반환
	public int getAllCount() {
		int count = 0;
		
		try {
			getConnection();
			
			String sql = "SELECT COUNT(BOARD_NUM) FROM BOARD";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return count;
	}
	
	// 지정된 페이지 수 만큼 게시물 데이터 추출
	public List<Board> getAllBoard(int startNum, int endNum) {
		List<Board> boardList = new ArrayList<Board>();

		try {
			getConnection();
			
			String sql = "SELECT * FROM (SELECT A.*, ROWNUM NUM FROM (SELECT * FROM BOARD ORDER BY REF DESC, RE_STEP ASC, RE_LEVEL ASC) A ) B WHERE B.NUM >= ? AND B.NUM <= ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startNum);
			pstmt.setInt(2, endNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				
				board.setBoard_num(rs.getInt(1));
				board.setWriter(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setSubject(rs.getString(4));
				board.setContent_password(rs.getString(5));
				board.setReg_date(rs.getString(6));
				board.setRef(rs.getInt(7));
				board.setRe_step(rs.getInt(8));
				board.setRe_level(rs.getInt(9));
				board.setRead_count(rs.getInt(10));
				board.setContent(rs.getString(11));
				
				boardList.add(board);
			}
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return boardList;
	}
	
	// 새로운 게시글을 등록
	public void insertBoard(Board board) {
		int ref = 0;
		int re_step = 1;
		int re_level = 1;
		
		try {
			getConnection();
			
			String refsql = "SELECT MAX(REF) FROM BOARD";
			pstmt = conn.prepareStatement(refsql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ref = rs.getInt(1) + 1;
			}
			
			String sql = "INSERT INTO BOARD VALUES(BOARD_SEQ.NEXTVAL, ?, ?, ? ,?, SYSDATE, ?, ?, ?, 0, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getEmail());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent_password());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, board.getContent());
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
}
```
