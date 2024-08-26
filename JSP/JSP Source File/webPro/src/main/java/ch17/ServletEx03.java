package ch17;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ServletEx03")
public class ServletEx03 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletEx03() {
        super();
        System.out.println("ServletEx03() 기본 생성자");
    }
    
    // HttpServlet의 Super Class인 GenericServlet Class Method
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		System.out.println("Destory() Call");
	}

    // HttpServlet의 Super Class인 GenericServlet Class Method
	// init(config)를 호출할 필요가 없도록 환경 설정 요소를 재정의
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("Init() Call");
	}

	// get방식 호출 시, 자동으로 호출되는 service 메서드
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet() 호출");
		PrintWriter out = response.getWriter();
		out = out.append("Served at: ");
		out = out.append(request.getContextPath());
		this.destroy();
	}

	// post방식 호출 시, 자동으로 호출되는 service 메서드
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost() 호출");
		doGet(request, response);
	}

}
