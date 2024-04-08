-----
### BoardListController
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

import Model.Board;
import Model.BoardDAO;

/*
 * BoardList 관련 기능을 담당하는 Servlet
 */
@WebServlet("/BoardListController.do")
public class BoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO boardDAO = new BoardDAO();
		
		/*
		 * Board Countering 
		 */
		int pageSize = 10;
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null) pageNum = "1";
		
		int count = 0;
		int number = 0;
		int currentPage = Integer.parseInt(pageNum);
		
		count = boardDAO.getAllCount();
		
		int startNum = (currentPage - 1) * pageSize + 1;
		int endNum = currentPage * pageSize;
				
		List<Board> boardList = boardDAO.getAllBoard(startNum, endNum);
				
		number = count - (currentPage - 1) * pageSize;
		
		request.setAttribute("boardList", boardList);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("count", count);
		request.setAttribute("number", number);
		request.setAttribute("currentPage", currentPage);

		RequestDispatcher rd = request.getRequestDispatcher("BoardList.jsp");
		rd.forward(request, response);
	}
}
```

-----
### BoardList JSP Page : Countering / Numbering 구현
-----
```jsp
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
```
 - BoardWriteForm JSP VIEW PAGE로 이동 시, 처리할 자바 코드가 있으면 이를 처리할 BoardWriteFORM Controller로 Handling이 정석
 - 그러나, 현재 해당 JSP PAGE에서는 크게 처리할 자바 코드가 없으므로 바로 이동

-----
### BoardDAO (Model) : getAllCount 및 getAllBoard 구현
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
				board.setReg_date(rs.getString(6).toString());
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
}
```
- SQL문을 String으로 적을 때, 띄어쓰기에 유의할 것

<div align="center">
<img width="894" alt="20240320_211441" src="https://github.com/sooyounghan/DataBase/assets/34672301/ba9f5f16-5c93-48ae-a782-a8e99061856a">
</div>


<div align="center">
<img width="897" alt="20240321_134020" src="https://github.com/sooyounghan/Web/assets/34672301/72521d83-f37f-4599-8955-eafbca16e80e">
</div>
