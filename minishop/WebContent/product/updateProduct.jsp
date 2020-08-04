<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ include file="../dbconn.jsp"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu.jsp"/>
	
	<div class="jumbotron">
		<div class="container">
			<h3 class="display-3">상품 수정</h3>
		</div>
	</div>
	
	<%
		String productId = request.getParameter("id");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from product where p_id = ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,productId);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			
	%>
		
		<div class="container">
			<div class="row">
				<div class="col-md-5">
					<img src="${pageContext.request.contextPath}/resources/images/<%=rs.getString("p_fileName")%>" style="width:100%"/>
				</div>
				<div class="col-md-7">
					<form name="newProduct"
					      action="processUpdateProduct.jsp"
					      class="form-horizontal"
					      method="post"
					      enctype="multipart/form-data">
					
						<div class="form-group row">
							<label class="col-sm-2">상품코드</label>
							<div class="col-sm-3">
								<input type="text" 
								       id="productId" 
								       name="productId" 
								       class="form-control" 
								       value="<%=rs.getString("p_id")%>">
							</div>
						</div>
						
						<div class="form-group row">
							<label class="col-sm-2">상품명</label>
							<div class="col-sm-3">
								<input type="text" 
								       id="name" 
								       name="name" 
								       class="form-control" 
								       value='<%=rs.getString("p_name")%>'>
							</div>
						</div>
					
						<div class="form-group row">
								<label class="col-sm-2">가격</label>
								<div class="col-sm-3">
									<input type="text" 
									       id="unitPrice" 
									       name="unitPrice" 
									       class="form-control" 
									       value="<%=rs.getString("p_unitPrice")%>">
								</div>
							</div>					
						
						<div class="form-group row">
								<label class="col-sm-2">상세설명</label>
								<div class="col-sm-5">
									<textarea name="description"
											  rows="2" 
											  cols="50"
											  class="form-control"><%=rs.getString("p_description")%>
									</textarea>
								</div>
						</div>
						
						<div class="form-group row">
								<label class="col-sm-2">제조사</label>
								<div class="col-sm-3">
									<input type="text" 
									       name="manufacturer" 
									       class="form-control" 
									       value="<%=rs.getString("p_manufacturer")%>">
								</div>
						</div>					
					
						<div class="form-group row">
								<label class="col-sm-2">분류</label>
								<div class="col-sm-3">
									<input type="text" 
									       name="category" 
									       class="form-control" 
									       value="<%=rs.getString("p_category")%>">
								</div>
						</div>
		
						<div class="form-group row">
								<label class="col-sm-2">재고수</label>
								<div class="col-sm-3">
									<input type="text" 
										   id="unitsInStock"
									       name="unitsInStock" 
									       class="form-control" 
									       value="<%=rs.getLong("p_unitsInStock")%>">
								</div>
						</div>
				
						<div class="form-group row">
								<label class="col-sm-2">상태</label>
								<div class="col-sm-5">
									<input type="radio" 
									       name="condition" 
									       value="New" <%if(rs.getString("p_condition").equals("New")){%> checked <%}%>>신규제품
									<input type="radio" 
									       name="condition" 
									       value="Old" <%if(rs.getString("p_condition").equals("Old")){%> checked <%}%>>중고제품
									<input type="radio" 
									       name="condition" 
									       value="Refurbished" <%if(rs.getString("p_condition").equals("Refurbished")){%> checked <%}%>>재생제품
								</div>
						</div>					
					
						<div class="form-group row">
								<label class="col-sm-2">이미지</label>
								<div class="col-sm-5">
									<input type="file" 
									       name="productImage" 
									       class="form-control"> 
								</div>
						</div>				
							
						<div class="form-group row">
							<div class="col-sm-offset-2 col-sm-10">
								<a href="/product/editProduct.jsp?edit=update" class="btn btn-primary">&laquo;이전</a>
								<input type="submit" class="btn btn-primary" value="수정">
								<input type="reset" class="btn btn-primary" value="취소">
							</div>
						</div>
					</form>
					
				</div>
			</div>
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