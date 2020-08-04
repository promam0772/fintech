<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="mvc.model.user.MemberDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<%
		String id = request.getParameter("id");

		MemberDAO member = new MemberDAO();
		boolean exist = member.isExistId(id);
	%>
<script type="text/javascript">
	function checkIdClose(){
	    /*login.jsp from name="newMember(여기이름)"*/
		opener.newMember.id.value = '<%=id%>';
		window.close();
		opener.addMember.pwd.focus();
	}
</script>

<title>중복체크</title>
</head>
<body>
	
	<form>
		<%if(exist){ %>
		<%=id %>는 사용중입니다.<br><br>
		아이디 <input type="text" name="id">
		<input type="submit" value="중복체크">
		<%}else{ %>
		<%=id %>는 사용 가능합니다.<br><br>
		<input type="button" value="사용" onclick="checkIdClose()">
		<%} %>

	</form>
</body>
</html>