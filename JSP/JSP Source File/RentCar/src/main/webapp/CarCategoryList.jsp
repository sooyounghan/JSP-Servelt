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