<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title> 조각집 </title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/Describe.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	</head>
	<body>
	<div class="background">
		<div class = "content">
		<div class = "first_section">
			<p class = "first"># 혐오의 시대</p>
			<p class = "first_content">
			우리는 혐오에 시대에 살고 있습니다.<br>
			타인에 대한 혐오, 사랑에 대한 혐오, 그리고 나 자신에 대한 혐오.<br>
			우리는 많은 혐오의 세상에 살고 있습니다. 당신의 혐오는 안녕하신가요?<br>
			</p>		
		</div>
		
		<div class = "second_section">
			<p class = "second"># 자기 혐오의 바다</p>
			<p class = "second_content">
			사람의 마음은 감기와도 같습니다.<br>
			가끔은 행복하기도, 슬프기도 하죠.<br>
			마음의 아픔은 누구나 겪기 쉽고, 오롯이 감당하기가 어렵습니다.<br>
			</p>
		</div>
		
		<div class = "third_section">
			<p class = "third"># Love Wins ALL</p>
			<p class = "third_content">
			그럼에도 불구하고, 우리는 서로 사랑해야합니다.<br>
			혐오의 세상에서도, 사람과 세상이 미친듯이 싫어져도,<br>
			우리는 결국 사랑해야합니다.<br>
			이 곳, 조각집은 여러분이 가진 우울과 혐오의 파도들을 잠시나마<br>
			유영시킬 수 있도록 도와드립니다.
			</p>
		</div>
		
		<input type = "button" id = "back" name = "back" value = "돌아가기" onclick = "location.href='LoginPage.jsp'">
		</div>
	</div>
	</body>
</html>