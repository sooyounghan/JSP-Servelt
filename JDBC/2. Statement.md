-----
### Statement 객체
-----
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/72e792a5-3032-4724-b064-c711a4c491b0">
</div>
1. 정적 쿼리에 사용 : Connection 객체를 생성한 후에는 Connection 객체로부터 Statment를 생성하고 쿼리를 실행
  
       Statment createStatement() throws SQLException
       Statment stmt = conn.createStatement();

       ResultSet executeQuery(String query) : SELECT 쿼리 실행
       int executeUpdate(String query) : UPDATE, INSERT, DELETE 쿼리 실행

2. 하나의 쿼리를 사용하고나면, 더 이상 사용 불가
   
3. 하나의 쿼리를 끝내고 나면, close()를 사용해 객체를 즉시 해제


-----
### executeQuery()
-----
: 데이터를 조회하는 메서드

       ResultSet executeQuery(String sql) throws SQLException

< 사용 예 >
```jsp
<%
String memberID = request.getParameter("memeberID");
String name = request.getParameter("name");

Class.forName("com.mysql.jdbc.Driver");

Connection conn = null;
Statment stmt = null;

try {
  String jdbcDriver = "jdbc.mysql://localhost:3306/chap14?" + "useUnicode=true&characterEncoding=UTF8";
  String dbUser = "jspexam";
  String dbPass = "jsppw";

  String sql = "SELECT * FROM Member WHERE id = '1'";

  conn = DriverManager.getConnection(jdbcDriver, dbUser, dpPass);
  stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery(sql);
} catch (SQLException ex) {
} finally {
  if(stmt != null) try { stmt.close(); } catch(SQLException ex) { }
  if(conn != null) try { conn.close(); } catch(SQLException ex) { }
}
%>
```

-----
### executeUpdate()
-----
- 데이터를 삽입, 삭제, 수정하는 메서드

      int executeUpdate(String sql) throws SQLException
    
< 사용 예 >
```jsp
<%
int updateCount = 0;
String memberID = request.getParameter("memeberID");
String name = request.getParameter("name");

Class.forName("com.mysql.jdbc.Driver");

Connection conn = null;
Statment stmt = null;

try {
  String jdbcDriver = "jdbc.mysql://localhost:3306/chap14?" + "useUnicode=true&characterEncoding=UTF8";
  String dbUser = "jspexam";
  String dbPass = "jsppw";

  String sql = "UPDATE MEMBER set NAME = " + name + " " + "WHERE MEMBERID = " + memberID + "";

  conn = DriverManager.getConnection(jdbcDriver, dbUser, dpPass);
  stmt = conn.createStatement();
  updateCount = stmt.executeUpdate(sql);
} catch (SQLException ex) {
} finally {
  if(stmt != null) try { stmt.close(); } catch(SQLException ex) { }
  if(conn != null) try { conn.close(); } catch(SQLException ex) { }
}
%>
```

- 변경된 레코드의 개수를 Return
- 지정한 아이디가 존재하지 않으면 0을 리턴 = 즉, 레코드의 개수를 사용해 지정한 아이디가 존재하는지 여부 판단

-----
### ResultSet에서 값 얻어오기
-----
1. Statement 또는 PreparedStatment 객체로 SELECT 문을 이용해 얻어온 레코드 값을 테이블 형태로 가진 객체

         Statement : ResultSet executeQuery(String sql) throws SQLException
         PreparedStatement : Result executeQuery(String sql) thros SQLException
   
2. next() 메서드 : SELECT 결과의 존재 여부 확인 가능
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/4ab90eb0-2505-4371-bcd8-436706747e97">
</div>   

 - SELECT 쿼리 결과를 같은 행으로 저장하며 커서를 통해 각 행의 데이터에 접근
 - 최초의 커서는 1행 이전에 존재
 - 다음 행이 존재하면 true Return, 커서를 그 행으로 이동
 - 마지막 커서에 도달하면 next() 메서드는 false를 Return

3. 주요 데이터 읽기 메서드
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/d8b9eb64-808c-4eff-94e7-53615368bbb5">
</div>

    - getTimestamp(String name(or int index)) : 저장한 컬럼 값을 Timestamp 타입으로 읽어옴
    - getDate(String name(or int index)) : 저장한 컬럼 값을 Date 타입으로 읽어옴
    - getTime(String name(or int index)) : 저장한 컬럼 값을 Time 타입으로 읽어옴

```jsp
<%
Connection conn = null;

try {
...

Statement stmt = conn.createStatement():
String sql = "SELECT * FROM Member WHERE id = '1'";
ResultSet rs = stmt.executeQuery(sql);

while(rs.next()) {
  out.println(rs.getString(2) + ", " + rs.getString(3) + "<br/>");
}

} catch (SQLException ex) { // 예외처리
} finally {
if(stmt != null) try { stmt.close() } catch(SQLException ex) { }
if(conn != null) try { conn.close() } catch(SQLException ex) { }
}
%>
```
-----
### ResultSet에서 LONG VARCHAR 타입 값 읽어오기
-----
1. SQL의 LONG VARCHAR 타입은 대량의 텍스트를 저장할 때 사용

       - Oracle에서는 LONG VARCHAR를 LONG형으로 표시함을 주의
       - 하지만, 다수의 JDBC 드라이버는 getString() 메서드를 사용해 읽어올 수 있도록 함 (스트림 사용 이유가 없으면 사용)

2. getCharacterStream() 이용 : ReturnType이 java.io.Reader
3. 사용 방법
```java
String data = null;
java.io.Reader reader = null;

try {
  // 1. ResultSet의 getCharcteStream()을 통해 Reader를 구함
  reader = rs.getCharacterStream("FIELD");

  if(reader != null) {
    // 2. 스트림에서 읽어온 데이터를 저장할 버퍼를 생성
    StringBuilder buff = new StringBuilder();
    char[] ch = new char[512];
    int len = -1;

    // 3. 스트림에서 데이터를 읽어와 버퍼에 저장
    while((len = reader.read(ch)) != -1) {
        buff.append(ch, 0, len);
    }

    // 4. 버퍼에 저장한 내용을 String으로 반환
    data = buff.toString();
}
catch (IOException ex) {
// 5. IO 관련 처리 도중 문제가 있으면 IOException 발생
// 예외 발생
} finally {
// 6. Reader를 종료
  if(reader != null) try { redaer.close(); } catch(IOException ex) { }
}
```
