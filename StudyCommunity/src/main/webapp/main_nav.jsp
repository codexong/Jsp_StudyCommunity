<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<hr style="margin: 0 ; padding: 0">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container-md" style="display: flex; justify-content:center; align-items: center;">
		<div class="navbar-header">
			<a class="navbar-brand" style="margin-right: 55px; font-size: 28px"  href="<c:url value="/BoardGridAction.do?pageNum=1"/>">Study Board</a>
			<a class="navbar-brand" style="margin-right: 55px; font-size: 28px" href="<c:url value="/RecordGridAction.to?pageNum=1"/>">Study Record</a>
			<a class="navbar-brand" style="margin-right: 55px; font-size: 28px" href="<c:url value="/BoardListAction.do?pageNum=1"/>">Study List</a>
		</div>
	</div>
</nav>