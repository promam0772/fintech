<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<script type="text/javascript">
	function checkOrder(){
		<%	
			String sessionId = (String) session.getAttribute("sessionId");
		
			ArrayList list = (ArrayList<Product>)session.getAttribute("cartlist");
			if(list == null || list.size() == 0){
		%>
			alert("선택하신 상품내역이 없습니다.");
			location.href = './cart.jsp';
			return false;
		<%
			}else if(sessionId == null || sessionId.equals("")) {
		%>
			 alert("로그인하세요.");
	         location.href = '/member/loginMember.jsp';
	         return false;
     	<%
        	}
		%>
			return true;
	}
</script>
<body>
	<%
		String cartId = session.getId();
		
		
		
	%>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="right"><a href="./deleteCart.jsp?cartId=<%=cartId %>" class="btn btn-danger">삭제하기</a></td>
					
					<td align="right"><a href="./shippingInfo.jsp?cartId=<%=cartId %>" onclick="return checkOrder()" class="btn btn-success">주문하기</a></td>
				</tr>
			</table>
		</div>
		<div style="padding-top:50px">
			<table class="table table-hover">
				<tr>
					<th class="text-left">상품</th>
					<th class="text-right">가격</th>
					<th class="text-right">수량</th>
					<th class="text-right">소계</th>
					<th class="text-right">비고</th>
				</tr>
				<%
					int sum = 0;
					ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
					if(cartList == null)
						cartList = new ArrayList<Product>();
					
					for(int i=0;i<cartList.size();i++){
						Product product = cartList.get(i);
						int total = product.getUnitPrice() * product.getQuantity();
						sum = sum + total;
				%>
				<tr>
					<td><%=product.getProductId() %> - <%=product.getPname() %></td>
					<td class="text-right"><fmt:formatNumber value='<%=product.getUnitPrice() %>' pattern="#,###"/></td>
					<td class="text-right"><%=product.getQuantity() %></td>
					<td class="text-right"><fmt:formatNumber value='<%=total %>' pattern="#,###"/></td>
					<td><a href="./removeCart.jsp?id=<%=product.getProductId() %>" class="badge badge-danger">삭제</a></td>
				</tr>
				<%
					}
				%>
				<tr>
					<th></th>
					<th></th>
					<th class="text-right">총액</th>
					<th class="text-right"><fmt:formatNumber value='<%=sum %>' pattern="#,###"/></th>
					<th></th>
				</tr>
			</table>
			<a href="./products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>