<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="mvc.model.product.ProductDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 상품 삭제</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		if(id == null || id.trim().equals("")){
			response.sendRedirect("../main.jsp");
			return;
		}
		
		/* ProductRepository dao = ProductRepository.getInstance(); */
		
		/* Product product = dao.getProductById(id);
		if(product == null){
			response.sendRedirect("exceptionNoProductId.jsp");
		} */
		
		ArrayList<ProductDTO> cartList = (ArrayList<ProductDTO>) session.getAttribute("cartlist");
		ProductDTO goodsQnt = new ProductDTO();
		for(int i = 0; i<cartList.size();i++){
			goodsQnt = cartList.get(i);
			if(goodsQnt.getProductId().equals(id)){
				cartList.remove(goodsQnt);
			}
		}
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>