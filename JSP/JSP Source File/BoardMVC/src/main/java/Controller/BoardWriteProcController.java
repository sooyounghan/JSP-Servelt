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
 * Board Write 기능을 처리할 Servlet
 */
@WebServlet("/BoardWriteProcController.do")
public class BoardWriteProcController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Board board = new Board();
		BoardDAO boardDAO = new BoardDAO();
		
		board.setWriter(request.getParameter("writer"));
		board.setContent_password(request.getParameter("content_password"));
		board.setSubject(request.getParameter("subject"));
		board.setEmail(request.getParameter("email"));
		board.setContent(request.getParameter("content"));
		
		boardDAO.insertBoard(board);
		
		RequestDispatcher rd = request.getRequestDispatcher("BoardListController.do");
		rd.forward(request, response);
	}
}
