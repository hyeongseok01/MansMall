$(document).ready(function(){
	
	var form= $("#loginForm");
	
	//로그인 버튼 클릭시
	$("#btn_login").on("click", function(){
		
		var mb_id = $("#mb_id");
		var mb_pw = $("#mb_pw");
		
		if(mb_id.val()==null || mb_id.val()==""){
			alert("아이디를 입력해주세요.");
			mb_id.focus();
		}else if(mb_pw.val()== null || mb_pw.val()==""){
			alert("비밀번호를 입력해주세요.");
			mb_pw.focus();		
		}else {
			form.submit();
		}
		
	});
	
});