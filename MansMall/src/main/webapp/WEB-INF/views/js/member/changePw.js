$(document).ready(function(){

    var form = $("#changePwForm");
    var mb_pw= $("#mb_pw");
    var mb_pw_change = $("#mb_pw_change");
    var mb_pw_check= $("#mb_pw_check");

    /*확인 버튼 클릭시*/ 
    $("#btn_submit").on("click", function(){
        //유효성 검사
        if(mb_pw.val() ==null ||mb_pw.val()==""){
            alert("현재 비밀 번호를 입력해주세요.");
            mb_pw.focus();
            return;
        } else if(mb_pw_change.val()==null||mb_pw_change.val()==""){
            alert("변경할 비밀번호를 입력해주세요.");
            mb_pw_change.focus();
            return;
        } else if(mb_pw_change.val()==null||mb_pw_change.val()==""){
            alert("변경할 비밀번호 확인란을 입력해주세요.");
            mb_pw_change.focus();
            return;
        } else if(mb_pw_change.val() != mb_pw_check.val()){
			alert("변경할 비밀번호와 비밀번호 확인 란의 비밀번호가 다릅니다.");
			
			mb_pw_change.val("");
			mb_pw_check.val("");
			mb_pw_change.focus();
            return;
        }    

        // 현재 비밀번호 확인 검사
        var mb_pw_val = mb_pw.val();
        $.ajax({
            url: "/member/checkPwAjax",
            type: "post",
            datatype: "text",
            data: {mb_pw :mb_pw_val},
            success: function(data){
                if(data =='SUCCESS'){
                    form.submit();

                }else{
                    alert("현재 비밀번호가 다릅니다.");
                    mb_pw.val("");
                    mb_pw.focus();

                }
            }
        });
    });

});