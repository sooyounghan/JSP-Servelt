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
 * 게시글 삭제 처리 Servlet
 */
@WebServlet("/BoardDeleteFormProcController.do")
public class BoardDeleteFormProcController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO boardDAO = new BoardDAO();
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		String content_password = request.getParameter("pwd");
		String password = request.getParameter("content_password");
		
		if(content_password.equals(password)) {
			boardDAO.deleteBoard(board_num);
			
			RequestDispatcher rd = request.getRequestDispatcher("BoardListController.do");
			rd.forward(request, response);
		} else {
			request.setAttribute("msg", 2);
			
			RequestDispatcher rd = request.getRequestDispatcher("BoardListController.do");
			rd.forward(request, response);
		}
	}
}
