<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<%@ include file="/WEB-INF/views/admin/include/plugins.jsp" %>
<%@include file="/WEB-INF/views/admin/include/head.jsp" %>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="canonical"
	href="https://getbootstrap.com/docs/3.4/examples/signin/">

<title>ADMIN SIGNIN</title>

<head>
<script>
	$(document).ready(function(){
	
		
		//배송현황 변경 버튼 클릭 시
		$("button[name=btn_modify]").on("click",function() {
				var odr_code = $(this).val();  
				var delivery = $("select[name='delivery_"+odr_code+"']").val();
				
				$.ajax({
					url : "/admin/order/modify",
					type : "post",
					dataType : "text",
					data : {
						odr_code : odr_code,
						delivery : delivery
					},
					success : function(data) {
						alert("배송현황이 변경되었습니다.");
						location.href="/admin/order/orderList${pm.makeQuery(pm.cri.page)}";
					}
				});

			});
	});
</script>


</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
		<%@include file="/WEB-INF/views/admin/include/main_header_admin.jsp" %>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/views/admin/include/left_admin.jsp" %>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					주문리스트 <small>orderList</small>
				</h1>
				
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
		        | Your Page Content Here |
		        -------------------------->

				<div class="row">
					<!-- left column -->
					<%-- 검색 조건 설정 및 페이지 이동에도 해당 값 유지 --%>
					<div class="col-md-12">
						

						<div class="box" style="border: none;">
							<div class="box-body">
							
								<table class="table table-striped text-center">
									<tr>
										<th>주문번호</th>
										<th>아이디</th>
										<th>이름</th>
										<th>총가격</th>
										<th>주문일</th>
										<th>배송현황</th>
										<th>배송현황변경</th>
									</tr>
								<tbody>
		                	<c:if test="${empty orderList}">
					    		<tr>
									<td colspan="10"> 
										
										<p>등록된 배송 정보가 존재하지 않습니다.</p>
									</td>
									
								</tr>
					   		 </c:if>
									<%-- 주문 리스트 출력 --%>
									<c:forEach items="${orderList}" var="orderVO">
										<tr>
											<td class="col-md-2"><a	href="/admin/order/orderRead${pm.makeQuery(pm.cri.page)}&odr_code=${orderVO.odr_code}"
												style="color: black;"> [${orderVO.odr_code} 상세보기]</a></td>
											<td class="col-md-1">${orderVO.mb_id}</td>
											<td class="col-md-1">${orderVO.odr_name}</td>
											<td class="col-md-1"><p><fmt:formatNumber value="${orderVO.odr_totalprice}" pattern="###,###,###" />원</p></td>
											<td class="col-md-2"><p><fmt:formatDate value="${orderVO.odr_date}" pattern="yyyy.MM.dd HH:mm:ss"/></p></td>
											<td class="col-md-2">${orderVO.delivery}</td>
											<td>
											<!-- 배송 현황(보임/숨김)기능 -->
												<select class="form-control" name="delivery_${orderVO.odr_code}" style="width: 120px; display: inline-block;">
												  <option>배송준비</option>
												  <option>배송중</option>
												  <option>배송완료</option>
												</select>
												<button type="button" name="btn_modify" class="btn btn-primary" value="${orderVO.odr_code}" >변경</button>
											</td>
											<td class="col-md-1"><input name="delivery_${orderVO.odr_code}" type="hidden" style="width:80px; height:34px; padding-left:5px;" value="${orderVO.delivery}" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							</div>
							<!-- /.box-body -->


							<!-- 페이징 기능 -->
							<div class="box-footer">

								<div class="text-center">
									<ul class="pagination">
										<!-- 이전표시 여부  [이전] -->
										<c:if test="${pm.prev}">
											<li><a href="orderList${pm.makeQuery(pm.startPage-1)}">&laquo;</a>
											</li>
										</c:if>
										<!-- 페이지목록번호 :  1  2  3  4  5  -->
										<c:forEach begin="${pm.startPage}" end="${pm.endPage}"
											var="idx">
											<li <c:out value="${pm.cri.page == idx?'class =active':''}"/>>
												<a href="orderList${pm.makeQuery(idx)}">${idx}</a>
											</li>
										</c:forEach>
										<!-- 다음표시 여부  [다음]-->
										<c:if test="${pm.next && pm.endPage > 0}">
											<li><a href="orderList${pm.makeQuery(pm.endPage +1)}">&raquo;</a>
											</li>
										</c:if>

									</ul>
								</div>

							</div>
							<!-- /.box-footer-->
						</div>
					</div>
					<!--/.col (left) -->

				</div>

			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->


		<!-- Main Footer -->
		<%@ include file="/WEB-INF/views/admin/include/main-footer.jsp" %>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Create the tabs -->
			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li class="active">
					<a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a>
				</li>
				<li>
					<a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a>
				</li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane active" id="control-sidebar-home-tab">
					<h3 class="control-sidebar-heading">Recent Activity</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;"> <i class="menu-icon fa fa-birthday-cake bg-red"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

									<p>Will be 23 on April 24th</p>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

					<h3 class="control-sidebar-heading">Tasks Progress</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;">
								<h4 class="control-sidebar-subheading">
									Custom Template Design
									<span class="pull-right-container">
										<span class="label label-danger pull-right">70%</span>
									</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
				<!-- /.tab-pane -->
				<!-- Settings tab content -->
				<div class="tab-pane" id="control-sidebar-settings-tab">
					<form method="post">
						<h3 class="control-sidebar-heading">General Settings</h3>

						<div class="form-group">
							<label class="control-sidebar-subheading">
								Report panel usage
								<input type="checkbox" class="pull-right" checked>
							</label>

							<p>Some information about this general settings option</p>
						</div>
						<!-- /.form-group -->
					</form>
				</div>
				<!-- /.tab-pane -->
			</div>
		</aside>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->


</body>
</html>