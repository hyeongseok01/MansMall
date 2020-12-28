<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="en">
<head>


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
<%-- 버튼 처리 --%>
<script>
	/* 장바구니 버튼 클릭 이벤트 */
	var cart_click = function(pdt_num){
		$.ajax({
			url: "/cart/add",
			type: "post",
			dataType: "text",
			data: {pdt_num: pdt_num},
			success: function(data){
				var result = confirm("장바구니에 추가되었습니다.\n지금 확인하시겠습니까?");
				if(result){
					location.href="/cart/list";
				} else{}
			}
		});
	}

</script>

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
      <!-- /.col-lg-3 -->

        <div class="col-lg-9">
		<!-- main-carousel begin  -->
        <%@ include file="/WEB-INF/views/common/carousel.jsp" %>
		<!-- main-carousel end -->

		<!-- Content Wrapper. Contains page content -->
		<br>
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Product List 
				</h1>
			<ol class="breadcrumb">
               <li>${cg_name}
               		<i class="fa fa-dashboard"></i> 
               </li>
            </ol>
			</section>
			
					
					<ul class="new_arrivals_list row">
						<%-- 상품이 존재하지 않는 경우 --%>
						<c:if test="${empty productList}">
							<span>등록된 상품이 존재하지 않습니다.</span>
						</c:if>
						
						<%-- 상품이 존재하는 경우 --%>
						<c:forEach items="${productList}" var="productVO" >
						<div class="col-lg-4 col-md-6 mb-4" >
							${productVO.pdt_num}
							<div class="thumnail">
								<a href="/product/read${pm.makeQuery(pm.cri.page)}&pdt_num=${productVO.pdt_num}&cg_code=${productVO.cg_code}">
									<img src="/product/displayFile?fileName=${productVO.pdt_img}">
								</a>
							</div>
							<div class="description">
								<a href="/product/read${pm.makeQuery(pm.cri.page)}&pdt_num=${productVO.pdt_num}&cg_code=${cg_code}" >${productVO.pdt_name}</a>
								<p>가격: <fmt:formatNumber value="${productVO.pdt_price}" pattern="###,###,###" />원<br>
								 	할인가: <fmt:formatNumber value="${productVO.pdt_price-productVO.pdt_discount}" pattern="###,###,###" />원</p>
							</div>
							<div class="btnContainer">
								<button class="btn btn-dark" id="btn_buy" type="button" 
									onclick="location.href = '/order/buy?pdt_num=${productVO.pdt_num}&ord_amount=1';">구매</button>
								<button class="btn btn-default" id="btn_cart" type="button" 
									onclick="cart_click(${productVO.pdt_num})">장바구니</button>
							</div>
							
							</div>
						</c:forEach>
					</ul>
				</div>
				
				<%-- 페이지 표시 --%>
		
					<div class="text-center">
						<ul class="pagination justify-content-center" style="display: center-block">
							<c:if test="${pm.prev}">
								<li><a href="list${pm.makeQuery(pm.startPage-1)}&cg_code=${cg_code}">&laquo;</a>
								</li>
							</c:if>

							<c:forEach begin="${pm.startPage}" end="${pm.endPage}"
								var="idx">
								<li <c:out value="${pm.cri.page == idx?'class =active':''}"/>>
									<a href="list${pm.makeQuery(idx)}&cg_code=${cg_code}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pm.next && pm.endPage > 0}">
								<li><a href="list${pm.makeQuery(pm.endPage +1)}&cg_code=${cg_code}">&raquo;</a>
								</li>
							</c:if>
						</ul>
					</div>
				</div>
			
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->


 

      </div>
      <!-- /.col-lg-9 -->

    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>	
		 <!-- Footer -->
  <%@ include file="/WEB-INF/views/common/bottom.jsp" %>

  <!-- Bootstrap core JavaScript -->
  <%@ include file="/WEB-INF/views/common/bootjs.jsp" %>

</body>

</html>
