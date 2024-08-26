package ch17;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/loginProc")
public class servlet_loginOk extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
	
	public servlet_loginOk() {
		super();
	}
       
	public void destroy() {
		super.destroy();
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		out.println("<!DOCTYPE html>\r\n"
				+ "	<html>\r\n"
				+ "	<head>\r\n"
				+ "		<meta charset=\"UTF-8\">\r\n"
				+ "		<title> 로그인 </title>\r\n"
				+ "	</head>\r\n"
				+ "\r\n"
				+ "	<body>\r\n"
				+ "			<div> User가 입력한 아이디 : " + request.getParameter("id") + " </div>\r\n "
				+ "			<div> 비밀번호 : " + request.getParameter("password") + "  </div>\r\n "
				+ "	</body>\r\n"
				+ "</html>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost() 호출");
		doGet(request, response);
	}

}
