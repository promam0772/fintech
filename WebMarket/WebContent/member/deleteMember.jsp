<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	String id = (String)session.getAttribute("sessionId");
%>

<sql:setDataSource
	var="dataSource"
	driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/webmarketdb"
	user="root"
	password="1234"/>

<sql:update
	dataSource="${dataSource}"
	var="resultSet">
	
	delete from member
	 where id = ?
	 
	<sql:param value="<%=id%>"/> 

</sql:update>

<%
	session.invalidate();
%>

<c:redirect url="resultMember.jsp?gubun=delete"/>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 삭제</title>
</head>
<body>

</body>
</html>