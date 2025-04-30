-----
### CarCategory Jsp Page : 선택한 메뉴에 따라 차 종류를 보여주는 페이지
-----
```jsp
<%@page import="RentCar.RentCarDAO, RentCar.CarList, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Car Category List</title>
	<style>
	* {
	    box-sizing:border-box;
	    padding:0;
	    margin:0;
	}
	
	.wrapper {
	    width:100%;
	    height:100%;
	    padding:20px;
		display:flex;
	    flex-direction:row;
	    flex-wrap:wrap;
	    justify-content:space-around;
	    align-items:space-between;
	}
	
	.item {
	    width:calc(20% - 5px);
	    height:100%;
	    margin:20px 10px;
	    border:2px solid #dddddd
	}
	
	.item img {
		width:100%;
		height:100px;
		object-fit:cover;
	    border-bottom:2px solid #dddddd
	}
	
	.item p {
		text-align:center;
		font-size:14px;
		font-weight:600;
	}
	
	.car_title {
		text-align:center;
		font-size:20px;
		font-weight:600;
	}
	</style>
</head>

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
				<p> Price : <%=car.getPrice()%>원 </p>
			</div>
<%
	}
%>

    </div>
</body>
</html>
```

<div align = "center">
<img src ="https://github.com/sooyounghan/Web/assets/34672301/8bc0bb6c-e78d-4dbd-b9c1-9fdc8c1691b9">
</div>

-----
### CarAllList Jsp Page : 모든 차 종류를 보여주는 페이지
-----
```jsp
<%@page import="RentCar.RentCarDAO, RentCar.CarList, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Car All List</title>
	<style>
	
	* {
	    box-sizing:border-box;
	    padding:0;
	    margin:0;
	}
	
	.wrapper {
	    width:100%;
	    height:100%;
	    padding:20px;
		display:flex;
	    flex-direction:row;
	    flex-wrap:wrap;
	    justify-content:space-around;
	    align-items:space-between;
	}
	
	.item {
	    width:calc(20% - 5px);
	    height:100%;
	    margin:20px 10px;
	    border:2px solid #dddddd
	}
	
	.item img {
		width:100%;
		height:100px;
		object-fit:cover;
	    border-bottom:2px solid #dddddd
	}
	
	.item p {
		text-align:center;
		font-size:14px;
		font-weight:600;
	}
	
	.car_title {
		text-align:center;
		font-size:20px;
		font-weight:600;
	}
	</style>
</head>
<body>

<%
	RentCarDAO rentCarDAO = new RentCarDAO();
	
	List<CarList> carList = rentCarDAO.getAllListCar();
%>

	<p class ="car_title">전체 자동차 목록</p>
    <div class="wrapper">
<%
			for(int i = 0; i < carList.size(); i++) {
				CarList car = carList.get(i);
%>
        	<div class="item">
				<a href="RentCarMain.jsp?center=CarReserveInfo.jsp?no=<%=car.getNo()%>"><img src="./img/<%=car.getImg()%>"></a>
				<p> Car : <%=car.getName()%> </p>
				<p> Price : <%=car.getPrice()%>원 </p>
			</div>
<%
	}
%>

    </div>
</body>
</html>
```

<div align = "center">
<img src ="https://github.com/sooyounghan/Web/assets/34672301/1ddc60ab-3b5a-41a3-8923-729faa4905b8">
</div>

-----
### RentCarDAO : Category 값에 따라 차 종류를 보여주는 getCategoryCar 및 전체 차 종류를 보여주는 getAllListCar 구현
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
}
```
