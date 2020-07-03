// 2020.06.25. 회원등록 유효성 검
function CheckAddMember() {
	
	var regExpId = /^[a-z|A-Z|0-9]/;
	var regExpPasswd = /^[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|0-9]*$/;
	var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
	var id = newMember.id.value;
	var name = newMember.name.value;
	var passwd1 = newMember.passwd.value;
	var passwd2 = newMember.passwd2.value;
	var gender = newMember.gender.value;
	var birthday = newMember.birth.value;
	var mail1 = newMember.mail1.value;
	var mail2 = newMember.mail2.value;
	var phone = newMember.phone.value;
	var postcd = newMember.postcd.value;
	var address = newMember.address.value;
	var address2 = newMember.address2.value;
	
	
	if (id == ""){
		alert("아이디를 입력하세요");
		newMember.id.select();
		newMember.id.focus();
		return false;
	}
	
	if (passwd1 == "") {
		alert("비밀번호를 입력하세요.");
		newMember.passwd.select();
		newMember.passwd.focus();
		return false;
	}
	
	if (passwd2 == "") {
		alert("비밀번호 확인을 입력하세요.");
		newMember.passwd2.select();
		newMember.passwd2.focus();
		return false;
	}

	if (passwd1 != passwd2) {
		alert("비밀번호를 동일하게 입력하세요.");
		newMember.passwd2.select();
		newMember.passwd2.focus();
		return false;
	}
	
	if (name == "") {
		alert("이름을 입력하세요.");
		newMember.name.select();
		newMember.name.focus();
		return false;
	}	
	
	if (gender == "") {
		alert("성별을 선택하세요.");
		newMember.gender.select();
		newMember.gender.focus();
		return false;
	}		
	
	if (document.newMember.birth.value == "") {
		alert("생일을 선택하세요.");
		newMember.birth.select();
		newMember.birth.focus();
		return false;
	}
	
	if (document.newMember.phone.value == "") {
		alert("휴대폰 번호를 입력하세요.");
		newMember.phone.select();
		newMember.phone.focus();
		return false;
	}	
	
	if (document.newMember.address.value == "") {
		alert("우편번호 찾기를 실행하세요");
		newMember.address.select();
		newMember.address.focus();
		return false;
	}	
	
	if (document.newMember.address2.value == "") {
		alert("상세주소내역을 입력하세요");
		newMember.address2.select();
		newMember.address2.focus();
		return false;
	}
	
	if(passwd1.search(id) > -1){
		alert("비밀번호는 아이디를 포함할 수 없습니다!");
		newMember.passwd1.select();
		newMember.passwd1.focus();
		return false;
	}
	
	
	document.newMember.submit();
	
}
	
//2020.06.10. 상품등록 유효성 검사
function CheckAddProduct() {
	                       //getElementById : input에서 id=""를 찾아온다.
	var productId = document.getElementById("productId");
	var name = document.getElementById("name");
	var unitPrice = document.getElementById("unitPrice");
	var unitsInStock = document.getElementById("unitsInStock");
	
	//상품 아이디 체크
	if(!check(/^P[0-9]{4,11}$/, productId, "[상품 코드]\nP와 숫자를 조합하여 5~12자까지 입력하세요\n첫 글자는 반드시 P로 시작하세요"))
		return false;
	
	//상품명 체크
	if(name.value.length < 4 || name.value.length >12){
		alert("[상품명]\n최소 4자에서 최대12자까지 입력하세요");
		name.select();   //테그를 선택하는 것
		name.focus();    //커서 옮김.
		return faalse;
	}
	
	//상품 가격 체크
	
	if(unitPrice.value == ""){
		alert("[가격]\n가격을 입력하세요.");
		unitPrice.select();
		unitPrice.focus();
		return false;
	}
	
	if(unitPrice.value.length == 0 || isNaN(unitPrice.value)){
		alert("[가격]\n숫자만 입력하세요");
		unitPrice.select();
		unitPrice.focus();
		return false;
	}
	
	if(unitPrice.value < 0){
		alert("[가격]\n음수는 입력할 수 없습니다.")
		unitPrice.select();
		unitPrice.focus();
		return false;
	}else if(!check(/^\d+(?:[.]?[\d])?$/, unitPrice, "[가격]\n소수점 둘째 자리까지만 입력하세요." ))
		return false;
	
	//재고 수 체크
	if(isNaN(unitsInStock.value)){
		alert("[재고 수]\n숫자만 입력하세요");
		unitsInStock.select();
		unitsInStock.focus();
		return false;
	}
	//check(정규식, 메시지)
	function check(regExp, e, msg){
		
		if(regExp.test(e.value)){
			return true;
		}
		alert(msg);
		e.select();
		e.focus();
		return false;
	}
	
	document.newProduct.submit();
}