<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<title>회원 정보</title>
</head>
<body>
		
		<jsp:include page="/login_nav.jsp" />
		<jsp:include page="/main_nav.jsp"/>
		
		<%
			String msg = request.getParameter("msg");

			if (msg != null) {
				if (msg.equals("0"))
					out.println(" <h2 class='alert alert-primary' style='text-align:center'>회원정보가 수정되었습니다.</h2>");
				else if (msg.equals("1"))
					out.println(" <h2 class='alert alert-primary'>회원가입을 축하드립니다.</h2>");
				else if (msg.equals("2")) {
					String loginId = (String) session.getAttribute("sessionId");
					out.println(" <h3 class='alert alert-primary' style='text-align:center'>" + loginId + "님 환영합니다</h3>");
				}				
			} else {
				out.println("<h2 class='alert alert-danger'>회원정보가 삭제되었습니다.</h2>");
			}
		%>
		
		<jsp:include page="/footer.jsp"/>
</body>
</html>

