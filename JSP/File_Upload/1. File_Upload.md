-----
### 파일 업로드
-----
1. 웹 브라우저에서 서버로 파일을 전송하여 서버에 저장하는 것
2. 그 종류로는 텍스트 파일, 바이너리 파일, 문서 등 다양하게 가능
3. 웹 브라우저에서 서버로 파일을 전송하기 위해 JSP 페이지 내 form 태그 이용
4. Form에서 원하는 Data 파일을 업로드가 가능함
5. 단, 일반적인 request 내장 객체로는 불가능하며, Multi-part Form Data를 이용해 가능
  - JSP/Servlet에서 제공되지 않아 Tomcat에서 cos.jar파일을 다운 받아 이를 적용 (http://www.servlets.com/)
  - cos.jar 파일 내 multi-part form data 이용

-----
### form 태그 형식
-----
```jsp
<form action="JSP 파일" method="POST" enctype="multipart/form-data">
  <input type="file" name="요청 파라미터 이름">
</form>
```

1. form 태그의 method는 반드시 POST
2. form 태그의 enctype 속성은 반드시 multipart/form-data
3. form 태그의 action 속성은 파일 업로드를 처리할 JSP파일로 설정
4. 파일 업로드를 위해 input 태그의 type 속성을 file로 설정
   - 만약, 여러 파일 업로드를 하려면, 2개 이상의 input 태그를 사용하고, name에 서로 다른 값 설정


```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>File Upload</title>
	<style>
		* {
		    box-sizing:border-box;
		    padding:0;
		    margin:0;
		}
		
		.wrapper {
		    width:100%;
		    margin-top:30px;
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-items:center;
		}
		
		.upload_title {
		    padding:20px;
		}
		.upload_form {
		    border:3px solid gray;
		    width:30%;
		    height:300px;
		    border-radius:10%;
		    
		    display:flex;
		    flex-direction:column;
		    justify-content:center;
		    align-items:center;
		}
		
		.upload_title {
		    text-align:center;
		    margin-bottom:10px;
		}
		
		.upload_name {
		    font-size:20px;
		    font-weight:600;
		}
		
		.upload_id, .upload_file {
		    width:100%;
		    padding:5px;
		    margin:10px 0;
		
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-items:center;
		
		    font-size:13px;
		    font-weight:600;
		}
		
		.upload_id_input_text {
		    width:70%;
		    margin-left:10px;
		    border-radius:10%;
		    border:2px solid gray;
		}
		
		.upload_file_input_text {
		    width:70%;
		    margin-left:10px;
		    border-radius:10%;
		}
		
		.upload_file_input_text::file-selector-button {
		    width:40%;
		    height:20px;
		    font-size:10px;
		    font-weight:600;
		}
		
		.menu_bar {
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-items:center;
		    margin:10px;
		}
		
		.upload_button, .upload_cancel {
		    width:50px;
		    height:20px;
		    font-size:13px;
		    font-weight:600;
		    margin:10px;
		}
	</style>
</head>

<body>
   <div class="wrapper">
	<div class="upload_form">
        <form action="FileUploadProc.jsp" method="post" enctype ="multipart/form-data">
            <div class="upload_title"><p class="upload_name">파일 업로드</p></div>
            <div class="upload_id">
                <div class="upload_id_name"><p>ID : </p></div>
                <div class="upload_id_input"><input type="text" name="name" class="upload_id_input_text"></div>
            </div>


            <div class="upload_file">
                <p class="upload_file_name"><p>파일 : </p>
                <input type="file" name="filedata", class="upload_file_input_text">
            </div>

            <div class="menu_bar">
                <input type="submit" class="upload_button" value = "Upload">
                <input type="reset" class="upload_cancel" value = "Cancel">
            </div>
        </form>
    </div>
    </div>
</body>
</html>
```

-----
### 파일 업로드 처리 방법
-----
1. 웹 브라우저에서 서버로 파일을 업로드하면 서버롷 request Parameter를 분석
2. 파일을 찾고, 서버의 자원(파일 저장 폴더)에 저장하는 과정을 거침
3. 단순 자바 코드로 처리할 수 없어 cos.jar 또는 commons-fileupload.jar 이용

4. MultipartRequest 방법은 가장 간단한 방법 (cos.jar)
5. commons-fileupload.jar, commons-io.jar 방법은 아파치 API 이용하는 편리하고 강력한 API 제공

-----
### MultipartRequest 이용
-----
1. 웹 페이지에서 서버로 업로드되는 '파일 자체만' 다루는 클래스
2. 한글 인코딩 값을 얻기 쉽고, 서버의 파일 저장 폴더에 동일한 파일명이 있으면 자동으로 파일명 변경
3. comm.oreilly.servlet.* Import 필요

-----
### MultipartRequest 클래스 생성
-----
1. 다양한 생성자를 제공
2. 생성자의 형식
```java
MultipartRequest(javax.servlet.http.HttpServletRequest request,
                  java.lang.String saveDirectory,
                  int maxPostSize,
                  java.lang.String encoding,
                  FileRenamePolicy poiicy)
```

  - request : Request 내장 객체 설정
  - saveDirectory : 서버의 파일 저장 경로 설정
  - maxPostSize : 파일의 최대 크기(바이트 단위)로 설정 (최대 크기 초과 시, IOException 발생)
  - encoding : 인코딩 유형 설정
  - policy : 파일명 변경 정책 설정 (saveDirectory에 파일명이 중복되는 경우 덮어쓰기 여부 설정, 설정하지 않으면 덮어씀)

3. 생성 예
```jsp
<%@ page import="com.oreilly.servlet.&"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
....(생략)...
MultipartRequest multi = new MultipartRequest(request, "C:\\uploan", 5*1024*1024, "utf-8", new DefaultFileRenamePolicy())
```

-----
### MultipartRequest Method
-----
1. 일반 데이터는 getParameter() 메서드로 가능
2. 파일의 경우 getFileNames() 메서드를 이용해 데이터를 받음
3. 종류
   - String getContentType(String name) : 업로드된 파일의 콘텐츠 유형 반 환(없으면 null 반환)
   - String getParameter(String name) : 요청 파라미터 이름이 name인 값을 전달 받음
   - java.util.Enumeration getParameterNames() : 요청 파라미터 이름을 Enumeration 객체 타입으로 반환
   - java.io.File getFile(String name) : 서버에 업로드된 파일에 대한 파일 객체 반환 (없으면 null 반환)
   - java.util.Enumeration getFileNames() : Form Page 내 input 태그 내 type 값이 file로 설정된 요청 파라미터의 이름 반환
   - String getFilesystemName(String name) : 사용자가 설정해 서버에 실제로 업로드된 파일명 반환 (중복되면 변경된 파일명 반환)
   - Stirng getOriginalFileName(String name) : 사용자가 업로드한 실제 파일명 반환 (파일명이 중복되면 변경 전 파일명 반환)

```jsp
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="com.oreilly.servlet.*"%>
<%@page import="com.oreilly.servlet.Multipart.*"%>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%
	MultipartRequest multi = new MultipartRequest(request, "D:\\upload", 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
    
    String title = multi.getParameter("title");
    out.println("<h3>" + title + "</h3>");
    
    Enumeration files = multi.getFileNames();
    String name = (String) files.nextElement();
    
    String filename = multi.getFilesystemName(name);
    String original = multi.getOriginalFileName(name);
    
    out.println("실제 파일 이름 : " + original + "<br>");
    out.println("저장 파일 이름 : " + filename + "<br>");
%>
```

<예제>
```jsp
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
```

-----
### Commons-FileUpload 이용
-----
1. 파일 업로드 패키지로 서버의 메모리 상에서 파일 처리가 가능하도록 지원
2. Commons-io패키지를 바탕으로 작성되었기에, commons-fileupload.jar, commons-io.jar 파일을 다운로드해 사용
3. org.apache.commons.fileupload.* import 필요
4. 예제
```jsp
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%
	String fileUploadPath = "D:\\upload";
	DiskFileUpload upload = new DiskFileUpload();
	List items = upload.parseRequest(request);
    
    while(params.hasNext()){
    	FileItem fileItem = (FileItem)params.next();
        if(item.isFormField()){
        	String title = item.getString("UTF-8");
            out.println("<h3>" + title + "</h3>");
        } else{
        	String fileName = item.getName();
            fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
            File file = new File(fileUploadPath + "/" + fileName);
            item.write(file);
            out.println("파일 이름 : " + fileName + "<br>");
        }
    }
%>
```
  - Commons-FileUpload를 이용해 파일을 업로드를 하려면 Commons-FileUpload 패키지에 포함된 DiskFileUpload 객체 생성
  - 생성된 객체를 통해 DiskFileUpload 클래스가 제공하는 메서드를 이용해 웹 브라우저가 전송한 multipart/form-data 유형의 요청 파라미터를 가져옴
  - FileItem 클래스 메서드를 이용해 요청 파라미터가 일반 데이터, 파일인지 분석 및 처리해 파일 업로드

5. DiskFileUpload 클래스 메서드
   - void setRepositoryPath(String repositoryPath) : 업로드된 파일을 임시로 저장할 디렉토리 설정
   - void setSizeMax(long sizeMax) : 최대 파일 크기 설정
   - void setSizeThreshold(int sizeThreshold) : 메모리 상 저장할 최대 크기 설정
   - List<FileItem> parseRequest(Http.ServletRequest req) : multipart/form-data 유형 파라미터를 가져옴
  
6. FileItem 클래스 메서드
   - boolean isFormField() : 요청 파라미터가 파일이 아니라 일반 데이터이면 false 반환
   - String getFieldName() : 요청 파라미터의 이름을 얻어옴
   - String getString() : 기본 문자 인코딩을 사용해 요청 파라마티의 값을 가져옴
   - String getString(String encoding) : 설정한 문자 인코딩 사용해 요청 파라미터 값을 얻어옴
   - String getName() : 업로드된 파일(경로 포함)의 이름을 얻어옴
   - long getSize() : 업로드된 파일의 크기를 얻어옴
   - byte[] get() : 업로드된 파일을 바이트 배열로 받아옴
   - boolean isInMemory(0 : 업로드된 파일이 메모리에 저장되었으면 true, 임시 디렉토리에 저장되었으면 false 반환
   - void delete() : 파일과 관련된 자원 삭제 (메모리 상 저장된 경우 할당된 메모리 반환, 임시 파일로 저장된 경우 파일 삭제)
   - void write() : 파일과 관련된 자원 저장
   - String getContentType() : 웹 브라우저가 전송하는 콘텐츠 유형 반환, 정의되어 있지 않으면 null 반환
