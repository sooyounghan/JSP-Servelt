<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>RentCar Main Page</title>
	<style>
		header {
			width:100%;
			height:170px;
		}
		
		footer {
			width:100%;
			height:100px;
		}
		
		section {
			width:100%;
			height:calc(100% - 270px);
		}
	</style>
</head>

<body>
	<%
		String center = request.getParameter("center");
		System.out.println(center);
		// 초기에는 center 값이 없을 것이므로 기존에 제작한 Center.jsp 호출
		if(center == null) {
			center = "Center.jsp";
		}
	%>
	
	<header>
		<jsp:include page="Top.jsp"/>
	</header>
	
	<section>
		<jsp:include page="<%=center%>"/>
	</section>
	
	<footer>
		<jsp:include page="Bottom.jsp"/>
	</footer>
</body>
</html>