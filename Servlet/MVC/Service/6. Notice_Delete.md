-----
### list.jsp 내 다중 선택 값을 POST 하기
-----
```jsp
<form action="list" method="post">
	<div class="notice margin-top">
		<h3 class="hidden">공지사항 목록</h3>
		<table class="table">
			<thead>
				<tr>
					<th class="w60">번호</th>
					<th class="expand">제목</th>
					<th class="w100">작성자</th>
					<th class="w100">작성일</th>
					<th class="w60">조회수</th>
					<th class="w40">공개</th>
					<th class="w40">삭제</th>
				</tr>
			</thead>
			<tbody>

		<c:forEach var="notice" items="${noticeList}">
		<tr> 
			<td>${notice.id}</td>
			<td class="title indent text-align-left"><a href="/Project/admin/board/notice/detail?id=${notice.id}">${notice.title}<span>[${notice.comment_count}]</span></a></td>
			<td>${notice.writerId}</td>
			<td>
				<fmt:formatDate pattern="yyyy년 MM월 dd일" value="${notice.regdate}"/>	
			</td>
			<td>${notice.hit}</td>
			<td><input type="checkbox" name="open-id" value="${notice.id}"></td>
			<td><input type="checkbox" name="del-id" value="${notice.id}"></td>
		</tr>
		</c:forEach>
			</tbody>
		</table>
	</div>

	<c:set var="page" value="${(empty param.page) ? 1 : param.page}"/>
	<c:set var="startNum" value="${page - (page - 1) % 5}"/>
	<fmt:parseNumber var="result" value="${count/10}" integerOnly="true"/>
	<c:set var="endNum" value="${result + ((count % 10 == 0) ? 0 : 1)}"/>
	

	<div class="indexer margin-top align-right">
		<h3 class="hidden">현재 페이지</h3>
		<div><span class="text-orange text-strong">${(empty param.page) ? 1 : param.page}</span> / ${endNum} pages</div>
	</div>

	<div class="text-align-right margin-top">
		<input type="submit" class="btn-text btn-default" name="cmd" value="일괄공개">
		<input type="submit" class="btn-text btn-default" name="cmd" value="일괄삭제">
		<a class="btn-text btn-default" href="reg.jsp">글쓰기</a>				
	</div>
</form>
```
  - 일괄공개와 일괄삭제에 대해 다중 값을 전달 가능
  - form태그에서 POST 방식으로 전달


-----
### Admin의 ListController 
-----
1. 위의 cmd request Parameter의 값을 통해 '일괄삭제', '일괄공개' 확인 후, 처리
```java
package com.newlecture.web.controller.admin.notice;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.newlectrue.web.service.NoticeService;
import com.newlecture.web.entity.NoticeView;

@WebServlet("/admin/notice/list")
public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		NoticeService service = new NoticeService();

		// list.do?field=title(or writerId)&query=검색어
		String page_ = request.getParameter("page");
		String field = request.getParameter("field");
		String query = request.getParameter("query");
		int page = 1;
		
		if(page_ == null || page_.equals("")) {
			page = 1;
		} else {
			page = Integer.parseInt(page_);
		}
		
		if(field == null || field.equals("")) {
			field = "title";
		}

		if(query == null || query.equals("")) {
			query = "";
		}
		
		List<NoticeView> noticeList = service.getNoticeList(field, query, page);
		int count = service.getNoticeCount(field, query);
		request.setAttribute("noticeList", noticeList);
		request.setAttribute("count", count);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/admin/board/notice/list.jsp");
		rd.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] openIds = request.getParameterValues("open-id");
		String[] delIds = request.getParameterValues("del-id");
		String command = request.getParameter("cmd");
		
		switch(command) {
			case "일괄공개" :
				for(String openId : openIds) {
					
				}

				break;
			case "일괄삭제" :
				NoticeService service = new NoticeService();
				int[] ids = new int[delIds.length];
				
				for(int i = 0; i < delIds.length; i++) {
					ids[i] = Integer.parseInt(delIds[i]);
				}
				
				service.removeNoticeAllList(ids);
				break;
		}
		
		response.sendRedirect("list");
	}

}
```

-----
### NoticeService Class 
-----
```java
package com.newlectrue.web.service;

import java.util.List;

import com.newlectrue.web.model.NoticeDAO;
import com.newlecture.web.entity.Notice;
import com.newlecture.web.entity.NoticeView;

public class NoticeService {
	NoticeDAO noticeDAO = new NoticeDAO();
	
	public void removeNoticeAllList(int[] ids) {
		noticeDAO.removeNoticeAllList(ids);
	}

	public void pubNoticeAllList(int[] ids) {
	}
	
	public void insertNotice(Notice notice) {
	}
	
	public void deleteNotice(int ids) {
	}
	
	public void updateNotice(Notice notice) {
	}
	
	public List<Notice> getNoticeNewestList() {
		return null;
	}
	
	public List<NoticeView> getNoticeList() {
		return getNoticeList("title", "", 1); // 기본값으로 해당 메서드 호출
	}
	
	public List<NoticeView> getNoticeList(int page) {
		return getNoticeList("title", "", page);
	}
	
	public List<NoticeView> getNoticeList(String field, String query, int page) {
		List<NoticeView> noticeList = noticeDAO.getAllNoticeList(field, query, page);
		return noticeList;
	}
	
	public int getNoticeCount() {
		return getNoticeCount("title", ""); // 동일하게 기본값으로 메서드 호출
	}
	
	public int getNoticeCount(String field, String query) {
		int count = noticeDAO.getNoticeCount(field, query);
		return count;
	}
	
	public Notice getNotice(int id) {
		Notice notice = noticeDAO.getNotice(id);
		return notice;
	}

	public Notice getPrevNotice(int id) {
		Notice notice = noticeDAO.getPrevNotice(id);
		return notice;
	}

	public Notice getNextNotice(int id) {
		Notice notice = noticeDAO.getNextNotice(id);
		return notice;
	}
}
```

-----
### NoticeDAO 
-----
```java
package com.newlectrue.web.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.newlecture.web.entity.Notice;
import com.newlecture.web.entity.NoticeView;

public class NoticeDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
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
	
	public List<NoticeView> getAllNoticeList(String field, String query, int page) {
		List<NoticeView> noticeList = new ArrayList<NoticeView>();
		
		try {
			getConnection();
			
			String sql = "SELECT B.* FROM (SELECT A.*, ROWNUM NUM FROM (SELECT * FROM NOTICE_VIEW WHERE " + field + " LIKE ? ORDER BY REGDATE DESC) A) B WHERE NUM BETWEEN ? AND ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+query+"%");
			pstmt.setInt(2, (page - 1) * 10 + 1);
			pstmt.setInt(3, page * 10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeView notice = new NoticeView();
				
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setRegdate(rs.getDate(4));
				notice.setHit(rs.getInt(5));
				notice.setFiles(rs.getString(6));
				notice.setComment_count(rs.getInt(7));
				
				noticeList.add(notice);
			}
			conn.close();
  		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return noticeList;
	}
	
	public Notice getNotice(int id) {
		Notice notice = new Notice();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM NOTICE WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setContent(rs.getString(4));
				notice.setRegdate(rs.getDate(5));
				notice.setHit(rs.getInt(6));
				notice.setFiles(rs.getString(7));
			}
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return notice;
	}
	
	public Notice getPrevNotice(int id) {
		Notice notice = new Notice();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM (SELECT * FROM NOTICE ORDER BY REGDATE DESC) A WHERE A.REGDATE < (SELECT REGDATE FROM NOTICE WHERE ID = ?) AND ROWNUM = 1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setContent(rs.getString(4));
				notice.setRegdate(rs.getDate(5));
				notice.setHit(rs.getInt(6));
				notice.setFiles(rs.getString(7));
			}
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return notice;
	}
	
	public Notice getNextNotice(int id) {
		Notice notice = new Notice();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM NOTICE WHERE ID = (SELECT ID FROM NOTICE WHERE REGDATE > (SELECT REGDATE FROM NOTICE WHERE ID = ?) AND ROWNUM = 1)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setContent(rs.getString(4));
				notice.setRegdate(rs.getDate(5));
				notice.setHit(rs.getInt(6));
				notice.setFiles(rs.getString(7));
			}
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return notice;
	}
	
	public int getNoticeCount(String field, String query) {
		int count = 0;
		
		try {
			getConnection();
			
			String sql = "SELECT COUNT(ID) FROM NOTICE WHERE " + field + " LIKE ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+query+"%");
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
	
	public void removeNoticeAllList(int[] ids) {
		try {
			getConnection();
			
			String parameter = "";
			
			for(int i = 0; i < ids.length; i++) {
				parameter += ids[i];
				
				if(i <= ids.length - 1) {
					parameter += ",";
				}
			}
			
			String sql = "DELETE FROM NOTICE WHERE ID IN (" + parameter + ")";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
}
```
