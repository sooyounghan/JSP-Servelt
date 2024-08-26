<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h4> JSTL (Java Standard Tag Library) </h4>
		<h5> Core 태그 : 변수 설정, 조건문, 반복문에 해당하는 기능 제공</h5>
		<c:out value = "${'<tag> , &'}"/>
		<br>
		<c:set var = "salary" scope = "session" value = "${2000*2}"/>
        <c:out value = "${salary}"/>
        <br>
        <hr>
         <c:choose>
         
         <c:when test = "${salary <= 0}">
            Salary is very low to survive.
         </c:when>
         
         <c:when test = "${salary > 1000}">
            Salary is very good.
         </c:when>
         
         <c:otherwise>
            No comment sir...
         </c:otherwise>
  	    </c:choose>
        
        <c:if test = "${salary > 2000}">
        <p>My salary is:  <c:out value = "${salary}"/><p>
      	</c:if>
      	
      	Item 
      	<c:forEach var = "i" begin = "1" end = "5">
     	 	<c:out value = "${i }"/>
		</c:forEach>
		<hr>
		<c:forEach var = "i" begin = "1" end = "5">
			 Item <c:forEach var = "j" begin = "1" end = "5">
     			 <c:out value = "[${i}, ${j}]"/>
     	 	</c:forEach> <br>
		</c:forEach>
		<hr>
		Item : 		
       <c:forTokens items = "Zara,nuha,roshy" delims = "," var = "name">
         <c:out value = "${name}"/>
      </c:forTokens><br>
	</body>
</html>