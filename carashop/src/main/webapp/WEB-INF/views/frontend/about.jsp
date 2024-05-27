<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

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
<!-- Css -->
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
</head>

<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

	<section id="page-header" class="about-header">
		<div class="container">
			<h2>Giới thiệu</h2>
		</div>
	</section>

	<section class="section-m1" style="margin-bottom: 0px !important;">
		<div class="container">
			<div class="row">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${classpath }/index">Trang
								chủ</a></li>
						<li class="breadcrumb-item active" aria-current="page">Giới
							thiệu</li>
					</ol>
				</nav>
			</div>
		</div>
	</section>

	<section id="about-head" class="section-p1">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6">
					<div class="image">
						<img width="794" height="365" class="lazyload loaded"
							src="${classpath }/frontend/img/about/section_about_image1.webp"
							alt="CaraShop đang tạo ra những bộ trang phục sản xuất trong nước hoàn toàn có thể sánh ngang với các thương hiệu thời trang nam đến từ nước ngoài "
							data-was-processed="true">
					</div>
				</div>
				<div class="col-lg-6">
					<div class="content">
						<h2 class="title">“CaraShop đang tạo ra những bộ trang phục sản
							xuất trong nước hoàn toàn có thể sánh ngang với các thương hiệu
							thời trang nam đến từ nước ngoài</h2>
						<span> Thời trang CaraShop thuyết phục khách hàng bằng từng
							kiểu dáng trang phục thiết kế độc quyền, sự sắc sảo trong mỗi
							đường nét cắt may, sử dụng chất liệu vải cao cấp và luôn hòa điệu
							cùng xu hướng quốc tế. Đây là con đường CaraShop theo đuổi và hướng
							đến phát triển bền vững. </span>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="about-head" class="section-p1">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6">
					<div class="content">
						<h2 class="title">Được thành lập vào năm 2023 và khởi đầu chỉ
							là một cơ sở kinh doanh nhỏ, một Website bán hàng sơ khai với mặt
							hàng chủ yếu là áo thun.</h2>
						<span> Dù là chàng trai mạnh mẽ, cá tính hay chững chạc,
							nghiêm túc thì CaraShop vẫn tin rằng mình có thể đáp ứng được nhu cầu
							mặc đẹp mỗi ngày cho bạn. Không chỉ mang lại sản phẩm đầy phong
							cách, kiểu dáng độc đáo mà chúng tôi còn cam kết chất lượng, các
							sản phẩm được kiểm duyệt kỹ lưỡng từ khâu chọn chất liệu đến
							thiết kế, hoàn thiện. Bởi vậy mặt hàng mà CaraShop cung cấp khi đến
							tay khách hàng sẽ mang lại sự hài lòng tuyệt đối. </span>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="image">
						<img width="794" height="365" class="lazyload loaded"
							src="${classpath }/frontend/img/about/section_about_image2.webp"
							alt="CaraShop đang tạo ra những bộ trang phục sản xuất trong nước hoàn toàn có thể sánh ngang với các thương hiệu thời trang nam đến từ nước ngoài "
							data-was-processed="true">
					</div>
				</div>

			</div>
		</div>
	</section>

	<section class="section-p1 about-contact">
		<div class="container">
			<div class="rowter">
				<div class="col-12  text-center">
					<span class="title1">BẠN CÓ CÂU HỎI GÌ KHÔNG?</span> <span
						class="title2">LIÊN HỆ VỚI CHÚNG TÔI NGAY</span> <span
						class="content">Đội ngũ thân thiện của chúng tôi mong muốn
						liên hệ lại với bạn trong vòng 48 giờ.</span> <a
						href="${classpath }/contact" title="LIÊN HỆ CHÚNG TÔI">LIÊN HỆ
						CHÚNG TÔI</a>
				</div>
			</div>
		</div>

	</section>

	<section class="section-p1">
		<div class="container">
			<div id="feature" class="row slide-img">
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f1.png" alt="">
						<h6>Miễn phí vận chuyển</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f2.png" alt="">
						<h6>Đặt hàng trực tuyến</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f3.png" alt="">
						<h6>Tiết kiệm tiền</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f4.png" alt="">
						<h6>Khuyến mãi</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f5.png" alt="">
						<h6>Bán vui vẻ</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f6.png" alt="">
						<h6>Hỗ trợ 24/7</h6>
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
</body>

</html>