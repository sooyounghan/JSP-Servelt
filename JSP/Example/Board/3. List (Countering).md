-----
### Countering
-----
1. 게시판에서 전체글에 대해서 일종의 인덱스 작업을 하는 것
2. BoardList JSP Page (한 Counter 당 최대 10개의 글이 보이도록 설정)
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
		
		.menu .name {
		    width:calc(100% - 400px);
		    border-right:1px solid black;
		   	display:flex;
		    flex-direction:row;
		    justify-content:flex-start;
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
		
		.menu div, .menu_name {
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
		

		.menu_name b {
			text-align:center;
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
		    margin:10px 60px;
		    display:flex;
		    flex-direction:row;
		    justify-content:space-between;
		    align-items:center;
		}
		
		footer .countering a {
			text-decoration:none;
			font-size:18px;
			font-weight:600;
			color:black;
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
  <header class="title"><h2>Board List</h2></header>

<%
	// 게시판 Countering 설정하기 위한 변수 선언
	int pageSize = 10; // 화면에 보여질 게시글 개수
	String pageNum = request.getParameter("pageNum"); // 현재 Count를 클릭한 번호값
	
	// 처음 BoardList JSP Page 접속 또는 수정/삭제 등 다른 게시글에서 해당 페이지로 넘어오면, pageNum값은 없으므로 Null처리
	if(pageNum == null) {
		pageNum = "1"; // null이면 pageNum은 1로 (처음 페이지로 보이도록) 처리;
	}
	
	int count = 0; // 전체 글의 갯수
	int number = 0; // pageNumbering 변수
	int currentPage = Integer.parseInt(pageNum);
	
	BoardDAO boardDAO = new BoardDAO();

	// 전체 게시글의 갯수를 읽어드림
	count = boardDAO.allCountBoard();
	
	// 현재 페이지에 보여줄 시작 번호와 끝 번호 설정 (DB에서 불러올 시작번호)
	int startNum = (currentPage - 1) * pageSize + 1;
	int endNum = currentPage * pageSize;
	
	// 최신글 eunNum ~ startNum개를 기준으로 게시글 가져오기
 	List<Board> boardList = boardDAO.allBoardList(startNum, endNum);	
	// 표시할 글번호 지정
	number = count - (currentPage - 1) * pageSize;
%>
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
               <div class="no"><%=number--%></div>
               
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
 		<div class="box"></div>
	 	<div class="countering">
	 	<%
	 		if(count > 0) {
	 			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); // Countering 수를 얼마까지 보여줄지 결정
	 			
	 			// 시작 페이지 숫자 설정
	 			int startPage = 1;

        // 현재 페이지의 위치에 따른 시작 페이지 설정 (현재페이지의 마지막 단위가 10단위 경우 중요)
	 			if(currentPage % 10 != 0) {
	 				startPage = (int)(currentPage / 10) * 10 + 1; 
	 			} else {
	 				startPage = ((int)(currentPage / 10) - 1) * 10 + 1;
	 			}

	 			int pageBlock = 10; // Countering 처리 수
	 			
	 			int endPage = startPage + pageBlock - 1;

        // 계산한 endPage보다 pageCount가 작으면, pageCount가 그 값이 되어 제일 마지막 페이지 표시
	 			if(endPage > pageCount) endPage = pageCount;

        // 이전 페이지 만들기
	 			if(startPage > 10) {
	 	%>
	 				<a href = "BoardList.jsp?pageNum=<%=startPage-10%>">[Previous]</a>
	 	<%
	 			}

        // 페이지 인덱스 작업
	 			for(int i = startPage; i <= endPage; i++) {
	 	%>
					<a href = "BoardList.jsp?pageNum=<%=i%>">[<%=i%>]</a>
	 	<%	
	 			}
	 	%>  
	 	<%    // 다음 페이지 만들기
          if(endPage < pageCount) {
	 	%>
				<a href = "BoardList.jsp?pageNum=<%=startPage+10%>">[Next]</a>
		<%
	 	}
	 		}
	 	%>
	 	</div>
 		<div><button onclick="location.href='BoardWriteForm.jsp'">Write</button> </div>
 	</footer>
</body>

</html>
```

3. BoardDAO - allBoardList 수정 / allCountBoard 추가
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
	 * 모든 게시글 -> 변경 : 시작번호와 끝번호까지의 게시물 정보를 불러옴
	 */
	public List<Board> allBoardList(int start_num, int end_num) {
		List<Board> boardList = new ArrayList<Board>();
		
		try {
			getConnection();
			
			// 답변형 게시판이므로 REF 순으로 오름차순 정렬 후, RE_STEP 순으로 오름차순 정렬한 후 RE_LEVEL순으로 오름차순 정렬
			// start_num부터 end_num이라는 특정 범위의 Row를 가져오기 위해 ROWNUM과 Inline View 이용
			String sql = "SELECT * FROM (SELECT A.*, ROWNUM NUM FROM (SELECT * FROM BOARD ORDER BY REF DESC, RE_STEP ASC, RE_LEVEL ASC) A) B WHERE NUM >= ? AND NUM <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start_num);
			pstmt.setInt(2, end_num);
			
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
	
	/*
	 * 하나의 게시물에 대해 수정하기 위한 정보
	 */
	public Board updateOneBoard(int board_num) {
		Board board = new Board();
		
		try {
			getConnection();
			
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
	 * Update, Delete에 필요한 Password 값
	 */
	public String getPass(int board_num) {
		String password = "";
		
		try {
			
			getConnection();
			
			String sql = "SELECT CONTENT_PASSWORD FROM BOARD WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				password = rs.getString(1);
			}
			
			conn.close();
			
		} catch(Exception e) {
			
			e.printStackTrace();
		}
		
		return password;
	}
	
	/*
	 * 하나의 게시글 수정
	 */
	public void updateBoard(Board board) {
		try {
			
			getConnection();
			
			String sql = "UPDATE BOARD SET SUBJECT = ?, CONTENT = ? WHERE Board_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getBoard_num());
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 하나의 게시글 삭제
	 */
	public void deleteBoard(int board_num) {
		try {
			getConnection();
			
			String sql = "DELETE FROM BOARD WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 전체 게시글의 개수
	 */
	public int allCountBoard() {
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
		} catch(Exception e) {
			
		}
		return count;
	}
}
```

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/493d0d98-d569-4355-a678-cec27f3167db">
</div>

-----
### Countering 이해
-----
1. 총 게시물이 184개라고 하자.
   - 기본 설정 : pageSize = 10 / String pageNum = "1"
   - count = 1 -> 184 / number = 0 / currentPage = 1
   - start_num = 1  / end_num = 10
   - number = 184 - (1 - 1) * 10 = 184

2. 하단 부분 (이해 중요)
   - pageCount = 18 + 1 = 19
   - startPage = 1 -> 1
   - pageBlock = 10
   - endPage = 1 + 10 - 1 = 10
   - endPage > pageCount 인가? 10 < 19이면 실행되지 않음
   - startPage > 10 인가? 1 < 10이므로 실행되지 않음
   - for문을 통해 startPage ~ endPage까지 출력
   - endPage < pageCount 인가? 10 < 19이므로 해당 부분 실행
  
3. 결과 : 1 2 3 4 5 6 7 8 9 10 [다음]

4. 위 결과에서 [다음]버튼을 누른다면?
   - 다시 1번부터 시작! (BoardList.jsp?pageNum=<%startPage+10%> 호출
   - startPage = 11
   - pageSize = 10 / String pageNum = "11"
   - count = 1 -> 184 / number = 0 / currentPage = 11
   - start_num = 101 / end_num = 110
   - number = 184 - (11 - 1) * 10 = 84

5. 하단 부분 (이해 중요)
   - pageCount = 19
   - startPage = 1 -> 11
   - endPage = 20
   - endPage > pageCount 인가? 20 > 19이므로, endPage는 19
   - startPage > 10인가? 19 > 10이므로 이전 칸 생성
   - for문을 통해 startPage ~ endPage(11 ~ 19)까지 생성
   - endPage < pageCount 인가? 20 < 19이므로, 해당 부분 미실행

6. 결과 : [이전] 11 12 13 14 15 16 17 18 19
   
