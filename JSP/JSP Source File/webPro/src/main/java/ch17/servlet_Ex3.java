package ch17;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// @WebServlet(urlPatterns="/myInfo")
public class servlet_Ex3 extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet() 호출");
		
		resp.setContentType("text/html; charset = UTF-8");
		PrintWriter out = resp.getWriter();
		out.print("<html>");
		out.print("<hea																												d><title>My Information</title></head>");
		out.print("<body>");
		out.print("<h1>My Information</h1>");
		out.print("<hr>");
		out.print("<h3>이름 : 한수영</h3>");
		out.print("<h3>좋아하는 색상 : 없음</h3>");
		out.print("<h3>거주도시 : 경기도</h3>");
		out.print("</body>");
		out.print("</html>");
	}
}
