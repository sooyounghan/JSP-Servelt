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