<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면</title>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu.jsp"/>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
	<div class="container">
		<div class="row" align="center">

		<%
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			String sql = "select * from product";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
			
		%>
			<div class="col-md-4">
				<img src="${pageContext.request.contextPath}/resources/images/<%=rs.getString("p_fileName")%>" style="width:100%">
				<h3><%=rs.getString("p_name")%></h3>
				<h3><%=rs.getString("p_description")%></h3>
				<h3><fmt:formatNumber value='<%=rs.getString("p_unitPrice")%>' pattern="#,###"/>원</h3>
				
				<p><a href="${pageContext.request.contextPath}/product/product.jsp?id=<%=rs.getString("p_id")%>"
				      class="btn btn-danger" role="button">상세보기</a>
				
			</div>
			<%
			    }
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
		    %>
		</div>
		<hr>
	</div>
	
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>