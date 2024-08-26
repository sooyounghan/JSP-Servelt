<%@page import="Board.BoardDAO, Board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Board Information</title>
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