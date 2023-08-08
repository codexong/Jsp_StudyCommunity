<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String name = (String) request.getAttribute("name");
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<title>Record</title>
</head>
<script type="text/javascript">
	function checkForm() {
		if (!document.newWrite.name.value) {
			alert("성명을 입력하세요.");
			return false;
		}
		if (!document.newWrite.subject.value) {
			alert("제목을 입력하세요.");
			return false;
		}
		if (!document.newWrite.content.value) {
			alert("내용을 입력하세요.");
			return false;
		}		
	}
</script>
<body>
		<jsp:include page="/login_nav.jsp"/>
		<jsp:include page="/main_nav.jsp"/>

		<form name="newWrite" action="./RecordWriteAction.to" style="margin-top: 20px; margin-left: 20px"
			class="form-horizontal" method="post" onsubmit="return checkForm()">
			
			<input name="id" type="hidden" class="form-control" value="${sessionId}">
			
			<div class="form-group row">
				<label class="col-sm-2 control-label" >성명 </label>
				<div class="col-sm-5">
					<input name="name" type="text" class="form-control" value="<%=name %>" placeholder="name">
				</div>
			</div>			
			
			<div class="form-group row">
				<label class="col-sm-2 control-label" >과목</label>
				<div class="col-sm-5">
					<input name="category" type="text" class="form-control"  placeholder="category">
				</div>
			</div>
			
			<div class="form-group row">
			  <label class="col-sm-2 control-label"> 공부 시간</label>
			  <div class="col-sm-2">
			    <input name="study_time_hour" type="number" class="form-control" min="0" max="23" placeholder="시">
			  </div>
			  <div class="col-sm-2">
			    <input name="study_time_minute" type="number" class="form-control" min="0" max="59" placeholder="분">
			  </div>
			</div>

			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
				 <input type="submit" class="btn btn-primary " value="등록 ">				
				 <input type="reset" class="btn btn-primary " value="취소 ">
				</div>
			</div>
		</form>

		<jsp:include page="/footer.jsp"/>
</body>
</html>



