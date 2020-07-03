<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
</head>
<body>
	<%
    	String id = (String) session.getAttribute("sessionId");
		
		String passwd = request.getParameter("passwd");
	  	String name = request.getParameter("name");
	  	String gender = request.getParameter("gender");
	  	
		String birthday = request.getParameter("birth");
		birthday = birthday.replaceAll("-","");
		String mail1 = request.getParameter("mail1");
		String mail2 = request.getParameterValues("mail2")[0];
		String mail = mail1 + "@" + mail2;
	
      	String phone = request.getParameter("phone");
      	String postcd = request.getParameter("postcd");
      	String address = request.getParameter("address");
      	String address2 = request.getParameter("address2");
      	
        //가입일자 처리
    	Date newDay = new Date();
		SimpleDateFormat td = new SimpleDateFormat("yyyy-MM-dd. a HH:mm:ss");
		String redate = td.format(newDay);;
	%>
	<sql:setDataSource 
      var="dataSource"
      url="jdbc:mysql://localhost:3306/webmarketdb"
      driver="com.mysql.jdbc.Driver"
      user="root"
      password="1234" />      
   <sql:update dataSource="${dataSource}" var="resultSet">
      update member
      	set passwd =?, name =?, gender =?, birth =?, mail =?, phone =?, address =?, address2 =?, postcd =?,  redate =?
      	where id =?
      
      <sql:param value="<%=passwd%>" />     
      <sql:param value="<%=name%>" />
      <sql:param value="<%=gender%>" />
      <sql:param value="<%=birthday%>" />
      <sql:param value="<%=mail%>" />
      <sql:param value="<%=phone%>" />
      <sql:param value="<%=address%>" />
      <sql:param value="<%=address2%>" />
      <sql:param value="<%=postcd%>" />
      <sql:param value="<%=redate %>" />
      
      <sql:param value="<%=id%>" />
   </sql:update>
	<c:redirect url="resultMember.jsp?gubun=update" />
</body>
</html>