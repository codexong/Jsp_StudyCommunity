<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<script type="text/javascript">
	function checkForm() {
		if (!document.newMember.id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}

		if (!document.newMember.password.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}

		if (document.newMember.password.value != document.newMember.password_confirm.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
	}
</script>
<title>회원 가입</title>
</head>
<body>
		
	<jsp:include page="/login_nav.jsp"/>
	<jsp:include page="/main_nav.jsp"/>

	<div class="container" style="width: 400px; margin-top: 10px">
		<form name="newMember" class="form-horizontal"  action="processAddMember.jsp" method="post" onsubmit="return checkForm()">
			
			<div class="input-group mb-3">
				<label class="input-group-text">아이디</label>
				<input name="id" type="text" class="form-control" placeholder="id" >
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text">비밀번호</label>
				<input name="password" type="text" class="form-control" placeholder="password" >
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text">비밀번호확인</label>
				<input name="password_confirm" type="text" class="form-control" placeholder="password confirm" >
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text">성명</label>
				<input name="name" type="text" class="form-control" placeholder="name" >
			</div>
	
			<div class="form-group  row" style="margin-top: 10px">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary " value="회원가입">
					<input type="reset" class="btn btn-primary " value="취소 " onclick="reset()" >
				</div>
			</div>
			
		</form>
	</div>
	
	<jsp:include page="/footer.jsp"/>

</body>
</html>