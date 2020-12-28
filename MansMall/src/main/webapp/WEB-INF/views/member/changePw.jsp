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
  <!-- Custom styles for this template -->
<%@ include file="/WEB-INF/views/common/bootcss.jsp" %>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- js 참조 파일경로 -->
<script src="/js/member/changePw.js"></script>
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
			
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
		

			
			<%-- MAIN CONTENT --%> 
			<section class="content container-fluid">
				<h3 class="breadcrumb" style="max-width: 230px;">
					비밀번호 변경
				</h3>
			
				<div style="background-color: white; width:80%; padding: 5% 5%;">
					<form id="changePwForm" method="post" action="/member/changePw">
						<div class="form-group">
							
							<input type= "hidden" name="mb_id" value="${sessionScope.user.mb_id}" />
							<div>현재 비밀번호 </div>
							<input type="password" class="form-control" id="mb_pw" class="form-control"
								placeholder="현재 비밀번호를 입력해주세요" style="max-width: 630px;">
							<div>변경할 비밀번호</div>
							<input type="password" class="form-control" id="mb_pw_change" name="mb_pw" class="form-control"
								placeholder="변경할 비밀번호를 입력해주세요" style="max-width: 630px; margin: 7px 0px;">
							<div>비밀번호 확인</div>
							<input type="password" class="form-control" id="mb_pw_check" class="form-control"
								placeholder="변경할 비밀번호를 다시 입력해주세요" style="max-width: 630px;">
						</div>
						<div class="form-group">
							<input type="button" id="btn_submit" class="btn btn-dark" value="확인">
						</div>
					</form>
				</div>
			</section>
			<!-- /.content -->
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

  <!-- Bootstrap core JavaScript -->
  <%@ include file="/WEB-INF/views/common/bootjs.jsp" %>

</body>

</html>

