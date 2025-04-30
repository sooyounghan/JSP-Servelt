-----
### 요구사항 정의
-----
1. 개인 렌터카 예약 서비스 Shopping Mall
2. 구성 : Top (Logo, Menu, 회원정보) / Center (Top의 메뉴를 선택하면 변경) / Bottom
3. Top의 주요 기능 구현 예정 부분 : 예약 / 예약 확인 / [이벤트 / 고객 센터]
  
4. 주요 기능 (예약하기)
   - 렌터카 카테고리 구성 : 카테고리에 따라 전체 또는 일부 리스트 선택 가능 
   - 특정 렌터카를 선택하면, 예약할 수 있는 기능
   - 수량이 부족하면, 예약이 힘든 메세지 까지 출력
   - 결제 시스템 전까지 구현 예정
     
5. 예약 확인 : 본인의 아이디와 비밀번호를 입력하면 예약 정보 확인을 제공하는 서비스

6. DB TABLE 구성
   - 렌터카 사이트에 등록된 자동차에 대한 정보를 담을 TABLE
   - 주문 유저 TABLE
   - 예약 확인 TABLE
  
-----
### DBCP 연동
-----
1. RentCar Project 생성 후, DBCP 연동

  - WAS의 Server.xml 설정 변경 (Pool에 Connection 객체 준비)
```jsp
      <Context docBase="RentCar" path="/RentCar" reloadable="true" source="org.eclipse.jst.jee.server:RentCar">
      	<Resource auth="Container" driverClassName="oracle.jdbc.driver.OracleDriver" loginTimeout="10" maxWaits="5000" name="jdbc/pool" password="1234" type="javax.sql.DataSource" url="jdbc:oracle:thin:@localhost:1521:xe" username="dbPractice"/>
      </Context>
```

2. RentCarDAO 생성 (DBCP 연동)
```java
package RentCar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class RentCarDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public void getConnection() {
		try {
			Context initcnx = new InitialContext();
			Context envcnx = (Context)initcnx.lookup("java:comp/env");
			DataSource ds = (DataSource)envcnx.lookup("jdbc/pool");
			
			conn = ds.getConnection();
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
```

1. Context 및 InitialContext : NamingException 발생 가능
2. DataSource에서 Connection 과정 : SQLException 발생 가능

-----
### RentCar TABLE 설정
-----
1. 렌터카 정보 TABLE
<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/753d9cc1-1842-4f9b-bbd6-16ec0741dc30">
</div>

   - RENTCAR TABLE 구조
```sql
CREATE TABLE RENTCAR (
NO NUMBER CONSTRAINT RENTCAR_NO_PK PRIMARY KEY,
NAME VARCHAR2(20) CONSTRAINT RENTCAR_NAME_NN NOT NULL,
CATEGORY NUMBER CONSTRAINT RENTCAR_CATEGORY_NN NOT NULL,
PRICE NUMBER CONSTRAINT RENTCAR_PRICE_NN NOT NULL,
USE_PEOPLE NUMBER CONSTRAINT RENTCAR_USE_PEOPLE_NN NOT NULL,
COMPANY VARCHAR2(50) CONSTRAINT RENTCAR_COMPANY_NN NOT NULL,
IMG VARCHAR2(50),
INFO VARCHAR2(500)
);
```
  + 자동차 식별자 (NO)는 PK
  + IMG와 INFO를 제외한 COLUMN은 NOT NULL 제약 조건 설정

<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/8f52109d-ee41-4a52-b86e-21a2b4a500a9">
<img src="https://github.com/sooyounghan/Web/assets/34672301/5a6bf857-51d2-4998-830b-563ad56c1c02">
<img src="https://github.com/sooyounghan/Web/assets/34672301/bcc4ebc3-b8a9-482f-8584-2364802cef1f">
</div>

2. 회원 정보 TABLE
3. 예약 정보 TABLE
   
-----
### CarList Bean Class [RENTCAR TABLE에 대한 Class]
-----
```java
package RentCar;

/*
 * RentCar에 대한 데이터에 대한 클래스
 */
public class CarList {
	private int no; // 자동차 식별자 
	private String name; // 자동차 이름
	private int category; // 자동차 분류
	private int price; // 렌터카 가격
	private int usepeople; // 차량 탑승 가능 인원
	private String company; // 자동차 회사
	private String img; // 렌터카 이미지
	private String info; // 렌터카 정보
	
	public int getNo() {
		return no;
	}
	
	public void setNo(int no) {
		this.no = no;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int getCategory() {
		return category;
	}
	
	public void setCategory(int category) {
		this.category = category;
	}
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}
	
	public int getUsepeople() {
		return usepeople;
	}
	
	public void setUsepeople(int usepeople) {
		this.usepeople = usepeople;
	}
	
	public String getCompany() {
		return company;
	}
	
	public void setCompany(String company) {
		this.company = company;
	}
	
	public String getImg() {
		return img;
	}
	
	public void setImg(String img) {
		this.img = img;
	}
	
	public String getInfo() {
		return info;
	}
	
	public void setInfo(String info) {
		this.info = info;
	}
}
```

-----
### Car Image에 대한 Mapping 작업 및 RENTCAR TABLE 내 자동차 정보 삽입
-----
1. 프로젝트 내 WebApp 내 img 폴더 (정적 이미지 저장 용도) 후 해당 이미지 삽입
2. RENTCAR TABLE 내 자동차 정보 삽입
   - CATEGORY : 소형(1), 중형(2), 대형(3)
   - IMG : 1번에서 저장한 해당 이미지와 동일하게 매핑

      		예) 아반테1에 대한 이미지의 이름이 1.jpg라면, DB 데이터 삽입 시 IMG도 동일
```sql
INSERT INTO RENTCAR VALUES(1 , '아반테1' , 1 , 2000 , 4 , '현대' , '1.jpg' , '아반테1 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(2 , '아반테2' , 3 , 2001 , 2 , '현대' , '2.jpg' , '아반테2 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(3 , '아반테3' , 2 , 2002 , 3 , '현대' , '3.jpg' , '아반테3 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(4 , '아반테4' , 1 , 2003 , 4 , '현대' , '4.jpg' , '아반테4 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(5 , '아반테5' , 3 , 2002 , 3 , '현대' , '5.jpg' , '아반테5 자동차 입니다 .');

INSERT INTO RENTCAR VALUES(6 , '무쏘1' , 1,  2010 , 3 , '쌍용' , '6.jpg' , '무쏘1 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(7 , '무쏘2' , 3 , 2009 , 2 , '쌍용' , '7.jpg' , '무쏘2 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(8 , '무쏘3' , 2 , 2001 , 4 , '쌍용' , '8.jpg' , '무쏘3 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(9 , '무쏘4' , 2 , 2002 , 4 , '쌍용' , '9.jpg' , '무쏘4 자동차 입니다 .');

INSERT INTO RENTCAR VALUES(10 , 'sm5_1' , 1 , 2001, 4 , '삼성' , '10.jpg' ,  'sm5_1 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(11 , 'sm5_2' , 3 , 2003 , 4 , '삼성' , '11.jpg' , 'sm5_2 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(12 , 'sm5_3' , 2 , 2005 , 4 , '삼성' , '12.jpg' , 'sm5_3 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(13 , 'sm5_4' , 2 , 2006 , 4 , '삼성' , '13.jpg' , 'sm5_4 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(14 , 'sm5_5' , 1 , 2001 , 4 , '삼성' , '14.jpg' , 'sm5_5 자동차 입니다 .');

INSERT INTO RENTCAR VALUES(15,  '카마로1' , 3 , 2001 , 4 , 'GM' , '15.jpg' , '카마로1 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(16 , '카마로2' , 1 , 2003 , 4 , 'GM' , '16.jpg' , '카마로2 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(17,  '카마로3' , 2 , 2005 , 4 , 'GM' , '17.jpg' , '카마로3 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(18,  '카마로4' , 2 , 2001 , 4 , 'GM' , '18.jpg' , '카마로4 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(19,  '카마로5' , 3 , 2002 , 4 , 'GM' , '19.jpg' , '카마로5 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(20,  '카마로6' , 1 , 2005 , 4 , 'GM' , '20.jpg' , '카마로6 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(21,  '카마로7' , 3 , 2006 , 4 , 'GM' , '21.jpg' , '카마로7 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(22,  '카마로8' , 2 , 2008 , 4 , 'GM' , '22.jpg' , '카마로8 자동차 입니다 .');

INSERT INTO RENTCAR VALUES(23, '쏘랜토1' , 2 , 2001 , 4 , '기아' , '23.jpg' , '쏘랜토1 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(24, '쏘랜토2' , 3 , 2003 , 4 , '기아' , '24.jpg' , '쏘랜토2 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(25, '쏘랜토3' , 1 , 2002 , 4 , '기아' , '25.jpg' , '쏘랜토3 자동차 입니다 .');
INSERT INTO RENTCAR VALUES(26, '쏘랜토4' , 3 , 2005 , 4 , '기아' , '26.jpg' , '쏘랜토4 자동차 입니다 .');
```

<div align ="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/030c029e-1a52-4598-8517-1cda9774874b">
</div>
