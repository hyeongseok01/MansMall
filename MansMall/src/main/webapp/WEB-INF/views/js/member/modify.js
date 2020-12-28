$(document).ready(function(){
   
    var form = $("#modifyForm");
    
    // 인증 확인 여부를 위한 변수
	var isCheckEmail = "true";
	 
	/* 이메일 변경 시 이메일 인증 활성화 */
    $("#mb_email").on("change", function(){
		$("#btn_sendAuthCode").show();
		isCheckEmail = "false";		
	});
	
	 /* 이메일 인증 클릭 시 */
	 $("#btn_sendAuthCode").on("click",function(){
	 	var receiveMail = $("#mb_email").val();
		
		if($("#mb_email").val()=="" || $("#mb_email").val()==null ){
			//메시지를 alert() 사용하지 않고, 임의의 위치에 출력하는 형태
			$("#authcode_status").html("이메일을 먼저 입력해주세요.");
			return;
		}
		
	 //현재 작업이 진행중인 메시지를 보여주는 구문.
	 $("#authcode_status").css("color","grey");
	 $("#authcode_status").html('인증코드 메일을 전송중입니다. 잠시만 기다려주세요...');	
	 	
	 $.ajax({
		url: '/email/send',
		type: 'post',
		dataType: 'text',
		data:{receiveMail : receiveMail}, //{key : value}
		success: function(data){
			$("#email_authcode").show();
			$("#authcode_status").css("color","grey");
	 		$("#authcode_status").html('메일이 전송되었습니다.  입력하신 이메일 주소에서 인증코드 확인 후 입력해주세요.');	
		}
	});	
});
	
      /* 인증코드 입력 후 확인 클릭 시 */
	$("#btn_checkAuthCode").on("click",function(){
		var code = $("#mb_authcode").val(); // 메일을 통하여 받았던 인증코드를 보고 입력하면 인증코드를참조 
		
		$.ajax({
			url: '/member/checkAuthCode',
			type: 'post',
			dataType: 'text',
			data: {code : code},
			success:function(data){
			if(data == 'SUCCESS'){
			   $("#email_authcode").hide(); // 인증코드 입력화면 숨김.
			   $("#authcode_status").css("color","blue");
			   $("#authcode_status").html('인증 성공');	
			   $("#mb_email").attr("readonly", true);
			   $("#btn_sendAuthCode").attr("disabled", true);
				isCheckEmail = "true"; // 인증메일 유효성 검사에 사용하기 위한 변수.
				return;
				
			  }	else {
				$("#email_authcode").hide();
				$("#authcode_status").css("color", "red");
				$("#authcode_status").html('인증 실패. 다시 시도해주세요.');
				return;
				
			  }
		 }
	});
		
});
		/* 닉네임 중복체크 기능 */
	$("#btn_checkNick").on("click", function(){
		
			if($("#mb_nickname").val()=="" || $("#mb_nickname").val()==null){
			$("#id_availability").html("닉네임을 먼저 입력해주세요.");
				return;	
			}
		
		var mb_nickname = $("#mb_nickname").val();
		
		$.ajax({
			url: '/member/checkNick',
			type: 'post',
			dataType: 'text',  //  
			data: {mb_nickname : mb_nickname},  // javasciprt object 표현구문.www.w3school.com 참고
			success : function(data){
				if(data== 'SUCCESS'){
					// 사용 가능한 아이디
					$("#nick_availability").css("color", "blue");
					$("#nick_availability").html("사용가능한 닉네임 입니다.");
					// 아이디를 중복체크하고 나서 아이디 텍스트박스 읽기모드, ,중복체크 비활성화
					$("#mb_nickname").attr("readonly", true);
					$("#btn_checkNick").attr("disabled", true);
					
					isCheckNick = "true";  // 아이디 중복체크를 한 용도
				} else {
					// 사용 불가능 - 이미 존재하는 아이디
					$("#nick_availability").html("이미 존재하는 닉네임입니다.. \n다시 시도해주세요.");
				}
			}
		});
	});

	  /* 회원정보수정 버튼 클릭 시 */ 
    $("#btn_modify").on("click",function(){
     
        var mb_id = $("#mb_id");
        var mb_pw = $("#mb_pw");
        var mb_pw_check = $("#mb_pw_check");
		var mb_name = $("#mb_name");
		var mb_nickname = $("#mb_nickname");
        var mb_email = $("#mb_email");
        var mb_authcode = $("#mb_authcode");
        var mb_phone = $("#mb_phone");
        var mb_zipcode = $("input[name='mb_zipcode']");
        var mb_addr = $("input[name='mb_addr']");
        var mb_addr_d = $("input[name='mb_addr_d']");
         
     	 /* 유효성 검사 */
		 if(mb_name.val()==null || mb_name.val()==""){
			alert("이름을 입력해주세요.");
			mb_name.focus();
			return;
		
		} else if(mb_pw.val()==null || mb_pw.val()==""){
			alert("비밀번호를 입력해주세요.");
			mb_pw.focus();
		
		} else if(mb_name.val()==null || mb_name.val()==""){
			alert("이름을 입력해주세요.");
			mem_name.focus();
			return;	
			
		} else if(mb_nickname.val()==null || mb_nickname.val()==""){
			alert("닉네임을 입력해주세요.");
			mb_nickname.focus();
			return;
		
		} else if(mb_email.val()==null || mb_email.val()==""){
			alert("이메일을 입력해주세요.");
			mb_email.focus();
			return;

		} else if(isCheckEmail=="false" && 
					(mb_authcode.val()==null || mb_authcode.val()=="")){
			alert("이메일 인증 확인 후 인증 코드를 입력해주세요.");
			mb_authcode.focus();
			return;

		} else if(isCheckEmail=="false"){
			alert("이메일인증을 해주세요.");
			$("#btn_sendAuthCode").focus();
			return;
		
		} else if(mb_phone.val()==null || mb_phone.val()==""){
			alert("휴대폰 번호를 입력해주세요.");
			mb_phone.focus();
			return;

		} else if(mb_zipcode.val()==null || mb_zipcode.val()==""){
			alert("우편번호를 입력해주세요.");
			$("#btn_postCode").focus();
			return;
			
		} else if(mb_addr.val()==null || mb_addr.val()==""){
			alert("주소를 입력해주세요.");
			$("#btn_postCode").focus();
			return;
			
		} else if(mb_addr_d.val()==null || mb_addr_d.val()==""){
			alert("상세 주소를 입력해주세요.");
			mb_addr_d.focus();
			return;
		}  
		
		// 현재 비밀번호 확인 검사
		var mb_pw_val = mb_pw.val();
		$.ajax({
			url: "/member/checkPwAjax",
			type: "post",
			datatype: "text",
			data: {mb_pw : mb_pw_val},
			success: function(data){
				if(data=='SUCCESS'){
					form.submit();
				} else{
					alert("비밀번호가 다릅니다.");
					mb_pw.val("");
					mb_pw.focus();
				}
			} 
		});
	});
		//취소 버튼 클릭시
		$("#btn_cancle").on("click",function(){
			
			var result = confirm("회원 정보 수정을 취소하시겠습니까?");
			if(result){
				location.href="/";
			}
			
		});
  
});



