<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String changepassword = request.getParameter("changepassword");
	String changename = request.getParameter("changename");
	String id = request.getParameter("id");
%>

<sql:setDataSource var="dataSource"
	url="jdbc:oracle:thin:@localhost:1521:xe"
	driver="oracle.jdbc.driver.OracleDriver" user="study" password="study"/>

<sql:update dataSource="${dataSource}" var="resultSet">
   	UPDATE MEMBER SET PASSWORD=?, NAME=? WHERE ID=?
	<sql:param value="<%=changepassword%>" />
	<sql:param value="<%=changename%>" />
	<sql:param value="<%=id%>" />
</sql:update>

<c:if test="${resultSet>=1}">
	<c:redirect url="resultMember.jsp?msg=0" />
</c:if>

