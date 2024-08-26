<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Member List</title>
	<style>
		* {
		    box-sizing:border-box;
		    padding:0;
		    margin:0;
		}
		
		.wrapper {
			margin:10px;
		    width:95%;
		    border:3px solid black;
		    display:flex;
		    flex-direction:column;
		    justify-content:center;
		    align-items:space-between;
		}
		
		.menu, .items {
			margin:10px;
		    display:flex;
		    flex-direction:row;
		    justify-content:flex-start;
		    align-items:center;
		}
		
		.name {
		    padding:10px;
		    margin:2px;
		    border:1px solid black;
		}
		
		.menu p {
		    font-size:12px;
		    font-weight:600;
		    text-align:center;
		}
		
		.items p {
		    font-size:10px;
		    font-weight:600;
		    text-align:center;
		}
		
		
		.id {
		    width:10%;
		}
		
		.email {
		    width:15%;
		}
		
		.tel {
		    width:15%;
		}
		
		.address {
		    width:15%;
		}
		
		.hobby {
		    width:15%;
		}
		
		.job {
		    width:10%;
		}
		
		.age {
		    width:10%;
		}
		
		.info {
		    width:20%;
		}
		
		.previous {
			padding:5px;
			margin:5px;
			width:70px;
			height:30px;
			border:2px solid black;
			border-radius:10%;
		}
		
		.button_box {
			display:flex;
			flex-direction:row;
			justify-content:center;
			align-items:center;
		}
	</style>
</head>

<body>
    <div class="wrapper">
        <div class="menu">
            <div class="name id"><p>ID</p></div>
            <div class="name email"><p>Email</p></div>
            <div class="name tel"><p>H.P.</p></div>
            <div class="name hobby"><p>Hobby</p></div>
            <div class="name job"><p>Job</p></div>
            <div class="name age"><p>Age</p></div>
            <div class="name info"><p>Info</p></div>
        </div>
	
		<c:forEach var="member" items="${memberList}">
        <div class="items">
            <div class="name id"><p>${member.id}</p></div>
            <div class="name email"><p>${member.email}</p></div>
            <div class="name tel"><p>${member.tel}</p></div>
            <div class="name hobby"><p>${member.hobby}</p></div>
            <div class="name job"><p>${member.job}</p></div>
            <div class="name age"><p>${member.age}</p></div>
            <div class="name info"><p>${member.info}</p></div>
        </div>
        </c:forEach>
    	
    	<div class="button_box"> 	   
		    <button onclick="location.href='MemberJoin.jsp'" class="previous">Previous</button>
		</div>
    </div>
</body>

</html>