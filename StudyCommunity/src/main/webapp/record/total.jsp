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
	
    <div>
        <h1><%=record.getId()%> 님의 총 공부 시간</h1>
        <c:set var="hours" value="${total_study_time / 60}" />
        <c:set var="minutes" value="${total_study_time % 60}" />
        <p>총 공부 시간은 <c:out value="${hours}"/>시간 <c:out value="${minutes}"/>분입니다.</p>
    </div>
    
    <jsp:include page="/footer.jsp"/>
</body>
</html>