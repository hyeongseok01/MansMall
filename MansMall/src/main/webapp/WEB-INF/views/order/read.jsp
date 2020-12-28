<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>

<%-- 버튼 클릭 이벤트 메소드 --%>



  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">


  
  <title>Shop Homepage - Start Bootstrap Template</title>  
  
  <!-- Bootstrap core CSS -->
  <!-- Bootstrap core JavaScript -->
<%@ include file="/WEB-INF/views/common/bootjs.jsp" %>
  
  
 <!-- Custom styles for this template -->
<%@ include file="/WEB-INF/views/common/bootcss.jsp" %>
 <script src="http://code.jquery.com/jquery-latest.js"></script>

</head>

<body>

  <!-- Navigation -->
  <%@ include file="/WEB-INF/views/common/top.jsp" %>

  <!-- Page Content -->
  <div class="container">

    <div class="row">
	<!-- 카테고리 메뉴 -->
      <div class="col-lg-3">
    	<%@ include file="/WEB-INF/views/common/category.jsp" %>
		</div>	
			
			<div class="col-lg-9">	
        <%@ include file="/WEB-INF/views/common/carousel.jsp" %>
		
	<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					주문 상세 내역 <small>Order Detail</small>
				</h1>
			</section>

			
			<%-- MAIN CONTENT --%> 
			<section class="content container-fluid">
			<div class="row">
				<!-- left column -->
				<div class="box" style="border: none;">
					<form >
						<div class="box-body" style="padding:30px 10px 100px 10px;">
							<%-- 주문내역 상단 버튼 --%>
							<div class="orderList" style="padding: 0px 40px;">
								<%-- 주문내역 테이블 --%>
								<table class="table  text-center" id="ordertbl">
									<thead id="thead">
										<tr style="background-color: aliceBlue;" >
											<td colspan="7" style="text-align:left;">
												<b>주문날짜: <fmt:formatDate value="${order.odr_date}" pattern="yyyy/MM/dd HH:mm:ss"/>
												(주문번호: ${order.odr_code} )</b>
											</td>
										<tr>
										<tr style="background-color: whitesmoke;">
											<td>IMAGE</td>
											<td>NAME</td>
											<td>PRICE</td>
											<td>AMOUNT</td>	
											<td>TOTAL</td> 
											<td>REVIEW</td>
										</tr>
										<%-- 상품이 존재하지 않는 경우 --%>
										<tr>
											<c:if test="${empty orderList}">
												<span>구매한 상품이 존재하지 않습니다.</span>
											</c:if>
										</tr>
									<thead>
									
									<%-- 상품이 존재하는 경우,  리스트 출력 --%>
									<tbody>
									<c:forEach items="${orderList}" var="product" varStatus="status">
									<c:set var="totalPrice" value="${totalPrice + orderList[status.index].pdt_price * orderList[status.index].odr_amount}"></c:set>
										<tr id="row">
											<td >
												<a href="/product/read?pdt_num=${product.pdt_num}">
													<img src="/product/displayFile?fileName=${product.pdt_img}" style="width:100px;">
												</a>
											</td>
											<td >
												<a href="/product/read?pdt_num=${product.pdt_num}"
													style="color: black;"> ${product.pdt_name} </a>
											</td>
											<td>
												<p><fmt:formatNumber value="${product.odr_price}" pattern="###,###,###" /></p>
											</td>
						
											<td >
												<p>${product.odr_amount}</p>
											</td>
											<td >
												<p ><fmt:formatNumber value="${product.odr_price * product.odr_amount}"  pattern="###,###,###" /></p>
											</td>
											<td>
												<button type="button" name="btn_review" class="btn btn-flat" 
												onclick="location.href='/product/read?pdt_num=${product.pdt_num}';" value="${product.pdt_num}" >상품후기 쓰기</button>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
								<br><br><br>
							</div>
							<hr><br>
							
							<%-- 주문 정보 --%>
							<div class="orderInfo" style="min-width:1000px;" > 
								<div class="userInfo" style="display:inline-block; float:left; width:60%; padding: 0% 5%;">
									<div class="container" style="width:100%;">
										<span>[주문 정보]</span>
										<div class="form-group">
											<label for="inputName">* 이름</label> <input type="text"
												class="form-control" value="${order.odr_name}" readonly>
										</div>
										<div class="form-group">
											<label for="inputMobile">* 휴대폰 번호</label> <input type="tel"
												class="form-control" value="${order.odr_phone}" readonly>
										</div>
										<div class="form-group">
											<label for="inputAddr">* 주소</label> <br />
											<input type="text" id="sample2_postcode" name="odr_zipcode" class="form-control" 
												value = "${order.odr_zipcode}" 
												style="width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호" readonly>
											<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기" disabled="disabled"><br>
											<input type="text" id="sample2_address" name="odr_addr" class="form-control" 
												value = "${order.odr_addr}" 
												placeholder="주소" style=" margin:3px 0px;" readonly>
											<input type="text" id="sample2_detailAddress" name="odr_addr_d" class="form-control" 
												value = "${order.odr_addr_d}"
												placeholder="상세주소" readonly >
											<input type="hidden" id="sample2_extraAddress" class="form-control" 
												placeholder="참고항목">
										</div>
									</div>
								</div>
								
								<%-- 주문 금액 확인 --%>
								<div class="orderConfirm" style="display:inline-block; width:20%; margin: 0px 5%;">
								<br>
									<%-- 주문 금액 --%>
									<div style="width: 400px;">
										<span>[결제 금액]</span>
										<table class="table" style="margin-top:15px;" >
										
											<tr>
												<td class="col-md-1"><label>결제 금액</label></td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<label><fmt:formatNumber value="${order.odr_totalprice}" pattern="###,###,###" /></label>
												</td>
											</tr>
										</table>
								
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			</section>
			<!-- /.content -->
		</div>
		</div>
		</div>
		</div>
		
		<!-- /.content-wrapper -->
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		 <!-- Footer -->
  <%@ include file="/WEB-INF/views/common/bottom.jsp" %>

  <!-- Bootstrap core JavaScript -->
  <%@ include file="/WEB-INF/views/common/bootjs.jsp" %>

</body>

</html>
