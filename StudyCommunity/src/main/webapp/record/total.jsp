<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.model.RecordDTO"%>
<%
	RecordDTO record = (RecordDTO) request.getAttribute("record");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<title>총 공부 시간</title>
</head>
<body>

	<jsp:include page="/login_nav.jsp"/>
	<jsp:include page="/main_nav.jsp"/>
	
    <div align="center" style="margin-top: 100px; margin-bottom: 100px">
        
      	<c:set var="total" value="${total_study_time}" />
        <c:set var="hours" value="${total_study_time / 60}" />
        <c:set var="minutes" value="${total_study_time % 60}" />
        <h1><%=record.getId()%> 님의 총 공부 시간은 </h1>
   		<h1>${hours.intValue()}시간 ${minutes.intValue()}분입니다.</h1>
   		
   		
    </div>
       		<h3 align="center" style="background-color: #F8F9FA">오늘도 수고하셨습니다.</h3>
    
    
    <jsp:include page="/footer.jsp"/>
</body>
</html>