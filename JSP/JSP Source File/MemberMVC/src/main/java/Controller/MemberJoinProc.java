package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Member;
import Model.MemberDAO;

/*
 * 회원가입 기능 처리 (Controller)
 */
@WebServlet("/MemberJoinProc.do")
public class MemberJoinProc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}

	public void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member member = new Member();
		
		String[] hobbys = request.getParameterValues("hobby");
		String hobby = "";
		
		for(String hobbies : hobbys) {
			hobby += hobbies + " ";
		}
		
		member.setId(request.getParameter("id"));
		member.setPass1(request.getParameter("pass1"));
		member.setPass2(request.getParameter("pass2"));
		member.setEmail(request.getParameter("email"));
		member.setTel(request.getParameter("tel"));
		member.setHobby(hobby);
		member.setJob(request.getParameter("job"));
		member.setAge(request.getParameter("age"));
		member.setInfo(request.getParameter("info"));
		
		// PassWord가 동일한 경우에만 DB에 저장
		if(member.getPass1().equals(member.getPass2())) {
			MemberDAO memberDAO = new MemberDAO();
			memberDAO.insertMember(member);
			
			// MemberList JSP Page로 호출 전, 회원 가입된 Member에 대해 List를 출력하기 위한 Controller 처리
			
			RequestDispatcher rd = request.getRequestDispatcher("MemberListController.do");
			rd.forward(request, response);
		} 
		
		else {
			request.setAttribute("ErrMsg", "PassWord가 일치하지 않습니다.");
			
			RequestDispatcher rd = request.getRequestDispatcher("LoginError.jsp");
			rd.forward(request, response);
		}
	}
}
