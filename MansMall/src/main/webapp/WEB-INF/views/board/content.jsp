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
      <div class="card-header text-white" style="background-color: #464646;">${vo.brd_num}번 게시물 내용</div>
      <div class="card-body">

       
        
          <div class="form-group">
            <label>작성자</label>
            <input type="text" class="form-control" name='mb_id' value="${vo.mb_id}" readonly>
          </div>
          
          <div class="form-group">
            <label>제목</label>
            <input type="text" class="form-control" name='brd_title' value="${vo.brd_title}" readonly>
          </div>

          <div class="form-group">
            <label>내용</label>
            <textarea class="form-control" rows="5" name='brd_content' readonly>${vo.brd_content}</textarea>
          </div>

         
        <form id="formObj" role="form" action="<c:url value='/board/delete'/>" method="post">  
          
          <input type="hidden" name="brd_num" value="${vo.brd_num}">
          <input type="hidden" name="page" value="${p.page}">
          <input type="hidden" name="countPerPage" value="${p.countPerPage}">
          
          <input type="button" value="목록" class="btn" id="list-btn"
		style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">&nbsp;&nbsp;
          
          
          <c:if test="${user.mb_id == vo.mb_id}">
	          <input id="modBtn" type="button" value="수정" class="btn btn-warning" style="color:white;">&nbsp;&nbsp;
	          
	          <input type="submit" value="삭제" class="btn btn-danger" onclick="return confirm('정말로 삭제하시겠습니까?')">&nbsp;&nbsp;
          </c:if>
        </form>

      </div>
    </div>
  </div>
</div>
</div>

<script>
	
	// 수정 완료 알림창 처리 "${msg}";를 제이쿼리가 아닌 el로 처리
	const msg =  "${msg}";
	if(msg == "modSuccess"){
		alert("게시물 수정 완료!");
	}
	
	// 제이쿼리의 시작
	$(function(){
		
	// 변수는 let, 상수는 const로 선언(ES2015문법)
	const formElement= $("#formObj")
	
	// 목록버튼 클릭이벤트 처리 (페이지 정보를 내용에서 다시 목록으로 보내주기 위한 처리.)
	$("#list-btn").click(function(){
		console.log("목록 버튼이 클릭됨!");
		location.href ='/board/list?page=${p.page}'
						+'&countPerPage=${p.countPerPage}'
						+'&keyword=${p.keyword}'
						+'&searchType=${p.searchType}';
	});
	// 수정버튼의 이벤트 처리
	var modifyBtn = $("#modBtn");
	
	modifyBtn.click(function(){
		console.log("수정 버튼이 클릭됨!");
		formElement.attr("action","/board/modify");  //attr(속성, 변경값) form이 현지 url이 delete , method가 post로 된걸 바꾸려고 함
		formElement.attr("method","get");
		formElement.submit();
		});
		
		
	});// 제이쿼리의 끝

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
