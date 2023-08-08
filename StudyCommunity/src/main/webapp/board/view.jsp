<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.example.model.BoardDTO"%>

<%
	BoardDTO notice = (BoardDTO) request.getAttribute("board");
	int num = ((Integer) request.getAttribute("num")).intValue();
	int nowpage = ((Integer) request.getAttribute("page")).intValue();
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<title>Board</title>
</head>
<body>

		<jsp:include page="/login_nav.jsp"/>
		<jsp:include page="/main_nav.jsp"/>

	<div class="container" style="margin-top: 10px">
		<form name="newUpdate"
			action="BoardUpdateAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"
			class="form-horizontal" method="post">
			
			<div class="form-group row">
				<label class="col-sm-2 control-label">성명</label>
				<div class="col-sm-3">
					<input name="name" class="form-control"	value="<%=notice.getName()%>">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2 control-label">과목</label>
				<div class="col-sm-3">
					<input name="category" class="form-control"	value="<%=notice.getCategory()%>">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2 control-label" >제목</label>
				<div class="col-sm-5">
					<input name="subject" class="form-control"	value="<%=notice.getSubject()%>" >
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2 control-label" >내용</label>
				<div class="col-sm-8" style="word-break: break-all;">
					<textarea name="content" class="form-control" cols="50" rows="5"><%=notice.getContent()%></textarea>
				</div>
			</div>
			
			<div class="form-group row" style="margin-top: 10px">
				<div class="col-sm-offset-2 col-sm-10 ">
					<c:set var="userId" value="<%=notice.getId()%>" />
					<c:if test="${sessionId==userId}">
						<p>
							<a	href="./BoardDeleteAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"	class="btn btn-danger"> 삭제</a> 
							<input type="submit" class="btn btn-success" value="수정 ">
					</c:if>
					<a href="./BoardListAction.do?pageNum=<%=nowpage%>"	class="btn btn-primary"> 목록</a>
				</div>
			</div>
		</form>
		<jsp:include page="/footer.jsp"/>
	</div>

</body>
</html>


