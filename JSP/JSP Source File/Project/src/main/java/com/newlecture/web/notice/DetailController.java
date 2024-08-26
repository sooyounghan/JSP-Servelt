package com.newlecture.web.notice;

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
public class DetailController extends HttpServlet {
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
