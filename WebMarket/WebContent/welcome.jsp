<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome</title>
</head>
<body>
	<%@ include file="menu.jsp" %>

	<%! String greeting = "웹 쇼핑몰에 오신 것을 환영합니다.";
		String tagline = "Welcome to Web Market!"; %>
	
	<!-- container : 반응형(고정형) 디자인 적용
		 display-3 : 글자크기 (숫자 크기 작아야 커진다.)
	 -->
	<div class="jumbotron">
		<div class= "container">
			<h1 class= "display-3">
				<%= greeting %>
			</h1>
		</div>
	</div>

	<div class = "container">
		<div class = "text-center">
			<h3>
				<%= tagline %>
			</h3>
		</div> 
		<hr>
	</div>
	<%
		Date day = new java.util.Date();
	
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss E요일");
		String today = sf.format(day);
		out.println("현재접속시간 : " + today);
		
		/* String am_pm;
		int hour = day.getHours();
		int minute = day.getMinutes();
		int second = day.getSeconds();
		
		if(hour / 12 ==0){
			am_pm = "AM";
		}else{
			am_pm = "PM";
			hour = hour - 12;
		}
		String CT =  am_pm + hour + ":" + minute + ":" + second + " ";
		out.println("현재 접속 시각: " + CT + "\n");   */
	%>
	
	<%@ include file="footer.jsp" %>	
	
</body>
</html>