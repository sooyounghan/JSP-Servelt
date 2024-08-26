<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>RentCar Main Bottom</title>
	
	<style>
	* {
	    box-sizing:border-box;
	    padding:0;
	    margin:0;
	}
	
	footer {
	    height:100px;
	    display:flex;
	    flex-direction:column;
	    justify-content:center;
	    align-items:center;
	}
	
	.description p {
	    font-size:14px;
	    font-weight:600;
	    font-style: italic;
	}
	
	.line_bottom {
		width:calc(100% - 50px);
		height:5px;
		border-top:2px solid black;	
		margin-bottom:20px;
	}

	</style>
</head>

<body>
    <footer>
    	<div class="line_bottom"></div>
        <div class="description">
            <p>RentCar에 오신걸 환영합니다!</p>
        </div>
    </footer>
</body>
</html>