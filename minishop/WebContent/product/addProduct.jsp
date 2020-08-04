<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/validation.js" ></script>
<title>상품 등록</title>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품등록</h1>
		</div>
	</div>
	<div class="container">
		<div class="text-right">
		<form name="newProduct" action="./processAddProduct.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
			<div class="form-group row">
				<label class="col-sm-2">상품코드</label>
				<div class="col-sm-5">
					<input type="text" id="productId" name="productId" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-5">
					<input type="text" id="name" name="name" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">가격</label>
				<div class="col-sm-5">
					<input type="text" id="unitPrice" name="unitPrice" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세설명</label>
				<div class="col-sm-5">
					<textarea name="description" rows="2" cols="50" class="form-control"></textarea>
				</div>	
			</div>
			<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm-5">
					<input type="text" name="manufacturer" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">분류</label>
				<div class="col-sm-5">
					<input type="text" name="category" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">재고 수</label>
				<div class="col-sm-5">
					<input type="text" id="unitsInStock" name="unitsInStock" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상태</label>
				<div class="col-sm-5">
					<input type="radio" name="condition" value="New">신규제품 
					<input type="radio" name="condition" value="Old">중고제품
					<input type="radio" name="condition" value="Refurbished">재생제품
				</div>
			</div>
			<!-- 2020.0610.
			1.col-xs-숫자:항상 가로로 배치(12등분)
			2.col-sm-숫자:가로가 768px 이상일떄만 가로표시
			3.col-md-숫자:가로가 992px 이상일때만 가로표시
			4.col-lg-숫자:가로가 1,200px 이상일떄만 가로표시 
			 -->
			<div class="form-group row">
				<label class="col-sm-2">이미지</label>
				<div class="col-sm-5">
					<input type="file" name="productImage" class="form-control">
				</div>			
			</div>
			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" value="등록" onclick="CheckAddProduct()">
					<input type="reset" class="btn btn-primary" value="취소">
				</div>
			</div>
		</form>
		</div>
	</div>
	
	
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>