package ch17;

import java.util.*;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * Browser에 현재 시간을 출력하는 웹 문서 (@WebServlet)
 */

// http://localhost:8081/webPro/hello
@WebServlet(urlPatterns = "/hello")
public class servlet_Ex extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet() 호출");
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset = UTF-8");
		
		PrintWriter out = resp.getWriter();
		out.println("<html>");
		out.println("<head><title> Servlet Document </title></head>");
		out.println("<body>");
		out.println("<h3> 현재시간 </h3>");
		out.println("<h4> Date 객체 : " + new Date() + " </h4>");
		Calendar cal = Calendar.getInstance();
		long millis = cal.getTimeInMillis();
		Date date = new Date(millis);
		out.print("<h1> 짜잔 <h1>");
		out.println("<h4> Calendar 객체 생성 후 getTimeMillis() : " + cal.getTime() + " </h4>");
		out.println("<h4> Date 객체 생성 (매개변수 millis) : " + date + " </h4>");
		out.println("</body>");
		out.println("</html>");
	}
}
