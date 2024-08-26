<%@page import="RentCar.RentCarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Car Option Select</title>
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
	    width:80%;
	    display:flex;
	    flex-direction:row;
	    justify-content:center;
	    align-items:center;
	    margin-top:20px;
	}
	
	.content_text {
	    width:40%;
	}
	
	.text_car {
		width:100%;
	    font-size:13px;
	    font-weight:600;
	    padding:15px;
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
		width:40%;
		height:40%;
	}
	
	.car_img {
		object-fit:fill;
		width:100%;
		height:100%;
	}
	
	.duration_day, .reserve_day, .insurance, .use_wifi, .navigation, .baby_sheet {
		border:1px solid black;
		border-radius:5px;
		font-size:10px;
		font-weight:600;
		width:100px;
		height:20px;
		margin-left:5px;
	}
	
	.car_reserve {
		width:50%;
	}
	</style>
</head>

<body>

<%
	// DB에 접속할 필요 없이 이미지만 가져오면 되므로 Request로 받아오기
	
	int no = Integer.parseInt(request.getParameter("no"));
	int car_num = Integer.parseInt(request.getParameter("car_num"));
	String img = request.getParameter("img");	
%>

    <div class="content_main">
        <div class="car_info_box"><p class="car_info">옵션 선택</p></div>
        
    	<form action="RentCarMain.jsp?center=CarReserveResult.jsp" method = "post"  class="select_form">
        <div class="content_section_box">
            <div class="content_image"><img class="car_img" src="./img/<%=img%>"></div>
            <div class="content_text">
                <div class="car_reserve"><p class="text_car">대여 기간 :
                	<select name="duration_day" class="duration_day">
                		<option value = "1">1일</option>
                		<option value = "2">2일</option>
                		<option value = "3">3일</option>
                		<option value = "4">4일</option>
                		<option value = "5">5일</option>
                		<option value = "6">6일</option>
                		<option value = "7">7일</option>
                	</select>
                	</p>
                </div>
                
                <div class="car_reserve"><p class="text_car">대여일 :
                	<input type="date" name="reserve_day" class="reserve_day">
                	</p>
                </div>
                
                <div class="car_reserve"><p class="text_car">보험 적용 :
                	<select name="insurance" class="insurance">
                		<option value = "1">적용 (1일 1만원)</option>
                		<option value = "2">미적용</option>
                	</select>
                	</p>
                </div>
                
                <div class="car_reserve"><p class="text_car">Wifi :
                	<select name="use_wifi" class="use_wifi">
                		<option value = "1">적용 (1일 1만원)</option>
                		<option value = "2">미적용</option>
                	</select>
                	</p>
                </div>
                
                  <div class="car_reserve"><p class="text_car">Navigation :
                	<select name="navigation" class="navigation">
                		<option value = "1">적용 (무료)</option>
                		<option value = "2">미적용</option>
                	</select>
                	</p>
                </div>
                
                <div class="car_reserve"><p class="text_car">Baby Sheet :
                	<select name="baby_sheet" class="baby_sheet">
                		<option value = "1">적용 (1일 1만원)</option>
                		<option value = "2">미적용</option>
                	</select>
                	</p>
                </div>
                
                <div class="menu_bar">
                	<input type="hidden" name="no" value="<%=no%>">
                	<input type="hidden" name="car_num" value="<%=car_num%>">
                    <input type="submit" value="Reservation" class="choice">
                    <input type="button" value="Previous" class="choice" onclick="location.href='RentCarMain.jsp?center=CarReserveMain.jsp'">
                </div>
            </div>
            </div>
         </form>
    </div>

</body>
</html>