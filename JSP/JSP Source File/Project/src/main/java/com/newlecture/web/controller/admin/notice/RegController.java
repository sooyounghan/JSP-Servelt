package com.newlecture.web.controller.admin.notice;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.newlectrue.web.service.NoticeService;
import com.newlecture.web.entity.Notice;

@MultipartConfig(
	  fileSizeThreshold=1024*1024,
	  maxFileSize=1024*1024*5,
	  maxRequestSize=1024*1024*5*5
)

@WebServlet("/admin/board/notice/reg")
public class RegController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/admin/board/notice/reg.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String isOpen = request.getParameter("open");
		
		Collection<Part> fileParts = request.getParts();
		StringBuilder builder = new StringBuilder();
		for(Part p : fileParts) {
			if(!p.getName().equals("file")) continue;
			if(p.getSize() == 0) continue; // Part의 크기가 0일 때 (빈 데이터)
			
			Part filePart = p;
			String fileName = filePart.getSubmittedFileName();
			
			InputStream fis = filePart.getInputStream();
			String realPath = request.getServletContext().getRealPath("/upload");
			
//			File path = new File(realPath);
//			if(!path.exists()) {
//				path.mkdirs();
//			}
			
			String filePath = realPath + File.separator + fileName;
			FileOutputStream fos = new FileOutputStream(filePath);
			
			byte[] buff = new byte[1024];
			int size = 0;
			while((size = fis.read(buff)) != -1) {
				fos.write(buff, 0, size);
				builder.append(fileName);
				builder.append(", ");
			}
			
			fos.close();
			fis.close();
		}
		
		builder.delete(builder.length() - 2, builder.length());
		
		boolean pub = false;
		if(isOpen != null) pub = true; 
		
		Notice notice = new Notice();
		notice.setTitle(title);
		notice.setContent(content);
		notice.setPub(pub);
		notice.setWriterId("newlec");
		notice.setFiles(builder.toString());

		NoticeService service = new NoticeService();
		service.insertNotice(notice);
		
		response.sendRedirect("list");
	}
}