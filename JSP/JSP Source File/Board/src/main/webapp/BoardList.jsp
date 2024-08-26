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
	 			
	 			if(currentPage % 10 != 0) {
	 				startPage = (int)(currentPage / 10) * 10 + 1; 
	 			} else {
	 				startPage = ((int)(currentPage / 10) - 1) * 10 + 1;
	 			}
	 			
	 			int pageBlock = 10; // Countering 처리 수
	 			
	 			int endPage = startPage + pageBlock - 1;
	 			
	 			if(endPage > pageCount) endPage = pageCount;
	 			
	 			if(startPage > 10) {
	 	%>
	 				<a href = "BoardList.jsp?pageNum=<%=startPage-10%>">[Previous]</a>
	 	<%
	 			}
	 			
	 			for(int i = startPage; i <= endPage; i++) {
	 	%>
					<a href = "BoardList.jsp?pageNum=<%=i%>">[<%=i%>]</a>
	 	<%	
	 			}
	 	%>
	 	<%		if(endPage < pageCount) {
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