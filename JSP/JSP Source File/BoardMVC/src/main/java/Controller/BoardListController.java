package Controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Board;
import Model.BoardDAO;

/*
 * BoardList 관련 기능을 담당하는 Servlet
 */
@WebServlet("/BoardListController.do")
public class BoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO boardDAO = new BoardDAO();
		
		/*
		 * Board Countering 
		 */
		int pageSize = 10;
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null) pageNum = "1";
		
		int count = 0;
		int number = 0;
		int currentPage = Integer.parseInt(pageNum);
		count = boardDAO.getAllCount();
		
		int startNum = (currentPage - 1) * pageSize + 1;
		int endNum = currentPage * pageSize;
				
		List<Board> boardList = boardDAO.getAllBoard(startNum, endNum);
				
		number = count - (currentPage - 1) * pageSize;
		
		// 수정 완료 처리
		String msg = (String)request.getParameter("Msg");
		request.setAttribute("Msg", msg);
		
		request.setAttribute("boardList", boardList);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("count", count);
		request.setAttribute("number", number);
		request.setAttribute("currentPage", currentPage);
		
		RequestDispatcher rd = request.getRequestDispatcher("BoardList.jsp");
		rd.forward(request, response);

	}
}
