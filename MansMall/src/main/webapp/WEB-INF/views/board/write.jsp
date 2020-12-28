<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 포맷팅 관련 태그라이브러리(JSTL/fmt) --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="en">
<head>

<%-- 버튼 클릭 이벤트 메소드 --%>
<script src="http://code.jquery.com/jquery-latest.js"></script>


  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function(){
	var form = $("#writeForm");
	
	$("#btnRegister").on("click",function(){
		
	var brd_title = $("input[name='brd_title']");
	var brd_content = $("#brd_content");
	
	if(brd_title.val() == null|| brd_title.val()== ""){
		alert("제목을 입력해주세요");
		brd_title.focus();
	}else if(brd_content.val() == null|| brd_content.val()==""){
		alert("내용을 입력해주세요");
		brd_content.focus();
	
	}else{
		form.submit();
	}
  });
	
});
</script>    
  
  <!-- Bootstrap core CSS -->
  <!-- Bootstrap core JavaScript -->
<%@ include file="/WEB-INF/views/common/bootjs.jsp" %>
  
  
 <!-- Custom styles for this template -->
<%@ include file="/WEB-INF/views/common/bootcss.jsp" %>
<style>
header.masthead {
	
	display: none;
}	
</style>


</head>

<body>

  <!-- Navigation -->
  <%@ include file="/WEB-INF/views/common/top.jsp" %>

  <!-- Page brd_content -->
  <div class="container">

    <div class="row">
	<!-- 카테고리 메뉴 -->
      <div class="col-lg-3">

    	<%@ include file="/WEB-INF/views/common/category.jsp" %>

      </div>
      <!-- /.col-lg-3 -->

        <div class="col-lg-9">
		<!-- main-carousel begin  -->
       
		<!-- main-carousel end -->
	
<br/><br/>
<div class="container">

<div class="row">
  <div class="col-lg-12">
    <div class="card">
      <div class="card-header text-white" style="background-color:#464646;"> 게시글 등록</div>
      <div class="card-body">

        <form id="writeForm" method="post" action="/board/write">
        
          <div class="form-group" hidden="hidden">
            <label>작성자</label>
            <input type="hidden" class="form-control" name='mb_id' value="${user.mb_id}">
          </div>
          
          <div class="form-group">
            <label>제목</label>
            <input type="text" class="form-control" name="brd_title" id="brd_title">
          </div>

          <div class="form-group">
            <label>내용</label>
            <textarea class="form-control" rows="5" name="brd_content" id="brd_content" placeholder="게시글 내용을 입력하세요."></textarea>
          </div>

         <input type="button" value="등록" class="btn form-control" id="btnRegister"
			style="background-color: #323232; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">
          &nbsp;&nbsp;
          <a class="btn form-control"	href="/board/list"
		style="cursor: pointer; margin-top: 0; height: 40px; color: white; background-color: #FF5675; border: 0px solid #388E3C; opacity: 0.8">취소</a>
        </form>

      </div>
    </div>
  </div>
</div>
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
