<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
</head>
<body>
	<%
		String filename = "";
		String realFolder = "E:\\jspStudy\\WebMarket\\WebContent\\resources\\images";
		String encType = "utf-8";
		int maxSize = 5 * 1024 * 1024;
		
		MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		//화면에서 입력받은 값을 가져온다.
		String productId = multi.getParameter("productId");
		String name = multi.getParameter("name");
		String unitPrice = multi.getParameter("unitPrice");
		String description = multi.getParameter("description");
		String manufacturer = multi.getParameter("manufacturer");
		String category = multi.getParameter("category");
		String unitsInStock = multi. getParameter("unitsInStock");
		String condition = multi.getParameter("condition");
		
		Integer price;
		
		if(unitPrice.isEmpty()){
			price = 0;
		}else{        //문자열을 정수형태로 변환
			price = Integer.valueOf(unitPrice);
		}
		
		long stock;
		
		if(unitsInStock.isEmpty()){
			stock = 0;
		}else{     //문자열을 LONG형으로 변환
			stock = Long.valueOf(unitsInStock);
		}
		//업로드한 파일명을 집합형태로 가져온다.
		Enumeration files = multi.getFileNames();
		//다음의 값을 가져온다.
		String fname = (String) files.nextElement();
		//getFilesystemName : 서버에 올라간 실제 파일명
		//getOriginalFileName() : 원본 파일명
		String fileName = multi.getFilesystemName(fname);
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from product where p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			if(fileName != null){  //파일명이 존재하면 
				sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=?, p_category=?, p_unitsInStock=?, p_condition=?, p_fileName=? WHERE p_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setInt(2, price);
				pstmt.setString(3, description);
				pstmt.setString(4, manufacturer);
				pstmt.setString(5, category);
				pstmt.setLong(6, stock);
				pstmt.setString(7, condition);
				pstmt.setString(8, fileName);
				pstmt.setString(9, productId);
				/* pstmt.executeUpdate(); */
			}else {
				sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=?, p_category=?, p_unitsInStock=?, p_condition=? WHERE p_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setInt(2, price);
				pstmt.setString(3, description);
				pstmt.setString(4, manufacturer);
				pstmt.setString(5, category);
				pstmt.setLong(6, stock);
				pstmt.setString(7, condition);
				pstmt.setString(8, productId);
			}
			pstmt.executeUpdate();
		}
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
		
		response.sendRedirect("editProduct.jsp?edit=update");
	%>
</body>
</html>