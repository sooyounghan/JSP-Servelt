----
### JSP 게시판 - 시스템 구조 (답변형 구조 게시판)
----
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/3a2d3840-8ac2-48e6-8584-4dca95d28ee5">
</div>

  - 답변형 게사판이므로, 글 읽기 다음에 답변형이라는 기능을 추가

1. Board Table 구성 
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/1cfca3d3-8bb1-4aee-9eec-c3b6def2f8b3">
</div>

  - NUM : Auto-Increment(Sequence)


2. 답변형 구조 게시판 구조
  - REF : 글 그룹
      + 답변형 게시판이므로 글에 대해 그룹으로 설정
      + 예시) 1, 2, 3, 4번의 글을 썼는데(다른 그룹), 4번째 글이 1번 글에 대한 답변을 작성한 것이라면?
      + 처리) 4번째 글(1번째의 답변)은 결과적으로 1번 글과 같은 그룹으로 설정되어야함
      + 처리) 즉, 글 읽기에서 부모 글이나 부모 글에 대한 답변을 하면, 이들은 같은 글 그룹에 묶어야함
      + 중요) 답변형이 아닌 글읽기에서 글쓰기에서 넘어왔다면, 이 때는 다른 그룹으로 설정 (새글이면, REF 최고 값에 1증가)
        
  - RE_STEP : 글 스텝
      + 글의 답변인지, 글의 답변에 답변인지, 아니면 또 부가적인 답변인지 확인
      + 지금 누구의 답변 글인지 확인

  - RE_LEVEL : 글 레벨
      + 글의 어떤 순서대로 보여줘야할 것인지 (최신순)
      + 최신순이라면, 글 레벨은 최신순
      + 부모글을 제외한 부모 글보다 큰 글 레벨 숫자를 1씩 증가시키고, 최신순의 글을 부모글에 1을 증가
        
3. 예시
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/9ebc6709-8a0b-49e5-a3b8-1650a47015a7">
</div>

<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/ba8e1056-10bd-4e38-9445-03082e07ea94">
</div>
