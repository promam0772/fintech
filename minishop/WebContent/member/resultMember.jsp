<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 처리결과</title>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원정보</h1>
		</div>
	</div>
	<div class="container" align="center">
		<%
			String gubun = request.getParameter("gubun");
		
			if(gubun.equals("insert")){
				out.println("<h2 class='alert alert-danger'>회원 가입을 축하드립니다.</h2>");
			}else if(gubun.equals("update")){
				out.println("<h2 class='alert alert-danger'>정상적으로 회원정보가 수정 되었습니다.</h2>");
			}else if(gubun.equals("delete")){
				out.println("<h2 class='alert alert-danger'>삭제가 완료 되었습니다.</h2>");
			}else if(gubun.equals("login")){
				out.println("<h2 class='alert alert-danger'>정상적으로 로그인 되었습니다.</h2>");
			}else if(gubun.equals("loginError")){
				out.println("<h2 class='alert alert-danger'>로그인 실패! 아이디 혹은 비밀번호를 확인 하세요.</h2>");
			}
		%>
	</div>
</body>
</html>