<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
				<h4>
					주문목록 
				</h4>
				
			</section>

			<%-- MAIN CONTENT --%>
			<!-- Main content -->
			<section class="content container-fluid">

				<div class="row">
					<!-- left column -->
					<div class="box" style="border: none; padding: 10px 30px;">
						<div class="box-body">
							<table class="table text-center">
								<%-- 상품이 존재하지 않는 경우 --%>
								<c:if test="${empty orderList}">
									<tr>
										<td colspan="10"> 
											<p style="padding:50px 0px; text-align: center;">주문하신 상품이 없습니다.</p>
										</td>
									<tr>
								</c:if>
								
								<%-- 상품이 존재하는 경우,  리스트 출력 --%>
								<c:forEach items="${orderList}" var="orderVO" varStatus="status">
									<c:if test="${status.index==0 || orderVO.odr_code != code}">
									<tr style="background-color: aliceBlue;" >
										<td colspan="5" style="text-align:left;">
											<b>주문날짜: <fmt:formatDate value="${orderVO.odr_date}" pattern="yyyy/MM/dd HH:mm:ss"/>
											(주문번호: ${orderVO.odr_code} ) <p><a style="color:red;">${orderVO.delivery}</a></p></b>
										</td>
										<td> 
											<button class="btn btn-dark" onclick="location.href='/order/read?odr_code=${orderVO.odr_code}';">
											Detail</button> 
											
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
									</c:if>
									<c:set var="code" value="${orderVO.odr_code}">	</c:set>
									<tr style="font-size: x-small;">
										<td class="col-md-2">
											<a href="/product/read?pdt_num=${orderVO.pdt_num}">
												<img src="/product/displayFile?fileName=${orderVO.pdt_img}" style="width:100px;">
											</a>
										</td>
										<td class="col-md-2">
											<a href="/product/read?pdt_num=${orderVO.pdt_num}"
												style="color: black;"> ${orderVO.pdt_name} </a>
										</td>
										<td class="col-md-1">
											<fmt:formatNumber value="${orderVO.odr_price}" pattern="###,###,###" /></p>
											
										<td class="col-md-1">
											<p>${orderVO.odr_amount}</p>
										</td>
										<td class="col-md-1">
											<fmt:formatNumber value="${orderVO.odr_price * orderVO.odr_amount}" pattern="###,###,###" /></p>
										</td>
										<td class="col-md-2">
											
											<button type="button" class="btn btn-flat" 
												onclick="location.href='/product/read?pdt_num=${orderVO.pdt_num}';" value="${orderVO.pdt_num}" >쓰기</button>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
				<!--/.col (left) -->
			</section>
		</div>
		</div>
		</div>
		</div>
		
		<!-- /.content -->
		<!-- /.content-wrapper -->
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>	
		 <!-- Footer -->
  <%@ include file="/WEB-INF/views/common/bottom.jsp" %>

  <!-- Bootstrap core JavaScript -->
  <%@ include file="/WEB-INF/views/common/bootjs.jsp" %>

</body>

</html>
