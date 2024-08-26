<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title> Form Example </title>
		<style>
		/* CSS 주석문 */
		/* Selector (선택자) : { css속성:값;css속성:값;..css속성:값; } */
		/* 선택자에는 tag, .클래스명, #id명 가능 */
		/* img { width:300px;height:200px; } img 태그를 선택해 너비를 100으로 일괄 적용 */
		.c1 { width:200px;height:100px; } /* 선택자 c1에 해당하는 것에 일괄 적용 */
		</style>
	</head>

	<body>
		<h4> form </h4>
		<pre>
		<a href = "https://www.w3schools.com/html/html_forms.asp" target = "_blank"> form 참고 </a>
		</pre>
		<hr>
		
		<form name = "form_data" action = "<%=request.getContextPath()%>/html/ok.jsp" method = "get">
			<ul>
				<li> 이름 : <input type = "text" name = "user_name" id = "name" required = "required" value = "ID"></li>
				<li> 비밀번호 : <input type = "password" name = "user_pwd" id = "pwd" required = "required" value = "Password"></li>
				<li> 자기소개 : 
					 <textarea name = "my_self", id = "user_self" rows = "5" cols ="50">Text기본값</textarea>
				</li>
				<li> 성별 : 
							<input type = "radio" name = "male" id = "user_sex_male" checked = "checked" value = "남"><label for = "male"> 남 </label>
						    <input type = "radio" name = "female" id = "user_sex_female" value = "여"><label for = "female"> 여 </label>
				</li>
				<li> 좋아하는 동물 :
							<input type = "checkbox" name = "animal_cat" id = "cat" value = "cat" checked = "checked"><label for = "cat"> 고양이 </label>
						    <input type = "checkbox" name = "animal_dog" id = "dog" value = "dog"><label for = "dog"> 강아지 </label>
						    <input type = "checkbox" name = "animal_fish" id = "fish" value = "fish"><label for = "fish"> 물고기 </label>
				
				<li> 자기소개 : <!-- textarea에 스타일 적용 -->
					 <textarea name = "my_self_1" id = "user_self_1" style = "height:80px; width:240px">Text기본값</textarea>
				</li>
				
				<li> 언어 (단일 선택):
				<select name = "language", id = "select_language">
					<option value = "korean">한국어</option>
					<option value = "english">영어</option>
					<option value = "china">중국어</option>
					<option value = "japan">일본어</option>
				</select>	
				</li>	
				
				<li> 언어 (다중 선택):
				<select name = "language", id = "select_language", size = "7" multiple = "multiple">
					<option value = "korean">한국어</option>
					<option value = "english">영어</option>
					<option value = "china">중국어</option>
					<option value = "japan">일본어</option>
				</select>	
				</li>
				
				  <input list="browsers">
  					<datalist id="browsers">
    				<option value="Edge">
    				<option value="Firefox">
    				<option value="Chrome">
    				<option value="Opera">
    				<option value="Safari">
  					</datalist>
			</ul>
				<input type = "submit" name = "user_submit" id = "submit" value = "로그인">	
				<input type = "reset" name = "user_reset" id = "reset" value = "취소">	
				<br>
				<input type = "button" value = "click" onclick = "alert('안녕');">
				<button type = "button">button 역할</button>
				<button type = "reset">reset 역할</button>
				<button type = "submit">submit 역할</button>
				<fieldset>
					<legend> FieldSet </legend>
					<ul>
						<li> color : <input type = "color" name = "color" id = "color"></li>
						<li> date : <input type = "date" name = "date1" id = "date1"></li>
						<li> datetime-local : <input type = "datetime-local" name = "date2" id = "date2"></li>
						<li> month : <input type = "month" name = "month" id = "month"></li>
						<li> time : <input type = "time" name = "time" id = "time"></li>
						<li> week : <input type = "week" name = "week" id = "week"></li>

					</ul>
				</fieldset>
				
				<fieldset> <!-- 유효성 검사 필요 -->
					<legend> FieldSet </legend>
					<ul>
						<li> E-mail : <input type = "email" name = "email" id = "email"></li>
						<li> tel : <input type = "tel" name = "tel" id = "tel"></li>
						<li> URL : <input type = "url" name = "url" id = "url"></li>
					</ul>
				</fieldset>
				
				<fieldset>
					<legend> FieldSet의 여러 속성 값 </legend>
					<ul>
						 <!-- File name=파일명(String으로 전달), file 업로드 기능 구현 시 form method는 post 방식, enctype = "multipart/form-date" 속성 값 설정 -->
						<li> File : <input type = "file" name = "file" id = "file"></li>
						<li> Order Number : <input type = "number" name = "order_number" id = "order_number" value = "1" max = "10", min = "2", step = "2"></li>
						<li> Age : 0<input type = "range" name = "age" id = "age" min = "0" max = "60" step = "10" value = "10">60</li>
						<li> Result : <output name = "x" for = "order_number age">11</output></li>
					</ul>
				</fieldset>
		</form>
		
		<form oninput="result.value=parseInt(order_number.value)+parseInt(age.value)">
  			Order Number : <input type = "number" name = "order_number" id = "order_number" value = "1" max = "10", min = "2", step = "2">
  			Age : <input type = "range" name = "age" id = "age" min = "0" max = "60" step = "10" value = "10">60
 		 	<output name="result" for="order_number age">11</output>
		</form>
				
		<form oninput="result.value=parseInt(a.value)+parseInt(b.value)">
  			<input type="range" id="b" name="b" value="50" /> +
  			<input type="number" id="a" name="a" value="10" /> =
 		 	<output name="result" for="a b">60</output>
		</form>
		
		<form action="" method="get">
			<input type ="hidden", name = "bno", id = "bno", value = "100">
    		검색 <input type="search" name="q">
    		<input type="submit">
		</form>
		
		<form method="get">
   		 아이디 : <input type="text" name="user_id"><br>
    	 비밀번호 : <input type="password" name="user_pw"><br>
    	 <%!int game_token = 200; %>
    	<input type="hidden" id="gameToken" name="game_token" value="<%=game_token%>">
    	<input type="submit">
    	
    	<img src="http://localhost:8081/webPro/imgs/submit-button.gif"
    		 alt="submit" title="submit image" class = "c1">
    	<input type = "image" src="<%=request.getContextPath()%>/imgs/submit-button.gif" class = "c1">
</form>
	</body>
</html>