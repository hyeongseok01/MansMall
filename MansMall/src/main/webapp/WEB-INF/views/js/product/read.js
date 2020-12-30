var replyPage = 1;


$(document).ready(function(){
	
	/* 
	 * 장바구니 버튼 클릭 시 
	 * ajax로 장바구니 추가 DB작업
	 */
	$("#btn_cart").on("click", function(){

		var pdt_num = $("#pdt_num").val(); //상품코드
		var pdt_amount = $("#ord_amount").val();  // 구매수량

		$.ajax({
			url:"/cart/addMany",
			type: "post",
			dataType: "text",
			data: { pdt_num: pdt_num,
					pdt_amount: pdt_amount},
			success: function(data){
				var result = confirm("장바구니에 추가되었습니다.\n지금 확인하시겠습니까?");
				if(result){
					location.href="/cart/list";
				} else{}
			}
		}); 
	});
	
	 /* 
	  * 별점 클릭 시, 색상 변경 
	  */
	 $('#star_grade a').click(function(){
		 $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
		 $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
		     return false;
	 });
	 

	/* 상품후기 쓰기 버튼 클릭 시 */
	$("#btn_write_review").on("click", function() {
		
		var rev_score=0;
		var rev_content = $("#reviewContent").val();
		var pdt_num = $("#pdt_num").val();
		
		// 선택된 별점 개수를 가져옴
		// each는 반복함수  i는 객체의 key값 e는 값을 의미
		$("#star_grade a").each(function(i, e){
			if($(this).attr('class')=='on'){
				rev_score += 1;
			}
		});
		
		// 유효성 검사
		if(rev_score==0){
			alert("별점을 선택해주세요.");
			return;
			
		} else if(rev_content=="" || rev_content==null){
			alert("후기 내용을 입력해주세요.")
			return;
		}
		

		// DB작업
		$.ajax({
			url: '/review/write',
			type:'post',
			dataType:'text',
			data: {
				"rev_score" : rev_score,
				"rev_content": rev_content,
				"pdt_num" : pdt_num
			},
			success : function(data){
				alert("상품후기가 등록되었습니다.");
				// 별점, 상품후기 비움
				$("#star_grade a").parent().children("a").removeClass("on");  
				$("#reviewContent").val("");
				replyPage = 1;
				getPage("/review/" + pdt_num + "/1");
			}
		});
		
	});

	/* 상품 후기 보기 클릭 시 */ 
	$("#repliesDiv").on("click", function() {

		var pdt_num = $("#pdt_num").val();
		
		// 이미 열려있으면, 닫아
		if ($(".timeline li").length > 2) {
			$(".replyLi").remove();
			$(".noReview").hide();
			// 페이지 숨기기
			$(".pagination li").remove();
			return;
		}
		// 열려있지 않으면, 목록 보여줌
		getPage("/review/" + pdt_num + "/1");

	});
	
	
	/* 상품 후기 하단 페이지 부분 클릭 시 - 페이지 이동 */
	$(".pagination").on("click", "li a", function(event) {

		var pdt_num = $("#pdt_num").val();
		
		event.preventDefault();
		
		replyPage = $(this).attr("href");
		getPage("/review/" + pdt_num + "/" + replyPage);

	});

	/* 
	 * Modal 창에 뿌리기
	 * 후기 리스트 ul 태그 밑에 있는 템플릿(li) 클릭 시,
	 * Modal 창의 title, content, rev_num 가져와서 뿌려줌
	 */
	 
	$(".timeline").on("click", "button.modify", function(event) {
		var x= event.clientX;
		var y = event.clientY;
		var pos=$(this).position();
	
		$("#modifyModal").css('top',(pos.top+900)+'px');
		$("#modifyModal").css('left',(pos.left-550)+'px');
		
		
		$("#modifyModal").css("display","");
			var btn = $(this);
			var rev_num = $(this).attr("data-rev_num");
			var rev_score = $(this).attr("data-rev_score");
		
		// 후기 점수 가져오기
		$(".modal-title").val(btn.parent().prev().find('.rev_score').text());
		
		// 후기 평점 가져오기
		$("#star_grade_modal a").each(function(index, item){
			if(index<rev_score){
				$(item).addClass('on');
			} else{
				$(item).removeClass('on');
			}
		});
		
		// 후기 내용 가져오기
		$("#replytext").val(btn.parent().prev().find('#rev_content').text());
		
		// 후기 번호 가져오기
		$(".modal-body").attr("data-rev_num", rev_num);
		
	});
	
	
	 /* 
	  * Modal 창에서 별점 클릭 시, 색상 변경 
	  */
	 $('#star_grade_modal a').click(function(){
		 $(this).parent().children("a").removeClass("on"); 
		 $(this).addClass("on").prevAll("a").addClass("on"); 
		     return false;
	 });	
	 
	 
	 /* modal 창에서 수정버튼 클릭 시 */
	 $("#btn_modal_modify").on("click", function() {

		var rev_num = $(".modal-body").attr("data-rev_num"); 
	 	var rev_content = $("#replytext").val();
	 	var pdt_num = $("#pdt_num").val();

	 	// 선택된 별점 개수를 가져옴
	 	var rev_score = 0;
	 	$("#star_grade_modal a").each(function(i, e){
	 		if($(this).attr('class')=='on'){
	 			rev_score += 1;
	 		}
	 	});
	 	
	 	// DB작업
	 	$.ajax({
	 		url : '/review/modify',
	 		type : 'post',
	 		data : {
	 			"rev_num" : rev_num,
	 			"rev_content" : rev_content,
	 			"rev_score" : rev_score
	 		},
	 		dataType: 'text',
	 		success : function(result) {
 				alert("수정 되었습니다.");
 				getPage("/review/" + pdt_num + "/" + replyPage);
 					$("#modifyModal").css("display","none");
	 		}
	 	});
	 });
	
	/* modal닫기 버튼 클릭시 */
	$("#btn_close").on("click", function(){
		$("#modifyModal").css("display","none"); 
	
	});
	
	
});


/* 
 * 후기 리스트 템플릿 적용 함수 
 * 후기를 DB에서 가져와서 뿌려주는 작업
 */
function getPage(pageInfo) {

	$.getJSON(pageInfo, function(data) {
		
		// 상품후기가 존재
		if(data.list.length>0){
			// 댓글 리스트 템플릿 적용
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));
	
			// 모달 창 숨기고 댓글 카운트
			$("#modifyModal").modal('hide');
			$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");
			
		// 상품후기가 존재하지 않음
		} else{
			printNoData();
			$("#replycntSmall").html("[ 0 ]");
			
		}
	});
}

/*
 * printNoData()
 * : 상품후기 리스트가 존재하지 않을 때 보여줌
 */
var printNoData = function() {
	$(".replyLi").remove();
	$(".noReview").show();
}

/*
 * printData()
 * : 상품후기 리스트를 보여주는 템플릿 적용
 */
var printData = function(replyArr, target, templateObject) {
	var template = Handlebars.compile(templateObject.html());

	var html = template(replyArr);
	$(".replyLi").remove();
	$(".noReview").hide();
	target.after(html);
}


/*
 * printPaging()
 * : 상품후기 리스트의 하단 페이지 부분 작업
 */
var printPaging = function(pageMaker, target) {

	var str = "";

	// 이전
	if (pageMaker.prev) {
		str += "<li><a href='" + (pageMaker.startPage - 1)
				+ "'> << </a></li>";
	}
	// 페이지 인덱스
	for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
		var strClass = pageMaker.cri.page == i ? 'class=active' : '';
		str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
	}
	// 다음
	if (pageMaker.next) {
		str += "<li><a href='" + (pageMaker.endPage + 1)
				+ "'> >> </a></li>";
	}

	target.html(str);
};


/* 상품후기 삭제 버튼 클릭 시 */
var deleteReview = function(rev_num){
	
	var result = confirm("이 상품 후기를 삭제하시겠습니까?");
	if(result){
		$.ajax({
			url: "/review/"+rev_num,
			type: "delete",
			dataType: "text",
			data:{"rev_num" : rev_num},
			success: function(data){
				alert("해당 상품후기가 삭제되었습니다.");
				var pdt_num = $("#pdt_num").val();
				getPage("/review/" + pdt_num+ "/" + replyPage);
			}
		});
	} else {}
	
}



