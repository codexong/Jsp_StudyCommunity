<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.example.model.BoardDTO"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	List boardList = (List) request.getAttribute("boardlist");
	int total_record = ((Integer) request.getAttribute("total_record")).intValue();
	int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
	int total_page = ((Integer) request.getAttribute("total_page")).intValue();
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<title>Study Board</title>
<script type="text/javascript">
	function checkForm() {	
		if (${sessionId==null}) {
			alert("로그인 해주세요.");
			return false;
		}

		location.href = "./BoardWriteForm.do?id=<%=sessionId%>"
	}
</script>
</head>
<body>
		<jsp:include page="/login_nav.jsp"/>
		<jsp:include page="/main_nav.jsp"/>
		
			
		<form action="<c:url value="./BoardListAction.do"/>" method="post">
			<div class="row row-cols-1 row-cols-md-3 g-4" style="margin-top: 10px; padding: 10px;">
				<%
					for (int j = 0; j < boardList.size(); j++) {
					BoardDTO notice = (BoardDTO) boardList.get(j);
				%>
			<div class="col">
			<div class="card">
				<ul class="list-group list-group-flush">
					<li class="list-group-item list-group-item-primary"><%=notice.getSubject()%></li>
					<li class="list-group-item">과목 : <%=notice.getCategory()%></li>
					<li class="list-group-item">회원 : <%=notice.getName()%></li>
					<li class="list-group-item"> 작성 날짜 : <%=notice.getRegist_day()%></li>
					<li class="list-group-item">조회수 : <%=notice.getHit()%></li>
				</ul>
				<div class="card-body" align="center">
					<button type="button" class="btn btn-outline-primary"><a id="link" href="./BoardViewAction.do?num=<%=notice.getNum()%>&pageNum=<%=pageNum%>"> 게시물 보기 </a></button>
				</div>
			</div>
			</div>
				<%
					}
				%>	
			</div>			
		</form>

			<form action="<c:url value="./BoardGridtAction.do"/>" method="post">
				<div align="center">
					<c:set var="pageNum" value="<%=pageNum%>" />
					<c:forEach var="i" begin="1" end="<%=total_page%>">
						<a href="<c:url value="./BoardGridtAction.do?pageNum=${i}" /> ">
							<c:choose>
								<c:when test="${pageNum==i}">
									<font color='4C5317'><b> [${i}]</b></font>
								</c:when>
								<c:otherwise>
									<font color='4C5317'> [${i}]</font>
								</c:otherwise>
							</c:choose>
						</a>
					</c:forEach>
				</div>
			</form>
		
		<jsp:include page="/footer.jsp"/>
	
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>	
</body>
</html>
