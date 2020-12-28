<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- Handlebar Template --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="subCGListTemplate" type="text/x-handlebars-template">
	{{#each .}}
		<li class="subCate"><a href="/product/list?cg_code={{cg_code}}">{{cg_name}}</a></li>
	{{/each}}
</script>

<%-- 2차 카테고리 템플릿 적용함수 --%>
<script>
	$(document).ready(function(){
		/* 1차 카테고리에 따른 2차 카테고리 작업.   on()메서드: 매번진행 one()메서드: 단1회만 진행 */
		$(".mainCategory").on("click", function(){
			var mainCGCode= $(this).val();
			var url = "/product/subCGList/" + mainCGCode;
			
						
			// REST 방식으로 전송
			$.getJSON(url, function(data){
				// 받은 데이터로 subCategory에 템플릿 적용
				subCGList(data, $("#mainCategory_"+mainCGCode) ,$("#subCGListTemplate"));
				
			});

		});	
	});

	var subCGList = function(subCGStr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());
		var options = template(subCGStr);

		// 기존 option 제거(누적방지)
		//$("#subCategory option").remove();
		$("ul > li.subCate").css("display","none");
		$("mainCategory_${list.cg_code}").css("display","");
		
		target.append(options);
	}
</script>

       <!--  <h1 class="my-4">Shop Name</h1>-->
       <br>
       <br>
        
  <aside class="main-sidebar">
  <section class="sidebar">
        <div class="list-group">
        <ul class="sidebar-menu" data-widget="tree">
        
        <!-- 검색 -->
	 <form action="/product/listSearch" method="get" class="sidebar-form">
		<div class="input-group">
			<input type="hidden" name="searchType" class="form-control" value="name_detail">
			<input type="text" name="keyword" class="form-control" placeholder="상품 검색 "  
				<c:if test="${!empty scri}">
					value="<c:out value='${scri.keyword}' />"
				</c:if>
					>
				<span class="input-group-btn">
				<button type="submit" name="search" id="search-btn" class="btn btn-dark">
						<i class="fa fa-search">확인</i>
				</button>
		     </span>
		  </div>
		</form>
    <div></div> <br>
        <h5 class="header" >CATEGORY</h5>
          <c:forEach items="${userCategoryList}" var="list">
					<li class="treeview mainCategory"  value="${list.cg_code}">
						
							<i class="fa fa-link"></i>
							<span>${list.cg_name}</span>
							<span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
							</span>
						
						<!--  2차카테고리 자식수준으로 추가작업 -->
						<ul class="treeview-menu" id="mainCategory_${list.cg_code}"></ul>
					</li>
				</c:forEach>
				<br><br>
				<hr>
         <li class="nav-item"><a class="nav-link" style ="font-size:medium; color:black;" href="/board/list">회원 게시판</a></li>
          </ul>
        </div>
        </section>
 		</aside>
 		