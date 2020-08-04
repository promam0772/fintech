<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mvc.database.DBConnection" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>
	<sql:setDataSource
			var="dataSource"
			driver="com.mysql.jdbc.Driver"
			url="jdbc:mysql://localhost/minishopdb"
			user="root"
			password="1234"
	/>
	
	<sql:query dataSource="${dataSource}" var="result">
	   select * from member where id = ?
	   
	   <sql:param value="${sessionId}"/>         
	</sql:query>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav class="navbar navbar-default" >
		<div class="container-fluid">
			<div class="navbar-header">		<!--메뉴에서 가장 왼쪽, 모바일에서 표시되는 제목 -->
				<a class="navbar-brand"  href="/main.jsp">미니쇼핑몰</a>
			</div>
			<ul class="nav navbar-nav ml-auto">
				<li class="action"><a href="/main.jsp">Home</a></li>
				 <li class="dropdown"><a class="btn-lg dropdown-toggle" data-toggle="dropdown" href="#">고객센타</a>
			        <ul class="dropdown-menu">
		              <li class="list-group-item"><a href="<c:url value="/BoardListAction.do?pageNum=1"/>">게시판</a></li>		              
		              <li class="list-group-item"><a href="<c:url value="${pageContext.request.contextPath}/product/editProduct.jsp?edit=update"/>">Q&A</a></li>
			        </ul>
			      </li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
		   		<c:choose>
					<c:when test="${empty sessionId}">		<!--sessionId가 없으면 화면에 나타 냄 -->
						<li><a  class="btn-lg dropdown-toggle" href="<c:url value="${pageContext.request.contextPath}/member/login.jsp"/>"><span class="glyphicon glyphicon-user"></span>로그인</a></li>
						<li><a  class="btn-lg dropdown-toggle" href="<c:url value="${pageContext.request.contextPath}/member/addMember.jsp"/>"><span class="glyphicon glyphicon-log-in"></span>회원가입</a></li>
						<li><a  class="btn-lg dropdown-toggle" href="<c:url value="${pageContext.request.contextPath}/product/cart.jsp"/>"><span class="glyphicon glyphicon-shopping-cart"></span>장바구니</a></li>
					</c:when>
					<c:when test="${sessionId == 'admin'}">		<!--sessionId = 'admin'이면 화면에 나타 냄 -->
						<li style="padding-top:8px; color:green;font-size:22px"><c:forEach var="row" items="${result.rows}">[<c:out value="${row.name}"/></c:forEach>님]</li>
					      
					      <li class="dropdown"><a class="btn-lg dropdown-toggle" data-toggle="dropdown" href="#">관리자용</a>
					        <ul class="dropdown-menu">
				              <li class="list-group-item"><a href="<c:url value="${pageContext.request.contextPath}/product/addProduct.jsp"/>">상품 등록</a></li>		              
				              <li class="list-group-item"><a href="<c:url value="${pageContext.request.contextPath}/product/editProduct.jsp?edit=update"/>">상품수정</a></li>
				              <li class="list-group-item"><a href="<c:url value="${pageContext.request.contextPath}/product/editProduct.jsp?edit=delete"/>">상품삭제</a></li>
					          <li class="list-group-item"><a href="<c:url value="${pageContext.request.contextPath}/board/deleteBoardList.jsp"/>">게시판삭제</a></li>
					          <li class="list-group-item"><a href="<c:url value="${pageContext.request.contextPath}/member/logout.jsp"/>">로그아웃 </a></li>
						      <li class="list-group-item"><a href="<c:url value="${pageContext.request.contextPath}/member/updateMember.jsp"/>">나의정보수정</a></li>
					        </ul>
					      </li>
					      
					      
					       
					</c:when>
					<c:when test="${sessionId != 'admin'}">		<!--sessionId != 'admin'이면 화면에 나타 냄 -->
						<li style="padding-top:8px; color:green;font-size:22px"><c:forEach var="row" items="${result.rows}">[<c:out value="${row.name}"/></c:forEach>님]</li>
						<li style="font-weight:bold" class="nav-item"><a class="btn-lg nav-link" href="<c:url value="${pageContext.request.contextPath}/member/logout.jsp"/>">로그아웃 </a></li>
						<li style="font-weight:bold" class="nav-item"><a class="btn-lg nav-link" href="<c:url value="${pageContext.request.contextPath}/member/updateMember.jsp"/>">나의정보수정</a></li>
						<li style="font-weight:bold" class="nav-item"><a  class="btn-lg dropdown-toggle" href="<c:url value="${pageContext.request.contextPath}/product/cart.jsp"/>"><span class="glyphicon glyphicon-shopping-cart"></span>장바구니</a></li>
					</c:when>	
		 		</c:choose>
    		</ul>
		</div>
	</nav>
</body>
</html>