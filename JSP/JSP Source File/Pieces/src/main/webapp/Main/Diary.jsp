<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>조각집</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/Diary.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	</head>
	
	<body>
	<%
		String user_id = (String)session.getAttribute("id");

	%>
	    <div class="container">
	        <div class="wrapper">
	            <div class="wrapper__head">
	                <div class="wrapper__head__title">오늘의 조각집</div>
	                <p class="wrapper__head__sub-title">
	                	<span id="point"> "<%=user_id%>님의 오늘 하루는 어떠셨나요?" </span>
	                </p>
	                    
	                    <textarea id = "todo" name = "todo" class = "todo"></textarea>
						<input type = "button" id = "submit" name = "submit" value = "기록 남기기" onclick = "location.href = alert('기록이 남겨졌어요. 언제든지 적은 글이 보고싶다면 보러 오세요.'); history.go(0)">
	            		<input type = "button" id = "go_main" name = "go_main" onclick = "location.href = './Main.jsp'" value = "잠시 돌아가기">
	            </div>
	            <div class="wrapper__body">
	                <span id="point_2"> "<%=user_id%>님의 버리고 싶은 감정이 있다면 버려주세요." </span>
	                    
	                <textarea id = "emotion" name = "emotion" class = "emotion"></textarea>
					<input type = "button" id = "submit_emotion" name = "submit_emotion" onclick = "location.href = './Diary.jsp'" value = "나의 바다에 버리기">
					
					<input type = "button" id = "logout" name = "logout" onclick = "location.href = './LoginOut.jsp'" value = "조각배 타기">
	            </div>
	        </div>
	    </div>
</body>
</html>