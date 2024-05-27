<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title }</title>
<link rel="icon" type="image/x-icon"
	href="${classpath }/frontend/img/favicon.webp">
<!-- Css -->
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
</head>

<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

	<section id="page-header" class="about-header">
		<div class="container">
			<h2>#Hãy_nói chuyện</h2>
			<p>ĐỂ LẠI TIN NHẮN, Chúng tôi rất mong nhận được phản hồi từ bạn!</p>
		</div>
	</section>
	<section class="section-m1">
		<div class="container">
			<div class="row">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${classpath }/index">Trang
								chủ</a></li>
						<li class="breadcrumb-item active" aria-current="page">Liên
							hệ</li>
					</ol>
				</nav>
			</div>
		</div>
	</section>
	<section id="contact-details" class="section-p1">
		<div class="container">
			<div class="row">
				<div class="col-12 col-md-6 details">
					<span>LIÊN LẠC</span>
					<h2>Hãy ghé thăm một trong các địa điểm đại lý của chúng tôi
						hoặc liên hệ với chúng tôi ngay hôm nay</h2>
					<h3>Trụ sở chính</h3>
					<ul>
						<li><i class="fa-regular fa-map"></i>
							<p>56 Glassford Street Glasgow 61 1UL New York</p></li>
						<li><i class="fa-regular fa-envelope"></i>
							<p>contact@example.com</p></li>
						<li><i class="fa-solid fa-phone"></i>
							<p>+84 987 654 321</p></li>
						<li><i class="fa-regular fa-clock"></i>
							<p>Monday to Saturday: 9.00am to 16.00pm</p></li>
					</ul>
				</div>
				<div class="col-12 col-md-6 map">
					<iframe
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.834734318766!2d105.7733868!3d21.039297699999995!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313454b5534fb3bf%3A0x70d71b071349fa94!2sDevPro%20Education!5e0!3m2!1svi!2s!4v1705543282661!5m2!1svi!2s"
						width="600" height="450" style="border: 0;" allowfullscreen=""
						loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div id="form-details">
						<div class="col-12 col-md-6 col-lg-8">
							<form action="/contact-send" method="post">
								<span>ĐỂ LẠI LỜI NHẮN</span>
								<h2>Chúng tôi thích nghe từ bạn</h2>
								<input type="text" placeholder="Họ và tên" id="txtName"
									name="txtName" value="${loginedUser.name }" /> <input
									type="email" placeholder="Email" id="txtEmail" name="txtEmail"
									value="${loginedUser.email }" /> <input type="text"
									placeholder="Số điện thoại" id="txtMobile" name="txtMobile"
									value="${loginedUser.mobile }" /> <input type="text"
									placeholder="Địa chỉ" id="txtAddress" name="txtAddress"
									value="${loginedUser.address }" />
								<textarea cols="30" rows="10" placeholder="Tin nhắn"
									id="txtMessage" name="txtMessage"></textarea>
								<button type="button" class="normal" onclick="_notification()">Gửi</button>
							</form>
						</div>

						<div class="col-12 col-md-6 col-lg-4 people">
							<div>
								<img src="${classpath }/frontend/img/people/1.png" alt="">
								<p>
									<span>John Doe</span> Senior Marketing Manager <br> Phone:
									+ 000 123 000 77 88 <br> Emial: contact@exmaple.com
								</p>
							</div>
							<div>
								<img src="${classpath }/frontend/img/people/2.png" alt="">
								<p>
									<span>Willam Smith</span> Senior Marketing Manager <br>
									Phone: + 000 123 000 77 88 <br> Emial: contact@exmaple.com
								</p>
							</div>
							<div>
								<img src="${classpath }/frontend/img/people/3.png" alt="">
								<p>
									<span>Emna Stone</span> Senior Marketing Manager <br>
									Phone: + 000 123 000 77 88 <br> Emial: contact@exmaple.com
								</p>
							</div>
						</div>
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
	<!-- Toast -->
	<jsp:include page="/WEB-INF/views/frontend/layout/toast.jsp"></jsp:include>
	<!-- Js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>

	<script type="text/javascript">
		function _notification() {
			//javascript object
			let data = {

				txtName : jQuery("#txtName").val(),
				txtEmail : jQuery("#txtEmail").val(), //Get by Id
				txtMobile : jQuery("#txtMobile").val(),
				txtAddress : jQuery("#txtAddress").val(),
				txtMessage : jQuery("#txtMessage").val(),

			};

			//$ === jQuery
			jQuery.ajax({
				url : "/contact-send",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json", //Kieu du lieu tra ve tu controller la json

				success : function(jsonResult) {
					//alert(jsonResult.code + ": " + jsonResult.message);
					//$("#notification").html(jsonResult.message);
					// Xóa các giá trị trong các trường của form	
					if (jsonResult.errorMessage) {
						$('.toast-body-error').html(jsonResult.errorMessage);
						$('.toast-error').toast('show');
					} else {
						$('.toast-body-success').html(jsonResult.message);
						$('.toast-success').toast('show');
						$('#txtName').val('');
						$('#txtMobile').val('');
						$('#txtEmail').val('');
						$('#txtAddress').val('');
						$('#txtMessage').val('');
					}
				},

				error : function(jqXhr, textStatus, errorMessage) {
					$('.toast-body-error').html(
							'Đã có lỗi xảy ra: ' + errorMessage);
					$('.toast-error').toast('show');
				}
			});
		}
	</script>
</body>
</html>