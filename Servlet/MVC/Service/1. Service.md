-----
### 코드의 분리 (기업형)
-----
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/b167ed8e-6783-4bfb-add8-65745ab52c80">
</div>

1. 클라이언트로부터 요청과 응답을 받고, 이를 View로 전송하는 부분인 Controller(Servlet)
2. 요청과 응답에 대해 실질적인 처리를 담당 Service Class
   - Model : Controller에 대한 요청/응답에 대해 Service Class와 연동되는 부분 : Model
3. 실제로 데이터를 조작하는 Model(DAO)
   - 비즈니스 로직을 처리하여 Service Class와 연동되는 부분 : Entity
4. 문서를 출력하는 View(JSP Page)

5. 필요에 따라 Service와 Controller를 합치거나 DAO와 Service를 합치기도 함
   
<div align="center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/f5ee6c7a-c269-4aef-ad8a-08e579f92056">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/82d98311-afb5-4997-aa58-f5fe474e7b96">
</div>

-----
### Service 함수 및 클래스 - 공지 시스템 이용 (NoticeService)
-----
1. 공지 시스템의 전반적인 구성
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/f1410bc1-a286-4fcd-9236-c41a253bc70c">
</div>

  - 관리자 : 공지를 등록 / 일괄 공개 가능 / 공지 수정 및 삭제 / 일괄 삭제 가능 (사용자의 기능도 당연히 존재)
  - 사용자 : 공지 목록 조회 / 공지 상세 조회 가능

<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/c6b33904-2b77-494b-84c9-7dcbd4f1c801">
</div>

2. 공지사항 목록에 대한 사용자가 요청 가능한 서비스의 예와 서비스 메서드 찾아내기
   - 어떠한 링크를 통해 공지사항 페이지 요청 : getNoticeList()
   - 공지사항의 페이지 번호에 대한 공지사항 페이지 요청 : getNoticeList(int page)
   - 검색 요청 : getNoticeList(String field, String query, int page) [filed는 검색분류, query는 검색 키워드, page는 검색 결과에 대한 페이지 수]
   - 공지사항의 전체 페이지 수와 현재(또는 검색을 통한) 페이지 수 : getNoticeCount() / getNoticeCount(String field, String query)

<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/00966567-4d7f-41cc-9299-1b5935e55627">
</div>

3. 하나의 공지사항 글에 대한 사용자가 요청 가능한 서비스의 예와 서비스 메서드 찾아내기
   - 사전 조건 : 해당 글에 대한 id를 알아야함
   - 현재 공지사항 글에 대한 정보 : getNotice(int id)
   - 다음 공지사항에 대한 정보 : getNextNotice(int id)
   - 이전 공지사항에 대한 정보 : getPrevNotice(int id)
  
