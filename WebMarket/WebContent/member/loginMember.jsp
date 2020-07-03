<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>

<body>
	<jsp:include page="../menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
	
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Please Sign In</h3>
			<%
				String error = request.getParameter("error");
				
				if(error != null){//에러가 있으면
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인하세요!");
					out.println("</div>");
				}
			%>
			<form class = "form-signin" action="processLoginMember.jsp" method="post">
				<div class="form-group">
					<label class="sr-only">User Name</label>
					<input class="form-control" type="text" name="id" placeholder="아이디 입력" autofocus>
				</div>
				<div class="form-group">
					<label class="sr-only">Password</label>
					<input class="form-control" type="password" name="passwd" placeholder="비밀번호 입력">
				</div>
				<button class="btn btn-lg btn-success btn-block" type="submit">로그인</button>
			</form>
		</div>
	</div>
</body>
</html>