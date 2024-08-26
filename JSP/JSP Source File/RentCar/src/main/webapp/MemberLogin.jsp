<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Member Login Page</title>
	<style>
	* {
    box-sizing:border-box;
    padding:0;
    margin:0;
	}
	
	.login_div {
	    display:flex;
	    flex-direction:rpw;
	    justify-content:center;
	    align-items:center;
	}
	
	.login_form {
	    width:300px;
	    height:300px;
	    border:3px solid gray;
	    border-radius:10%;
		text-align:center;
	    display:flex;
	    flex-direction:column;
	    justify-content:space-around;
	    align-items:center;
	}
	
	.login_menu {
	    width:20%;
	    font-size:20px;
	    font-weight:600;
	}
	
	.login_select {
	    width:80%;
	    height:100px;
	
	    display:flex;
	    flex-direction:row;
	    flex-wrap:wrap;
	    justify-content:center;
	    align-content:space-around;
	}
	
	.login_id, .login_pwd {
	    width:100%;
	
	    display:flex;
	    flex-direction:row;
	    justify-content:flex-start;
	    align-content:center;
	}
	
	.login_id_menu, .login_pwd_menu {
	    font-size:13px;
	    font-weight:600;
	    padding:0 15px;
	    width:50px;
	}
	
	.login_id_input, .login_pwd_input {
	    padding-left:30px;
	}
	
	.login_button {
	    width:100%;
	    height:50px;
	
	    display:flex;
	    flex-direction:row;
	    flex-wrap:wrap;
	    justify-content:center;
	    align-content:center;
	}
	
	.id, .pwd {
	    width:calc(100%);
	}
	
	.login_button_input {
	    border:2px solid black;
	    width:50px;
	    height:30px;
	}
	</style>
</head>

<body>
	<form action="MemberLoginProc.jsp" method="post">
	<div class="login_div">
    <div class="login_form">
        <div class="login_menu">Login</div>
        <div class="login_select">
            <div class="login_id">
                <div class="login_id_menu">ID</div>
                <div class="login_id_input">
                    <input type="text" class="id" name="id" placeholder="ID 입력">
                </div>
            </div>
            <div class="login_pwd">
                <div class="login_pwd_menu">PassWord</div>
                <div class="login_pwd_input">
                    <input type="password" class="pwd" name="pwd" placeholder="PassWord 입력"></div>
            </div>
        </div>
        <div class="login_button">
            <input type="submit" class="login_button_input" value="Login">
        </div>
    </div>
    </div>
    </form>
</body>
</html>