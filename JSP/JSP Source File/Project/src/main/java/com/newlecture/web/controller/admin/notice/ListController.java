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
