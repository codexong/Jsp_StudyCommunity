<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.example.model.RecordDTO"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	List recordList = (List) request.getAttribute("recordlist");
	int total_record = ((Integer) request.getAttribute("total_record")).intValue();
	int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
	int total_page = ((Integer) request.getAttribute("total_page")).intValue();
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/930e9d87c4.js"></script>
<title>Study Record</title>
<script type="text/javascript">
	function checkForm() {	
		if (${sessionId==null}) {
			alert("로그인 해주세요.");
			return false;
		}

		location.href = "./RecordWriteForm.to?id=<%=sessionId%>"
	}
</script>
</head>
<body>
		<jsp:include page="/login_nav.jsp"/>
		<jsp:include page="/main_nav.jsp"/>
		
			
		<form action="<c:url value="./RecordGridAction.to"/>" method="post">
			<div class="row row-cols-1 row-cols-md-3 g-4" style="margin-top: 10px; padding: 10px;">
				<%
					for (int j = 0; j < recordList.size(); j++) {
					RecordDTO record = (RecordDTO) recordList.get(j);
				%>
			<div class="col">
			<div class="card">
				<ul class="list-group list-group-flush">
					<li class="list-group-item list-group-item-primary"><%=record.getName()%></li>
					<li class="list-group-item">과목 : <%=record.getCategory()%></li>
					<li class="list-group-item"> 공부 시간 : <%=record.getStudy_time()%></li>
					<li class="list-group-item"> 작성 날짜 : <%=record.getRegist_day()%></li>
				</ul>
				<div class="card-body" align="center">
					<button type="button" class="btn btn-outline-primary"><a id="link" href="./RecordViewAction.to?num=<%=record.getNum()%>&pageNum=<%=pageNum%>"> 게시물 보기 </a></button>
				</div>
			</div>
			</div>
				<%
					}
				%>	
			</div>			
		</form>

			<form action="<c:url value="./RecordGridtAction.to"/>" method="post">
				<div align="center">
					<c:set var="pageNum" value="<%=pageNum%>" />
					<c:forEach var="i" begin="1" end="<%=total_page%>">
						<a href="<c:url value="./RecordGridtAction.to?pageNum=${i}" /> ">
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
			
			<div align="right" style="padding-right: 50px; margin-top: 10px">
				<table>
					<tr>
						<td width="100%" align="right">
							<a href="#" onclick="checkForm(); return false;" class="btn btn-primary">인증하기</a>
						</td>
					</tr>
				</table>
			</div>
			
		<jsp:include page="/footer.jsp"/>
	
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>	
</body>
</html>

