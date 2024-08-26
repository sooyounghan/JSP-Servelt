<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<c:if test="${msg == 1}">
	<script>
		alert("수정 시 비밀번호가 일치하지 않습니다.")
	</script>
</c:if>

<c:if test="${msg == 2}">
	<script>
		alert("삭제 시 비밀번호가 일치하지 않습니다.")
	</script>
</c:if>

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
   
   <c:set var="number" value="${number}"/>
   <c:forEach var="board" items="${boardList}">
    <div class = "container">
       <div class = "wrapper">
           <div class = "menu">
               <div class="no">${number}</div>
               
               <div class="name">
               	   <c:if test="${board.re_step > 1}">
	               	   <c:forEach var="space" begin="1" end="${(board.re_step - 1) * 5}">
	               			&nbsp;
	              	   </c:forEach>
	              </c:if>
	               <a href="BoardInfoProcController.do?board_num=${board.board_num}">${board.subject}</a>
               </div>
               
               <div class="writer">${board.writer}</div>
               
               <div class="date_data">${board.reg_date}</div>
               
               <div class="count">${board.read_count}</div>
           </div>
       </div>
   </div>
 	  <c:set var="number" value="${number-1}"/>
   </c:forEach>

	<footer>
 		<div class="box"></div>
	 	<div class="countering">
	 		<c:if test="${count > 0}">
	 			<c:set var="pageCount" value="${(count / pageSize) + (count % pageSize == 0 ? 0 : 1)}"/>
	 			<c:set var="startPage" value ="${1}"/>
	 			
	 			<c:if test="${currentPage % pageSize != 0}">
	 				<fmt:parseNumber var="result" value="${currentPage / pageSize}" integerOnly="true"/>
	 				<c:set var="startPage" value="${result * pageSize + 1}"/>
	 			</c:if>
	 			<c:if test="${currentPage % pageSize == 0}">
	 				<c:set var="startPage" value="${(result - 1) * pagSize + 1}"/>
	 			</c:if>
				
				<c:set var="pageBlock" value="${pageSize}"/>
				
				<c:set var="endPage" value="${startPage + pageBlock - 1}"/>	
				
				<c:if test="${endPage > pageCount}">
					<c:set var="endPage" value="${endPage = pageCount}"/>
				</c:if>

				<c:if test="${startPage > pageSize}">
					<a href = "BoardListController.do?pageNum=${startPage - 10}">[Previous]</a>
				</c:if>
				
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<a href = "BoardListController.do?pageNum=${i}">${i}</a>
				</c:forEach>
				
				<c:if test="${endPage < pageCount}">
					<a href = "BoardListController.do?pageNum=${startPage + 10}">[Next]</a>
				</c:if>
	 		</c:if>
	 	</div>
 		<div><button onclick="location.href='BoardWriteForm.jsp'">Write</button> </div>
 	</footer>
</body>

</html>