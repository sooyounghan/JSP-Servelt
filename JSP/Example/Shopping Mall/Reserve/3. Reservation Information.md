-----
### CarReserveInfo JSP Page
-----
```jsp
<%@page import="RentCar.RentCarDAO, RentCar.CarList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Car Reserve Info</title>
	<style>
	* {
	    box-sizing:border-box;
	    padding:0;
	    margin:0;
	}
	
	.content_main {
	    display:flex;
	    flex-direction:column;
	    justify-content:center;
	    align-items:center;
	}
	
	.select_form {
		display:flex;
	    flex-direction:row;
	    justify-content:center;
	    align-items:center;
	    margin-top:20px;
	}
	
	.content_main .content_section_box {
	    width:70%;
	    display:flex;
	    flex-direction:row;
	    justify-content:center;
	    align-items:center;
	    margin-top:20px;
	}
	
	.content_text {
	    width:30%;
	}
	
	.text_car {
		width:60%;
	    font-size:13px;
	    font-weight:600;
	    padding:15px;
	    margin:20px;
	}
	
	.previous, .choice {
	    border-radius:5px;
	    border:2px solid black;
	    padding:5px;
	    margin:5px;
	}
	
	.menu_bar {
	    display:flex;
	    flex-direction:row;
	    justify-content:center;
	    align-items:center;
	}
	
	.car_info_box {
		font-size:18px;
		font-weight:600;
	    margin:10px;
	    text-align:center;
	}
	
	.content_image {
		width:50%;
		height:50%;
	}
	
	.car_img {
		object-fit:fill;
		width:100%;
		height:100%;
	}
	</style>
</head>
<body>

<%
	int no = Integer.parseInt(request.getParameter("no"));

	RentCarDAO rentCarDAO = new RentCarDAO();
	
	CarList car = rentCarDAO.getOneCarList(no);

	int category = car.getCategory();
	
	String car_category = "";
	if(category == 1) car_category = "소형";
	else if(category == 2) car_category = "중형";
	else if(category == 3) car_category = "대형";
	
%>

<body>
    <div class="content_main">
        <div class="car_info_box"><p class="car_info">차량 정보 보기</p></div>
        
    	<form action="RentCarMain.jsp?center=CarOptionSelect.jsp" method = "post" class="select_form">
        <div class="content_section_box">
            <div class="content_image"><img class="car_img" src="./img/<%=car.getImg()%>"></div>
            <div class="content_text">
                <div class="car_name"><p class="text_car">차량 이름 : <%=car.getName()%></p></div>
                <div class="car_num"><p class="text_car">차량 수량 :
                	<select name="car_num">
                		<option value = "1">1</option>
                		<option value = "2">2</option>
                		<option value = "3">3</option>
                	</select>
                	</p>
                </div>
                <div class="car_usepeople"><p class="text_car">차량 분류 : <%=car_category%></p></div>
                <div class="car_price"><p class="text_car">차량 가격 : <%=car.getPrice()%>만원</p></div>
                <div class="car_company"><p class="text_car">제조 회사 : <%=car.getCompany()%></p></div>
                <div class="menu_bar">
                	<input type="hidden" name="no" value="<%=car.getNo()%>">
                	<input type="hidden" name="img" value="<%=car.getImg()%>">
                    <input type="submit" value="Choice" class="choice">
                    <input type="button" value="Previous" class="choice" onclick="location.href='RentCarMain.jsp?center=CarReserveMain.jsp'">
                </div>
            </div>
            </div>
         </form>
        <div class="car_info_box">
        	<p class="car_info">차량 정보</p>
        	<p class="car_info"><%=car.getInfo()%></p>
        </div>
    </div>
</body>
</html>

</body>
</html>
```

-----
### CarReserveInfo가 CarRentMain Center에 출력을 위해 일부 코드 변경
-----
1. CarReserveMain
```jsp
...
<body>
<!-- 상위 상품 3개만 가져오도록 설정 -->
<%
	RentCarDAO rentcarDAO = new RentCarDAO();
	
	List<CarList> carList = rentcarDAO.getSelectCar();
%>
    <div class="wrapper">
<%
			for(int i = 0; i < carList.size(); i++) {
				CarList car = carList.get(i);
%>
        	<div class="item">
				<a href="RentCarMain.jsp?center=CarReserveInfo.jsp?no=<%=car.getNo()%>"><img src="./img/<%=car.getImg()%>"></a>
				<p> 차량명 : <%=car.getName()%> </p>
			</div>
<%
	}
%>
    </div>
    
    <div class="choice">
    	<div class="line"></div>
    	<p> 차량 검색 하기 </p>
    	<form action="RentCarMain.jsp?center=CarCategoryList.jsp" method="post">
  			<div class="category_car">
		    	<p>차량 종류 : </p>
		    	<div class="category_car_select">
		    		<select name="category">
		    		<option value="1">소형</option>
		    		<option value="2">중형</option>
		    		<option value="3">대형</option>
		    		</select>
		    	</div>
		    	
		    	<div class="categroy_car_submit">
		    	<input type="submit" value="Search"/>
		    	<input type="button" onclick="location.href='RentCarMain.jsp?center=CarAllList.jsp'" value="All Search">
		    	</div>
    		</div>
    	</form>
    </div>
</body>
...
```

2. CarCategoryList JSP Page
```jsp
<body>
<%
	int category = Integer.parseInt(request.getParameter("category"));

	String car_category = "";
	if(category == 1) car_category = "소형";
	else if(category == 2) car_category = "중형";
	else if(category == 3) car_category = "대형";
	
	RentCarDAO rentCarDAO = new RentCarDAO();
	
	List<CarList> carList = rentCarDAO.getCategoryCar(category);
%>
<p class ="car_title"><%=car_category%> 자동차</p>
    <div class="wrapper">
<%
			for(int i = 0; i < carList.size(); i++) {
				CarList car = carList.get(i);
%>
        	<div class="item">
				<a href="RentCarMain.jsp?center=CarReserveInfo.jsp?no=<%=car.getNo()%>"><img src="./img/<%=car.getImg()%>"></a>
				<p> Car : <%=car.getName()%> </p>
				<p> Price : <%=car.getPrice()%>만원 </p>
			</div>
<%
	}
%>

    </div>
</body>
```

<div align = "center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/c8e3b529-698c-44c8-a9d0-cdf971384fe9">
</div>

-----
### RentCarDAO : getOneCarList 구현 (예약을 위한 하나의 차량에 대한 정보 추출)
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
}
```
