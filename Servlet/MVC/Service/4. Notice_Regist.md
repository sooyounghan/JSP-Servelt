-----
### 공지사항 등록을 위한 View (reg JSP Page 변경)
-----
```jsp
<form action="/Project/admin/board/notice/reg" method="post">
    <div class="margin-top first">
        <h3 class="hidden">공지사항 입력</h3>
        <table class="table">
            <tbody>
                <tr>
                    <th>제목</th>
                    <td class="text-align-left text-indent text-strong text-orange" colspan="3">
                        <input type="text" name="title" />
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3" class="text-align-left text-indent"><input type="file"
                            name="file" /> </td>
                </tr>
                <tr class="content">
                    <td colspan="4"><textarea class="content" name="content"></textarea></td>
                </tr>
                <tr>
                    <td colspan="4" class="text-align-right"><input class="vertical-align" type="checkbox" id="open" name="open" value="true"><label for="open" class="margin-left">바로공개</label> </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="margin-top text-align-center">
        <input class="btn-text btn-default" type="submit" value="등록" />
        <a class="btn-text btn-cancel" href="/Project/admin/board/notice/list">취소</a>
    </div>
</form>
```

### NOTICE 테이블에 공개여부에 대한 PUB 컬럼 추가 및 Notice Class 변경
-----
1. PUB 컬럼을 통해 해당 글의 공개 / 미공개 여부 확인
  - 공개 : 1
  - 비공개 : 0

2. Notice Class에 Pub 추가
```java
package com.newlecture.web.entity;

import java.util.Date;

public class Notice {
	private int id;
	private String title;
	private String writerId;
	private String content;
	private Date regdate;
	private int hit;
	private String files;
	private boolean pub;

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getWriterId() {
		return writerId;
	}
	
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	
	public Date getRegdate() {
		return regdate;
	}
	
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	public int getHit() {
		return hit;
	}
	
	public void setHit(int hit) {
		this.hit = hit;
	}
	
	public String getFiles() {
		return files;
	}
	
	public void setFiles(String files) {
		this.files = files;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	public boolean getPub() {
		return pub;
	}
	public void setPub(boolean pub) {
		this.pub = pub;
	}

	@Override
	public String toString() {
		return "Notice [id=" + id + ", title=" + title + ", writerId=" + writerId + ", content=" + content
				+ ", regdate=" + regdate + ", hit=" + hit + ", files=" + files + ", pub=" + pub + "]";
	}
}
```

   
-----
### 공지사항 등록을 위한 Controller (RegController)
-----
```java
package com.newlecture.web.controller.admin.notice;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.newlectrue.web.service.NoticeService;
import com.newlecture.web.entity.Notice;

@WebServlet("/admin/board/notice/reg")
public class RegController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/admin/board/notice/reg.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String isOpen = request.getParameter("open");
		
		boolean pub = false;
		if(isOpen != null) pub = true; 
		
		Notice notice = new Notice();
		notice.setTitle(title);
		notice.setContent(content);
		notice.setPub(pub);
		notice.setWriterId("newlec");

		NoticeService service = new NoticeService();
		service.insertNotice(notice);
		
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
		noticeDAO.insertNotice(notice);
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
### NoticeDAO : insertNode 구현
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
				notice.setPub(rs.getBoolean(8));

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
				notice.setPub(rs.getBoolean(8));
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
				notice.setPub(rs.getBoolean(8));
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
				notice.setPub(rs.getBoolean(8));
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
	
	public void insertNotice(Notice notice) {
		try {
			getConnection();
			
			String sql = "INSERT INTO NOTICE(TITLE, CONTENT, WRITER_ID, PUB) VALUES(?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getTitle());
			pstmt.setString(2, notice.getContent());
			pstmt.setString(3, notice.getWriterId());
			pstmt.setBoolean(4, notice.getPub());
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
}
```
