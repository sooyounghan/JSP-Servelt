<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>File Upload Processing</title>
</head>

<body>
	<%
		// Project 내 만들어질 폴더를 저장할 이름 변수 선언
		String realFolder = "";
	
		// 실제 만들어질 폴더명 설정
		String saveFolder = "/upload";
		
		// 한글 설정
		String encType = "UTF-8";
		
		// 저장된 파일 사이즈 설정 (5MB로 설정)
		int maxSize = 1024 * 1024 * 5;
		
		// 파일이 저장될 경로 값을 읽어오는 객체 선언
		ServletContext context = getServletContext();
		
		realFolder = context.getRealPath(saveFolder);
		
		try {
			// Client로부터 얻어온 데이터를 저장해주는 객체
			// DefaultFileRenamePolicy : 파일 이름을 자동으로 변경
			MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	%>
		이름 : <%=multi.getParameter("name")%>
	<%
		out.println(realFolder);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>