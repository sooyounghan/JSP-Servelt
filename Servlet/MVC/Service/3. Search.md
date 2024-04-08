-----
### 목록 페이지에서 검색 기능 구현
-----
1. Notice List JSP View Page의 검색 창 일부
```jsp
  <div class="search-form margin-top first align-right">
    <h3 class="hidden">공지사항 검색폼</h3>
    <form class="table-form">
      <fieldset>
        <legend class="hidden">공지사항 검색 필드</legend>
        <label class="hidden">검색분류</label>
        <select name="field">
          <option ${(param.field == "title") ? "selected" : ""} value="title">제목</option>
          <option ${(param.field == "writer_Id") ? "selected" : ""} value="writer_Id">작성자</option>
        </select> 
        <label class="hidden">검색어</label>
        <input type="text" name="query" value="${param.query}"/>
        <input class="btn btn-search" type="submit" value="검색" />
      </fieldset>
    </form>
  </div>
```
  - form 태그는 action을 생략하면 자기 자신 호출, method는 get 방식
  - option의 selected 지정 속성은 EL을 통해 표현 가능
  - 따라서, 제목 / 작성자로 설정하여 검색한 결과에 대해 계속 유지
    
2. NoticeListController
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
		
		String field = request.getParameter("field");
		String query = request.getParameter("query");

		if(field == null) {
			field = "title";
		}

		if(query == null) {
			query = "";
		}
		
		List<Notice> noticeList = service.getNoticeList(field, query, 1);
		request.setAttribute("noticeList", noticeList);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/notice/list.jsp");
		rd.forward(request, response);
	}
}
```
  - field와 query 값이 null일 경우 기본값으로 처리
