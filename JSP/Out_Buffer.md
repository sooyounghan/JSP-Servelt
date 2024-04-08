-----
### 출력 버퍼
-----
1. JSP 페이지는 응답 결과를 곧바로 웹 브라우저에 전송하지 않음
2. 출력 버퍼(Buffer)라고 불리는 곳에 임시로 응답 결과를 저장했다가 한 번에 웹 브라우저에 전송

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/73d4aae6-6f14-41e4-a89b-60f2a3e58496"> 
</div>

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/ad3e21d8-f67d-42f5-8da1-120dd1f276be"> 
</div>

3. JSP 실행 도중 버퍼를 지우고 새로운 내용을 전송 가능하다는 장점
   - < jsp : forward > 기능과 에러 페이지 처리 기능이 가능
   - 버퍼에 보관된 데이터는 일정 크기가 될 때까지 버퍼에 보관될 데이터를 지우고 새로운 내용이 전송 가능
     
4. 버퍼가 다 차기 전에 헤더 변경이 가능하다는 장점
   (버퍼 내용이 웹 브라우저에 전송되는 그 이후로는 헤더 정보를 변경해도 적용 불가)
