package ch17;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// http://localhost:8081/webPro/loginForm
@WebServlet("/loginForm")
public class loginForm extends HttpServlet {
	// Class를 구분하기 위한 역할을 수행
	private static final long serialVersionUID = 1L;
       
    public loginForm() {
        super();
    }

	public void init(ServletConfig config) throws ServletException {
		System.out.println("loginForm init()");
	}

	public void destroy() {
		System.out.println("loginForm destroy()");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("loginForm doGet()");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		out.println("<!DOCTYPE html>\r\n"
				+ "	<html>\r\n"
				+ "	<head>\r\n"
				+ "		<title> 로그인 </title>\r\n"
				+ "	</head>\r\n"
				+ "\r\n"
				+ "	<body>\r\n"
				+ "		<a href = \"<%=./index.jsp\">Index</a>\r\n"
				+ "		<fieldset style = \"width:400px;height:150px\">\r\n"
				+ "		<legend> Login </legend>\r\n"
				+ "		<form action = \"./loginProc\" method = \"post\" id = \"loginForm\" name = \"loginForm\">\r\n"
				+ "		\r\n"
				+ "		<div>\r\n"
				+ "			<div>\r\n"
				+ "			아이디 <input type = \"text\" id = \"id\" name = \"id\" value = \"\">\r\n"
				+ "			</div>\r\n"
				+ "			<div>\r\n"
				+ "			비밀번호 : <input type = \"password\" id = \"password\" name = \"password\">\r\n"
				+ "			</div>		\r\n"
				+ "			<div>\r\n"
				+ "			<input type = \"submit\" name = \"submit\" value = \"Login\">\r\n"
				+ "			<input type = \"reset\" name = \"reset\" value = \"Cancel\">\r\n"
				+ "			</div>\r\n"
				+ "			\r\n"
				+ "		</form>\r\n"
				+ "		</fieldset> \r\n"
				+ "	</body>\r\n"
				+ "</html>");

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("loginForm doPost()");
	}

}
