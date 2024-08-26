package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Board;
import Model.BoardDAO;

/*
 * 답변 기능을 처리할 Servlet
 */
@WebServlet("/BoardReWriteProcController.do")
public class BoardReWriteProcController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}
	
	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO boardDAO = new BoardDAO();
		Board board = new Board();
		
		board.setWriter(request.getParameter("writer"));
		board.setSubject(request.getParameter("subject"));
		board.setEmail(request.getParameter("email"));
		board.setContent_password(request.getParameter("content_password"));
		
		board.setRef(Integer.parseInt(request.getParameter("ref")));
		board.setRe_step(Integer.parseInt(request.getParameter("re_step")));
		board.setRe_level(Integer.parseInt(request.getParameter("re_level")));
		
		boardDAO.reWriteInsertBoard(board);
		
		RequestDispatcher rd = request.getRequestDispatcher("BoardListController.do");
		rd.forward(request, response);
	}
}
