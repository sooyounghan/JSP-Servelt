-----
### 차량 예약
-----
1. 상위 최신 상품 3개를 인위적으로 화면에 출력할 예정
2. 차량 종류에 대한 선택(소형, 중형, 대형)하여 검색하게 되면, 해당 차량에 대해서만 출력
   - RentCar의 Category에 설정한 부분에 맞게 출력 설정  
3. 전체 검색을 하게 되면, 전체 차량에 대한 정보 출력

-----
### Top 부분 예약하기 부분 링크 변경
-----
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>RentCar Main Top</title>
	<style>
	
	* {
	    box-sizing:border-box;
	    margin:0;
	    padding:0;
	}
	
	header {
	    height:170px;
	
	    display:flex;
	    flex-direction:column;
	    justify-content:flex-start;
	    align-items:space-around;
	}
	
	.top_logo_user {
	    height:50%;
	    display:flex;
	    flex-direction:row;
	    justify-content:space-between;
	    align-items:center;
	}
	
	.top_logo {
	    width:20%;
	    height:100%;
	    position:relative;
	}
	
	.top_user  {
		padding:20px;
	    width:30%;
	    text-align:right;
	}
	
	.top_menu {
	    padding:10px;
	    height:40%;
	    
	    display:flex;
	    flex-direction:row;
	    justify-content:space-between;
	    align-items:center;
	}
	
	.menu1, .menu2, .menu3, .menu4, .menu5 {
	    width:calc(20% - 15px);
	    height:100%;
	
	    display:flex;
	    flex-direction:row;
	    justify-content:center;
	    align-items:center;
	}
	
	.menu a {
	    display:inline-block;
	    font-size:15px;
	    font-weight:600;
	    text-decoration:none;
	    color:black;
	}
	
	.top_logo img {
		position:absolute;
		over-fit:cover;
	}
	</style>
</head>

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
            <div class="top_user"><p><%=id%>님 어서오세요!</p></div>
        </div>
        <div class="top_menu">
            <div class="menu1 menu"><a href = "RentCarMain.jsp?center=CarReserveMain.jsp">Reservation</a></div>
            <div class="menu2 menu"><a href = "#">Reserved Check</a></div>
            <div class="menu3 menu"><a href = "#">Board</a></div>
            <div class="menu4 menu"><a href = "#">Event</a></div>
            <div class="menu5 menu"><a href = "#">Q&A</a></div>
        </div>
    </header>
</body>

</html>
```

-----
### RentCarDAO - 차량 3개 정보 가져오기 구현
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
}
```

-----
### CarReserveMain 
-----
```jsp
<%@page import="RentCar.RentCarDAO, RentCar.CarList, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Car Reservation Main</title>
	<style>
	* {
	    box-sizing:border-box;
	    padding:0;
	    margin:0;
	}
	
	.wrapper {
	    width:100%;
	    height:300px;
	    padding:20px;
		display:flex;
	    flex-direction:row;
	    justify-content:space-around;
	    align-items:center;
	}
	
	.item {
	    width:calc(30% - 10px);
	    height:100%;
	}
	
	.item img {
		width:100%;
		height:100%;
		object-fit:fill;
	}
	
	.item p {
		text-align:center;
	}

	.choice {
		margin:20px;
	}
	
	.choice p {
		margin:20px;
		text-align:center;
	}
	
	.choice .category_car {
		display:flex;
		flex-direction:row;
		justify-content:center;
		align-items:center;
	}
	
	.category_car_select, .category_car_sumbit {
		margin:0 10px;
	}
	
	select {
		width:100px;
		height:30px;
		border:2px solid black;
		background-color:white;
	}
	
	input {
		padding:7px;
		width:100px;
		border:2px solid black;
	}
	
	.line {
		width:100%;
		height:5px;
		border-top:2px solid black;	
	}
	</style>
</head>

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
</html>
```

<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/36b257b2-4817-4586-82e1-bd5587d0b939">
</div>
