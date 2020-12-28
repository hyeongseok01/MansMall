<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<script type="text/javascript" src="/js/order/buyFromCart.js"></script>
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
		
	<section id="cart-view">
   <div class="container">
     <div class="row">
       <div class="col-md-12">
       
         <div class="cart-view-area">
           <div class="cart-view-table">
           <%-- 주문내역 상단 버튼 --%>
           			 <span style="display: inline-block; float: left; margin:20px 10px 5px 0px;">[주문내역]</span>
          			 <div class="btn-container" style="display: inline-block; float: right; margin:20px 10px 5px 5px;">
							<button id="btn_delete_check"  class="btn btn-dark" >선택 상품 삭제</button>
					   </div>
             <form action="/order/order" id="orderForm" method="post">
               <div class="table-responsive">
                  <table class="table"  id="ordertbl">
                    <thead id="thead">
                      <tr style="font-size: small;">           
							<th><input type="checkbox" id="checkAll" checked="checked"/></th>
							<th>이미지</th>
							<th>상품명</th>
							<th>가격</th>	
							<th>할인금액</th>
							<th>총량</th>
							<th>결제금액</th>
					 </tr>
               		
                 
                   	 <tr>
                        <c:if test="${empty productList}">
                             <td colspan="6">구매할 상품이 존재하지 않습니다.</td> 
                        </c:if>
                     </tr>   
					
                        <%-- 상품이 존재하는 경우,  리스트 출력 --%>
						<%--JSTL 변수 선언 --%>
                      <tbody>
                        <c:forEach items="${productList}" var="productVO"  varStatus="i">
                           <tr id="productVO_${productVO.pdt_num}" class="productRow">
                            <td>
                             	<input type="checkbox" name="check" class="check" value="${productVO.pdt_num}" checked="checked" >
								<input type="hidden" id="amount_${productVO.pdt_num}" name="orderDetailList[${i.index}].odr_amount" value="${amountList[i.index]}" />
								<input type="hidden" name="orderDetailList[${i.index}].pdt_num" value="${productVO.pdt_num}" />
								<input type="hidden" name="orderDetailList[${i.index}].odr_price" value="${productVO.pdt_price-productVO.pdt_discount}" />
							</td>
                            
                            <td>
                           		 <a href="/product/read?pdt_num=${productVO.pdt_num}&cg_code=${cg_code}">
					 				<img src="/product/displayFile?fileName=${productVO.pdt_img}" style="width:100px;">
						   		 </a> 
                            </td>
                            
                            <td>
                            	<a href="/product/read?pdt_num=${productVO.pdt_num}&cg_code=${cg_code}"
									style="color: black;"> ${productVO.pdt_name}   </a>
							</td>
							
                            <td>
                            	<p><fmt:formatNumber value="${productVO.pdt_price}" pattern="###,###,###" /></p>
								<input type="hidden" name="price" value="${productVO.pdt_price}" />
							</td>
							<td>
                            	<p><fmt:formatNumber value="${productVO.pdt_discount}" pattern="###,###,###" /></p>
								<input type="hidden" name="discount" value="${productVO.pdt_discount}" /> 
							</td>
							
							 <td>
                            	<p>${amountList[i.index]} </p>
								<input type="hidden" name="amount" value="${amountList[i.index]}" /> 
							</td>
							<td >
									<p><fmt:formatNumber value="${productVO.pdt_price*amountList[i.index]-productVO.pdt_discount*amountList[i.index]}"  pattern="###,###,###" />원</p>
									<input type="hidden" name="pay" value="${productVO.pdt_price-productVO.pdt_discount}" /> 
							</td>
                            
							
                           </tr>
                         </c:forEach>
                      </tbody>
                  </table>
                  <br><br><br>  
                </div>
             
                <hr style="border-color: black;"><br>
                
                <div>
                <%-- 주문 정보 --%>
				<table class="col-12">
					<tr>[주문 정보]</tr>
					
               	 	<tr class="orderInfo">
                		<td><input type="hidden" class="form-control" id="mb_id" name="mb_id" value="${user.mb_id}"></td>
                	</tr>
                	
                	<tr>
                		<td>* 이름 <input type="text" class="form-control" id="odr_name" name="odr_name" value="${user.mb_name}"></td>
                	</tr>
                	
                	<tr>
						<td>* 휴대폰 번호 <input type="tel" class="form-control" id="odr_phone" name="odr_phone" value="${user.mb_phone}"></td>	
					</tr>
					
					<tr>
						<td>* 주소 
                			 <input type="text" id="sample2_postcode" class="form-control" name="odr_zipcode" value="${user.mb_zipcode}" readonly>
                			 <input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-dark" value="우편번호 찾기">
                			 <input type="text" id="sample2_address"  class="form-control" name="odr_addr" value="${user.mb_addr}" readonly>      
             	    	     <input type="text" id="sample2_detailAddress" class="form-control" name="odr_addr_d" style="max-width: 630px;" value="${user.mb_addr_d}"  >
               	  			 <input type="hidden" id="sample2_extraAddress" class="form-control" placeholder="참고항목">   
                		</td>
					</tr>
                </table>
                 <br><br>
                <hr style="border-color: black;"><br>
                <%-- 결제 방식 선택  및 주문 금액 확인 --%>
                <table class="col-12">
                	<tr>[결제 방식]</tr>
                	<tr>
                		<td><input type="radio" name="payment" value="card" checked="checked">카드 결제</td>
						<td><input type="radio" name="payment" value="tcash">실시간 계좌이체<br></td>
						<td><input type="radio" name="payment" value="phone">휴대폰 결제</td>
						<td><input type="radio" name="payment" value="cash">무통장 입금</td>
                	</tr>
                </table>
                <br><br>
                <span>[결제 금액]</span>
                <table class="table">   
                  <tbody class="text-center">
					<tr >
						<td>총금액</td>
						<td>결제금액</td>
					</tr>
				
					<tr >
						<td><p id="totalPrice">0</p></td>
						<td><p id="totalPay">0</p>
						<input type="hidden" id="odr_totalprice" name="odr_totalprice" value="0"/></td>
					</tr>
							
					<tr>
						<td class="col-md-1" colspan="2" >
						<button id="btn_submit" class="btn btn-flat" type="button" style="padding: 10px 40px; background-color: grey; color:white;">결제하기</button>
						</td>
					</tr>
					</tbody>
				</table> 
               </div>
 
              </form> 
           </div>
         </div>
       
       </div>
     </div>
   </div>
 </section>
   
    <!-- Daum 우편번호 API -->
    <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer'); //getElementById: id 속성을 가진 요소를 찾고, 이를 나타내는 Element 객체를 반환합니다. 

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

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
                    document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>






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
