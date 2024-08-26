<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Member Join</title>
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
	
	.content .id, .password, .email, .tel, .submit_button, .hobby, .job, .age, .info {
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

   <div class="wrapper">
        <div class="container">
            <div class="title"><p>회원 가입</p></div>
            <form action="MemberJoinProc.do" method="post">
            <div class="content">
                <div class="id">
                    <div class="name"><p>ID : </p></div>
                    <div class="input"><input type="text" name="id" class="input_content" placeholder="  ID" required = "required"></div>
                </div>

                <div class="password">
                    <div class="name"><p>PassWord : </p></div>
                    <div class="input"><input type="password" name="pass1" class="input_content" placeholder="  Passwrod : Only Number and English" required = "required"></div>
                </div>

                <div class="password">
                    <div class="name"><p>PassWord : </p></div>
                    <div class="input"><input type="password" name="pass2"  class="input_content" placeholder="  Passwrod : Only Number and English" required = "required"></div>
                </div>

                <div class="email">
                    <div class="name"><p>Email : </p></div>
                    <div class="input"><input type="email" name="email" class="input_content" placeholder=" Ex) abc@naver.com"></div>
                </div>

                <div class="tel">
                    <div class="name"><p>H.P. : </p></div>
                    <div class="input"><input type="tel" name="tel" id="tel" class="input_content"/></div>
                </div>

                <div class="hobby">
                    <div class="name"><p>Hobby : </p></div>
                    <div class="hobby_box input">		
                        <input type="checkbox" name="hobby" value="camping"> Camping 
                        <input type="checkbox" name="hobby" value="hiking"> Hiking 
                        <input type="checkbox" name="hobby" value="book"> Book 
                        <input type="checkbox" name="hobby" value="etc" checked="checked"> etc  	
                    </div>
                </div>

                <div class="job">
                    <div class="name"><p>Job : </p></div>
                    <div class="job_box input">		
                        <select name="job" class="job_check">
                            <option value="teacher"> Teacher</option>
                            <option value="doctor"> Doctor</option>
                            <option value="lawyer"> Lawyer</option>
                            <option value="etc"> etc</option>
                        </select>	
                    </div>
                </div>

                <div class="age">
                    <div class="name"><p>Age : </p></div>
                    <div class="age_box input">		
                        <input type="radio" name="age" value="10" class="age_check" checked="checked">10's
                        <input type="radio" name="age" value="20" class="age_check">20's
                        <input type="radio" name="age" value="30" class="age_check">30's
                        <input type="radio" name="age" value="40" class="age_check">40's	
                    </div>
                </div>

                <div class="info">
                    <div class="name"><p>Info : </p></div>
                    <div class="info_box input">		
                        <textarea name="info" placeholder = " Write Your Information." class="info_text" ></textarea>	
                    </div>
                </div>

                <div class="submit_button">
                    <input type="submit" value="Join" class="submit">
                </div>
            </div>
            </form>
        </div>
    </div>
    
</body>
</html>