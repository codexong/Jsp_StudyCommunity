<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page import="com.example.model.BoardDTO"%>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	
%>
<sql:setDataSource var="dataSource"
	url="jdbc:oracle:thin:@localhost:1521:xe"
	driver="oracle.jdbc.driver.OracleDriver" user="study" password="study"/>

<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM MEMBER WHERE ID=?
   <sql:param value="<%=sessionId%>" />
</sql:query>


	
<title>회원 수정</title>
</head>
<body onload="init()">
		
	<jsp:include page="/login_nav.jsp"/>
	<jsp:include page="/main_nav.jsp"/>
	
	<c:forEach var="row" items="${resultSet.rows}">
	
	<div class="container" style="width: 400px; margin-top: 10px" align="left">
		<form name="newMember" class="form-horizontal" action="processUpdateMember.jsp" 
			  method="post" onsubmit="return checkForm()">
			
			<div class="input-group mb-3">
				<label class="input-group-text"> 회원 ID </label>
				<input name="id" type="text" class="form-control" placeholder="id"
						value="<c:out value='${row.id }'/>" />
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text"> 회원 Password  </label>
					<input name="password" type="text" class="form-control"
						placeholder="password" value="<c:out value='${row.password }'/>" >
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text"> 변경 Password </label>
					<input name="changepassword" type="text" class="form-control" placeholder="password">
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text"> Password 확인  </label>
					<input name="password_confirm" type="text" class="form-control"
						placeholder="password_confirm" >
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text">현재 성명</label>
					<input name="name" type="text" class="form-control"
						placeholder="name" value="<c:out value='${row.name }'/>" >
			</div>
			
			<div class="input-group mb-3">
				<label class="input-group-text">바꿀 성명</label>
					<input name="changename" type="text" class="form-control"
						placeholder="changename">
			</div>

			<div class="form-group  row" style="margin-top: 10px">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary" value="회원수정 "> 
					<a href="deleteMember.jsp" class="btn btn-primary">회원탈퇴</a>
				</div>
			</div>
		</form>	
	</div>
	</c:forEach>
	
	<jsp:include page="/footer.jsp"/>

</body>
</html>
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
		if (document.newMember.changepassword.value != document.newMember.password_confirm.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
	}
</script>