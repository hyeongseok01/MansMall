<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html lang="en">
<head>

<%-- 버튼 클릭 이벤트 메소드 --%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/js/cart/list.js"></script>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
  <title>Shop Homepage - Start Bootstrap Template</title>  
  
  <!-- Bootstrap core CSS -->
  <!-- Bootstrap core JavaScript -->
<%@ include file="/WEB-INF/views/common/bootjs.jsp" %>
  
  
 <!-- Custom styles for this template -->
<%@ include file="/WEB-INF/views/common/bootcss.jsp" %>

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
<div class="content-header">
          
            <%-- realPath 주석 
            <%= application.getRealPath("/") %>
            --%>
            <ol class="breadcrumb">
               <li>장바구니
               <i class="fa fa-dashboard"></i> 
               </li>
            </ol>
      </div>

  <!-- / catg header banner section -->
 
 <!-- Cart view section -->
 <section id="cart-view">
   <div class="container">
     <div class="row">
       <div class="col-md-12">
         <div class="cart-view-area">
           <div class="cart-view-table">
            <form method="post" action="/order/buyFromCart">
         			   <div class="btn-container" style="display: inline-block; float: right; margin:20px 10px 5px 5px;">
							<button id="btn_buy_check"  class="btn btn-primary" type="submit" >선택 상품 구매</button>
							<button id="btn_delete_check"  class="btn btn-default" >선택 상품 삭제</button>
						</div>

               <div class="table-responsive">
                  <table class="table">
                    <thead>
                      <tr style="font-size: x-small;">
                        <th><input type="checkbox" id="checkAll" checked="checked"/></th>
                       <th>No.</th>
					   <th>상품 이미지</th>
			      	   <th>상품명</th>
			           <th>가격</th>
				       <th>할인</th>
					   <th>수량</th>
					   <th>구매/삭제</th>
                      </tr>
                    </thead>
                   
                        <c:if test="${empty cartProductList}">
                            <tr>
                             <td colspan="6">장바구니가 비었습니다.</td>
                            </tr>
                        </c:if>
                        
                        <%-- 상품이 존재하는 경우,  리스트 출력 --%>
						<%--JSTL 변수 선언 --%>
                      
                        <c:set var="i" value="${fn:length(cartProductList)}" />
                        <c:forEach items="${cartProductList}" var="cartProductVO">
                         
                           <tr style="font-size: small;">
                            <td>
                        	 <input type="checkbox" name="check" class="check" value="${cartProductVO.cart_code}" checked="checked" >
							 <input type="hidden" id="pdt_num_${cartProductVO.cart_code}" name="pdt_num" value="${cartProductVO.pdt_num}" >
							 <input type="hidden" name="cart_amount" value="${cartProductVO.cart_amount}" >
							 <input type="hidden" name="cart_code" value="${cartProductVO.cart_code}" >
							 
                            </td>
                            <td>${i}</td>
                            <td><a href="/product/read?pdt_num=${cartProductVO.pdt_num}&cg_code=${cg_code}">
								  <img src="/product/displayFile?fileName=${cartProductVO.pdt_img}" style="width:100px;"></a>
									
							</td>
                            <td><a href="/product/read?pdt_num=${cartProductVO.pdt_num}&cg_code=${cg_code}"
												style="color: black;"> ${cartProductVO.pdt_name} </a>
							</td>
                            <td>
                           		 <p><fmt:formatNumber value="${cartProductVO.pdt_price}" pattern="###,###,###" /></p>
								<input type="hidden" name="price_${cartProductVO.cart_code}" value="${cartProductVO.pdt_price}" />
							</td>
							
                            <td><p>${cartProductVO.pdt_discount}</p>
											<input type="hidden" name="discount_${cartProductVO.cart_code}" value="${cartProductVO.pdt_discount}" />
							</td>
                            <td><input type="number" name="cart_amount_${cartProductVO.cart_code}"
												style="width:60px; height:34px; padding-left:5px;" min="1" value="${cartProductVO.cart_amount}" />
											<button type="button" name="btn_modify" class="btn btn-default" value="${cartProductVO.cart_code}" >변경</button>
							</td>
							<td>
								<button type="button" name="btn_buy" class="btn btn-primary" value="${cartProductVO.cart_code}"
												onclick="clickBuyBtn(${cartProductVO.pdt_num}, ${cartProductVO.cart_code});">구매</button>
								<button type="button" name="btn_delete" class="btn btn-default" value="${cartProductVO.cart_code}" >삭제</button>
							</td>
							<td><input type="hidden" name="totalPay_${cartProductVO.cart_code}" value="${cartProductVO.pdt_price-cartProductVO.pdt_discount}" /></td>
							<c:set var="i" value="${i-1}" ></c:set>
                           </tr>

                          </c:forEach>
                  </table>
                  
                    <input type="hidden" value="cart_delete" name="command">
                </div>
             </form>
              
             
           		<form>
                   <table class="table">
                     <tbody style="text-align: center;" >
                       <tr>                        
                   		  <td> 가격</td>
                          <td> 할인 금액</td>
                          <td>총 결제금액</td>   
                       </tr>
                       
                       <tr>
                       	 <td style="height:50px; text-align: center;"><p id="totalPrice">0</p></td>
						 <td style="height:50px; text-align: center;"><p id="totalDiscount">0</p></td>
						 <td style="height:50px; text-align: center;"><p id="totalPay">0</p></td>
						
                       </tr>
                     </tbody>
                   </table>
                 </form>
              
              
              
           </div>
         </div>
       </div>
     </div>
   </div>
 </section>
 <!-- / Cart view section -->
 
 

 

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
