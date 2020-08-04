<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 정보</title>
</head>
<script type="text/javascript">
	function addToCart(){
		if(confirm("상품을 장바구니에 추가하시겠습니까?")){
			document.addForm.submit();
		}else{
			document.addForm.reset();
		}
	}
</script>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<%
		String id = request.getParameter("id");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from product where p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		while (rs.next()){
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="${pageContext.request.contextPath}/resources/images/<%=rs.getString("p_fileName") %>" style="width: 100%">
			</div>
			<div class="col-md-6">
				<h3><%=rs.getString("p_name") %></h3>
				<p><%=rs.getString("p_description") %>
				<p><b>상품 코드 : </b><span class="badge badge-danger">
					<%=rs.getString("p_id") %></span>
				<p> <b>제조사</b> : <%=rs.getString("p_manufacturer") %>
				<p><b>분류</b>:<%=rs.getString("p_category")%>
				<p> <b>재고 수</b> : <%=rs.getLong("p_unitsInStock") %>
				<h4><fmt:formatNumber value='<%=rs.getInt("p_unitPrice") %>' pattern="#,###" />원</h4>
				<p> <form action="./addCart.jsp?id=<%=rs.getString("p_id") %>" name="addForm" method="post" >
						<a href="#" class="btn btn-info" onclick="addToCart()"> 상품 주문 &raquo;</a>
						<a href="./cart.jsp" class="btn btn-warning">장바구니 &raquo;</a>
						<a href="../main.jsp" class="btn btn-success">상품목록 &raquo;</a>
					</form>
			</div>
		</div>
		<hr>
	</div>
	<%
		}
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	%>
	
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>