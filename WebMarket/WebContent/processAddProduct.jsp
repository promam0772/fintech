<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<!-- 2020.06.10. 이미지 업로드 처리-->
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
</head>
<body>
	<%
		/* request.setCharacterEncoding("UTF-8"); */
		// 2020.06.10. 이미지 업로드 추가
		String filename = "";
		String realFolder = "E:\\jspStudy\\WebMarket\\WebContent\\resources\\images";
		int maxSize = 5* 1024 * 1024;
		String encType = "utf-8";
		
		MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		String productId = multi.getParameter("productId");
		String name = multi.getParameter("name");
		String unitPrice = multi.getParameter("unitPrice");
		String description = multi.getParameter("description");
		String manufacturer = multi.getParameter("manufacturer");
		String category = multi.getParameter("category");
		String unitsInStock = multi.getParameter("unitsInStock");
		String condition = multi.getParameter("condition");
		
		Integer price;
		
		if(unitPrice.isEmpty()) {
			price = 0;  
		}else {   
			price = Integer.valueOf(unitPrice);
		}
		
		long stock;
		if(unitsInStock.isEmpty()) { 
			stock = 0;
		}else {   
			stock = Long.valueOf(unitsInStock);
		}
		// 2020.06.10. 이미지 업로드 추가
		Enumeration files = multi.getFileNames();
		String fname = (String) files.nextElement();
		String fileName = multi.getFilesystemName(fname);
		
		/* ProductRepository dao = ProductRepository.getInstance();
		
		Product newProduct = new Product();
		
		newProduct.setProductId(productId);
		newProduct.setPname(name);
		newProduct.setUnitPrice(price);
		newProduct.setDescription(description);
		newProduct.setManufacturer(manufacturer);
		newProduct.setCategory(category);
		newProduct.setUnitsInStock(stock);
		newProduct.setCondition(condition);
		newProduct.setFilename(fileName);
		
		dao.addProduct(newProduct); */
		
		PreparedStatement pstmt = null;
		
		String sql = "insert into product values(?,?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		pstmt.setString(2, name);
		pstmt.setInt(3, price);
		pstmt.setString(4, description);
		pstmt.setString(5, category);
		pstmt.setString(6, manufacturer);
		pstmt.setLong(7, stock);
		pstmt.setString(8, condition);
		pstmt.setString(9, fileName);
		pstmt.executeUpdate();
		
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
		
		response.sendRedirect("products.jsp"); 
	%>
</body>
</html>