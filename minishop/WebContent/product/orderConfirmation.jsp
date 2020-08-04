<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="mvc.model.product.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문정보</title>
</head>
<body>
	<%
		String cartId = session.getId();
	
		String shipping_cartId = "";
		String shipping_name = "";
		String shipping_shippingDate = "";
		String shipping_country = "";
		String shipping_zipCode = "";
		String shipping_addressName = "";
		String shipping_addressName2 = "";
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null){
			for(int i=0;i < cookies.length;i++){
				Cookie thisCookie = cookies[i];
				String n = thisCookie.getName();
				if(n.equals("Shipping_cartId"))
					shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if(n.equals("Shipping_name"))
					shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if(n.equals("Shipping_shippingDate"))
					shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if(n.equals("Shipping_country"))
					shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if(n.equals("Shipping_zipCode"))
					shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if(n.equals("Shipping_addressName"))
					shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if(n.equals("Shipping_addressName2"))
					shipping_addressName2 = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			}
		}
	%>
	<jsp:include page="${pageContext.request.contextPath}/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문정보</h1>
		</div>
	</div>
	<div class="container col-8 alert alert-info">
		<div class="text-center">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-bbetween">
			<div class="col-4" align="left">
				<strong>배송주소</strong><br> 성명: <% out.println(shipping_name); %> <br>
					우편번호: <% out.println(shipping_zipCode); %> <br>
					주소: <% out.println(shipping_addressName); %><% out.println(shipping_addressName2); %>(<% out.println(shipping_country); %>) <br>
			</div>
			<div class="col-4" align="right">
				<p> <em>배송일: <% out.println(shipping_shippingDate); %></em>
			</div>
		</div>
		<div>
			<table class="table table-hover">
				<tr>
					<th class="">상품</th>
					<th class="">수량</th>
					<th class="">가격</th>
					<th class="">소계</th>
				</tr>
				<%
					int sum = 0;
					ArrayList<ProductDTO> cartList = (ArrayList<ProductDTO>) session.getAttribute("cartlist");
					if(cartList == null)
						cartList = new ArrayList<ProductDTO>();
					for(int i = 0;i < cartList.size();i++){
						ProductDTO product = cartList.get(i);
						int total = product.getUnitPrice() * product.getQuantity();
						sum = sum + total;
				%>
				<tr>
					<td class="text-center"><em><%=product.getPname() %></em></td>
					<td class="text-center"><%=product.getQuantity() %></td>
					<td class="text-center"><fmt:formatNumber value='<%=product.getUnitPrice() %>' pattern="#,###"/></td>
					<td class="text-center"><fmt:formatNumber value='<%=total %>' pattern="#,###"/></td>
				</tr>
				<%
					}
				%>
				<tr>
					<td></td>
					<td></td>
					<td class="text-right"><strong>총액:</strong></td>
					<td class="text-center text-danger"><strong><fmt:formatNumber value='<%=sum %>' pattern="#,###"/></strong></td>
				</tr>
			</table>
			<a href="./shippingInfo.jsp?cartId=<%=shipping_cartId %>" class="btn btn-success" role="button">&laquo;이전</a>
			<a href="./thankCustomer.jsp" class="btn btn-success" role="button">주문 완료&raquo;</a>
			<a href="./checkOutCancelled.jsp" class="btn btn-success" role="button">취소</a>
		</div>
	</div>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>