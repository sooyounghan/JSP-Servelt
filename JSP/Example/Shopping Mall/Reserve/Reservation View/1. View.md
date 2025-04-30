-----
### CarReserveView JSP Page
-----
1. 예약에 대한 정보를 확인하는 페이지
2. 오늘 날자 이후에 대한 예약에 대해서 확인
3. 웹 페이지에 로그인된 유저에 대해서 예약 내역을 확인
4. Top.jsp에서 Reserve Check 메뉴 변경
```jsp
        <div class="top_menu">
            <div class="menu1 menu"><a href = "RentCarMain.jsp?center=CarReserveMain.jsp">Reservation</a></div>
            <div class="menu2 menu"><a href = "RentCarMain.jsp?center=CarReserveView.jsp">Reserved Check</a></div>
            <div class="menu3 menu"><a href = "#">Board</a></div>
            <div class="menu4 menu"><a href = "#">Event</a></div>
            <div class="menu5 menu"><a href = "#">Q&A</a></div>
        </div>
```

5. 보여줄 항목
   - 예약 차량의 이미지
   - 예약 차량의 이름
   - 예약 차량의 대여 가격
   - 예약 차량 수량
   - 예약 차량의 대여 기간
   - 예약 차량의 대여 일자
   - 예약 차량의 보험료 유무
   - 예약 차량의 Wi-fi 이용 유무
   - 예약 차량의 Navigation 이용 유무
   - 예약 차량의 BabySheet 유무
  
-----
### Car(Reserve)View Class
-----
1. 보여줄 항목에 대해 새로운 Bean Class 생성
```java
package RentCar;

/*
 * 차량 예약에 대한 정보를 담을 Class
 */
public class CarView {
	private String name; // 차 이름
	private int price; // 대여 가격
	private String img; // 차 이미지
	private int car_num; // 차 수량
	private int duration_day; // 대여기간
	private String reserve_day; // 대여일
	private int insurance; // 보험료
	private int use_wifi; // Wi-fi 이용
	private int navigation; // Navigation 이용
	private int baby_sheet; // BabySheet 이용
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}
	
	public String getImg() {
		return img;
	}
	
	public void setImg(String img) {
		this.img = img;
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
2. 이 정보를 얻기 위한 JOIN 방법
```sql
SELECT *
FROM RENTCAR R INNER JOIN CAR_RESERVE C ON (R.NO = C.NO)
WHERE C.ID = ?  AND SYSDATE < TO_DATE(C.RESERVE_DAY, 'YYYY-MM-DD');
```

-----
### Top.jsp 부분에 CarReserveView JSP Page 연동
-----
```jsp
<body>
<%
	// Session을 이용한 로그인 처리
	String id = (String)session.getAttribute("id");

	if(id == null) {
		id = "Guest";
	}
%>
    <header class="top">
        <div class="top_logo_user">
            <div class="top_logo"><a href = "RentCarMain.jsp"><img src = "./img/logo.png"></a></div>
            <div class="top_user"><p><%=id%>님 어서오세요!
            <%
	        	if(id.equals("Guest")) {
	        %>
	        	<button class="login" onclick="location.href='RentCarMain.jsp?center=MemberLogin.jsp'">Login</button>
	        <%
	        	} else {
	        %>
	           	<button class="login" onclick="location.href='MemberLogOut.jsp'">Logout</button>
	        <%
	        	}
	        %>
	        </p>
            </div>
        </div>
        <div class="top_menu">
            <div class="menu1 menu"><a href = "RentCarMain.jsp?center=CarReserveMain.jsp">Reservation</a></div>
            <div class="menu2 menu"><a href = "RentCarMain.jsp?center=CarReserveView.jsp">Reserved Check</a></div>
            <div class="menu3 menu"><a href = "#">Board</a></div>
            <div class="menu4 menu"><a href = "#">Event</a></div>
            <div class="menu5 menu"><a href = "#">Q&A</a></div>
        </div>
    </header>
</body>
```

-----
### CarReserveView JSP Page
-----
```jsp
<%@ page import="RentCar.RentCarDAO, RentCar.CarView, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Car Reserve View</title>
	<style>
	* {
    box-sizing:border-box;
    padding:0;
    margin:0;
	}
	
	.result {
	    width:100%;
	    height:100%;
	    display:flex;
	    flex-direction:column;
	    justify-content:center;
	    align-items:center;
	}
	
	.result_title {
	    width:100%;
	    padding:10px;
	    text-align:center;
	}
	
	.result_wrapper {
	    width:90%;
	    height:300px;
	    padding:10px;
	    display:flex;
	    flex-direction:row;
	    justify-content:center;
	    text-align:center;
	}
	
	.result_item {
	    width:100%;
	    display:flex;
	    flex-direction:row;
	    justify-content:center;
	    text-align:center;
	}
	
	.result_img {
		width:100%;
		height:100%;
	}
	
	.result_image {
		width:100%;
		height:100%;
	    object-fit:fill;
	}
	.result_content_box {
	    width:50%;
	    height:100%;
	    margin:0 10px;
	    display:flex;
	    flex-wrap:wrap;
	    flex-direction:column;
	    justify-content:center;
	    text-align:left;
	}
	
	.result_title_name {
	    font-size:20px;
	    font-weight:600;
	    margin:5px
	
	}
	.result_content {
	    font-size:13px;
	    font-weight:600;
	    margin:5px
	}
	
	.result_menu {
	    text-align:center;
	}
	
	.delete_button {
	    border-radius:6px;
	    width:50px;
	    height:30px;
	}
	</style>
</head>

<body>
	<%
		String id = (String)session.getAttribute("id");
		
		if(id == null) {
	%>
		<script>
			alert("Require Login!");
			location.href="RentCarMain.jsp?center=MemberLogin.jsp";
		</script>
	<%
		} 
		
		RentCarDAO rentCarDAO = new RentCarDAO();
		
		List<CarView> reserveList = rentCarDAO.getAllReserve(id);
	%>	
		<div class="result">
        <div class="result_title"><p class="result_title_name">예약 내역</p></div>
        <div class="result_wrapper">
            <div class="result_item">
	<%	
		for(int i = 0; i < reserveList.size(); i++) {
			CarView car = reserveList.get(i);
			
			String insurance = (car.getInsurance() == 1 ? "가입" : "미가입");
			String use_wifi = (car.getUse_wifi() == 1 ? "있음" : "없음");
			String navigation = (car.getNavigation() == 1 ? "포함" : "미포함");
			String baby_sheet = (car.getBaby_sheet() == 1 ? "포함" : "미포함");
	%>
            <div class="result_img"><img src="./img/<%=car.getImg()%>" class="result_image"></div>
            <div class="result_content_box">
                <p class="result_content">차량명 : <%=car.getName()%></p>
                <p class="result_content">대여일 : <%=car.getDuration_day()%>일</p>
                <p class="result_content">수량 : <%=car.getCar_num()%>대</p>
                <p class="result_content">대여기간 : <%=car.getReserve_day()%></p>
                <p class="result_content">차량금액 : <%=car.getPrice()%>원</p>
                <p class="result_content">보험유무 : <%=insurance%></p>
                <p class="result_content">Wi-fi : <%=use_wifi%></p>
                <p class="result_content">Navigation : <%=navigation%></p>
                <p class="result_content">Baby-Sheet : <%=baby_sheet%></p>
                <div class="result_menu">
                    <button class="delete_button" onclick="location.href='CarReserveDelete.jsp?id=<%=id%>&reserve_day=<%=car.getReserve_day()%>'">Delete</button>
                </div>
            </div>
    <%
		}
    %>
            </div>
        </div>
    </div>
</body>
</html>
```

-----
### MemberDAO : getAllReserve 구현 (ID에 따른 모든 예약 내역 조회)
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
	
	/*
	 * 예약 정보를 모든 추출
	 */
	public List<CarView> getAllReserve(String id) {
		List<CarView> reserveList = new ArrayList<CarView>();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM RENTCAR R INNER JOIN CAR_RESERVE C ON (R.NO = C.NO)"
						 + "WHERE C.ID = ? AND SYSDATE < TO_DATE(C.RESERVE_DAY, 'YYYY-MM-DD')";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CarView reserve_car = new CarView();
				
				reserve_car.setName(rs.getString(2));
				reserve_car.setPrice(rs.getInt(4));
				reserve_car.setImg(rs.getString(7));
				reserve_car.setCar_num(rs.getInt(12));
				reserve_car.setDuration_day(rs.getInt(13));
				reserve_car.setReserve_day(rs.getString(14));
				reserve_car.setInsurance(rs.getInt(15));
				reserve_car.setUse_wifi(rs.getInt(16));
				reserve_car.setNavigation(rs.getInt(17));
				reserve_car.setBaby_sheet(rs.getInt(18));
				
				reserveList.add(reserve_car);
			}
			
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return reserveList;
	}
}
```

* BeanClass에서 Query 결과를 Mapping할 때, 해당 Column의 Index Mapping 주의

<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/5f223263-9fc8-4713-80f5-354c9da42c05">
</div>
