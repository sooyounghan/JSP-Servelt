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
 * 하나의 게시물을 보도록 처리할 Controller
 */
@WebServlet("/BoardInfoProcController.do")
public class BoardInfoProcController extends HttpServlet {
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
		
		Board board = boardDAO.getOneBoard(board_num);
		request.setAttribute("board", board);
		
		RequestDispatcher rd = request.getRequestDispatcher("BoardInfo.jsp");
		rd.forward(request, response);
	}
}
