<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>


  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
 <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
  <title>Shop Homepage - Start Bootstrap Template</title>  
  
  <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
  <!-- Bootstrap core CSS -->
  <!-- Bootstrap core JavaScript -->
<%@ include file="/WEB-INF/views/common/bootjs.jsp" %>
  
  
 <!-- Custom styles for this template -->
<%@ include file="/WEB-INF/views/common/bootcss.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript" src="/js/product/read.js"></script>

<%-- 템플릿: 상품목록 --%>
<script id="template" type="text/x-handlebars-template">
	
{{#each .}}
		<li class="replyLi" data-rev_num={{rev_num}}>
        	<i class="fa fa-comments bg-blue"></i>
            <div class="timeline-item" >
                <span class="time">
                	<i class="fa fa-clock-o"></i>{{prettifyDate rev_date_reg}}
                </span>
                <h3 class="timeline-header">
					<strong>{{checkRating rev_score}}</strong> 
					</h3>
                <div class="timeline-body">
					<p style="float:right;">작성자: {{mb_id}}</p> <br>
					<p id='rev_content'>{{rev_content}}</p> </div>
				<div class="timeline-footer" style="float:right;">
					{{eqReplyer mb_id rev_num rev_score}}
				</div>
	         </div>			
         </li>
	{{/each}}

</script>

<%-- 버튼 클릭 이벤트 메소드/ 핸들바 사용자 정의 헬퍼 --%>
<script>
	$(document).ready(function(){

		/* 상품 목록 버튼 클릭 시 */
		$("#btn_list").on("click", function(){
			location.href="/product/list${pm.makeQuery(1)}&cg_code=${vo.cg_code}";
		});

		/* 
		 * 사용자 정의 헬퍼(prettifyDate)
		 * : 매개변수로 받은 timeValue를 원하는 날짜 형태로 바꿔준다.
		 */ 
		Handlebars.registerHelper("prettifyDate", function(timeValue) {
			var dateObj = new Date(timeValue);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth() + 1;
			var date = dateObj.getDate();
			return year + "/" + month + "/" + date;
		});

		/* 
		 * 사용자 정의 헬퍼(checkRating)
		 * : 매개변수로 받은 후기 평점을 별표로 출력
		 */ 
		Handlebars.registerHelper("checkRating", function(rating) {
			var stars = "";
			switch(rating){
				case 1:
					 stars="★☆☆☆☆";
					 break;
				case 2:
					 stars="★★☆☆☆";
					 break;
				case 3:
					 stars="★★★☆☆";
					 break;
				case 4:
					 stars="★★★★☆";
					 break;
				case 5:
					 stars="★★★★★";
					 break;
				default:
					stars="☆☆☆☆☆";
			}
			return stars;
		});

		/* 
		 * 사용자 정의 헬퍼(eqReplyer)
		 * : 로그인 한 아이디와 리뷰의 아이디 확인 후, 수정/삭제 버튼 활성화 
		 */ 
		Handlebars.registerHelper("eqReplyer", function(replyer, rev_num, rev_score) {
			var btnHtml = '';
			var mb_id = "${sessionScope.user.mb_id}";
			if (replyer == "${user.mb_id}") {
				btnHtml = "<button class='btn btn-primary btn-sm modify'"
					  + " data-rev_num='"+rev_num+"' "+ " data-rev_score='"+rev_score+"' >"
					  + "MODIFY</button>"
					  + "<button class='btn btn-danger btn-sm' style='margin-left:5px;'" 
					  + "onclick='deleteReview("+rev_num+");'"
					  + "type='button' >DELETE</button><hr>"; 
			}
			return new Handlebars.SafeString(btnHtml);
			

		});
				
	});
</script>



<%-- 스타일 --%>
<style>
     #star_grade a{
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade a.on{
        color: orange;
    }
    
    #star_grade_modal a{
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade_modal a.on{
        color: orange;
    }
    
    .popup {position: absolute;}
    .back { background-color: gray; opacity:0.5; width: 100%; height: 300%; overflow:hidden;  z-index:1101;}
    .front { 
       z-index:1110; opacity:1; boarder:1px; margin: auto; 
      }
     .show{
      
      
       overflow: auto;       
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
	

		<%-- MAIN CONTENT --%>
			<section class="content container-fluid">

				<!-- 상품등록 폼 -->
				<div class="row">
					<!-- left column -->
					<div class="col-md-12">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-header">
							<br>
								<h3 class="box-title">PRODUCT DETAIL</h3>
							</div>
							<!-- /.box-header -->
							
							<%-- 상품 상세 정보 출력 --%>
							<div class="box-body">
								<div class="form-group container" style="margin:30px 0px; height:350px;" >
									<div style="float:left; width:30%; height:100%;">
										<img src="/product/displayFile?fileName=${vo.pdt_img}" style="display: inline; width:90%;">
									</div>
									<div style="display: inline-block; margin-left:20px;">
										<label for="exampleInputEmail1">상품명</label><br>
										<span>${vo.pdt_name}</span><br><br>
										
										<label for="exampleInputEmail1">회사명</label><br>
										<span>${vo.pdt_company}</span><br><br>
										
										<div>
											<label for="exampleInputEmail1" style="width:100px; margin-right:10px;">가격</label> 
											<label for="exampleInputEmail1" style="width:100px;">할인가</label> <br>
											<span style="width:100px; margin-right:10px; display:inline-block;">
												<fmt:formatNumber value="${vo.pdt_price}" pattern="###,###,###" />원
											</span>
											<span style="width:100px; display:inline-block;">
												<fmt:formatNumber value="${vo.pdt_price-vo.pdt_discount}" pattern="###,###,###" />원
											</span>
										</div>
										<br>
										
										<div>
											<form method="get" action="/order/buy" >
												<label for="exampleInputEmail1">Amount</label><br>
												<input type="number" id="ord_amount" name="ord_amount" min="1" value="1" /><br><br>
												<input type="hidden" id="pdt_num" name="pdt_num" value="${vo.pdt_num}" />
												<button type="submit" id="btn_buy" class="btn btn-primary">Buy</button>
												<!-- 장바구니 기능으로 진행 -->
												<button type="button" id="btn_cart" class="btn btn-default">Cart</button>
											</form>
										</div>
										
									</div>
								</div>
								<!-- 상품 상세 -->
								<label for="detail">Detail</label><br>
								<div contenteditable="false" style="border: 1px solid grey; padding: 20px;">
									${vo.pdt_detail}
								</div>
								<br>
								
								<%-- 상품 후기 --%>
								<div class='popup back' style="display:none;"></div>
							    <div id="popup_front" class='popup front' style="display:none;">
							     	<img id="popup_img">
							    </div>
						    	<form role="form" action="modifyPage" method="post">
						    	<%-- 
									<input type='hidden' name='bno' value="${boardVO.bno}">
									<input type='hidden' name='page' value="${cri.page}"> 
									<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
									
									<input type='hidden' name='searchType' value="${cri.searchType}">
									<input type='hidden' name='keyword' value="${cri.keyword}">
									 --%>
								</form>
								
								<div>
									<!-- 상품후기쓰기 부분 -->
									 <div class="card">
										<label for="review">Review</label><br>
										<div class="rating">
											<p id="star_grade">
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
											</p>
										</div>
										<textarea id="reviewContent" rows="3" style="width:100%;"></textarea><br>
									
										<!-- 상품 후기 리스트 -->
									 	<ul class="timeline" >
				 							 <!-- timeline time label -->
											<li class="time-label" id="repliesDiv">
												<span class="btn btn-default">
											    	상품후기 보기 <small id='replycntSmall'> [ ${totalReview} ] </small>
											    </span>
											    <button class="btn btn-primary" id="btn_write_review" type="button">상품후기쓰기</button>
											</li>
											<li class="noReview" style="display:none;">
												<i class="fa fa-comments bg-blue"></i>
												<div class="timeline-item" >
													 <h3 class="timeline-header">
														상품후기가 존재하지 않습니다.<br>
														상품후기를 입력해주세요.</h3>
											   </div>
											</li> 
										 </ul>
									  </div>
									
										 <br>
									  <br>
								  <br>
										<!-- 상품 후기 리스트 페이지부분 -->  
										<div class="pagination justify-content-center" style="display:center-block">
											<ul id="pagination"  class="pagination pagination-sm no-margin "></ul>
									 	</div>
	
									 <%-- Modal : 상품후기 수정/삭제 팝업 --%>
									<div id="modifyModal"  role="dialog" style="display: none; position:absolute; width:500px; ">
									  <div class="modal-dialog">
									    <!-- Modal content-->
									    <div class="modal-content">
									      <div class="modal-header" >
									       
									        <div class="modal-title">
												<p id="star_grade_modal">
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
												</p>
									        </div>
									      </div>
									      <div class="modal-body" data-rev_num>
									        <p><input type="text" id="replytext" class="form-control"></p>
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-info" id="btn_modal_modify" >MODIFY</button>
									        <button type="button" class="btn btn-default" data-dismiss="modal" id="btn_close">CLOSE</button>
									      </div>
									    </div>
									  </div>
									</div>      
								</div>
							
							
							<!-- /.box-body -->

							<div class="box-footer">
								<div>
									<hr>
								</div>

								<ul class="mailbox-attachments clearfix uploadedList">
								</ul>

								<button id="btn_list" type="button" class="btn btn-primary" >GO List</button>
							</div>
						
						</div>
						<!-- /.box -->	
					</div>
					<!--/.col (left) -->

				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

 

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
