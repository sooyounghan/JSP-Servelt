-----
### Notice - Reply Join
-----
```sql
SELECT N.ID, N.TITLE, N.WRITER_ID, N.REGDATE, N.HIT, N.FILES, COUNT(C.ID) "COUNT"
FROM NOTICE N LEFT OUTER JOIN "COMMENT" C ON (N.ID = C.NOTICE_ID)
GROUP BY N.ID, N.TITLE, N.WRITER_ID, N.REGDATE, N.HIT, N.FILES
ORDER BY N.REGDATE DESC;
```

-----
### Notice - Reply Join 관련 View
-----
```sql
CREATE VIEW NOTICE_VIEW
AS
SELECT N.ID, N.TITLE, N.WRITER_ID, N.REGDATE, N.HIT, N.FILES, COUNT(C.ID) "COUNT"
FROM NOTICE N LEFT OUTER JOIN "COMMENT" C ON (N.ID = C.NOTICE_ID)
GROUP BY N.ID, N.TITLE, N.WRITER_ID, N.REGDATE, N.HIT, N.FILES;
```

-----
### View를 이용한 Notice-Reply 조회
-----
```sql
SELECT B.*
FROM (SELECT  ROWNUM NUM, A.*
      FROM (SELECT * FROM NOTICE_VIEW ORDER BY REGDATE DESC) A) B
WHERE NUM BETWEEN ? AND ?;
```

-----
### NoticeView Class : Notice 클래스 상속
-----
```java
package com.newlecture.web.entity;

public class NoticeView extends Notice {

	private int comment_count;

	public int getComment_count() {
		return comment_count;
	}

	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}
}
```

-----
### NoticeDAO getAllNoticeList 수정
-----
```java
public List<NoticeView> getAllNoticeList(String field, String query, int page) {
		List<NoticeView> noticeList = new ArrayList<NoticeView>();
		
		try {
			getConnection();
			
			String sql = "SELECT B.* FROM (SELECT A.*, ROWNUM NUM FROM (SELECT * FROM NOTICE_VIEW WHERE " + field + " LIKE ? ORDER BY REGDATE DESC) A) B WHERE NUM BETWEEN ? AND ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+query+"%");
			pstmt.setInt(2, (page - 1) * 10 + 1);
			pstmt.setInt(3, page * 10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeView notice = new NoticeView();
				
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setRegdate(rs.getDate(4));
				notice.setHit(rs.getInt(5));
				notice.setFiles(rs.getString(6));
				notice.setComment_count(rs.getInt(7));
				
				noticeList.add(notice);
			}
			conn.close();
  		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return noticeList;
	}
```

-----
### NoticeService 변경
----
```java
public class NoticeService {
	NoticeDAO noticeDAO = new NoticeDAO();
	
	public List<NoticeView> getNoticeList() {
		return getNoticeList("title", "", 1); // 기본값으로 해당 메서드 호출
	}
	
	public List<NoticeView> getNoticeList(int page) {
		return getNoticeList("title", "", page);
	}
	
	public List<NoticeView> getNoticeList(String field, String query, int page) {
		List<NoticeView> noticeList = noticeDAO.getAllNoticeList(field, query, page);
		return noticeList;
	}
...
}
```

-----
### NoticeListController 변경
-----
```java
...
		List<NoticeView> noticeList = service.getNoticeList(field, query, page);
...
```

-----
### list.jsp 변경
-----
```jsp
    <td>${notice.id}</td>
    <td class="title indent text-align-left"><a href="/Project/notice/detail.do?id=${notice.id}">${notice.title}<span>[${notice.comment_count}]</span></a></td>
    <td>${notice.writerId}</td>
```

