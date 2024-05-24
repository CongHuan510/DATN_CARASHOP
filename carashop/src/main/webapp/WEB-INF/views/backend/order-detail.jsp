<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description"
	content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
<meta name="author" content="AdminKit">
<meta name="keywords"
	content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="shortcut icon"
	href="${classpath }/backend/img/icons/icon-48x48.png" />

<link rel="canonical"
	href="https://demo-basic.adminkit.io/pages-blank.html" />

<title>${title }</title>
<!-- variables -->
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
<!-- Custome css resource file -->
<jsp:include page="/WEB-INF/views/backend/layout/css.jsp"></jsp:include>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap"
	rel="stylesheet">


</head>

<body>
	<div class="wrapper">
		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/backend/layout/sidebar.jsp"></jsp:include>

		<div class="main">
			<jsp:include page="/WEB-INF/views/backend/layout/navbar.jsp"></jsp:include>

			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h1 mb-3" style="font-weight: 700;">Chi tiết đơn
						hàng</h1>

					<div class="container-fluid">
						<!-- ============================================================== -->
						<!-- Start Page Content -->
						<!-- ============================================================== -->
						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-body">
										<form class="form" action="${classpath }/admin/order/detail"
											method="get">

											<div class="form-body">
												<div class="row">
													<div class="col-md-12 text-center mb-3">
														<h2>CHI TIẾT ĐƠN HÀNG</h2>
													</div>

													<div class="col-md-6">
														<p>Số đơn hàng : ${saleOrder.code }</p>
													</div>
													<div class="col-md-6">
														<p>Tên khách hàng : ${saleOrder.customerName }</p>
													</div>
													<div class="col-md-6">
														<p>Số điện thoại : ${saleOrder.customerMobile }</p>
													</div>
													<div class="col-md-6">
														<p>Địa chỉ : ${saleOrder.customerAddress }</p>
													</div>

													<table id="zero_config"
														class="table table-striped table-bordered no-wrap">
														<thead>
															<tr align="center">
																<th scope="col">STT</th>
																<th scope="col">Mã sản phẩm</th>
																<th scope="col">Tên sản phẩm</th>
																<th scope="col">Hình ảnh sản phẩm</th>
																<th scope="col">Số lượng</th>
																<th scope="col">Giá bán</th>
																<th scope="col">Thành tiền</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="item" items="${saleOrderProducts }"
																varStatus="loop">
																<tr>
																	<td class="text-center">${loop.index + 1 }</td>
																	<td class="text-center">${item.product.id }</td>
																	<td>${item.product.name }</td>
																	<td class="text-center"><img width="40px"
																		height="40px"
																		src="${classpath }/FileUploads/${item.product.avatar }"
																		class="light-logo"></td>
																	<td class="text-right">${item.quantity}</td>
																	<td class="text-right"><fmt:formatNumber
																			value="${item.product.price}" pattern="#,##0₫" /></td>
																	<td class="text-right"><fmt:formatNumber
																			value="${item.product.price * item.quantity}"
																			pattern="#,##0₫" /></td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
													<div class="col-md-12">
														<p>Ghi chú : ${saleOrder.note }</p>
													</div>

													<div class="col-md-12 text-right">
														<div class="form-group mb-4">
															<h3>
																Tổng thành tiền:
																<fmt:formatNumber value="${totalSales}" pattern="#,##0₫" />
															</h3>
														</div>
													</div>

												</div>

												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<a href="${classpath }/admin/order/list"
																class="btn btn-secondary active" role="button"
																aria-pressed="true">Trở lại</a>
														</div>
													</div>
												</div>

											</div>
										</form>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</main>

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/backend/layout/footer.jsp"></jsp:include>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/backend/layout/js.jsp"></jsp:include>

</body>

</html>