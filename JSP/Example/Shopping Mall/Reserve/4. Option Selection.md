-----
### CarOptionSelect JSP Page
-----
1. 차량 종류와 대여 차량의 수를 전달 받은 상태
2. 부가적인 정보를 입력하여 이를 처리하는 페이지로 전달
```jsp
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
```

-----
### CarReserve Class : 예약 페이지에 관한 정보를 담을 Class
-----
```java
package RentCar;


/*
 * 차량에 대한 예약 정보 클래스
 */
public class CarReserve {
	private int reserve_no; // 예약번호
	private String id; // 예약 회원 ID
	private int no; // 차 식별자
	private int car_num; // 차 수량
	private int duration_day; // 대여 기간
	private String reserve_day; // 대여일
	private int insurance; // 보험료
	private int use_wifi; // Wi-fi 이용
	private int navigation; // Navigation 이용
	private int baby_sheet; // BabySheet 이용
	
	public int getReserve_no() {
		return reserve_no;
	}

	public void setReserve_no(int reserve_no) {
		this.reserve_no = reserve_no;
	}

	public int getNo() {
		return no;
	}
	
	public void setNo(int no) {
		this.no = no;
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

<고려사항>
1. 예약 건에 대해서는 CarOptionSelect Form에서 Select 태그를 통해 오직 하나의 값만 받으므로, 여러 값을 받을 필요가 없으므로, Bean Class 이용
2. 예약일을 String으로 받을 것인가? Date형으로 받을 것인가?
3. Date 타입으로 설정하여, useBean 이용 시 다음과 같은 상황이 발생
    - form 태그에서 입력받은 Date가 bean의 Date형으로 받지 못함

			org.apache.jasper.JasperException: org.apache.jasper.JasperException:
			속성 [reserve_day]에 설정된 문자열 [2024-03-19]을(를), 클래스 [java.sql.Date](으)로 변환할 수 없습니다: 					[PropertyEditorManager에 PropertyEditor가 등록되어 있지 않습니다.]

4. 즉, SQL로 추후 쿼리를 전달할 때, 타입이 맞지 않아 오류가 발생할 수 있음. 따라서 String형으로 받은 뒤, 날짜 계산등의 작업은 추후에 필요
   
-----
### CarReserveResult JSP Page : 예약에 관련 정보를 처리하는 Page
-----
1. 회원에 대한 처리가 필요하므로 이에 따른 처리 필요 및 오늘보다 이전 날짜에 대한 잘못된 값 처리
2. 따라서 Top.jsp도 로그인 창 생성
```jsp
<%@ page import ="java.util.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Car Reserve Result</title>
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
	%>
</body>
</html>
```
<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/fe5bf30b-589d-401f-a54c-8013970602b3">
</div>

1. alert 창 이후 CarReserveResult JSP Page에 출력 버퍼에 의해 씌여지므로, response의 sendRedirect가 무시 되는 현상 발생
  : alert 이후 JS의 location.href를 통해 바로 이동시키는 방법 적용
2. JS 코드는 클라이언트 측에서 실행되는 언어이며, sendRedirect는 서버 측에서 실행되는 언어 이므로 서로 다른 환경에서 실행
   - 그러므로 서로 영향을 주지 못하는 상황 발생
   - 따라서, 사용자 측인 alert 이후에 location.href를 통해 사용자 측에서 이동이 되도록 설정

<Top.jsp>
```jsp
...
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
	        	}
	        %>
	        </p>
            </div>
        </div>
...
```

<div align="center">
<img src="https://github.com/sooyounghan/Web/assets/34672301/b1c261a4-6e82-46dc-b8c6-8888769651ec">
<img src="https://github.com/sooyounghan/Web/assets/34672301/1629d794-cfab-4327-a2d1-07c795510a39">
</div>

: 회원이 아닐 경우, 결제를 실패한다는 Script 태그 처리
