<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="mvc.model.product.ProductDTO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<style>
	.qty{
		width:50px;
		text-align:center;
	}
</style>
<!--주문전 로그인 여부 확인-->
<script type="text/javascript">
	function checkOrder(){
		<%	
			String sessionId = (String) session.getAttribute("sessionId");
		
			ArrayList list = (ArrayList<ProductDTO>)session.getAttribute("cartlist");
			if(list == null || list.size() == 0){
		%>
			alert("선택하신 상품내역이 없습니다.");
			location.href = './cart.jsp';
			return false;
		<%
			}else if(sessionId == null || sessionId.equals("")) {
		%>
			 alert("로그인하세요.");
	         location.href = '../member/login.jsp';
	         return false;
     	<%
        	}
		%>
			return true;
	}
	/*수량변경 */
	
	function updateQty(i){
		if(confirm("정말로 변경하시겠습니까?")){
			var newQty = document.getElementsByName("qty")[i].value;
			var newPrice = document.getElementsByName("price")[i].value;
			
			document.getElementsByName("total")[i].value = newQty*newPrice;
			totalcal();
		}
	}
	/*총계수정 */
	function totalcal(){
		var newNum = 0;
		var newTotal = 0;
		var row = document.getElementsByName("qty").length;
		
		for(var i=0;i<row;i++){
			var newQty = document.getElementsByName("qty")[i].value;
			var newPrice = document.getElementsByName("price")[i].value;
			newNum = Number(newNum) + Number(newQty);
			newTotal = Number(newTotal) + (Number(newPrice)*Number(newQty)); 
		}
		
		document.getElementById("sumtotal1").value = newNum;
		document.getElementById("sumtotal").value = newTotal;
	}
</script>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<%
		String cartId = session.getId();
	%>
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="right"><a href="./deleteCart.jsp?cartId=<%=cartId %>" class="btn btn-danger">삭제하기</a>
									<a href="./processCart.jsp?cartId=<%=cartId %>" onclick="return checkOrder()" class="btn btn-primary">주문하기</a>
									<a href="../main.jsp" class="btn btn-success">&laquo;쇼핑 계속하기</a></td>
				</tr>
			</table>
		</div>
		<div style="padding-top:50px">
			<table id="tbl" class="table table-hover" >
				<tr>
					<th class="text-left">상품</th>
					<th class="text-right">가격</th>
					<th class="text-right">수량</th>
					<th class="text-right">소계</th>
					<th class="text-right">비고</th>
				</tr>
				<%
					int sum = 0;
					int sum1 = 0;
					ArrayList<ProductDTO> cartList = (ArrayList<ProductDTO>) session.getAttribute("cartlist");
					if(cartList == null)
						cartList = new ArrayList<ProductDTO>();
					
					for(int i=0;i<cartList.size();i++){
						ProductDTO product = cartList.get(i);
						int total = product.getUnitPrice() * product.getQuantity();
						sum = sum + total;
						
						int total1 = product.getQuantity();
						sum1 = sum1 + total1;
						
						DecimalFormat df = new DecimalFormat("###,###");
						String gagyeog = df.format(sum);
				%>
				<tr id="num">
					<td><input type="test" name="pid" value='<%=product.getProductId() %>'> - <input type="test" name="pname" value='<%=product.getPname() %>'></td>
					<td class="text-right">
						<input type="hidden" name="price" id="price" value='<%=product.getUnitPrice() %>'>
						<input type="text" class="text-right" value="<fmt:formatNumber value='<%=product.getUnitPrice() %>' pattern="#,###"/>" readonly="readonly">
					</td>
					<td class="text-right">
						<input type="number" name="qty" class="qty" value="<%=product.getQuantity() %>" min="1">
						<a href="javascript:updateQty(<%=i %>)" ><button>수정</button></a>
					</td>
					<td class="text-right">
						<input type="text" name="total" class="text-right" value="<%=total %>" readonly="readonly">
						<%-- <fmt:formatNumber value='<%=total %>' pattern="#,###"/> --%>
					</td>
					<td><a href="./removeCart.jsp?id=<%=product.getProductId() %>" class="badge badge-danger">삭제</a></td>
				</tr>
				<%
					}
				%>
				<tr>
					<th></th>
					<th class="text-right">총계</th>
					<th class="text-right">
						<input type="text" name="sumtotal1" id="sumtotal1" class="text-right" value="<%=sum1 %>" readonly="readonly">
					</th>
					<th class="text-right">
						<input type="text" name="sumtotal" id="sumtotal" class="text-right" value="${gagyeog}" readonly="readonly">
						<%-- <fmt:formatNumber value='<%=sum %>' pattern="#,###"/> --%>
					</th>
					<th></th>
				</tr>
			</table>
			
		</div>
		<hr>
	</div>
</body>
</html>