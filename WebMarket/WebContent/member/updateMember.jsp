<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	fieldset{
		min-width:0;
		padding:0;
		margin:0;
		border:0;	
	}
	.well{
		width:350px;
		min-height:20px;
		padding:20px;
		margin-bottom:80px;
		background-color:#f5f5f5;
		border:1px solid #e3e3e3;
		border-radius:4px;
	}
	.well_legend{
		display:block;
		font-size:14px;
		width:auto;
		padding:2px 7px 2px 5px;
		margin-bottom:20px;
		line-height:inherit;
		color:#333;
		background:#cea6d8;
		border:1ps solid #e3e3e3;
		border-radius:10px;
	}
</style>
<meta charset="UTF-8">
<title>회원수정</title>
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script>
	$(function(){
		$("#birth").datepicker({
			changeMonth:true,
			changeYear:true,
			dateFormat:"yy-mm-dd",
			prevText:"이전 달",
			nextText:"다음 달",
			monthNames:['1월','2월','3월','4월',
						'5월','6월','7월','8월',
						'9월','10월','11월','12월'
				       ],
			monthNamesShort:['1월','2월','3월','4월',
							'5월','6월','7월','8월',
							'9월','10월','11월','12월'
					       ],
			dayNames:['일','월','화','수','목','금','토'],
			dayNamesShort:['일','월','화','수','목','금','토'],
			dayNamesMin:['일','월','화','수','목','금','토'],
			showMonthAfterYear:true,
			yearSuffix:'년',
			yearRange: 'c-100:c+0'
		});
	});
</script>
<!--유효성 검사  -->
<script src="../resources/js/validation.js"></script>
<!--우편번호 찾기  -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function Postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드(id)에 넣는다.
                    document.getElementById("address2").value = extraAddr;
                
                } else {
                    document.getElementById("address2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcd').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("postcd").focus();
            }
        }).open();
    }
</script>

<body onload="init()">
	<%
		//정상 로그인시 session id 값을 가져온다
		String sessionId = (String)session.getAttribute("sessionId");
	%>
		<!-- db 접속 설정 -->	
	<sql:setDataSource
			var="dataSource"
			driver="com.mysql.jdbc.Driver"
			url="jdbc:mysql://localhost:3306/webmarketdb"
			user="root"
			password="1234"	/>
	<!-- member테이블에서 정보를 가져오기 위해  sql 쿼리 정의-->
	<sql:query 
			dataSource="${dataSource}"
			var="resultSet">
		select * from member where id = ?
		<sql:param value="<%=sessionId%>"/>
	</sql:query>
	
	<jsp:include page="../menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 수정</h1>
		</div>
	</div>
	
	<!-- member 테이블 자료를 가져온다 -->
	<c:forEach var="row" 
	           items="${resultSet.rows}">
	
		<c:set var="mail" value="${row.mail}"/>
		<!-- 메일자료를 @ 기준으로 분리 -->
		<c:set var="mail1" value="${mail.split('@')[0]}"/>
		<c:set var="mail2" value="${mail.split('@')[1]}"/>
		
		<div class="container">
		<form name="newMember" 
		      class="form-horizontal"  
		      action="processUpdateMember.jsp" 
		      method="post">
			<div class="form-group  row">
				<label class="col-sm-2">아이디</label>
				<div class="col-sm-3">
					<input  name="id" type="text" class="form-control" 
							placeholder="아이디입력" readonly="readonly"	
							value="<c:out value='${row.id}'/>">
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input  name="passwd" type="password" class="form-control"
							placeholder="비밀번호 입력"
							value="<c:out value='${row.passwd}'/>">
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호확인</label>
				<div class="col-sm-3">
					<input  name="passwd2" type="password" class="form-control" 
							placeholder="비밀번호 확인 입력">
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">이름</label>
				<div class="col-sm-3">
					<input  name="name" type="text" class="form-control" 
							placeholder="이름 입력" readonly="readonly"	
							value="<c:out value='${row.name}'/>">
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">성별</label>
				<div class="col-sm-10">
					<c:set var="gender" value="${row.gender}"/>
					<input name="gender" type="radio" value="남" <c:if test="${gender.equals('남')}"><c:out value="checked"/></c:if>/>남자 
					<input name="gender" type="radio" value="여" <c:if test="${gender.equals('여')}"><c:out value="checked"/></c:if>/>여자
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">생일</label>
				<div class="col-sm-3">
					<c:set var="gender" value="${row.gender}"/>
					<input  id="birth" name="birth" type="text" class="form-control" 
							placeholder="생일 입력" value="<c:out 
							value='${fn:substring(row.birth,0,4)}${"-"}${fn:substring(row.birth,4,6)}${"-"}${fn:substring(row.birth,6,9)}'/>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" id="mail1" name="mail1" maxlength="50" value="${mail1}">@ 
					<select name="mail2" id="mail2">
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
					</select>
				</div>				
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">전화번호</label>
				<div class="col-sm-3">
					<input class="phone" name="phone" type="text" class="form-control" placeholder="0000-0000-0000" 
						   value="<c:out value='${row.phone}'/>">

				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>					
				<div class="col-sm-2"> 
					<input id="postcd" name="postcd" type="text"
					       value="<c:out value='${row.postcd}'/>" 
					       class="form-control" />
					<input type="button" value="우편번호 찾기" onclick="Postcode()"/>       
				</div>	
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소</label>					
				<div class="col-sm-7">
					<input id="address" name="address" type="text" readonly="readonly"
					       value="<c:out value='${row.address}'/>"
					       class="form-control" />
				</div>				
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">상세주소</label>					
				<div class="col-sm-7">
					<input id="address2" name="address2"  type="text"
					       value="<c:out value='${row.address2}'/>"   
					       class="form-control" />
				</div>				
			</div>
			<div class="form-group  row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="button" class="btn btn-primary " value="수정 " onclick="CheckAddMember()"> 
					<input type="reset" class="btn btn-primary " value="취소 " onclick="reset()">
				</div>
			</div>
		</form>
	</div>
	</c:forEach>
</body>
</html>
<script>
	function init(){
		selectUrl("${mail2}");
	}
	
	function selectUrl(val){
		var selectUrl = document.getElementById('mail2');
		
		for(i=0;i<selectUrl.length;i++){
			if(selectUrl.options[i].value == val){
				selectUrl.options[i].selected = true;
				break;
			}
		}
	}
</script>
