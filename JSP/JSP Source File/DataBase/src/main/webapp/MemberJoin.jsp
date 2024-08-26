<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Join</title>
	<style>
	
	* {
	    box-sizing:border-box;
	    padding:0;
	    margin:0;
	}
	
	.wrapper {
	    padding:30px;
	    display:flex;
	    flex-direction:row;
	    justify-content:center;
	    align-items:center; 
	}
	.container {
	    background-color:#dddddd;
	    width:600px;
	    height:900px;
	    padding:30px;
	    border-radius:10%;
	    border:3px solid black;
	
	    display:flex;
	    flex-direction:column;
	    justify-content:center;
	    align-items:center;
	}
	
	.title p {
	    font-size:20px;
	    font-weight:600;
	}
	
	.content {
	    padding:15px;
	}
	
	.content .id, .password, .email, .tel, .address, .submit_button, .hobby, .job, .age, .info {
	    width:100%;
	    padding:10px 0;
	    display:flex;
	    flex-direction:row;
	    justify-content:space-around;
	    align-items:center;
	}
	
	.hobby_box, .job_box, .age_box, .info_box {
	    font-size:12px;
	    font-weight:600;
	}
	
	.age_check {
	    margin-left:20px;
	}
	.job_check {
	    width:200px;
	    height:25px;
	    font-size:12px;
	    font-weight:600;
	}
	
	.info_text {
	    width:200px;
	    height:100px;
	    resize:none;
	    font-size:12px;
	    font-weight:600;
	    padding:10px;
	}
	.name {
	    font-size:14px;
	    font-weight:600;
	}
	
	.input {
	    margin:10px;
	}
	
	.input_content {
	    width:200px;
	    height:25px;
	    font-size:10px;
	}
	
	.submit {
	    width:100px;
	    height:30px;
	    border:2px solid black;
	}
		
	</style>
</head>

<body>

	<h2>Member Join</h2>
	<form action="MemberJoinProc.jsp" method = "post">
	<table>
		<tr>
			<td>ID</td>
			<td><input type="text" name="id" size="40" placeholder="ID" required = "required"></td>
		</tr>
		
		<tr>
			<td>Password</td>
			<td> <input type="password" name="pass1" size="40" placeholder="Passwrod : Only Number and English" required = "required"></td>
		</tr>
		
		<tr>
			<td>Password</td>
			<td><input type="password" name="pass1" size="40" placeholder="Passwrod : Only Number and English" required = "required"></td>
		</tr>
		
		<tr>
			<td>E-Mail</td>
			<td><input type="email" name="email" size="40" placeholder="Ex) abc@naver.com"></td>
		</tr>
		
		<tr>
			<td>H.P.</td>
			<td><input type="tel" name="tel" size="40" placeholder="Ex) 010-1234-5678"></td>
		</tr>
		
		<tr>
			<td>Hobby</td>
			<td>
				<input type="checkbox" name="hobby" value="camping">Camping 
				<input type="checkbox" name="hobby" value="hiking">Hiking 
				<input type="checkbox" name="hobby" value="book">Book 
				<input type="checkbox" name="hobby" value="etc">etc  	
			</td>
		</tr>
		
	   <tr>
			<td>Job</td>
			<td>
				<select name="job">
				<option value="teacher">Teacher</option>
				<option value="doctor">Doctor</option>
				<option value="lawyer">Lawyer</option>
				<option value="etc">etc</option>
				</select>				
			</td>
		</tr>
		
		<tr>
			<td>Age</td>
			<td>
				<input type="radio" name="age" value="10">10's
				<input type="radio" name="age" value="20">20's
				<input type="radio" name="age" value="30">30's
				<input type="radio" name="age" value="40">40's			
			</td>
		</tr>
		
		<tr>
			<td>Info.</td>
			<td><textarea rows="2" cols="40" name="info" placeholder = "Write Your Information."></textarea></td>
		</tr>
			
		<tr class = "menu">
			<td colspan="2">
				<input type="submit" value="Join">	
			</td>
		</tr>	
	</table>
	</form>	
</body>
</html>