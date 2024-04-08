-----
### DataBase Connection Pool (DBCP)
-----
1. 웹 컨테이너가 실행되면서 Connection 객체를 미리 Pool에 생성
2. DB와 연결된 Connection을 미리 생성해 Pool 속에 저장해두고 필요시마다 사용하고 반환
3. 미리 생성해두기 때문에 데이터베이스 부하 방지 및 유동적 연결 관리 가능
4. 사용 이유
   - JDBC를 통해 DB를 연결하기 위해서는 Driver를 Load하고 Connection 객체를 가져와야함
   - JDBC를 사용하면 사용자가 요청할 때마다 매번 Driver Load 및 Connection 객체 생성 후 연결 및 종료 때문에 비효율적
   - 이 문제를 해결하기 위해 DBCP를 사용 (속도적인 측면에서 효율적)

-----
### JNDI(Java Naming and Directory Interface)
-----
1. 디렉터리 서비스에서 제공하는 데이터 및 객체를 발견하고 참고(lookup)하기 위한 자바 API
2. 외부에 있는 객체를 가져오기 위한 기술
3. Tomcat와 같은 WAS를 보면 특정 폴더에 필요한 데이터 소스(라이브러리)가 있는데 그것을 우리가 사용하기 위해 JNDI를 이용해서 가져오는 것
4. JNDI와 DBCP의 전체적 구성
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/39fa8ccb-d54e-43d8-8af9-7a5f10560dd7">
</div>

  - 사용자가 요청을 함
  - 요청은 Contorl을 거쳐서 Model로 전달
  - Model로 넘어간 요청은 JNDI에 등록된 데이터베이스 객체(Type : DataSource)를 검색
  - JNDI를 통해 찾은 객체로부터 Connection 획득
  - 데이터베이스 작업이 끝난 후 획득한 Connection 반납
  
-----
### DBCP 연결
-----
1. 웹 컨테이너가 실행되면서 JDBC에 대해 Connection 객체를 Connection Pool을 사용하기 위해 필요한 웹 서버의 server.xml에 할당
```jsp
      <Context docBase="DataBase" path="/DataBase" reloadable="true" source="org.eclipse.jst.jee.server:DataBase">
      		<Resource name = "jdbc/pool" auth = "Container" type="javax.sql.DataSource"
      					driverClassName = "oracle.jdbc.driver.OracleDriver" loginTimeout = "10" maxWaits = "5000"
      					username = "dbPractice" password = "1234" url="jdbc:oracle:thin:@localhost:1521:xe"/>   			
      </Context>
```
  - < Resource >~< /Resoure > : 자원을 할당하는 것을 의미
  - Resource 태그 내 속성 설명
    + name : 자원을 사용할 이름
    + auth : 자원 관리자 (Web Container Connection Pool을 이용할 것이기 때문에 Container로 설정)
    + type : 객체를 생성할 타입 (SQL 내의 DataSource를 이용할 것이므로 javax.sql.DataSource)
    + driverClassName : JDBC 드라이버
    + username : 접속 계정
    + password : 접속할 계정의 비밀번호
    + loginTimeout : 접속된 자원과 연결이 끊어지는 시간
    + maxWaits : 사용 가능한 Connection 없을 때 Connection 회수를 기다리는 시간 (1000 = 1초)
    + url = 접속할 자원의 url 주소

          maxActive : 최대 연결 가능한 Connection 수
          maxIdle : Connection Pool 유지를 위한 최대 대기 Connection 숫자
          testOnBorrow : DB Test 설정

2. 할당된 자원을 Web Project의 web.xml에서 설정하는 방법
```jsp
<resource-ref>
     <description>connection</description>
     <res-ref-name>jdbc/pool</res-ref-name>
     <res-type>javax.sql.DataSource</res-type>
     <res-auth>Container</res-auth>
</resource-ref>
```

  - description : 설명
  - res-ref-name : JDBC 이름 (<Resource>태그와 동일하게 이름 설정)
  - res-type : <Resource>의 type부분과 일치
  - res-auth : <Resource>의 auth부분과 일치

    
3. Java 혹은 JSP Page에서 설정
```java
import javax.naming.Context; 
import javax.naming.InitialContext; // Web Container의 초기 Context를 가져오기 위해 Import
import javax.sql.DataSource; //  java.sql 패키지의 기능을 보조하기 위해 Import

	// Connection Pool 이용해 DB 접근
		try {

			// 외부에서 데이터를 읽어드리기 위해 초기 context 객체 설정
			Context initctx = new InitialContext();
			
			// Tomcat 서버에 정보를 담아 놓은 곳으로 이동 (java:comp/env(자바 환경 설정 변수)에 해당하는 객체를 찾아 envctx에 연결)
			Context envctx = (Context)initctx.lookup("java:comp/env");
			
			// Data Source 객체 생성 ("jdbc/pool"에 해당하는 객체를 찾아 ds에 연결)
			DataSource ds = (DataSource)envctx.lookup("jdbc/pool");
			
			// Data Source를 기준으로 Connection 연결 (getConnection()을 이용해 Connection Poo로부터 Connection 객체를 얻어 연결)
			conn = ds.getConnection();

            /*   위의 코드를 아래와 같이 줄여서 작성 가능하다.
             Context context = new InitialContext();
             DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/oracle");
             Connection con = dataSource.getConnection();
            */

		} catch (Exception e) {
			e.printStackTrace();
		}
```




   
