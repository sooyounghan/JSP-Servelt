<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<h2>${board.subject}</h2>
	
	<div class = "wrapper">
        <div class = "container">
            <div class = "first_line_form form">
                <div class="num">글번호</div>
                <div class="num_content">${board.board_num}</div>
                <div class="count">조회수</div>
                <div class="count_content">${board.read_count}</div>
            </div>
            <div class = "writer_form form">
                <div class = "writer_name">Writer</div>
                <div class = "writer_content">${board.writer}</div>
                <div class = "reg_date_name">작성일</div>
                <div class = "reg_date_content">${board.reg_date}</div>
            </div>
            
            <div class = "email_form form">
                <div class = "email_name">Email</div>
                <div class = "email">${board.email}</div>
            </div>
            
            <div class = "title_form form">
                <div class = "title_name">Title</div>
                <div class = "title">${board.subject}</div>
            </div>
            
            <div class = "content_form form">
                <div class = "content_name">Content</div>
                <div class = "content">${board.content}</div>
            </div>
        
	       <div class="button_zip">
	           <button class="button" onclick="location.href='BoardReWriteController.do?board_num=${board.board_num}&ref=${board.ref}&re_step=${board.re_step}&re_level=${board.re_level}'">Reply</button>
	           <button class="button" onclick="location.href='BoardUpdateController.do?board_num=${board.board_num}'">Update</button>
	           <button class="button" onclick="location.href='BoardDeleteProcController.do?board_num=${board.board_num}'">Delete</button>
	           <button class="button" onclick="location.href='BoardListController.do'">BoardList</button>
	       </div>
	       
        </div>
     </div>
</body>
</html>