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
	
	.login {
		width:70px;
		height:30px;
		border-radius:5px;
		border:2px solid black;
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
            <div class="top_user"><p><%=id%>님 어서오세요!
            <%
	        	if(id.equals("Guest")) {
	        %>
	        	<button class="login" onclick="location.href='RentCarMain.jsp?center=MemberLogin.jsp'">Login</button>
	        <%
	        	} else {
	        %>
	           	<button class="login" onclick="location.href='MemberLogOut.jsp'">Logout</button>
	        <%
	        	}
	        %>
	        </p>
            </div>
        </div>
        <div class="top_menu">
            <div class="menu1 menu"><a href = "RentCarMain.jsp?center=CarReserveMain.jsp">Reservation</a></div>
            <div class="menu2 menu"><a href = "RentCarMain.jsp?center=CarReserveView.jsp">Reserved Check</a></div>
            <div class="menu3 menu"><a href = "#">Board</a></div>
            <div class="menu4 menu"><a href = "#">Event</a></div>
            <div class="menu5 menu"><a href = "#">Q&A</a></div>
        </div>
    </header>
</body>

</html>