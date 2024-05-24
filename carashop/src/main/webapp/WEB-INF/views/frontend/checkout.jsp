<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title }</title>
<link rel="icon" type="image/x-icon"
	href="${classpath }/frontend/img/favicon.webp">
<!-- variables -->
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
<!-- Css -->
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>

</head>

<body>
	<!-- Toast -->
	<jsp:include page="/WEB-INF/views/frontend/layout/toast.jsp"></jsp:include>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

	<section class="section-m1" style="margin-bottom: 0px !important;">
		<div class="container">
			<div class="row">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${classpath }/index">Trang
								chủ</a></li>
						<li class="breadcrumb-item active" aria-current="page">Đặt
							hàng</li>
					</ol>
				</nav>
			</div>
		</div>
	</section>

	<section id="cart" class="section-p1"
		style="padding-top: 0px !important;">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<!-- Thông tin khách hàng và thanh toán -->
					<div>
						<form action="/vnpay-payment-page" method="post">
							<div class="row">
								<div class="col-12 col-md-8 page-breadcrumb">
									<div class="row">
										<div id="custom-info" class="col-md-12">
											<div class="main_products-title text-center">
												<h3>Thông tin khách hàng</h3>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<label for="txtName">Tên khách hàng (*)</label> <input
															type="text" class="form-control" id="txtName"
															name="txtName" placeholder="your name"
															value="${loginedUser.name }" />
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<label for="txtMobile">Số điện thoại (*)</label> <input
															type="text" class="form-control" id="txtMobile"
															name="txtMobile" placeholder="your phone number"
															value="${loginedUser.mobile }" />
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<label for="txtEmail">Email</label> <input type="email"
															class="form-control" id="txtEmail" name="txtEmail"
															placeholder="your email" value="${loginedUser.email }" />
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<label for="txtAddress">Địa chỉ</label> <input type="text"
															class="form-control" id="txtAddress" name="txtAddress"
															placeholder="your address"
															value="${loginedUser.address }" />
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<label for="txtNote">Ghi chú</label>
														<textarea cols="30" rows="10" placeholder="Ghi chú"
															class="form-control" id="txtNote" name="txtNote"
															style="height: 150px;"></textarea>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<a href="${classpath }/cart-view" class="normal"
															role="button" aria-pressed="true"><i
															class="fa-solid fa-arrow-left"></i> Trở lại </a>
													</div>
												</div>
											</div>

										</div>										
									</div>
								</div>
								<div class="col-12 col-md-4 cartotal">
									<div id="subtotal">
										<h3>Đơn hàng</h3>
										<table>
											<thead>
												<tr>
													<th>Sản phẩm</th>
													<th style="text-align: right;">Tổng tiền</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${cart.productCarts }"
													varStatus="loop">
													<tr>
														<td>${item.productName }<strong>, ${item.size }</strong>
															<strong id="productQuantity_${item.productId}">×${item.quantity}</strong>
														</td>
														<td align="right"><span> <fmt:formatNumber
																	value="${item.price * item.quantity }" pattern="#,##0₫" />
														</span></td>
													</tr>
												</c:forEach>
											</tbody>
											<tfoot>
												<tr>
													<th>Tạm tính</th>
													<td align="right"><span> <fmt:formatNumber
																value="${totalCartPrice }" pattern="#,##0₫" />
													</span></td>
												</tr>
												<tr>
													<th>Tổng thành tiền</th>
													<td align="right"><span> <fmt:formatNumber
																value="${totalCartPrice }" pattern="#,##0₫" />
													</span></td>
												</tr>
											</tfoot>
										</table>
										<div id="payment-method">
											<label for="txtName">Phương thức thanh toán(*)</label>
											<div class="payments-method-item">
												<input id="cod" type="radio" name="paymentMethod"
													value="0"> <label for="cod">Thanh toán khi nhận hàng
												</label>
											</div>
											<div class="payments-method-item">
												<input id="vnpay" type="radio" name="paymentMethod"
													value="1"> <label for="vnpay">Thanh toán với VNPay
												</label>
											</div>
										</div>

										<button class="normal" onclick="_placeOrder(event)">Đặt
											hàng</button>


										<div class="modal fade" id="statusSuccessModal" tabindex="-1"
											role="dialog" data-bs-backdrop="static"
											data-bs-keyboard="false">
											<div class="modal-dialog" role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title text-white">Chi tiết hóa đơn</h5>
														<button type="button" class="close" data-dismiss="modal"
															aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>
													<div class="modal-body">
														<div class="Info-customer text-center mt-3">
															<h1 class="text-uppercase">${loginedUser.name }</h1>
															<p>Hotline: ${loginedUser.mobile }</p>
															<p>${loginedUser.address }</p>
														</div>
														<h2 class="text-center text-uppercase">Hóa đơn bán
															hàng</h2>
														<table>
															<thead>
																<tr>
																	<th scope="col">Sản phẩm</th>
																	<th scope="col" class="text-center">Số lượng</th>
																	<th scope="col" class="text-right">Đơn giá</th>
																	<th scope="col" class="text-right">Thành tiền</th>
																</tr>
															</thead>
															<tbody>

																<c:forEach var="item" items="${cart.productCarts }"
																	varStatus="loop">
																	<tr>
																		<td><strong>${item.productName }</strong>,
																			${item.size }</td>
																		<td align="center">${item.quantity }</td>
																		<td align="right"><fmt:formatNumber
																				value="${item.price }" pattern="#,##0₫" /></td>
																		<td align="right"><fmt:formatNumber
																				value="${item.price * item.quantity }"
																				pattern="#,##0₫" /></td>
																	</tr>
																</c:forEach>
															</tbody>
														</table>
														<div class="Info-total">
															<div class="order-subtotal row">
																<div class="col-6">Tổng cộng</div>
																<div class="col-6 text-right">
																	<fmt:formatNumber value="${totalCartPrice }"
																		pattern="#,##0₫" />
																</div>
															</div>
															<div class="order-subtotal row">
																<div class="col-6">Khách phải trả</div>
																<div class="col-6 text-right">
																	<fmt:formatNumber value="${totalCartPrice }"
																		pattern="#,##0₫" />
																</div>
															</div>
															<div class="order-subtotal text-center mt-3">
																<div>
																	<span id="orderDateTime"></span>
																</div>
																<div class="text-uppercase">Cảm ơn quý khách</div>

															</div>
														</div>
													</div>
													<div class="modal-footer">
														<a href="${classpath }/index" class="normal btn-backhome">
															<i class="fa-solid fa-arrow-left"></i> Trở lại
														</a> <a href="${classpath }/openpdf/export"
															class="normal btn-pdf"> <i
															class="bi bi-file-earmark-image"></i> Kết xuất PDF
														</a>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="newsletter" class="section-p1 section-m1">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<div class="newstext">
						<h4>Đăng ký để nhận Bản Tin</h4>
						<p>
							Nhận thông tin cập nhật qua Email về cửa hàng mới nhất của chúng
							tôi và <span>ưu đãi đặc biệt.</span>
						</p>
					</div>

				</div>
				<div class="col-md-6">

					<div class="form">
						<input type="text" placeholder="Địa chỉ email của bạn">
						<button class="normal">Đăng ký</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>
	<!-- Js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>
	<script type="text/javascript">
	function _placeOrder(event) {
	    // Ngăn chặn hành vi mặc định của form
	    event.preventDefault();
	    
	    // Lấy giá trị của phương thức thanh toán được chọn
	    var paymentMethod = $('input[name="paymentMethod"]:checked').val();
	    
	    // Tạo đối tượng dữ liệu để gửi đi
	    var data = {
	        txtName: jQuery("#txtName").val(),
	        txtEmail: jQuery("#txtEmail").val(),
	        txtMobile: jQuery("#txtMobile").val(),
	        txtAddress: jQuery("#txtAddress").val(),
	        txtNote: jQuery("#txtNote").val(),
	    };

	    // Kiểm tra giá trị của phương thức thanh toán
	    if (paymentMethod == 0) {
	        // Nếu là COD, thực hiện gửi yêu cầu đặt hàng bình thường
	        $.ajax({
	            url: "/place-order",
	            type: "POST",
	            contentType: "application/json",
	            data: JSON.stringify(data),
	            dataType: "json",
	            success: function (jsonResult) {
	                // Xử lý kết quả trả về
	                if (jsonResult.isCheck) {
	                    // Hiển thị modal hoặc thông báo đặt hàng thành công
	                    $("#statusSuccessModal").modal("show");
	                    $('#orderDateTime').text(jsonResult.orderDateTime);
	                } else {
	                    // Hiển thị thông báo lỗi nếu có
	                    $('.toast-body-error').html(jsonResult.message);
	                    $('.toast-error').toast('show');
	                }
	            },
	            error: function (jqXhr, textStatus, errorMessage) {
	                // Hiển thị thông báo lỗi nếu có lỗi xảy ra
	                $('.toast-body-error').html('Đã có lỗi xảy ra: ' + errorMessage);
	                $('.toast-error').toast('show');
	            }
	        });
	    } else if (paymentMethod == 1) {
	        // Nếu là VNPay, chuyển hướng đến trang thanh toán
	    	$.ajax({
	            url: "/payment",
	            type: "POST",
	            contentType: "application/json",
	            data: JSON.stringify(data),
	            dataType: "json",
	            success: function (jsonResult) {
	            	// Xử lý kết quả trả về
	                if (jsonResult.isCheck) {
	                	 window.location.href = jsonResult.Url;
	                } else {
	                    // Hiển thị thông báo lỗi nếu có
	                    $('.toast-body-error').html(jsonResult.message);
	                    $('.toast-error').toast('show');
	                }
	               
	            },
	            error: function (jqXhr, textStatus, errorMessage) {
	                // Hiển thị thông báo lỗi nếu có lỗi xảy ra
	                $('.toast-body-error').html('Đã có lỗi xảy ra: ' + errorMessage);
	                $('.toast-error').toast('show');
	            }
	        });
	    }
	}

	</script>
</body>
</html>