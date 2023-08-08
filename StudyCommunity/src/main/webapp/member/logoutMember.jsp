<%@ page contentType="text/html; charset=utf-8"%>

<%
	session.invalidate();
	response.sendRedirect("/Study_Project/home.jsp");
%>