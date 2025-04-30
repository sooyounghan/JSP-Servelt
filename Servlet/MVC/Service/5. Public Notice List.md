-----
### 1단계 : 관리자 공지사항에서 일괄 공지 등록 확인을 위한 설정
-----
```jsp
  <c:forEach var="notice" items="${noticeList}">
  <tr> 
    <td>${notice.id}</td>
    <td class="title indent text-align-left"><a href="/Project/admin/board/notice/detail?id=${notice.id}">${notice.title}<span>[${notice.comment_count}]</span></a></td>
    <td>${notice.writerId}</td>
    <td>
      <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${notice.regdate}"/>	
    </td>
    <td>${notice.hit}</td>
    
    <c:set var="open" value=""/>
    <c:if test = "${notice.pub}">
      <c:set var="open" value="checked"/>
    </c:if>
    <td><input type="checkbox" name="open-id" value="${notice.id}" ${open}></td>
    <td><input type="checkbox" name="del-id" value="${notice.id}"></td>
    
  </tr>
  </c:forEach>
```
: < c:if >문을 통해 pub의 값이 ture(1)이면 등록된 공지임을 확인

-----
### 2단계 : 관리자 공지와 유저의 공지를 구분하기 위한 service Class 및 DAO 함수 구현
-----
1. Service Class
```java
public class NoticeService {
	NoticeDAO noticeDAO = new NoticeDAO();

...

	public List<NoticeView> pubNoticeAllList(String field, String query, int page) {
		return noticeDAO.getPubNoticeList(field, query, page);
	}
}
```

2. NoticeDAO에서 getPubNoticeList 구현
```java
	public List<NoticeView> getPubNoticeList(String field, String query, int page) {
		List<NoticeView> noticeList = new ArrayList<NoticeView>();
		
		try {
			getConnection();
			
			String sql = "SELECT B.* FROM (SELECT A.*, ROWNUM NUM FROM (SELECT * FROM NOTICE_VIEW WHERE " + field + " LIKE ? ORDER BY REGDATE DESC) A) B WHERE PUB = 1";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+query+"%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeView notice = new NoticeView();
				
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setRegdate(rs.getDate(4));
				notice.setHit(rs.getInt(5));
				notice.setFiles(rs.getString(6));
				notice.setPub(rs.getBoolean(7));
				noticeList.add(notice);
			}
			conn.close();
  		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return noticeList;
	}
```

3. 이에 따른 Controller 변경 (유저의 ListController)
```java
package com.newlecture.web.notice;

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

@WebServlet("/notice/list.do")
public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		
		List<NoticeView> noticeList = service.pubNoticeAllList(field, query, page);
		int count = service.getNoticeCount(field, query);
		request.setAttribute("noticeList", noticeList);
		request.setAttribute("count", count);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/notice/list.jsp");
		rd.forward(request, response);
	}
}
```

-----
### 3단계 : 해당 조건에 따라 공지사항(pub = 1)이 등록된 경우만 유저에게 출력
-----

-----
### 공지사항 일괄 등록
-----
1. admin에서의 list.jsp 부분
```jsp
<div class="text-align-right margin-top">

<c:set var="ids" value=""/>
<c:forEach var="notice_check" items="${noticeList}">
	<c:set var="ids" value="${ids} ${notice_check.id}"/>
</c:forEach>
<input type="hidden" name="ids" value="${ids}"/>

	<input type="submit" class="btn-text btn-default" name="cmd" value="일괄공개">
	<input type="submit" class="btn-text btn-default" name="cmd" value="일괄삭제">
	<a class="btn-text btn-default" href="reg">글쓰기</a>				
</div>
```

2. hidden으로 넘겨받은 id에 대해 ListController에서 처리
```java
package com.newlecture.web.controller.admin.notice;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.newlectrue.web.service.NoticeService;
import com.newlecture.web.entity.NoticeView;

@WebServlet("/admin/board/notice/list")
public class ListController extends HttpServlet {
...
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] openIds = request.getParameterValues("open-id");
		String[] delIds = request.getParameterValues("del-id");
		String command = request.getParameter("cmd");
		String ids_ = request.getParameter("ids");
		String[] ids = ids_.trim().split(" ");
		

		NoticeService service = new NoticeService();
		switch(command) {
			case "일괄공개" :
				List<String> openids = Arrays.asList(openIds);
				
				List<String> closeids = new ArrayList(Arrays.asList(ids));
				closeids.removeAll(openids);
				
				// Transaction 처리 (Service 함수를 2개 만들면, 이 두 개를 하나로 실행될 수 있도록 처리)
				service.pubNoticeAll(openids, closeids);
				
				break;
			case "일괄삭제" :
				int[] ids1 = new int[delIds.length];
				
				for(int i = 0; i < delIds.length; i++) {
					ids1[i] = Integer.parseInt(delIds[i]);
				}
				
				service.removeNoticeAllList(ids1);
				break;
		}
		
		response.sendRedirect("list");
	}

}
```

3. NoticeSerive Class의 pubNoticeAll Overloading
```java
package com.newlectrue.web.service;

import java.util.ArrayList;
import java.util.List;

import com.newlectrue.web.model.NoticeDAO;
import com.newlecture.web.entity.Notice;
import com.newlecture.web.entity.NoticeView;

public class NoticeService {
	NoticeDAO noticeDAO = new NoticeDAO();

...

	public void pubNoticeAll(String opneidCSV, String closeidCSV) {
		noticeDAO.putNoticeAll(opneidCSV, closeidCSV);
	}
	
	public void pubNoticeAll(int[] openIds, int[] closeIds) {
		List<String> openidList = new ArrayList<String>();
		for(int i = 0 ; i < openIds.length; i++) {
			openidList.add(String.valueOf(openIds[i]));
		}

		List<String> closeidList = new ArrayList<String>();
		for(int i = 0 ; i < closeIds.length; i++) {
			closeidList.add(String.valueOf(closeIds[i]));
		}
		pubNoticeAll(openidList, closeidList);
	}
	
	public void pubNoticeAll(List<String> openIds, List<String> closeIds) {
		String openidCSV = String.join(",", openIds);
		String closeidCSV = String.join(",", closeIds);
		
		pubNoticeAll(openidCSV, closeidCSV);
	}
...
}
```

4. NoticeDAO에서 공지 일괄 등록 기능 구현
```java
public void putNoticeAll(String openidCSV, String closeidCSV) {
try {
	getConnection();
	
	String openSql = "UPDATE NOTICE SET PUB = 1 WHERE ID IN (" + openidCSV + ")";
	pstmt = conn.prepareStatement(openSql);
	pstmt.executeUpdate();
	
	String closeSql = "UPDATE NOTICE SET PUB = 0 WHERE ID IN (" + closeidCSV + ")";
	pstmt = conn.prepareStatement(closeSql);
	pstmt.executeUpdate();
	
	conn.close();
} catch(SQLException se) {
	se.printStackTrace();
}
}
```
