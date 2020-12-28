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
<script>
if("${msg}" == "CHECK_PW_FAIL"){
	alert("비밀번호가 다릅니다.");
}
</script>

<script>
$(document).ready(function(){
	$("#btn_submit").on("click", function(){
		if($("#mb_pw").val()== null || $("#mb_pw").val()==""){
			alert("비밀번호를 입력해주세요.");
		} else {
			$("#delete").submit();
		}
	});
});
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

 
		<div class="wrapper">
 
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h3>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					회원탈퇴
					<small style="font-size: small;">*곧바로 회원탈퇴 처리됩니다.</small>
				</h3>
				<%-- realPath 주석 
				<%= application.getRealPath("/") %>
				
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> Main</a>
					</li>
				</ol>
				--%>
			</section>

			
			<%-- MAIN CONTENT --%> 
			<section class="content container-fluid">
			 
				<div style="background-color: white; width:70%; padding: 5% 5%;">
					<form id="delete" method="post" action="/member/delete">
						<div class="form-group">

							<input type="password" class="form-control" id="mb_pw" name="mb_pw" class="form-control"
								placeholder="비밀번호를 입력해주세요" style="max-width: 630px;">
						</div>
						<div class="form-group">
							<input type="button" id="btn_submit" class="btn btn-dark" value="확인">
						</div>
					</form>
				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		
		
		
		
		 </div>
     
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

  <!-- Bootstrap core JavaScript -->
  <%@ include file="/WEB-INF/views/common/bootjs.jsp" %>

</body>

</html>
