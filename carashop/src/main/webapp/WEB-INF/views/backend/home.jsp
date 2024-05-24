<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	href="${classpath}/backend/img/icons/icon-48x48.png" />

<link rel="canonical" href="https://demo-basic.adminkit.io/" />

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
			<!-- navbar -->
			<jsp:include page="/WEB-INF/views/backend/layout/navbar.jsp"></jsp:include>

			<main class="content">
				<div class="container-fluid p-0">
					<div class="row">
						<div class="col-xl-6 col-xxl-5 d-flex">
							<div class="w-100">
								<div class="row">
									<h1 class="h3 mt-1 mb-4">
										<strong>Thống kê</strong>
									</h1>
									<div class="col-sm-6">
										<div class="card">
											<div class="card-body">

												<div class="row">
													<div class="col mt-0">
														<h5 class="card-title">Sản phẩm đã bán</h5>
													</div>

													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="truck"></i>
														</div>
													</div>
												</div>
												<h1 class="mt-1 mb-3">${totalProducts }</h1>
											</div>
										</div>
										<div class="card">
											<div class="card-body">
												<div class="row">
													<div class="col mt-0">
														<h5 class="card-title">Khách hàng</h5>
													</div>

													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="users"></i>
														</div>
													</div>
												</div>
												<h1 class="mt-1 mb-3">${visitors }</h1>
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="card">
											<div class="card-body">
												<div class="row">
													<div class="col mt-0">
														<h5 class="card-title">Doanh thu</h5>
													</div>

													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="dollar-sign"></i>
														</div>
													</div>
												</div>
												<h1 class="mt-1 mb-3">
													<fmt:formatNumber value="${totalSales}" pattern="#,##0₫" />
												</h1>
											</div>
										</div>
										<div class="card">
											<div class="card-body">
												<div class="row">
													<div class="col mt-0">
														<h5 class="card-title">Đơn hàng</h5>
													</div>

													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="shopping-cart"></i>
														</div>
													</div>
												</div>
												<h1 class="mt-1 mb-3">${orders }</h1>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xl-6 col-xxl-7">
							<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
								<li class="nav-item" role="presentation">
									<button class="nav-link active" id="pills-home-tab"
										data-bs-toggle="pill" data-bs-target="#pills-home"
										type="button" role="tab" aria-controls="pills-home"
										aria-selected="true">Thống kê doanh thu</button>
								</li>
								<li class="nav-item" role="presentation">
									<button class="nav-link" id="pills-profile-tab"
										data-bs-toggle="pill" data-bs-target="#pills-profile"
										type="button" role="tab" aria-controls="pills-profile"
										aria-selected="false">Thống kê đơn hàng</button>
								</li>
								<li class="nav-item" role="presentation">
									<button class="nav-link" id="pills-contact-tab"
										data-bs-toggle="pill" data-bs-target="#pills-contact"
										type="button" role="tab" aria-controls="pills-contact"
										aria-selected="false">Thống kê sản phẩm đã bán</button>
								</li>
							</ul>
							<div class="tab-content" id="pills-tabContent">
								<div class="tab-pane fade show active" id="pills-home"
									role="tabpanel" aria-labelledby="pills-home-tab">
									<div class="card flex-fill w-100">
										<div class="card-header">

											<h5 class="card-title mb-0">Thống kê doanh thu</h5>
										</div>
										<div class="card-body py-3">
											<div class="chart chart-sm">
												<canvas id="chartjs-dashboard-revenue"></canvas>
											</div>
										</div>
									</div>
								</div>
								<div class="tab-pane fade" id="pills-profile" role="tabpanel"
									aria-labelledby="pills-profile-tab">
									<div class="card flex-fill w-100">
										<div class="card-header">

											<h5 class="card-title mb-0">Thống kê đơn hàng</h5>
										</div>
										<div class="card-body py-3">
											<div class="chart chart-sm">
												<canvas id="chartjs-dashboard-order"></canvas>
											</div>
										</div>
									</div>
								</div>
								<div class="tab-pane fade" id="pills-contact" role="tabpanel"
									aria-labelledby="pills-contact-tab">
									<div class="card flex-fill w-100">
										<div class="card-header">

											<h5 class="card-title mb-0">Thống kê sản phẩm đã bán</h5>
										</div>
										<div class="card-body py-3">
											<div class="chart chart-sm">
												<canvas id="chartjs-dashboard-product"></canvas>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-xl-12 col-xxl-12"></div>
					</div>

					<div class="row">
						<div class="col-12 col-lg-12 col-xxl-12 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">Top 5 Sản Phẩm Bán Chạy Nhất</h5>
								</div>
								<table class="table table-borderless my-0">
									<thead>
										<tr>
											<th>STT</th>
											<th>Tên sản phẩm</th>
											<th>Hình ảnh</th>
											<th>Số lượng đã bán</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${topSellingProducts}" var="product"
											varStatus="loop">
											<tr>
												<td>${loop.index + 1}</td>
												<!-- Số thứ tự -->
												<td >${product.name}</td>
												<!-- Tên sản phẩm -->
												<td ><img width="40px"
													height="40px"
													src="${classpath}/FileUploads/${product.avatar}"
													alt="${product.name} Image"></td>
												<!-- Hình ảnh -->
												<td >${product.productQuantity}</td>
												<!-- Số lượng đã bán -->
											</tr>
										</c:forEach>
									</tbody>
								</table>

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