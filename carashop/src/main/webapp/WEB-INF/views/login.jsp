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

<!-- variables -->
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
<!-- Css -->
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

	<main class="bg-light">
		<div class="section-p1">
			<div class="container">
				<div class="row justify-content-center ">
					<div class="col-12 col-lg-10 col-xl-8 contents">
						<div class="wrap d-md-flex">
							<div
								class="text-wrap p-4 p-lg-5 text-center d-flex align-items-center order-md-last">
								<div class="text w-100">
									<h2>Chào mừng bạn đăng nhập</h2>
									<p>Bạn chưa có tài khoản?</p>
									<a href="${classpath }/signup"
										class="btn btn-white btn-outline-white">Đăng ký <i
										class="fa-solid fa-arrow-right"></i></a>
								</div>
							</div>
							<div class="form-block p-lg-5">
								<div class="mb-4 text-center text-uppercase">
									<h3>Đăng nhập</h3>
								</div>
								<form action="${classpath }/login_processing_url" method="POST"
									id="login-form">
									<c:if test="${not empty param.login_error }">
										<div class="alert alert-danger" role="alert">Đăng nhập không thành công, vui lòng thử lại!!!</div>
									</c:if>

									<!-- Username -->
									<div class="form-group first">
										<label for="username">Tên tài khoản</label> 
										<input type="text" class="form-control"
										 id="username" name="username"> 
										<img src="${classpath }/frontend/img/icon/user.png"
											class="form-icon"> 
										<span class="form-message"></span>
									</div>

									<!-- Password -->
									<div class="form-group last mb-3">
										<label for="password">Mật khẩu</label> 
										<input type="password" class="form-control" 
										id="password" name="password"> 
										<img src="${classpath }/frontend/img/icon/hide.png"
											onclick="change()" class="eye-password"> 
										<span class="form-message"></span>
									</div>

									<!-- Check box -->
									<div class="d-flex mb-3 align-items-center">
										<label class="control control--checkbox mb-0"> <input
											type="checkbox" id="remember-me" name="remember-me"
											class="checkbox" checked> <span class="caption">Remember
												me</span>
										</label>
									</div>
									<button type="submit" id="submit" class="btn btn-primary"
										style="font-size: 20px; width: 100%;">Đăng nhập</button>
									<!-- <span class="d-block text-center my-4 text-muted"> or
										sign in with</span>
									<div class="social-login text-center">
										<a href="#" class="facebook"> <span
											class="icon-facebook mr-3"> <i
												class="fa-brands fa-facebook-f"></i>
										</span>
										</a> <a href="#" class="twitter"> <span
											class="icon-twitter mr-3"> <i
												class="fa-brands fa-twitter"></i>
										</span>
										</a> <a href="#" class="google"> <span
											class="icon-google mr-3"> <i
												class="fa-brands fa-google"></i>
										</span>
										</a>
									</div> -->
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>

	<!-- Js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>
</body>
<script>
	//JS LOGIN SHOW/HIDE PASSWORD AND CHECK INPUT
	let input = document.querySelector('#password');
	let eyePassword = document.querySelector('.eye-password');

	function change() {
		if (input.type === 'password') {
			input.type = 'text';
			eyePassword.src = '${classpath }/frontend/img/icon/visible.png';
		} else {
			input.type = 'password';
			eyePassword.src = '${classpath }/frontend/img/icon/hide.png';
		}
	}
</script>
<script src="${classpath }/frontend/js/validator.js"></script>
<script>
	// Mong muốn của chúng ta
	Validator({
		form : '#login-form',
		errorSelector : '.form-message',
		rules : [ Validator.isRequired('#username'),
				Validator.isRequired('#password'),
				Validator.minLength('#password', 3), ]
	});
</script>
</html>