<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<footer class="section-p1">
	<div class="container">
		<div class="row">
			<div class="col-md-4  col-lg-3">
				<img class="logo" src="${classpath }/frontend/img/logo.png" alt="">
				<h4>Liên hệ</h4>
				<p>
					<strong>Địa chỉ: </strong> 562 Wellington Road, Street 32, San
					Francisco
				</p>
				<p>
					<strong>Số điện thoại: </strong> +01 2222 365 /(+91) 01 2345 6789
				</p>
				<p>
					<strong>Giờ: </strong> 08:00 - 18:00, Thứ 2 - Thứ 6
				</p>
				<div class="follow">
					<h4>Theo dõi chúng tôi</h4>
					<div class="icon">
						<i class="fab fa-facebook-f"></i> <i class="fab fa-twitter"></i> <i
							class="fab fa-instagram"></i> <i class="fab fa-pinterest-p"></i>
						<i class="fab fa-youtube"></i>
					</div>
				</div>
			</div>
			<div class="col-6 col-md-4  col-lg-3 matop20">
				<div class="colu">
					<h4>Về</h4>
					<a href="#">Về chúng tôi</a> <a href="#">Thông tin giao hàng</a> <a
						href="#">Chính sách bảo mật</a> <a href="#">Điều khoản và điều kiện</a>
					<a href="#">Liên hệ chúng tôi</a>
				</div>
			</div>
			<div class="col-6 col-md-4  col-lg-3 matop20">
				<div class="colu">
					<h4>Tài khoản của bạn</h4>
					<a href="#">Đăng nhập</a> <a href="#">Xem giỏ hàng</a> <a href="#">Sản phẩm yêu thích</a> 
					<a href="#">Theo dõi đơn hàng</a> <a href="#">Giúp đỡ</a>
				</div>
			</div>
			<div class="col-md-12  col-lg-3 install">
				<h4>Cài đặt ứng dụng</h4>
				<p>Từ App Store hoặc Google Play</p>
				<div class="row">
					<div class="col-3 col-lg-6">
						<img src="${classpath }/frontend/img/pay/app.jpg" alt="">
					</div>
					<div class="col-3 col-lg-6">
						<img src="${classpath }/frontend/img/pay/play.jpg" alt="">
					</div>
				</div>
				<p>Cổng thanh toán an toàn</p>
				<div class="row">
					<div class="col-3 col-lg-12">
						<img src="${classpath }/frontend/img/pay/pay.png" alt=""
							style="border: none;">
					</div>
				</div>
			</div>
		</div>
	</div>
</footer>

<script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
<df-messenger
  intent="WELCOME"
  chat-title="Test_ai_chat"
  agent-id="9b5761e4-392a-41b3-af41-8d344b4151d5"
  language-code="vi"
></df-messenger>

<a id="scrollTop"><i class="fa-solid fa-chevron-up"
	style="color: #5d5c5c;"></i></a>