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