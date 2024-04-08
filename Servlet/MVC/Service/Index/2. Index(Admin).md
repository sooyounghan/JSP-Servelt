-----
### 공지사항 관련 Admin(관리자) 기능
-----
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/ce8e664b-c839-478e-b7bc-92b204c49b9b">
<img src="https://github.com/sooyounghan/Web/assets/34672301/e64511b3-b0f9-41ba-a151-fedd6ceb4849">
<img src="https://github.com/sooyounghan/Web/assets/34672301/30f38ff9-128e-4443-a085-4b2db6b5eed0">
<img src="https://github.com/sooyounghan/Web/assets/34672301/019ecc94-f88f-4a92-8a3a-334ca3e26fd6">
</div>

1. 여러 개의 공지에 대한 일괄 공개 : void pubNoticeAll(int[] ids)
2. 여러 개의 공지에 대한 일괄 삭제 : void removeNoticeAll(int[] ids)
3. 공지 글쓰기 작성
   - 공지 등록 요청(void insertNotice(notice))
   - 공지 삭제 요청(void deleteNotice(id))
   - 공지 수정 요청(void updateNotice(notice))
4. 페이지 요청 : List<Notice> getNoticeNewestList()

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

------
### admin/notice/Listcontroller
------
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

------
### admin/notice list.jsp
------
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
		<td><input type="checkbox" name="open"></td>
		<td><input type="checkbox" name="del"></td>
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
	<td><input type="checkbox" name="open-id" value="${notice.id}"></td>
	<td><input type="checkbox" name="del-id" value="${notice.id}"></td>
	<a class="btn-text btn-default" href="reg.jsp">글쓰기</a>				
</div>

<div class="margin-top align-center pager">	


<div>		
	<c:if test="${startNum - 1 > 1}">
		<a href="?page=${startNum - 1}&field=${param.field}&query=${param.query}" class="btn btn-next">이전</a>
	</c:if>
	<c:if test="${startNum - 1 <= 1}">
		<span class="btn btn-prev" onclick="alert('이전 페이지가 없습니다.');">이전</span>
	</c:if>
</div>
<ul class="-list- center">
	<c:forEach var="i" begin="0" end="4">
		<c:if test="${(startNum + i) <= endNum}">
			<li><a class="-text- ${(page == (startNum + i)) ? 'orange' : ''} bold" href="?page=${startNum + i}&field=${param.field}&query=${param.query}" >${startNum + i}</a></li>
		</c:if>
	</c:forEach>		
</ul>
<div>
	<c:if test="${startNum + 4 < endNum}">
		<a href="?page=${startNum + 4}&field=${param.field}&query=${param.query}" class="btn btn-next">다음</a>
	</c:if>
	<c:if test="${startNum + 4 >= endNum}">
		<span class="btn btn-next" onclick="alert('다음 페이지가 없습니다.');">다음</span>
	</c:if>
</div>
</div>
</main>
```
