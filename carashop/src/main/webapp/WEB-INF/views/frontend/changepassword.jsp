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
				<div class="row">
					<nav aria-label="breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="${classpath}/index">Trang chủ</a></li>
							<li class="breadcrumb-item active" aria-current="page">Đổi mật khẩu</li>
						</ol>
					</nav>
				</div>
				<div class="row justify-content-center pt-3">
					<div class="col-12 col-lg-6 col-xl-5 contents">
						<div class="wrap">

							<div class="form-password">
								<div class="mb-4 text-center">
									<h3>Đổi mật khẩu</h3>
								</div>
								<form action="${classpath }/change-password" method="post" id="change-password">
									<c:if test="${not empty errorMessage }">
										<div class="alert alert-danger" role="alert">${errorMessage }</div>
									</c:if>
									<c:if test="${not empty message }">
										<div class="alert alert-success" role="alert">${message }</div>
									</c:if>
								
									<div class="form-group first">
										<label for="username">Tên tài khoản</label> <input type="text"
											class="form-control" id="username" name="username"> <img
											src="${classpath }/frontend/img/icon/user.png"
											class="form-icon"> <span class="form-message"></span>
									</div>
									<div class="form-group mb-4">
										<label for="oldpassword">Mật khẩu cũ</label> <input
											type="password" class="form-control" id="oldpassword"
											name="oldpassword"> <img
											src="${classpath }/frontend/img/icon/hide.png"
											class="eye-oldpassword"> <span class="form-message"></span>
									</div>
									<div class="form-group mb-4">
										<label for="newpassword">Mật khẩu mới</label> <input
											type="password" class="form-control" id="newpassword"
											name="newpassword"> <img
											src="${classpath }/frontend/img/icon/hide.png"
											class="eye-newpassword"> <span class="form-message"></span>
									</div>
									<div class="form-group last mb-4">
										<label for="retypenewpassword">Nhập lại mật khẩu mới</label> <input
											type="password" id="retypenewpassword"
											name="retypenewpassword" class="form-control"> <img
											src="${classpath }/frontend/img/icon/hide.png"
											class="eye-retypenewpassword"> <span
											class="form-message"></span>
									</div>
									<button type="submit"
										class="col-12 btn btn-pill text-white btn-block btn-primary">
										Lưu</button>
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
	<script>
		//Lấy các phần tử cần thiết từ DOM
		let oldPasswordInput = document.querySelector('#oldpassword');
		let newPasswordInput = document.querySelector('#newpassword');
		let retypeNewPasswordInput = document.querySelector('#retypenewpassword');
		let eyeOldPassword = document.querySelector('.eye-oldpassword');
		let eyeNewPassword = document.querySelector('.eye-newpassword');
		let eyeRetypePassword = document.querySelector('.eye-retypenewpassword');
		// Định nghĩa hàm để xử lý sự kiện khi click vào biểu tượng mắt
		function togglePasswordVisibility(input, eyeIcon) {
		    if (input.type === 'password') {
		        input.type = 'text';
		        eyeIcon.src = '${classpath}/frontend/img/icon/visible.png';
		    } else {
		        input.type = 'password';
		        eyeIcon.src = '${classpath}/frontend/img/icon/hide.png';
		    }
		}
		// Lắng nghe sự kiện click vào biểu tượng mắt cho password
		eyeOldPassword.addEventListener('click', () => {
		    togglePasswordVisibility(oldPasswordInput, eyeOldPassword);
		});
		eyeNewPassword.addEventListener('click', () => {
		    togglePasswordVisibility(newPasswordInput, eyeNewPassword);
		});
		eyeRetypePassword.addEventListener('click', () => {
		    togglePasswordVisibility(retypeNewPasswordInput, eyeRetypePassword);
		});
	</script>
	<script src="${classpath }/frontend/js/validator.js"></script>
	<script>
	// Mong muốn của chúng ta
		Validator({
			form : '#change-password',
			errorSelector : '.form-message',
			rules : [ 
				Validator.isRequired('#username'),
				Validator.isRequired('#oldpassword'),
				Validator.minLength('#oldpassword', 3),
				Validator.isRequired('#newpassword'),
				Validator.minLength('#newpassword', 3), 
				Validator.isRequired('#retypenewpassword'),
				Validator.minLength('#retypenewpassword', 3), 	
			]
		});
	</script>
</body>
</html>