-----
### 예약 관련 TABLE
-----
1. CarReserve Class에 대한 CAR_RESERVE TABLE 생성
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/3869ef5a-cd7b-41ab-9610-dc1a4af7e733">
</div>

```sql
CREATE TABLE CAR_RESERVE (
RESERVE_NO NUMBER CONSTRAINT CAR_RESERVE_RESERVE_NO_PK PRIMARY KEY,
NO NUMBER CONSTRAINT CAR_RESERVE_NO_NN NOT NULL,
ID VARCHAR2(10) CONSTRAINT CAR_RESERVE_ID_NN NOT NULL,
DURATION_DAY NUMBER CONSTRAINT CAR_RESERVE_DURATION_DAY_NN NOT NULL,
RESERVE_DAY VARCHAR2(50) CONSTRAINT CAR_RESERVE_RESERVE_DAY_NN NOT NULL,
USE_INSURANCE NUMBER CONSTRAINT CAR_RESERVE_USE_INSURANCE_NN NOT NULL,
USE_WIFI NUMBER CONSTRAINT CAR_RESERVE_USE_WIFI_NN NOT NULL,
USE_NAVIGATION NUMBER CONSTRAINT CAR_RESERVE_USE_NAVGATION_NN NOT NULL,
USE_BABY_SHEET NUMBER CONSTRAINT CAR_RESERVE_USE_BABY_SHEET_NN NOT NULL,

CONSTRAINT CAR_RESERVE_NO_FK FOREIGN KEY(NO) REFERENCES RENTCAR(NO),
CONSTRAINT CAR_RESERVE_ID_FK FOREIGN KEY(ID) REFERENCES MEMBER(ID)
);
```
- RESERVE_NO는 PK이며, Sequence를 이용해 설정 (RESERVE_SEQ)
```sql
CREATE SEQUENCE RESERVE_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000;
```

- NO, ID는 FK로서 각각 RENTCAR의 PK, ID는 MEMBER의 PK를 참조
- 모든 COLUMN에 대해서 NOT NULL

- 테이블 구조 및 제약조건
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/a5a0df6f-805d-427d-9aae-dc60b3fc5d3c">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/b1839fe2-466f-4184-b890-dfba64f78fc8">
</div>


- 총 3개의 테이블의 ERD
<div align = "center">
<img src = "https://github.com/sooyounghan/Web/assets/34672301/bf57c360-3e14-43a1-9608-8d211952e12b">
</div>


2. 기존 CarReserve Class

```java
package RentCar;


/*
 * 차량에 대한 예약 정보 클래스
 */
public class CarReserve {
	private int reserve_no; // 예약번호
	private String id; // 예약 회원 ID
	private int no; // 차 식별자
	private int car_num; // 차 수량
	private int duration_day; // 대여 기간
	private String reserve_day; // 대여일
	private int insurance; // 보험료
	private int use_wifi; // Wi-fi 이용
	private int navigation; // Navigation 이용
	private int baby_sheet; // BabySheet 이용
	
	public int getReserve_no() {
		return reserve_no;
	}

	public void setReserve_no(int reserve_no) {
		this.reserve_no = reserve_no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getNo() {
		return no;
	}
	
	public void setNo(int no) {
		this.no = no;
	}
	
	public int getCar_num() {
		return car_num;
	}
	
	public void setCar_num(int car_num) {
		this.car_num = car_num;
	}
	
	public int getDuration_day() {
		return duration_day;
	}
	
	public void setDuration_day(int duration_day) {
		this.duration_day = duration_day;
	}
	
	public String getReserve_day() {
		return reserve_day;
	}
	
	public void setReserve_day(String reserve_day) {
		this.reserve_day = reserve_day;
	}
	public int getInsurance() {
		return insurance;
	}
	
	public void setInsurance(int insurance) {
		this.insurance = insurance;
	}
	
	public int getUse_wifi() {
		return use_wifi;
	}
	
	public void setUse_wifi(int use_wifi) {
		this.use_wifi = use_wifi;
	}
	
	public int getNavigation() {
		return navigation;
	}
	
	public void setNavigation(int navigation) {
		this.navigation = navigation;
	}
	
	public int getBaby_sheet() {
		return baby_sheet;
	}
	
	public void setBaby_sheet(int baby_sheet) {
		this.baby_sheet = baby_sheet;
	}
}
```

-----
### CarReserveResult JSP Page
-----
```jsp
<%@ page import ="java.util.*, java.text.*, RentCar.RentCarDAO, RentCar.CarList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Car Reserve Result</title>
	<style>
	* {
	    box-sizing:border-box;
	    padding:0;
	    margin:0;
	}
	
	.wrapper_main {
		display:flex;
	    flex-direction:row;
	    justify-content:center;
	    align-items:center;
	}
	
	.car_result_text {
	    font-size:15px;
	    font-weight:600;
	    padding:10px;
	}

	.content_main {
		width:40%;
	    height:400px;
	    display:flex;
	    flex-direction:column;
	    justify-content:center;
	    align-items:center;
	}
	
	.car_image {
	    width:50%;
	    height:50%;
	    margin:10px;
	}
	
	.car_img_content {
	    width:100%;
	    height:100%;
	    object-fit:fill;
	}
	
	.car_result {
		display:flex;
	    flex-direction:column;
	    justify-content:center;
	    align-items:center;
	    font-size:15px;
	    font-weight:600;
		text-align:center;
	    width:50%;
	    height:50%;
	}
	
	.car_result_info {
		width:100%;
	    padding:5px;
	}
	</style>
</head>

<body>
	<jsp:useBean id="car_reserve" class="RentCar.CarReserve">
		<jsp:setProperty name="car_reserve" property="*"/>	
	</jsp:useBean>
	
	<%
		String id = (String)session.getAttribute("id");
		
		if(id == null) {		
	%>			
		<script>
			alert("Require Login!");
			location.href="RentCarMain.jsp?center=MemberLogin.jsp"
		</script>
	<%
		}
		
		// 날짜 비교
		Date d1 = new Date();
		Date d2 = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		d1 = sdf.parse(car_reserve.getReserve_day());
		d2 = sdf.parse(sdf.format(d2));
		
		int compare = d1.compareTo(d2);
		
		// 예약일자 < 현재 일자 : -1
		// 예약일자 = 현재 일자 : 0
		// 예약일자 > 현재 일자 : 1
		
		if(compare < 0) {
	%>			
			<script>
				alert("Wrong Date!");
				history.go(-1);
			</script>
	<%	
		}
		
		
		// CarReserve 객체인 car_reserve 객체에 reserve_no (Sequence 이용)과 회원 ID 입력되지 않았으므로 처리
		// 위의 id는 null 값에 대비한 경우, 현재부분은 login이 되었을 때 id
		String login_id = (String)session.getAttribute("id"); 
		car_reserve.setId(login_id);
		
		RentCarDAO rentCarDAO = new RentCarDAO();
		rentCarDAO.setReserveCar(car_reserve);
		// 차량 정보
		CarList car = rentCarDAO.getOneCarList(car_reserve.getNo());
		
		int total_price = car.getPrice() * car_reserve.getCar_num() * car_reserve.getDuration_day();

		int insurance = 0;
		int use_wifi = 0;
		int use_baby_sheet = 0;
		
		if(car_reserve.getInsurance() == 1) insurance = 10000;
		if(car_reserve.getUse_wifi() == 1) use_wifi = 10000;
		if(car_reserve.getBaby_sheet() == 1) use_baby_sheet = 10000;
		
		int option_price = car_reserve.getCar_num() * car_reserve.getDuration_day() * (insurance + use_wifi + use_baby_sheet);
	%>
	<div class="wrapper_main">
	<div class="content_main">
	        <p class="car_result_text">차량 예약 완료</p>
        <div class="car_image"><img class="car_img_content" src="./img/<%=car.getImg()%>"></div>
        <div class="car_result">
            <p class="car_result_info">차량 총 예약 금액 : <%=total_price%>원</p>
            <p class="car_result_info">차량 총 옵션 금액 : <%=option_price%>원</p>
            <p class="car_result_info">차량 총 금액 : <%=(total_price + option_price)%>원</p>
        </div>
    </div>  
    </div>
</body>
</html>
```

-----
### RentCarDAO : setReserveCar (차량 예약 관련 부분) 구현
-----
```java
package RentCar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

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
	
	/*
	 * 상위 3개의 Car List 추출
	 */
	public List<CarList> getSelectCar() {
		List<CarList> carList = new ArrayList<CarList>();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM RENTCAR ORDER BY NO DESC";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();

			int count = 0; // 상위 3개 상품 출력을 위해 설정
			while(rs.next()) {	
				CarList car = new CarList();
				
				car.setNo(rs.getInt(1));
				car.setName(rs.getString(2));
				car.setCategory(rs.getInt(3));
				car.setPrice(rs.getInt(4));
				car.setUsepeople(rs.getInt(5));
				car.setCompany(rs.getString(6));
				car.setImg(rs.getString(7));
				car.setInfo(rs.getString(8));
				
				carList.add(car);
				
				count++;
				if(count >= 3) break;
			}
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return carList;
	}
	
	/*
	 * Category별 CarList 추출
	 */
	public List<CarList> getCategoryCar(int category) {
		List<CarList> carList = new ArrayList<CarList>();
		
			try {
				getConnection();
				
				String sql = "SELECT * FROM RENTCAR WHERE CATEGORY = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, category);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					CarList car = new CarList();
					
					car.setNo(rs.getInt(1));
					car.setName(rs.getString(2));
					car.setCategory(rs.getInt(3));
					car.setPrice(rs.getInt(4));
					car.setUsepeople(rs.getInt(5));
					car.setCompany(rs.getString(6));
					car.setImg(rs.getString(7));
					car.setInfo(rs.getString(8));
					
					carList.add(car);
				}
				
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		return carList;
	}
	
	/*
	 * 모든 CarList 추출
	 */
	public List<CarList> getAllListCar() {
		List<CarList> carList = new ArrayList<CarList>();
		
			try {
				getConnection();
				
				String sql = "SELECT * FROM RENTCAR";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					CarList car = new CarList();
					
					car.setNo(rs.getInt(1));
					car.setName(rs.getString(2));
					car.setCategory(rs.getInt(3));
					car.setPrice(rs.getInt(4));
					car.setUsepeople(rs.getInt(5));
					car.setCompany(rs.getString(6));
					car.setImg(rs.getString(7));
					car.setInfo(rs.getString(8));
					
					carList.add(car);
				}
				
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		return carList;
	}
	
	/*
	 * 하나의 Car 정보 추출
	 */
	public CarList getOneCarList(int no) {
		CarList car = new CarList();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM RENTCAR WHERE NO = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				car.setNo(rs.getInt(1));
				car.setName(rs.getString(2));
				car.setCategory(rs.getInt(3));
				car.setPrice(rs.getInt(4));
				car.setUsepeople(rs.getInt(5));
				car.setCompany(rs.getString(6));
				car.setImg(rs.getString(7));
				car.setInfo(rs.getString(8));
			}
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return car;
	}
	
	/*
	 * 로그인 처리를 위한 회원 ID와 PassWord를 추출
	 */
	public int getMember(String id, String password) {
		int result = 0;
		
		try {
			getConnection();
			
			// 일치하면 1, 불일치하면 0 
			String sql = "SELECT COUNT(*) FROM MEMBER WHERE ID = ? AND PASS1 = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/*
	 * 예약 정보를 삽입
	 */
	public void setReserveCar(CarReserve car_reserve) {
		try {
			getConnection();
			
			String sql = "INSERT INTO CAR_RESERVE VALUES(RESERVE_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, car_reserve.getNo());
			pstmt.setString(2, car_reserve.getId());
			pstmt.setInt(3, car_reserve.getCar_num());
			pstmt.setInt(4, car_reserve.getDuration_day());
			pstmt.setString(5, car_reserve.getReserve_day());
			pstmt.setInt(6, car_reserve.getInsurance());
			pstmt.setInt(7, car_reserve.getUse_wifi());
			pstmt.setInt(8, car_reserve.getNavigation());
			pstmt.setInt(9, car_reserve.getBaby_sheet());
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
```
