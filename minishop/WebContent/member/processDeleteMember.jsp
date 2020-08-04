<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 삭제</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
	%>
	
	<sql:setDataSource 	var="dataSource" 
						driver="com.mysql.jdbc.Driver"
						url="jdbc:mysql://localhost:3306/minishopdb"
						user="root"
						password="1234"/>
	
	<sql:update var="resultSet" dataSource="${dataSource}">
		DELETE * FROM member WHERE id=? and passwd=?
		<sql:param value="<%=id %>" />
		<sql:param value="<%=passwd %>" />
	</sql:update>
	<c:redirect url="./resultMember.jsp?gubun=deleteMember" />
</body>
</html>