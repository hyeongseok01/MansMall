<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 

<style>

.navbar-brand{
 font-weight: bold;
 font-size: x-large;
 font-variant:inherit;
}

</style>
</head>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
       <a class="navbar-brand" href="/" >ManS Mall</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
           
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <%-- 로그인 안 한 상태 --%>
		<c:if test="${sessionScope.user == null}">
          <li class="nav-item">
            <a class="nav-link" style ="font-size:x-small;  color: white; "  href="/member/join">회원가입</a>
           </li>
           <li> 
            <a class="nav-link" style ="font-size:x-small; color: white;" href="/member/login">로그인</a>
          </li>
         </c:if>
          	<%-- 로그인 한 상태 --%>
		 <c:if test="${sessionScope.user != null}"> 
		 <li class="nav-item"> 
			<li class="nav-item"><p class="nav-link" style ="font-size:x-small; color: white;">${sessionScope.user.mb_name}님</p></li>
          	<li class="nav-item"><a class="nav-link" style ="font-size:x-small; color: white;" href="/member/logout">로그아웃</a></li>
			<li class="nav-item"><a class="nav-link" style ="font-size:x-small; color: white;" href="/member/checkPw?url=modify">회원정보 수정</a></li>
			<li class="nav-item"><a class="nav-link" style ="font-size:x-small; color: white;" href="/member/checkPw?url=changePw">비밀번호 변경</a></li>
			<li class="nav-item"><a class="nav-link" style ="font-size:x-small; color: white;" href="/member/delete">회원 탈퇴</a></li>
			<li class="nav-item"><a class="nav-link" style ="font-size:x-small; color: white;" href="/cart/list">장바구니</a></li>
			<li class="nav-item"><a class="nav-link" style ="font-size:x-small; color: white;" href="/order/list">주문조회</a></li>
		
          </c:if>
        </ul>
      </div>
    </div>
  </nav>