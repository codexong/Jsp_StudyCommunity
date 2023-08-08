<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<meta charset="UTF-8">
<title>Welcome</title>
</head>
<body>
	
	<%@ include file="login_nav.jsp" %>
	
	<%@ include file="main_nav.jsp" %>

		<div class="card mb-3">
			<img src="<%=request.getContextPath()%>/resources/img/home.jpg"  class="card-img-top" style=" height:400px; opacity: 0.7; margin: auto;">
			<div class="card-img-overlay">
			<div class="card-body" style="text-align:left;">
			      <% response.setIntHeader("Refresh", 5);
			        Date day = new java.util.Date();
			        int hour = day.getHours();
			        int minute = day.getMinutes();
			        int second = day.getSeconds();
			
			        // 24시간 기준으로 오늘의 마감시각 계산
			        int remainingHours = 23 - hour;
			        int remainingMinutes = 59 - minute;
			        int remainingSeconds = 60 - second;
			
			        // 출력 문자열 생성
			        String remainingTime = remainingHours + "시간 " + remainingMinutes + "분 " + remainingSeconds + "초";
			      %>
			      <h2 class="card-text"><%out.println("현재 시각은 " + hour + "시 " + minute + "분 " + second + "초 입니다.");%></h2>
			      <h2 class="card-text"><%out.println("오늘 하루가 " + remainingTime + " 남았습니다.");%></h2>
			</div>
			</div>
		</div>
		
		<%@ include file="footer.jsp" %>

</body>
</html>

