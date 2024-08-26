package Controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Member;
import Model.MemberDAO;

/*
 * MemberList 출력을 위해 처리할 Controller
 */
@WebServlet("/MemberListController.do")
public class MemberListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// DB에 연결, 회원의 모든 정보 전달
		MemberDAO memberDAO = new MemberDAO();
		
		List<Member> memberList = memberDAO.allMemberList();
		request.setAttribute("memberList", memberList);
		
		RequestDispatcher rd = request.getRequestDispatcher("MemberList.jsp");
		rd.forward(request, response);
	}
}
