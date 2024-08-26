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
                <div class="car_price"><p class="text_car">차량 가격 : <%=car.getPrice()%>원</p></div>
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