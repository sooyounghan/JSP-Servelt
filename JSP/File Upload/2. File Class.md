-----
### File 클래스
-----
1. 자바에서 파일과 디렉토리에 대해 다루는 클래스
2. File 클래스 관련 생성자 / 메서드
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/b55ac3d9-28f1-4bf6-b497-026fbeb32d53">
<img src="https://github.com/sooyounghan/Web/assets/34672301/90f71f32-c0b8-4bd8-b6fd-2df7c98dd4b0">
<img src="https://github.com/sooyounghan/Web/assets/34672301/50ecbbdb-ac60-42fe-b80f-12e8b766fe27">
</div>

-----
### File Upload 관련 논의사항
-----
1. Upload 폴더에 대한 변경 방법
```java
  Part filePart = p;
  String fileName = filePart.getSubmittedFileName();
  
  InputStream fis = filePart.getInputStream();
  String realPath = request.getServletContext().getRealPath("/upload");
  
  File path = new File(realPath);
  if(!path.exists()) {
    path.mkdirs();
  }
  String filePath = realPath + File.separator + fileName;
```

2. 기존 파일명과 동일한 파일명 존재 시, 처리 방법
