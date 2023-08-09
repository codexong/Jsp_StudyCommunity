<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<script type="text/javascript">
	function checkForm() {
		if (!document.loginMember.id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}

		if (!document.loginMember.password.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}

		if (document.loginMember.password.value != document.newMember.password_confirm.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
	}
</script>
<title>Login</title>
</head>
<body>
	
		<jsp:include page="/login_nav.jsp"/>
		<jsp:include page="/main_nav.jsp"/>
		
		<div class="container" style="width: 400px; margin-top: 10px" align="left">	
			<form action="processLoginMember.jsp" method="post" name="loginMember" onsubmit="return checkForm()">
				
				<div class="input-group mb-3">
					<label class="input-group-text">User ID</label> 
					<input type="text" class="form-control" name="id" placeholder="ID">
				</div>	
				
				<div class="input-group mb-3">
					<label class="input-group-text">Password</label>
					<input type="password" class="form-control" name="password" placeholder="PW">
				</div>
				
				
				<div class="form-group  row" style="margin-top: 10px">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary " value="로그인">
					<input type="reset" class="btn btn-primary " value="취소 " onclick="reset()" >
				</div>
			</div>
			</form>
		</div>	
		
		<jsp:include page="/footer.jsp"/>

</body>
</html>