-----
### Board Table
-----
1. BOARD_NUM은 Sequence 객체를 이용할 것이므로 Sequence 객체 우선 생성
```sql
CREATE SEQUENCE BOARD_SEQ 
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000;
```
  - 최소값과 시작값은 1이며, 1씩 증가하되, 최댓값은 1000
  - Sequence Name : BOARD_SEQ

2. BOARD TABLE 생성
```sql
CREATE TABLE BOARD (
BOARD_NUM NUMBER(4) CONSTRAINT BOARD_BOARD_NUM_NN NOT NULL,
WRITER VARCHAR2(20) CONSTRAINT BOARD_WRITER_NN NOT NULL,
EMAIL VARCHAR2(50),
SUBJECT VARCHAR2(50) CONSTRAINT BOARD_SUBJECT_NN NOT NULL,
CONTENT_PASSWORD VARCHAR(10) CONSTRAINT BOARD_CONTENT_PASSWORD_NN NOT NULL,
REG_DATE DATE DEFAULT SYSDATE,
REF NUMBER CONSTRAINT BOARD_REF_NUMBER_NN NOT NULL,
RE_STEP NUMBER CONSTRAINT BOARD_RE_STEP_NUMBER_NN NOT NULL,
RE_LEVEL NUMBER CONSTRAINT BOARD_RE_LEVEL_NUMBER_NN NOT NULL,
READCOUNT NUMBER CONSTRAINT BOARD_READ_COUNT_NUMBER_NN NOT NULL,
CONTENT VARCHAR2(500),

CONSTRAINT BOARD_BOARD_NUM_PK PRIMARY KEY(BOARD_NUM)
);
```

3. 테이블 및 ERD, 제약조건 현황
<div align = "center">
<img src="https://github.com/sooyounghan/DataBase/assets/34672301/5bfcfcba-1c46-47ad-8db3-65d7ab75a58b">
<img src="https://github.com/sooyounghan/Web/assets/34672301/8e52cf62-66fc-4ef2-b968-0eca3d5d88bd">
<img src="https://github.com/sooyounghan/DataBase/assets/34672301/08296f65-262e-4293-9541-e0c471c7cf06">
</div>

4. Server의 web.xml에 DBCP를 위한 설정
```jsp
<Context docBase="Board" path="/Board" reloadable="true" source="org.eclipse.jst.jee.server:Board">
  <Resource auth="Container" driverClassName="oracle.jdbc.driver.OracleDriver" type="javax.sql.DataSource" loginTimeout="10" maxWaits="5000" name="jdbc/pool" username="dbPractice" password="1234" url="jdbc:oracle:thin:@localhost:1521:xe"/>
</Context> 
```

-----
### Board Class (BeanClass)
-----
```java
package Board;

public class Board {
	private int board_num; // 글번호
	private String writer; // 글쓴이
	private String email; // 이메일 주소
	private String subject; // 글제목
	private String content_password; // 글에 설정한 비밀번호
	private String reg_date; // 글쓴 일자(화면 출력을 위해 String형으로 사용)
	private int ref; // 글 그룹
	private int re_step; // 글 단계
	private int re_level; // 글 레벨
	private int read_count; // 조회수
	private String content; // 글 내용
	
	public int getBoard_num() {
		return board_num;
	}
	
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	
	public String getWriter() {
		return writer;
	}
	
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getSubject() {
		return subject;
	}
	
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getContent_password() {
		return content_password;
	}
	
	public void setContent_password(String content_password) {
		this.content_password = content_password;
	}
	
	public String getReg_date() {
		return reg_date;
	}
	
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	
	public int getRef() {
		return ref;
	}
	
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	
	public int getRe_level() {
		return re_level;
	}
	
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	
	public int getRead_count() {
		return read_count;
	}
	
	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
}
```

-----
### Board DAO (DBCP 연동)
-----
```java
package Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public void getConnection() {
		try {
			Context initcnx = new InitialContext();
			Context envcnx = (Context)initcnx.lookup("java:comp/env");
			
			DataSource ds = (DataSource)envcnx.lookup("jdbc/pool");
			
			conn = ds.getConnection();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
```
