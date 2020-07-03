<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//session 값들을 삭제
		session.invalidate();
		response.sendRedirect("addProduct.jsp");
	%>
</body>
</html>