<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <!-- Bootstrap core JavaScript -->
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/common/bootjs.jsp" %>


<!DOCTYPE html>
<html lang="en">

<head>
	
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=num">
  <meta name="description" content="">
  <meta name="author" content="">
 
  <title>Shop Homepage - Start Bootstrap Template</title>
	
    
   
<script >
	if("${msg}"=="LOGIN_SUCCESS"){
		alert("로그인 되었습니다.\n환영합니다!");
		
	} else if("${msg}"=="LOGOUT_SUCCESS"){
		alert("로그아웃 되었습니다.");
		
	} else if("${msg}"=="REGISTER_SUCCESS"){
		alert("성공적으로 회원가입 되었습니다.\n로그인 해주세요.");
		
	} else if("${msg}"=="MODIFY_USER_SUCCESS"){
		alert("회원 정보가 수정되었습니다.");
		
	} else if("${msg}"=="CHANGE_PW_SUCCESS"){
		alert("비밀번호가 성공적으로 변경되었습니다.");
		
	}  else if("${msg}"=="DELETE_USER_SUCCESS"){
		alert("회원 탈퇴되었습니다. 감사합니다.");
		
	} 

  </script>
  
  <script type="text/javascript">
     var cart_click = function(pdt_num){
        $.ajax({
           url:'/cart/add',
           type:'post',
           dataType:'text',
           data:{pdt_num:pdt_num},
           success:function(data){
              var result = confirm("장바구니에 추가되었습니다.\n지금 확인 하시겠습니까?");
                 if(result){
                    location.href="/cart/list";
              }
           }
        });
     }
  </script>
  
  

  <!-- Bootstrap core CSS -->
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
               <li>모든 상품
               <i class="fa fa-dashboard"></i> 
               </li>
            </ol>
      </div>
        <div class="row">
             
                  <c:if test="${empty productList}">
                     <span style="padding:30px 1px; ">등록된 상품이 존재하지 않습니다.</span>
                  </c:if>
        
          	<c:forEach items="${productList}" var="productVO" >
						<div class="col-lg-4 col-md-6 mb-4" >
							
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
							
							
						</div>
						</c:forEach>
               
          </div>
				<div class="text-center">
					<!-- 페이징 기능 -->
					<ul class="pagination justify-content-center"
						style="display: center-block">
						<c:if test="${pm.prev}">
							<li><a class="page-link"
								href="${pm.makeQuery(pm.startPage-1)}">&laquo;</a></li>
						</c:if>
						<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="idx">
							<li class="page-item"><a
								class="page-link ${pm.cri.page == idx?'page-active':''}"
								href="${pm.makeQuery(idx)}"
								style="margin-top: 0; height: 40px; color: black; border: 1px solid orange;">${idx}</a>
							</li>
						</c:forEach>
						<c:if test="${pm.next && pm.endPage>0}">
							<li><a class="page-link"
								href="${pm.makeQuery(pm.endPage+1)}">&raquo;</a></li>
						</c:if>
					</ul>
				</div>
			</div>

        </div>
        <!-- /.row -->

      </div>
      <!-- /.col-lg-9 -->

    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
  <!-- Footer -->
  <%@ include file="/WEB-INF/views/common/bottom.jsp" %>

</body>

<style type="text/css">
.page-active{
	background-color:orange;
}

</style>
</html>

