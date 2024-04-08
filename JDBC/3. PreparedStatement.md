-----
### PreparedStatement
-----
1. java.sql.PreparedStatement는 java.sql.Statement와 동일한 기능을 가짐
2. 동적 쿼리에 사용 (하나의 쿼리로 여러번의 쿼리를 실행 가능)
3. 동일한 쿼리문을 특정 값만 바꾸어서 여러번 실행해야 할 때, 매개변수가 많아 쿼리문을 정리해야할 때 유용
   - 값 변환을 자동하기 위해 사용
   - 간결한 코드를 위해 사용
    
4. 즉, SQL의 틀을 미리 생성해놓고 값을 나중에 지정
   
       PreparedStatement preparedStatement(String url) throws SQLException
       - 매개변수 sql : 데이터베이스에 보낼 Query (쿼리문에 정해지지 않은 값은 ? 표시)
       - 물음표에 값을 할당하기 위해 setter 메서드 사용

5. 사용 순서
   - Connection.preparedStatement() 메서드를 사용해 PreparedStatement 객체 생성
   - PreparedStatment의 set 메서드를 이용해 필요한 값 지정
   - PreparedStatment의 executeQuery() 또는 executeUpdate() 메서드를 사용해 쿼리 실행
   - finally 블록에서 사용한 PreparedStatement 객체 닫음 (close() 메서드 실행)

6. 객체를 생성할 때, 실행할 쿼리를 미리 입력하는데, 물음표(?)를 대치한 쿼리 사용
```jsp
<%
PreparedStatement pstmt = null;

...

pstmt = conn.prepareStatement("insert into MEMBER(MEMBERID, NAME, EMAIL) VALUES (?, ? ,?)");
%>
```

7. 객체를 생성한 다음, 객체가 제공하는 set 계열 메서드를 사용해 물음표를 대체할 값을 지정해줘야함
```
<%
pstmt.setString(1, "madvirus");
pstmt.setString(2, "hi");
%>
```
  - 첫 물음표의 인덱스는 1이며, 이후 물음표의 인덱스는 나오는 순서대로 인덱스 값이 1씩 증가

8. 제공하는 set 메서드
<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/c0c3b5b4-b249-4774-b6cf-f7a45318b9cf">
</div>

  - ResultSet executeQuery()
```jsp
<%
Connection conn = null;
...
String sql = "SELECT * FROM Member WHERE id = ?";

PreparedStatement pstmt = conn.preparedStatement(sql);
pstmt.setString(1, "1");
ResultSet rs = pstmt.executeQuery(sql);
%>
```

  - int executeUpdate()
```jsp
<%
Connection conn = null;

String sql = "INSERT INTO Member(id, name, password) VALUES(?, ?, ?)";
// String sql = "DELETE FROM Member WHERE id = ?";
PreparedStatement pstmt = conn.preparedStatement(sql);
pstmt.setString(1, "1");
pstmt.setString(2, "홍길순");
pstmt.setString(3, "1234");

pstmt.executeQuery(sql);

...


ResultSet rs = pstmt.executeQuery(sql);
%>
```

-----
### PreparedStatement 에서 LONG VARCHAR 타입 값 지정하기
-----
1. setCharacterStream(int index, Reader reader, int length) : Reader로부터 length 글자 수 만큼 데이터를 읽어와 저장
  - String 타입을 저장하고 싶으면, StringReader 사용
```jsp
<%
PreparedStatment pstmt = null;

try {
   String value = " ... "; // LONG VARCHAR에 넣을 값
   pstmt = conn.preparedStatement(..);
   java.io.StringReader reader = new java.io.StringReader(value);
   pstmt.setCharacterStream(1, reader, value.length);
...
} catch (SQLException ex) {
...
} finally {
...
   if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) { }
}
%>
```

2. 텍스트 파일로부터 데이터를 읽어와 저장하고 싶으면, FileReader 사용
```jsp
<%
PreparedStatment pstmt = null;

try {
   pstmt = conn.preparedStatement(..);
   java.io.FileReader reader = new java.io.FileReader(파일경로);
   pstmt.setCharacterStream(1, reader, value.length);
...
} catch (SQLException ex) {
...
} catch (IOException ex) {
} finally {
...
   if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) { }
   if(reader != null) try { reader.close(); } catch(SQLException ex) { }
}
%>
```
