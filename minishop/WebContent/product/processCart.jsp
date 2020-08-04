<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="mvc.model.product.ProductDTO"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String m_id = (String) session.getAttribute("sessionId");
		String cartId = session.getId();
		
		String p_id = request.getParameter("pid");
		String p_name = request.getParameter("pname");
		String totalQty = request.getParameter("sumtotal1");
		String totalPrice = request.getParameter("sumtotal");
		
	%>

	<sql:setDataSource var="dataSource" 
					   url="jdbc:mysql://localhost:3306/minishopDB" 
					   driver="com.mysql.jdbc.Driver" 
					   user="root" 
					   password="1234" />
					   
	<sql:update dataSource="${dataSource}" >
		INSERT INTO cart(cartId, m_id, totalQty, totalPrice) values(?,?,?,?)
		<sql:param value="<%=cartId %>" />
		<sql:param value="<%=m_id %>" />
		<sql:param value="<%=totalQty %>" />
		<sql:param value="<%=totalPrice %>" />
	</sql:update>
	<c:redirect url="shippingInfo.jsp?cartId=<%=cartId %>" />
</body>
</html>