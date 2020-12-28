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
	
.btn-orange {
	background-color: orange;
	color: white;
}
.btn-izone {
	background-color: #323232;
	color: white;
}


.container {
  padding: 0 15px;
}

body {
overflow-x:auto; overflow-y:scroll;
}

.page-active{
	background-color:orange;
}


</style>


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
       
		<!-- main-carousel end -->

		
<br><br> 
 
    <!-- Begin Page Content -->
	

	<div class="container">
		<div class="row">
			<div class="col-lg-2">
			</div>
			<div class="col-lg-12">
				<div class="panel-body">
				<h2 class="page-header"><span style="color: orange;">ManSmall</span> 회원 게시판
					<span id="count-per-page" style="float: right;">
	                     <input class="btn btn-izone" type="button" value="10">  
	                     <input class="btn btn-izone" type="button" value="20">   
	                     <input class="btn btn-izone" type="button" value="30">
                     </span>
					
				</h2>
					<table class="table table-bordered table-hover">
						<thead>
							<tr style="background-color: black; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8; font-size:x-small;" >
								<th>번호</th>
								<th>작성자</th>
								<th>제목</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						
						<c:if test="${empty vo}">
							<tr>
								<td colspan="5" align="center">
									<strong>검색 결과가 없습니다!!</strong>
								</td>
							</tr>
						</c:if>

						<!-- 게시물이 들어갈 공간 -->
						
						<c:if test="${vo.size() > 0}">
						<c:forEach var="b" items="${vo}" >
							<tr style="color: gray;">
								<td>${b.brd_num}</td>
								<td>${b.mb_id}</td>

								<td>
									<!--목록으로 돌아갈떄 페이지 정보 실어주기 paging.page로 들어가는 이유는  pagemakervo에 바로 page가 없음. 거쳐서 들어가게 되어있다. -->
									<a style="margin-top: 0; height: 40px; color: orange;" href="<c:url value='/board/content/${b.brd_num}${param.page == null ? pm.makeSearch(1) : pm.makeSearch(param.page)}'/>">
										${b.brd_title}
									</a>
									&nbsp;
									<!-- b.newMark -->
									<c:if test="${b.newMark}">
										<span class="badge badge-pill badge-danger">new</span>
									</c:if>
								</td>

								<td>
									<fmt:formatDate value="${b.brd_date_reg}" pattern="yyyy년 MM월 dd일 a hh:mm" />	   
								</td>
								<td>${b.view_cnt}</td>
							</tr>
						</c:forEach>
						</c:if>
					</table>
					
					<!-- 페이징 처리 부분  -->
					<ul class="pagination justify-content-center">
					<c:if test="${pm.prev}">
                       	<li class="page-item">
							<a class="page-link" href="/board/list${pm.makeSearch(pm.startPage-1)}" 
							style="background-color: black; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">이전</a>
						</li>
					</c:if>	
					<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="idx">
						<li class="page-item" >
						   <a href="/board/list${pm.makeSearch(idx)}" class="page-link ${pm.paging.page == idx?'page-active':''}" style="margin-top: 0; height: 40px; color: black; border: 1px solid orange;">${idx}</a>
						</li>
					</c:forEach> 
					 <c:if test="${pm.next && pm.endPage>0}">
					    <li class="page-item">
					      <a class="page-link" href="/board/list${pm.makeSearch(pm.endPage+1)}" 
					      style="background-color: black; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">다음</a>
					    </li>
					  </c:if>
				    </ul>
					<!-- 페이징 처리 끝 -->
					</div>
				</div>
			</div>
					<!-- 검색 버튼 -->
					<div class="row">
						<div class="col-sm-2"></div>
	                    <div class="form-group col-sm-2">
	                    
	                        <select id="condition" class="form-control" name="searchType">                            	
	                            <option value="title" ${param.searchType == 'title'? 'selected' : ''}>제목</option>
	                            <option value="content" ${param.searchType == 'content'? 'selected' : ''}>내용</option>
	                            <option value="writer" ${param.searchType == 'writer'? 'selected' : ''}>작성자</option>
	                            <option value="titleContent" ${param.searchType == 'titleContent'? 'selected' : ''}>제목+내용</option>
	                        </select>
	                    </div>
	                    <div class="form-group col-sm-4">
	                        <div class="input-group">
	                        <!--EL에서는 jsp의 request.getParameter를 param.으로 대체 가능 -->
	                            <input type="text" class="form-control" name="keyword" value="${param.keyword}" id="keywordInput" placeholder="검색어">
	                            <span class="input-group-btn">
	                                <input type="button" value="검색" class="btn btn-izone btn-flat" id="searchBtn">                                       
	                            </span>
	                        </div>
	                    </div>
	                    <div class="col-sm-2">
							<a href="<c:url value='/board/write'/>" class="btn btn-izone float-right">글쓰기</a>
						</div>
						<div class="col-sm-2"></div>
					</div>
					
		
	</div>
<script>

	//글쓰기 완료 시 띄울 알림창 처리
	const result = "${msg}";
	
	if(result === "regSuccess") {
		alert("게시글 등록이 완료되었습니다.");
	} else if(result === "delSuccess") {
		alert("게시글 삭제가 완료되었습니다.");
	}
	
	//start jquery
	$(function(){
		
		//목록 개수가 변동하는 이벤트 처리
		$("#count-per-page .btn-izone").click(function(){
			let count = $(this).val();
			const keyword = "${param.keyword}";
			const searchType = "${param.searchType}";
			location.href="/board/list?page=1&countPerPage=" + count
							+"&keyword="+keyword
							+"&searchType="+searchType;
		});
		
		//검색 버튼 이벤트 처리
		$("#searchBtn").click(function(){
			console.log("검색 버튼이 클릭됨!");
			const keyword = $("#keywordInput").val();
			console.log("검색어:"+keyword);
			const searchType =  $("#condition option:selected").val();
			location.href="/board/list?keyword="+keyword
					+"&searchType="+searchType;
			
		});
		//엔터키 입력 이벤트
		$("#keywordInput").keydown(function(key){
			if(key.keyCode == 13){ //키가 13이면 실행(엔터는 13)
				$("#searchBtn").click();
			}
			
		});
		
		
		
	});//end jQuery


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
