----
### BoardReWrite 구조도
----
<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/ba2f9515-d306-4ffe-b95a-a9c336b3a45a">
</div>

----
### BoardReWrite Form
----
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Board Reply Write Form</title>
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
	<%
		// QueryString 정보 
		int board_num = Integer.parseInt(request.getParameter("board_num").trim());
		int ref = Integer.parseInt(request.getParameter("ref").trim());
		int re_step = Integer.parseInt(request.getParameter("re_step").trim());
		int re_level = Integer.parseInt(request.getParameter("re_level").trim());
 	%>
	
    <h2>Reply Write</h2>
	<div class = "wrapper">
       <form action = "BoardReWriteProc.jsp" method = "post">
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
                   <input type = "text" name = "subject" required = "required" value = "[Reply]"/>
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
           	   <input type="hidden" name="ref" value="<%=ref%>">
           	   <input type="hidden" name="re_step" value="<%=re_step%>">
           	   <input type="hidden" name="re_level" value="<%=re_level%>">
               <input type="submit" class="button" value="Reply Write">
               <input type="reset" class="button" value="Reset"></form>
               <button class="button" onclick="location.href='BoardList.jsp'">Board List</button>
           </div>
       </div>
   </div>
</body>
</html>
```

1. 해당 페이지가 어느 특정 글에 답변 페이지 이므로 title 부분에 [reply] 초기값 입력

2. 답변에 대해서는 ref / re_step / re_level 정보가 중요
   - 어떤 부모 글에 대한 답변인지?
   - 부모 글의 몇 번째 답변인지?
   - 최신순으로 되어있는지?
   - 이러한 정보가 중요하므로, 이를 사용자로부터 입력받지 않고, hidden 속성을 통해 DB가 받을 수 있도록 처리

<div align = "center">
<img  src="https://github.com/sooyounghan/Web/assets/34672301/a0ea4b0e-f3b9-471e-95a4-8a0479be404c">
</div>

----
### BoardReWriteProc Web Page
----
```jsp
<%@ page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

<body>

<jsp:useBean id="board_reply" class="Board.Board">
	<jsp:setProperty name="board_reply" property="*"/>
</jsp:useBean>

	<%
		BoardDAO boardDAO = new BoardDAO();
		
		boardDAO.reWriteBoard(board_reply);
		
		response.sendRedirect("BoardList.jsp");
	%>
</body>
</html>
```

----
### BoardDAO : reWriteBoard 구현 (특정 글에 대한 답변)
----
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
	
	/*
	 * 특정 글에 대한 답변을 저장
	 */
	public void reWriteBoard(Board board_reply) {
		// 현재 작성된 글에 대해 부모글의 ref, re_step, re_level 필요
		int ref = board_reply.getRef();
		int re_step = board_reply.getRe_step();
		int re_level = board_reply.getRe_level();
		
		try {
			getConnection();
			
			// 부모 글보다 큰 re_level을 모두 1씩 증가 (아직 최근 답변은 넣지 않은 상태)
			String relevelsql = "UPDATE BOARD SET RE_LEVEL = RE_LEVEL + 1 WHERE REF = ? AND RE_LEVEL > ?";
			
			pstmt = conn.prepareStatement(relevelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			
			pstmt.executeUpdate();
			
			
			// 최근 답변 글 저장
			String sql = "INSERT INTO BOARD VALUES(BOARD_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE, ?, ?, ?, 0, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_reply.getWriter());
			pstmt.setString(2, board_reply.getEmail());
			pstmt.setString(3, board_reply.getSubject());
			pstmt.setString(4, board_reply.getContent_password());
			pstmt.setInt(5, ref); // 부모 글에 대한 답변이므로 ref 값은 변동 없음
			pstmt.setInt(6, re_step + 1); // 부모 글에 대한 답변이므로 re_step 값의 1 증가
			pstmt.setInt(7, re_level + 1); // 이미 기존의 글들은 1씩 증가. 최신 글이므로 부모 글의 re_level에 1 증가
			pstmt.setString(8, board_reply.getContent());
			pstmt.executeQuery();
			
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
```

< 답변에 대한 re_step과 re_level 주의사항 >
1. 부모 글이므로 ref의 값은 부모글과 동일

2. re_step는 부모 글에 대해 re_step이 1이 증가해야함
	- 부모 글의 답변에 대한 답변이라면 re_step은 답변에 1증가 (re_step은 겹쳐도 문제사항없음)

3. re_level의 경우 새로운 글이 추가 되었을 때,
	- 기존 re_level은 부모글보다 큰 숫자를 전부 1씩 증가
	- 가장 최근에 입력된 re_level은 부모글의 1증가

-----
#### BoardList의 답변 구분 (공백 추가)
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
	               <a href="BoardInfo.jsp?board_num=<%=board.getBoard_num()%>">
	               <%
	               		if(board.getRe_step() > 1) {
							for(int j = 0; j < (board.getRe_step() - 1) * 5; j++) {
					%>
											&nbsp;
					<%
							}
	               		}
	                %>
	               <%=board.getSubject()%></a>
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
<img src="https://github.com/sooyounghan/Web/assets/34672301/574c89ee-debe-49b3-a414-091a0198d495">
</div>
