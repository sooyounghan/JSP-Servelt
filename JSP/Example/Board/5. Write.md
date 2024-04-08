-----
### BoardWrite 구조
-----
<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/7fa771ee-15c1-4367-a6da-602e3d839cbe">
</div>

-----
### BoardWriteForm
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
		.title {
		    text-align:center;
		    font-size:20px;
		    font-weight:600;
		}
		
		.container {
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-content:center;
		}
		
		.wrapper {
		    width:90%;
		    border:3px solid black;
		
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-content:center;
		}
		
		.wrapper .menu {
		    padding:10px;
		    width:100%;
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-content:center;
		}
		
		.menu div {
		    padding:10px;
		    display:flex;
		    flex-direction:row;
		    justify-content:space-around;
		    align-content:center;
		}
		
		.no {
		    width:100px;
		    border-right:1px solid black;
		}
		
		.menu .name {
		    width:calc(100% - 400px);
		    border-right:1px solid black;
		   	display:flex;
		    flex-direction:row;
		    justify-content:flex-start;
		    align-content:center;
		}
				
		.menu_name b {
			transform:translateX(265px);
		}
		
		.name a {
			color:black;
			font-size:18px;
			font-weight:600;
			text-decoration:none;
		}
		
		.writer {
		    width:100px;
		    border-right:1px solid black;
		}
		
		.date {
		    width:100px;
		    border-right:1px solid black;
		}
		
		.date_data {
			font-size:14px;
		    width:100px;
		    border-right:1px solid black;
		}
		
		.count {
		    width:100px;
		}
		
		footer {
		    margin:10px;
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-items:flex;
		}
		
		footer div button {
		    padding:10px;
		    margin:10px;
		
		    font-size:16px;
		    font-weight:600;
		    border:2px solid black;
		}
	</style>
</head>

<body>
	<h2> Board </h2>
	
	<div class = "wrapper">
	<form action = "BoardWriteProc.jsp" method = "post">
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
				<input type = "password" name = "password" required = "required"/>
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
			<button class="button" onclick="location.href='BoardList.jsp'">Board List</button>
		</div>
	</div>
</body>
</html>
```
<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/afc1d7d7-d3d0-4235-b8eb-f91cc085fc22">

</div>

-----
### BoardWriteProcessing JSP Page (DB 전송만 구현)
-----
```jsp
<%@page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Board Write Processing</title>
</head>

<body>

<!-- 게시글에 작성한 데이터를 불러옴 -->
<jsp:useBean id="board" class="Board.Board">
	<jsp:setProperty name="board" property="*"/>
</jsp:useBean>

<%
	// DB쪽으로 데이터 전송
	BoardDAO boardDAO = new BoardDAO();

	// DB에 데이터 삽입
	boardDAO.insertBoard(board);
%>
</body>
</html>
```

-----
### BoardDAO (insertBoard & allBoardList까지 구현)
-----
```java
package Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}

```

-----
### BoardList JSP Page
-----
```jsp
<%@page import="Board.BoardDAO, Board.Board, java.util.*"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Board List</title>
	
	<style>
		* {
		    box-sizing:border-box;
		}
		.title {
		    text-align:center;
		    font-size:20px;
		    font-weight:600;
		}
		
		.container {
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-content:center;
		}
		
		.wrapper {
		    width:90%;
		    border:3px solid black;
		
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-content:center;
		}
		
		.wrapper .menu {
		    padding:10px;
		    width:100%;
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-content:center;
		}
		
		.menu div {
		    padding:10px;
		    display:flex;
		    flex-direction:row;
		    justify-content:space-around;
		    align-content:center;
		}
		
		.no {
		    width:100px;
		    border-right:1px solid black;
		}
		
		.menu .name {
		    width:calc(100% - 400px);
		    border-right:1px solid black;
		   	display:flex;
		    flex-direction:row;
		    justify-content:flex-start;
		    align-content:center;
		}
				
		.menu_name b {
			transform:translateX(265px);
		}
		
		.name a {
			color:black;
			font-size:18px;
			font-weight:600;
			text-decoration:none;
		}
		
		.writer {
		    width:100px;
		    border-right:1px solid black;
		}
		
		.date {
		    width:100px;
		    border-right:1px solid black;
		}
		
		.date_data {
			font-size:14px;
		    width:100px;
		    border-right:1px solid black;
		}
		
		.count {
		    width:100px;
		}
		
		footer {
		    margin:10px;
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-items:flex;
		}
		
		footer div button {
		    padding:10px;
		    margin:10px;
		
		    font-size:16px;
		    font-weight:600;
		    border:2px solid black;
		}

	</style>
</head>

<body>

<%
	// 전체 게시굴 내용이 해당 페이지로 출력
	BoardDAO boardDAO = new BoardDAO();

	List<Board> boardList = boardDAO.allBoardList();	
%>

  <header class="title"><h2>Board List</h2></header>

   <div class = "container">
       <div class = "wrapper">
           <div class = "menu">
               <div class="no"><b>No.</b></div>
               <div class="name menu_name"><b>Title</b></div>
               <div class="writer"><b>Writer</b></div>
               <div class="date"><b>Date</b></div>
               <div class="count"><b>Count</b></div>
           </div>
       </div>
   </div>
   
 <%
 	for(int i = 0; i < boardList.size(); i++) {
 		Board board = boardList.get(i);
 		
 %>
    <div class = "container">
       <div class = "wrapper">
           <div class = "menu">
               <div class="no"><%=i+1%></div>
               
               <div class="name">
	               <a href="BoardInfo.jsp?board_num=<%=board.getBoard_num()%>"><%=board.getSubject()%></a>
               </div>
               
               <div class="writer"><%=board.getWriter()%></div>
               
               <div class="date_data"><%=board.getReg_date()%></div>
               
               <div class="count"><%=board.getRead_count()%></div>
           </div>
       </div>
   </div>
 <%
 	}
 %>
 
 	<footer>
 		<div><button onclick="location.href='BoardWriteForm.jsp'">Write</button> </div>
 	</footer>
</body>

</html>
```

<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/84a84325-0020-4d1c-91df-cec5ac208c14">
</div>

---
### 주의사항
---
1. BOARD_NUM으로 게시판 번호를 하지 않는 이유?
   - 추후에 수많은 글인 적힌 전체 게시글에 대해서 데이터를 가져와야 함
   - 이는 처리 시간이 무수히 증가 및 BOARD_NUM의 답변형 게시판으로 인해 그 번호가 상이해짐
   - 해결 방법 : 카운터링 (예정)

2. 즉, BOARD_NUM은 답변항 게시판으로 글 번호로 사용하기 부적합
   - 기본적으로, PK로 사용하는 것이 효율적
   - 즉, 글 제목에 대한 그 정보를 보고 싶을 때 사용하기에 적합

3. 그러므로, 글번호는 i+1로 설정해주는 것이 좋음
