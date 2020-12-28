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
  <script src="http://code.jquery.com/jquery-latest.js"></script>
  <!-- 유효성검사 -->
  <script type="text/javascript" src="/js/member/modify.js"></script>
  
 <!-- Custom styles for this template -->
<%@ include file="/WEB-INF/views/common/bootcss.jsp" %>

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
		
		
        <div class="row">
		
		<!-- 회원가입 -->
          
    	<div class="col">
    <h2>회원정보수정</h2>
    * 수정하고자하는 정보를 수정해주세요.<br><br><br>
    <form id="modifyForm" action="/member/modify" method="post">
        <table class="table table-boardered">
            <tr>
                <th >아이디</th>
                <td>
                	<input type="text" class="form-control" id="mb_id" name="mb_id" style="max-width:630px;" 
                			value="${vo.mb_id}" readonly="readonly">
				</td>   
            </tr>
            
             <tr>
                <th>패스워드</th>
                <td><input type="password" class="form-control" id="mb_pw"  name="mb_pw" placeholder="현재 비밀번호를 넣어주세요" ></td>      
            </tr>
             
   
            <tr>
            	<th>이름</th>
            	<td><input type="text" class="form-control" id="mb_name" name="mb_name" placeholder="이름을 입력해주세요" style="max-width: 630px;" 
            					value="${vo.mb_name}"  ></td>
            
            </tr>
             <tr>
            	<th>닉네임</th>
            	<td><input type="text" class="form-control" id="mb_nickname" name="mb_nickname" placeholder="이름을 입력해주세요" style="max-width: 630px;" 
            					value="${vo.mb_nickname}" ></td>
            
            </tr>
            
            <tr>
                <th >이메일</th>
                <td>
                	<input type="email" id="mb_email" class="form-control" name="mb_email" placeholder="이메일 주소를 입력해주세요" value="${vo.mb_email}"
                	style="max-width: 526px; width:calc(100% - 115px); margin-right: 5px; display: inline-block;"> 
                	<button id="btn_sendAuthCode" class="btn btn-dark" type="button" >이메일 인증요청</button>
					<p id="authcode_status" style="color: red;"></p>
                 </td>       
            </tr>
             <!-- 이메일 인증 요청을 하고 , 성공적으로 진행이 되면, 아래 div태그가 보여진다. -->
            <tr id="email_authcode" style="display: none;">
             	 <th>이메일 인증코드</th>
             	 <td>
             		 <input type="text" class="form-control" id="mb_authcode" placeholder="이메일 인증코드를 입력해주세요"
             		 style="max-width: 570px; width:calc(100% - 70px); margin-right: 5px; display: inline-block;"/>
             		 <button id="btn_checkAuthCode" class="btn btn-dark" type="button" >확인</button>
             	 </td>
            </tr>
             
            <tr>
                <th>전화번호</th>
                <td><input type="tel" class="form-control" id="mb_phone"  name="mb_phone" value="${vo.mb_phone}"></td>       
            </tr>
             
            <tr>
                <th>주소</th>
                <td>
                	<input type="text" id="sample2_postcode" placeholder="우편번호" class="form-control" name="mb_zipcode" value="${vo.mb_zipcode}"
                	style="max-width: 510px; width:calc(100% - 128px); margin-right: 5px; display: inline-block;">
                	<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-dark" value="우편번호 찾기">
                	<input type="text" id="sample2_address" placeholder="주소" class="form-control" name="mb_addr" style="max-width: 630px; margin:3px 0px;" value="${vo.mb_addr}">      
             	    <input type="text" id="sample2_detailAddress" placeholder="상세주소" class="form-control" name="mb_addr_d" style="max-width: 630px;" value="${vo.mb_addr_d}">
               	    <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">   
                </td>
            </tr>
            
            <tr>
              	<th>수신동의</th>
              	<td>이벤트 등 프로모션 메일 알림 수신에 동의합니다.<br>
           	 	
           	 		<input type="radio" name="mb_accept_e" value="Y" style="margin-left: 20px;" checked="checked"> 예
	       			<input type="radio" name="mb_accept_e" value="N" style="margin-left: 20px;"> 아니오
	       		</td>
            </tr>
  
             
            <tr>
                <td colspan="2" class="text-center">
                <input type="button" id="btn_modify" class="btn btn-dark" value="전송">
                <input type="button" id="btn_cancle" class="btn btn-outline-danger" value="취소">
                </td>
            </tr>
      
        </table>
    </form>
    
    <!-- Daum 우편번호 API -->
    <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer'); //getElementById: id 속성을 가진 요소를 찾고, 이를 나타내는 Element 객체를 반환합니다. 

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
    
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

