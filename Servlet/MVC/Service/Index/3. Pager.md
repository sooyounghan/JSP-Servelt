-----
### Pager 작업
-----
1. 목록 페이징 구현
2. Pager에서 현재 페이지 번호 처리
3. Pager에서 마지막 번호 처리 등
```jsp
<c:set var="page" value="${(empty param.page) ? 1 : param.page}"/>
<c:set var="startNum" value="${page - (page - 1) % 5}"/>
<fmt:parseNumber var="result" value="${count/10}" integerOnly="true"/>
<c:set var="endNum" value="${result + ((count % 10 == 0) ? 0 : 1)}"/>

<div class="indexer margin-top align-right">
	<h3 class="hidden">현재 페이지</h3>
	<div><span class="text-orange text-strong">${(empty param.page) ? 1 : param.page}</span> / ${endNum} pages</div>
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
```
- EL 연산자 중 empty 연산자는 null이거나 빈 문자열("")이면, 모두 true 반환

4. NoticeListController
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
		
		List<Notice> noticeList = service.getNoticeList(field, query, page);
		int count = service.getNoticeCount(field, query);
		request.setAttribute("noticeList", noticeList);
		request.setAttribute("count", count);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/notice/list.jsp");
		rd.forward(request, response);
	}
}
```
