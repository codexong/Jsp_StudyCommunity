<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.example.model.RecordDTO"%>

<%
	RecordDTO record = (RecordDTO) request.getAttribute("record");
	int num = ((Integer) request.getAttribute("num")).intValue();
	int nowpage = ((Integer) request.getAttribute("page")).intValue();
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<title>Record</title>
</head>
<body>

		<jsp:include page="/login_nav.jsp"/>
		<jsp:include page="/main_nav.jsp"/>

	<div class="container" style="margin-top: 10px">
		<form name="newUpdate"
			action="RecordUpdateAction.to?num=<%=record.getNum()%>&pageNum=<%=nowpage%>"
			class="form-horizontal" method="post">
			
			<div class="form-group row">
				<label class="col-sm-2 control-label">성명</label>
				<div class="col-sm-3">
					<input name="name" class="form-control"	value="<%=record.getName()%>">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2 control-label">과목</label>
				<div class="col-sm-3">
					<input name="category" class="form-control"	value="<%=record.getCategory()%>">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2 control-label"> 공부 시간 </label>
				<div class="col-sm-3">
					<input name="category" class="form-control"	value="<%=record.getStudy_time()%>">
				</div>
			</div>
			
				<div class="form-group row" style="margin-top: 10px">
				<div class="col-sm-offset-2 col-sm-10 ">
					<c:set var="userId" value="<%=record.getId()%>" />
					<c:if test="${sessionId==userId}">
						<p>
							<a	href="./RecordDeleteAction.to?num=<%=record.getNum()%>&pageNum=<%=nowpage%>" class="btn btn-danger"> 삭제</a> 
							<input type="submit" class="btn btn-success" value="수정 ">
					</c:if>
					<a href="./RecordGridAction.to?pageNum=<%=nowpage%>"class="btn btn-primary"> 목록</a>
				</div>
			</div>
			
		</form>
		
		<jsp:include page="/footer.jsp"/>
	</div>

</body>
</html>


