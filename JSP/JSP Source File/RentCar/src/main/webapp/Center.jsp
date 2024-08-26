<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>RentCar Main Center</title>
	<style>
	* {
	    box-sizing:border-box;
	    padding:0;
	    margin:0;
	}
	
	section {
		height:calc(100% - 280px);
	}
	
	.imageBox {
		display:flex;
		flex-direction:row;
		justify-content:center;
		align-items:center;
	}
	.mainImg {
		display:block;
		width:60%;
		object-fit:cover;
	}
	</style>
</head>

<body>
    <section>
        <div class="imageBox">
            <img class="mainImg" src="./img/Main.jpg">
        </div>
    </section>
</body>
</html>