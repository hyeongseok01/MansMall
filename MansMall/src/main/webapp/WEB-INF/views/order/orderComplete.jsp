<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script type="text/javascript" src="/js/order/orderComplete.js"></script>
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
					상품구매 <small>주문내역</small>
				</h1>
			</section>

			
			<%-- MAIN CONTENT --%> 
			<section class="content container-fluid">
				<div class="box" style="border: none; padding:200px 50px; text-align: center;">
					<div class="box-body"  >
						<h3>해당 상품의 주문이 완료되었습니다.</h3><br>
						<button type="button" id="btn_orderList" class="btn btn-primary">주문내역 확인</button>
						<button type="button" id="btn_main" class="btn btn-default">쇼핑 계속하기</button>
					</div>
				</div>
			</section>
		</div>			
   
    




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
