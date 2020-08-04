<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--유효성 검사 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/validation.js" ></script>
<!--ID 중복체크 -->
<script>
	function IdCheck(){
		var id = document.newMember.id.value;
		if(id == "" || id.length == 0){
			alert("체크 할 아이디를 입력해주세요.");
			id.focus();
			return;
		}else{
			window.open("IdCheck.jsp?id=" + id,"","width=350 height=100 left=500 top=200")
		}
	}
</script>
<!--날짜를 달력 표시로 선택-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script>
	$(document).ready(function () {
	   $(function () {
	            $('.phone').keydown(function (event) {
	             var key = event.charCode || event.keyCode || 0;
	             $text = $(this); 
	             if (key !== 8 && key !== 9) {
	                 if ($text.val().length === 3) {
	                     $text.val($text.val() + '-');
	                 }
	                 if ($text.val().length === 8) {
	                     $text.val($text.val() + '-');
	                 }
	             }
	
	             return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
				 // Key 8번 백스페이스, Key 9번 탭, Key 46번 Delete 부터 0 ~ 9까지, Key 96 ~ 105까지 넘버패트
				 // 한마디로 JQuery 0 ~~~ 9 숫자 백스페이스, 탭, Delete 키 넘버패드외에는 입력못함
	         })
	   });
	});
</script>
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
			yearRange: 'c-50:c+0' 
		});
	});
</script>
<!--우편번호 클릭하면 주소창 띄워서 주소 선택 -->
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
                    // 조합된 참고항목을 해당 필드에 넣는다.
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
<title>회원가입</title>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 가입</h1>
		</div>
	</div>

	<div class="container">
		<form action="processAddMember.jsp" method="post" name="newMember" class="form-horizontal" >
			<div class="form-group  row">
				<label class="col-sm-2">아이디</label>
				<div class="col-sm-3">
					<input  name="id" type="text" class="form-control" placeholder="아이디입력" >
					<input  type="button" class="id_overlap_button " value="ID중복체크 " onclick="IdCheck()">
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input  name="passwd" type="password" class="form-control" placeholder="비밀번호 입력" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호확인</label>
				<div class="col-sm-3">
					<input   name="passwd2" type="password" class="form-control" placeholder="비밀번호 확인 입력" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">이름</label>
				<div class="col-sm-3">
					<input  name="name" type="text" class="form-control" placeholder="이름 입력" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">성별</label>
				<div class="col-sm-10">
					<input name="gender" type="radio" value="남" /> 남 
					<input name="gender" type="radio" value="여" /> 여
				</div>
			</div>

			<div class="form-group  row">
				<label class="col-sm-2">생일</label>
				<div class="col-sm-3">
					<input id="birth" name="birth" type="text" class="form-control" placeholder="생일 입력" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" id="mail1" name="mail1" maxlength="50">@ 
					<select name="mail2" id="mail2" >
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
					</select>
				</div>				
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">전화번호</label>
				<div class="col-sm-7">
					<input class="phone" 
					       name="phone" 
					       type="text" 
					       class="form-control"
					       maxlength="13" 
					       size="20" 
					       placeholder="000-0000-0000" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>					
				<div class="col-sm-6"> 
					<input class="col-sm-2" 
					       id="postcd" 
					       name="postcd" 
					       type="text"
					       readonly 
					       class="form-control" />
					<input class="col-sm-4" 
					       type="button" 
					       value="우편번호 찾기" 
					       onclick="Postcode()"/>       
				</div>	
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소</label>					
				<div class="col-sm-7">
					<input id="address" name="address" type="text" readonly="readonly"
					       class="form-control" />
				</div>				
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세주소</label>					
				<div class="col-sm-7">
					<input id="address2" name="address2"  type="text"  class="form-control" />
				</div>				
			</div>
			<div class="form-group  row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="button" class="btn btn-primary " value="등록 " onclick="CheckAddMember()"> 
					<input type="reset" class="btn btn-primary " value="취소 " onclick="reset()">
				</div>
			</div>
		</form>
	</div>
</body>
</html>