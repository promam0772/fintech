<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="mvc.model.product.ProductDTO"%>
<%@ include file="../dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		
		if(id == null || id.trim().equals("")){
			response.sendRedirect("../main.jsp");
			return;
		}
		
		ArrayList<ProductDTO> list = (ArrayList<ProductDTO>)session.getAttribute("cartlist");
		
		if(list == null){
			list = new ArrayList<ProductDTO>();
			session.setAttribute("cartlist", list);
		}
		
		//데이터베이스 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int cnt = 0;
		ProductDTO goodsQnt = new ProductDTO();
		for(int i=0;i<list.size();i++){
			goodsQnt = list.get(i);
			//동일한 상품을 선택하면 수량 증가시킴. 
			if(goodsQnt.getProductId().equals(id)){
				cnt++;
				int orderQuantity = goodsQnt.getQuantity() + 1;
				goodsQnt.setQuantity(orderQuantity);
			}
		}
		//장바구니에 처음으로 담는것.
		if(cnt == 0){
			try{
				ProductDTO goods = new ProductDTO();
				String sql = "select * from product where p_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				while (rs.next()){
					goods.setPname(rs.getString("p_name"));
					goods.setProductId(rs.getString("p_id"));
					goods.setUnitPrice(rs.getInt("p_unitPrice"));
					goods.setQuantity(1);
					
					list.add(goods);
				}
			}catch(SQLException ex){
				out.println("addCart.jsp 오류");
				out.println("SQLException: " + ex.getMessage());
			}finally{
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			}
		}
		response.sendRedirect("product.jsp?id=" + id);
	%>
</body>
</html>