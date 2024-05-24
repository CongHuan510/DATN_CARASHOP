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

					<h1 class="h1 mb-3" style="font-weight: 700;">Chỉnh sửa đơn hàng</h1>

					<div class="container-fluid">
						<!-- ============================================================== -->
						<!-- Start Page Content -->
						<!-- ============================================================== -->
						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-body">
										<sf:form class="form"
											action="${classpath }/admin/order/edit-save" method="post"
											modelAttribute="saleOrder" enctype="multipart/form-data">

											<div class="form-body">
												<!-- Thực hiện việc sửa với hidden -->
												<sf:hidden path="id" />
												<!-- id > 0 -> Edit -->

												<div class="row">
													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="code">Số đơn hàng</label>
															<sf:input path="code" type="text" class="form-control"
																id="code" name="code" placeholder="Code" readonly="true"></sf:input>
														</div>
													</div>

													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="customerName">Tên khách hàng</label>
															<sf:input path="customerName" type="text"
																class="form-control" id="customerName"
																name="customerName" placeholder="Customer Name"
																readonly="true"></sf:input>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="customerMobile">Số điện thoại</label>
															<sf:input path="customerMobile" type="number"
																id="customerMobile" name="customerMobile"
																class="form-control" placeholder="Customer Mobile"></sf:input>
														</div>
													</div>

													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="customerAddress">Địa chỉ</label>
															<sf:input path="customerAddress" type="text"
																autocomplete="off" id="customerAddress"
																name="customerAddress" class="form-control"
																placeholder="Customer Address"></sf:input>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="total">Thành tiền</label>
															<sf:input path="total" type="number" autocomplete="off"
																id="total" name="total" class="form-control"
																placeholder="total" readonly="true"></sf:input>
														</div>
													</div>

													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="saleOrder">Người tạo</label>
															<sf:select path="userCreateSaleOrder.id"
																class="form-control" id="userCreateSaleOrder">
																<sf:options items="${users }" itemValue="id"
																	itemLabel="username"></sf:options>
															</sf:select>
														</div>
													</div>


												</div>

												<div class="row">
													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="createDate">Ngày tạo</label>

															<sf:input path="createDate" class="form-control"
																type="date" id="createDate" name="createDate"></sf:input>
														</div>
													</div>

													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="updatedate">Ngày giao hàng</label>

															<sf:input path="updateDate" class="form-control"
																type="date" id="updateDate" name="updateDate"></sf:input>
														</div>
													</div>
												</div>
												
												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<label for="message">Ghi chú</label>
															<sf:textarea path="note" id="note" name="note"
																class="form-control" rows="3" placeholder="ghi chú..."></sf:textarea>
														</div>
													</div>
												</div>
												
												<div class="row">
													<div class="col-md-10">
														<div class="form-group mb-4">
															<label for="status">Status:</label>
															<sf:select path="status" class="form-control" id="status" name="status">
															    <option value="PENDING_PROCESSING"
															     <c:if test="${category.status == 'PENDING_PROCESSING'}">
															        selected
															    </c:if>>Chờ xử lý</option>
															    <option value="PROCESSED"
															     <c:if test="${category.status == 'PROCESSED'}">
															        selected
															    </c:if>>Đã xử lý</option>
															    <option value="ON_DELIVERY" 
															     <c:if test="${category.status == 'ON_DELIVERY'}">
															        selected
															    </c:if>>Đang giao hàng</option>
															    <option value="DELIVERED"
															     <c:if test="${category.status == 'DELIVERED'}">
															        selected
															    </c:if>>Đã giao hàng</option>
															</sf:select>
														</div>
													</div>

												</div>
												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<a href="${classpath }/admin/order/list"
																class="btn btn-secondary active" role="button"
																aria-pressed="true">Trở lại</a>
															<button type="submit" class="btn btn-primary">Cập nhật</button>
														</div>
													</div>
												</div>

											</div>
										</sf:form>
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