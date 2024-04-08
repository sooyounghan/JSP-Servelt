-----
### BoardInfo 구조도
----
<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/d7310df8-b429-4c58-a7f3-9021b90130ea">
</div>

1. 전체 게시글을 보기 (BoardList JSP Page)
2. 하나의 글을 볼 수 있도록 처리 (BoardDAO - getOneBoard() 구현)
3. 선택한 하나의 게시글 보기 (BoardInfo JSP Page)
  - 답변 달기 (BoardReWriteForm JSP Page)
  - 글 수정하기 (BoardUpdateForm JSP Page)
  - 글 삭제하기 (BoardDeleteFrom JSP Page)

-----
### BoardDAO - getOneBoard 구현 (선택한 페이지에 대한 정보)
-----
```java
package Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public void getConnection() {
		try {
			Context initcnx = new InitialContext();
			Context envcnx = (Context)initcnx.lookup("java:comp/env");
			
			DataSource ds = (DataSource)envcnx.lookup("jdbc/pool");
			
			conn = ds.getConnection();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 새로운 게시글 하나 추가하는 메서드
	 */
	public void insertBoard(Board board) {
		int ref = 0; // 글 그룹 의미 (Query를 실해시켜 가장 큰 REF 값을 가져온 후 1 증가)
		int re_step = 1; // 새로운 글의 re_step은 1
		int re_level = 1; // 새로운 글이므로 re_level은 1
		
		try {
			getConnection();
			
			// 가장 큰 REF를 읽어오는 Query
			String refsql = "SELECT MAX(REF) FROM BOARD";
			
			pstmt = conn.prepareStatement(refsql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//최댓값에 1을 더해서 글 그룹 설정
				ref = rs.getInt(1) + 1;
			}
			
			// 게시글 전체 데이터를 DB에 전송
			String sql = "INSERT INTO BOARD VALUES(BOARD_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE, ?, ?, ?, 0, ?)";
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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 모든 게시글 정보를 불러옴
	 */
	public List<Board> allBoardList() {
		List<Board> boardList = new ArrayList<Board>();
		
		try {
			getConnection();
			
			// 답변형 게시판이므로 REF 순으로 오름차순 정렬 후, RE_STEP 순으로 오름차순 정렬한 후 RE_LEVEL순으로 오름차순 정렬  
			String sql = "SELECT * FROM BOARD ORDER BY REF DESC, RE_STEP ASC, RE_LEVEL ASC";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				//DB에서 받은 데이터에 대한 Packaging 작업 
				Board board = new Board();
				
				board.setBoard_num(rs.getInt(1));
				board.setWriter(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setSubject(rs.getString(4));
				board.setContent_password(rs.getString(5));
				board.setReg_date(rs.getDate(6).toString());
				board.setRef(rs.getInt(7));
				board.setRe_step(rs.getInt(8));
				board.setRe_level(rs.getInt(9));
				board.setRead_count(rs.getInt(10));
				board.setContent(rs.getString(11));
				
				boardList.add(board);
			}
			
			conn.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return boardList;
	}
	
	/*
	 * 하나의 게시글을 불러옴
	 */
	public Board getOneBoard(int board_num) {
		Board board = new Board();
		
		try {
			getConnection();
			
			// 조회수 증가 Query
			String readCountsql = "UPDATE BOARD SET READCOUNT = READCOUNT + 1 WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(readCountsql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
			
			// 게시글을 불러오는 Query
			String sql = "SELECT * FROM BOARD WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board.setBoard_num(rs.getInt(1));
				board.setWriter(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setSubject(rs.getString(4));
				board.setContent_password(rs.getString(5));
				board.setReg_date(rs.getDate(6).toString());
				board.setRef(rs.getInt(7));
				board.setRe_step(rs.getInt(8));
				board.setRe_level(rs.getInt(9));
				board.setRead_count(rs.getInt(10));
				board.setContent(rs.getString(11));
			}
			
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return board; 
	}
}
```

-----
### BoardInfo JSP Page
-----
```jsp
<%@page import="Board.BoardDAO, Board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
		
		.first_line_form, .writer_form {
		    display:flex;
		    justify-content:space-between;
		    align-content:center;
		}
		
		.num, .count, .writer_name, .reg_date_name {
		    padding:10px;
		    width:100px;
		    text-align:center;
		}
		
		.num_content, .count_content, .writer_content, .reg_date_content {
		    padding:10px;
		    text-align:center;
		    width:calc(100% - 350px);
		}
		
		.password_name, .email_name, .title_name, .content_name {
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
		
		.password, .email, .title, .content {
		    width:100%;
		    text-align:center;
		    
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

<%
	// QueryString으로 Board_Num의 값을 전달 받음
	int board_num = Integer.parseInt(request.getParameter("board_num").trim());
	
	BoardDAO boardDAO = new BoardDAO();
	
	// Board_Num에 해당하는 게시글 정보 불러오기
	Board board = boardDAO.getOneBoard(board_num);
%>

	<h2><%=board.getSubject()%></h2>
	
	<div class = "wrapper">
        <div class = "container">
            <div class = "first_line_form form">
                <div class="num">글번호</div>
                <div class="num_content"><%=board.getBoard_num()%></div>
                <div class="count">조회수</div>
                <div class="count_content"><%=board.getRead_count()%></div>
            </div>
            <div class = "writer_form form">
                <div class = "writer_name">Writer</div>
                <div class = "writer_content"><%=board.getWriter()%></div>
                <div class = "reg_date_name">작성일</div>
                <div class = "reg_date_content"><%=board.getReg_date()%></div>
            </div>
            
            <div class = "email_form form">
                <div class = "email_name">Email</div>
                <div class = "email"><%=board.getEmail()%></div>
            </div>
            
            <div class = "title_form form">
                <div class = "title_name">Title</div>
                <div class = "title"><%=board.getSubject()%></div>
            </div>
            
            <div class = "content_form form">
                <div class = "content_name">Content</div>
                <div class = "content"><%=board.getContent()%></div>
            </div>
        
	       <div class="button_zip">
	           <button class="button" onclick="location.href='BoardReWriteForm.jsp?board_num=<%=board.getBoard_num()%>&ref=<%=board.getRef()%>&re_step=<%=board.getRe_step()%>&re_level=<%=board.getRe_level()%>'">Reply</button>
	           <button class="button" onclick="location.href='BoardUpdateForm.jsp?board_num=<%=board.getBoard_num()%>'">Update</button>
	           <button class="button" onclick="location.href='BoardDeleteForm.jsp?board_num=<%=board.getBoard_num()%>'">Delete</button>
	           <button class="button" onclick="location.href='BoardList.jsp'">BoardList</button>
	       </div>
	       
        </div>
     </div>
</body>
</html>
```

1. 해당 글에 답변을 달기 위한 조건을 생각해보자.
2. Reply 페이지로 이동 시, Reply를 달기 위한 조건인 board_num / ref / re_step / re_level에 대해 QueryString으로 넘기는 방법이 존재
3. 또는, board_num정보만을 넘긴 후, Reply 페이지에서 이에 해당하는 정보를 DB에서 가져와 ref / re_step / re_level을 처리하는 방법이 존재

<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/d8e6a9d3-cdbe-4ab1-81e6-e3e2284d7da6">
</div>
