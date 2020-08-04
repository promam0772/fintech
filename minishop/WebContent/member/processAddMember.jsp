<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		
		String birth = request.getParameter("birth");
		birth = birth.replaceAll("-","");
		
		String mail1 = request.getParameter("mail1");
		String mail2 = request.getParameterValues("mail2")[0];
		String mail = mail1 + "@" + mail2;
		
		String phone = request.getParameter("phone");
		String postcd = request.getParameter("postcd");
		String addr = request.getParameter("address");
		String addr2 = request.getParameter("address2");
		
		Date newDay = new Date();
		SimpleDateFormat td = new SimpleDateFormat("yyyy-MM-dd. a HH:mm:ss");
		String regday = td.format(newDay); 
		 
	%>
	<sql:setDataSource var="dataSource" 
					   url="jdbc:mysql://localhost:3306/minishopDB" 
					   driver="com.mysql.jdbc.Driver" 
					   user="root" 
					   password="1234" />
					   
	<sql:update dataSource="${dataSource}" >
		INSERT INTO member values(?,?,?,?,?,?,?,?,?,?,?)
		<sql:param value="<%=id %>" />
		<sql:param value="<%=passwd %>" />
		<sql:param value="<%=name %>" />
		<sql:param value="<%=gender %>" />
		<sql:param value="<%=birth %>" />
		<sql:param value="<%=mail %>" />
		<sql:param value="<%=phone %>" />
		<sql:param value="<%=postcd %>" />
		<sql:param value="<%=addr %>" />
		<sql:param value="<%=addr2 %>" />
		<sql:param value="<%=regday %>" />
	</sql:update>
	<c:redirect url="resultMember.jsp?gubun=insert" />
</body>
</html>