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