-----
#### 공지사항(Notice) Class에 대한 필요 메서드 구현
-----
: 기본 구현 틀
```java
package com.newlectrue.web.service;

import java.util.List;

import com.newlectrue.web.model.NoticeDAO;
import com.newlecture.web.entity.Notice;

public class NoticeService {
	NoticeDAO noticeDAO = new NoticeDAO();
	
	public List<Notice> getNoticeList() {
		return getNoticeList("title", "", 1); // 기본값으로 해당 메서드 호출
	}
	
	public List<Notice> getNoticeList(int page) {
		return getNoticeList("title", "", page);
	}
	
	public List<Notice> getNoticeList(String field, String query, int page) {
		List<Notice> noticeList = noticeDAO.getAllNoticeList(field, query, page);
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
#### Notice Class에서 getPrevNotice와 getNextNotice에 대한 탐구
-----
1. getNextNotice에 대한 탐구
   - 예를 들어, 현재 게시물의 ID는 3번이라고 하자. 그 다음 글의 ID는 5번이면, 이 글을 어떻게 가져올 것인가?
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/b084026b-15ca-4180-8fcd-0ded85f23db2">
</div>

   - ID에 1을 더하는 경우는, 글이 삭제되는 경우를 고려하지 않은 것

<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/2f1660b7-9d7f-4606-a855-ee0edc85d15e">
</div>

  - 그렇다면, 우리는 3번을 기준점으로 잡을 것
  - 일반적으로 등록일에 따라 글 번호가 점차 커지는 형태이므로 이를 이용
  - 즉, 이를 쿼리로 생각해본다면 다음과 같음
```sql
SELECT *
FROM NOTICE
WHERE ID IN (SELECT ID FROM NOTICE WHERE REGDATE > (SELECT REGDATE FROM NOTICE WHERE ID = 3));
```

  - 즉, 위 쿼리의 결과를 본다면 다음과 같음
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/8090e0a7-82fc-4926-95f2-081546b67180">
</div>

  - 이 상태에서 우리는 ROWNUM을 이용해 첫 번째 값을 얻어내면, 다음 글을 얻어낼 수 있음
```sql
SELECT *
FROM NOTICE
WHERE ID = (SELECT ID FROM NOTICE WHERE REGDATE > (SELECT REGDATE FROM NOTICE WHERE ID = 3) AND ROWNUM = 1);
```

2. getPrevNotice에 대한 탐구
   - 예를 들어, 현재 게시물의 ID는 3번이라고 하면, 우리는 위에 대해 역순으로 생각하면 됨
   - 하지만, 현재 오름차순 정렬이므로, 이에 대해 역정렬이 필요 (인라인 뷰 사용)
```sql
SELECT *
FROM (SELECT * FROM NOTICE ORDER BY REGDATE DESC) A
WHERE A.REGDATE < (SELECT REGDATE FROM NOTICE WHERE ID = 12) AND ROWNUM = 1;
```

-----
#### NoticeDAO
-----
```java
package com.newlectrue.web.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.newlecture.web.entity.Notice;

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
	
	public List<Notice> getAllNoticeList(String field, String query, int page) {
		List<Notice> noticeList = new ArrayList<Notice>();
		
		try {
			getConnection();
			
			String sql = "SELECT B.* FROM (SELECT A.*, ROWNUM NUM FROM (SELECT * FROM NOTICE WHERE " + field + " LIKE ? ORDER BY REGDATE DESC) A) B WHERE NUM BETWEEN ? AND ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+query+"%");
			pstmt.setInt(2, (page - 1) * 10 + 1);
			pstmt.setInt(3, page * 10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Notice notice = new Notice();
				
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setContent(rs.getString(4));
				notice.setRegdate(rs.getDate(5));
				notice.setHit(rs.getInt(6));
				notice.setFiles(rs.getString(7));
				
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
}
```

-----
#### NoticeListContorller
-----
```java
package com.newlectrue.web.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.newlectrue.web.service.NoticeService;
import com.newlecture.web.entity.Notice;

@WebServlet("/notice/list.do")
public class NoticeListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		NoticeService service = new NoticeService();
		
		List<Notice> noticeList = service.getNoticeList();
		request.setAttribute("noticeList", noticeList);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/notice/list.jsp");
		rd.forward(request, response);
	}
}
```

-----
#### NoticeDetailController
-----
```java
package com.newlectrue.web.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.newlectrue.web.service.NoticeService;
import com.newlecture.web.entity.Notice;

/**
 * Servlet implementation class NoticeDetailController
 */
@WebServlet("/notice/detail.do")
public class NoticeDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		NoticeService service = new NoticeService();
		int id = Integer.parseInt(request.getParameter("id"));
		
		Notice notice = service.getNotice(id);
		Notice prevNotice = service.getPrevNotice(id);
		Notice nextNotice = service.getNextNotice(id);
		request.setAttribute("notice", notice);
		request.setAttribute("prevNotice", prevNotice);
		request.setAttribute("nextNotice", nextNotice);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/notice/detail.jsp");
		rd.forward(request, response);
	}
}
```

-----
#### List / Detail View Page
-----
```jsp
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
      </tr>
    </thead>
    <tbody>

    <c:forEach var="notice" items="${noticeList}">
    <tr> 
      <td>${notice.id}</td>
      <td class="title indent text-align-left"><a href="/Project/notice/detail.do?id=${notice.id}">${notice.title}</a></td>
      <td>${notice.writerId}</td>
      <td>
        <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${notice.regdate}"/>	
      </td>
      <td>${notice.hit}</td>
    </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
```
```jsp
<div class="margin-top first">
    <h3 class="hidden">공지사항 내용</h3>
    <table class="table">
      <tbody>
        <tr>
          <th>제목</th>
          <td class="text-align-left text-indent text-strong text-orange" colspan="3">${notice.title}</td>
        </tr>
        <tr>
          <th>작성일</th>
          <td class="text-align-left text-indent" colspan="3">
          <fmt:formatDate pattern="yyyy년 MM월 dd일 hh시 MM분" value="${notice.regdate}"/></td>
        </tr>
        <tr>
          <th>작성자</th>
          <td>${notice.writerId}</td>
          <th>조회수</th>
          <td>${notice.hit}</td>
        </tr>
        <tr>
          <th>첨부파일</th>
          <td colspan="3">
          <c:forTokens var="fileName" items="${notice.files}" delims="," varStatus="st">
            <a href="${fileName}">${fileName}</a>
            <c:if test="${!st.last}">
            /
            </c:if>
          </c:forTokens>
          </td>
        </tr>
        <tr class="content">
          <td colspan="4">${notice.content}</td>
        </tr>
      </tbody>
    </table>
  </div>
  
  <div class="margin-top text-align-center">
    <a class="btn btn-list" href="/Project/notice/list.do">목록</a>
  </div>
  
  <div class="margin-top">
    <table class="table border-top-default">
      <tbody>
        
        <tr>
          <th>다음글</th>
          <td colspan="3"  class="text-align-left text-indent"><a class="text-blue text-strong" href="/Project/notice/detail.do?id=${nextNotice.id}">${nextNotice.title}</a></td>
        </tr>
        <tr>
          <th>이전글</th>
          <td colspan="3"  class="text-align-left text-indent"><a class="text-blue text-strong" href="/Project/notice/detail.do?id=${prevNotice.id}">${prevNotice.title}</a></td>
        </tr>
      </tbody>
    </table>
  </div>
```

