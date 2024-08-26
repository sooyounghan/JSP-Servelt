package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.BoardDAO;

/*
 * 게시물 수정 처리 Servlet
 */
@WebServlet("/BoardUpdateFormProcController.do")
public class BoardUpdateFormProcController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO boardDAO = new BoardDAO();
				
		String content_password = request.getParameter("content_password");
		String password = request.getParameter("pwd");
	
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		if(password.equals(content_password)) {
			boardDAO.updateBoard(board_num, subject, content);
			
			request.setAttribute("msg", 1);
			RequestDispatcher rd = request.getRequestDispatcher("BoardListController.do");
			rd.forward(request, response);
			
		} else {

			request.setAttribute("msg", 1);
			RequestDispatcher rd = request.getRequestDispatcher("BoardListController.do");
			rd.forward(request, response);
		}
	}
}
