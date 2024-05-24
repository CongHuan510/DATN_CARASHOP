<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title }</title>
<link rel="icon" type="image/x-icon"
	href="${classpath }/frontend/img/favicon.webp">
<!-- variables -->
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>

<!-- css -->
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>

</head>
<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

	<main class="bg-light">
		<div class="section-p1">
			<div class="container">
				<div class="row justify-content-center ">
					<div class="col-md-12 col-lg-10 contents">
						<div class="wrap d-md-flex">
							<div
								class="text-wrap p-4 p-lg-5 text-center d-flex align-items-center">
								<div class="text w-100">
									<h2>ĐĂNG KÝ NGAY</h2>
									<p>Nếu bạn chưa có tài khoản, vui lòng đăng ký tại đây!</p>
									<a href="${classpath }/login"
										class="btn btn-white btn-outline-white"><i
										class="fa-solid fa-arrow-left"></i> Đăng nhập </a>
								</div>
							</div>
							<div class="form-block p-lg-5">
								<div class="mb-4 text-center text-uppercase">
									<h3>Đăng ký</h3>
								</div>
								<form action="${classpath }/register" method="post"
									id="register-form">
									<div class="form-group first">
										<label for="name">Họ và tên</label> <input type="text"
											class="form-control" id="name" name="name" />
										<%-- <img src="${classpath }/frontend/img/icon/user.png" class="form-icon"> --%>
										<span class="form-message"></span>
									</div>
									<div class="form-group">
										<label for="email">Email</label> <input type="email"
											class="form-control" id="email" name="email" />
										<%-- <img src="${classpath }/frontend/img/icon/email.png" class="form-icon"> --%>
										<span class="form-message"></span>
									</div>
									<div class="form-group">
										<label for="mobile">Số điện thoại</label> <input type="text"
											class="form-control" id="mobile" name="mobile" />
										<%-- <img src="${classpath }/frontend/img/icon/call.png" class="form-icon"> --%>
										<span class="form-message"></span>
									</div>
									<div class="form-group">
										<label for="address">Địa chỉ</label> <input type="text"
											class="form-control" id="address" name="address" />
										<%-- <img src="${classpath }/frontend/img/icon/location.png" class="form-icon"> --%>
										<span class="form-message"></span>
									</div>
									<div class="form-group ">
										<label for="username">Tên tài khoản</label> <input type="text"
											class="form-control" id="username" name="username" />
										<%-- <img src="${classpath }/frontend/img/icon/user.png" class="form-icon"> --%>
										<span class="form-message"></span>
									</div>
									<div class="form-group mb-4">
										<label for="password">Mật khẩu</label> <input type="password"
											class="form-control input" id="password" name="password" />
										<img src="${classpath }/frontend/img/icon/hide.png"
											class="eye-password"> <span class="form-message"></span>
									</div>
									<div class="form-group last mb-4">
										<label for="retypepassword">Nhập lại mật khẩu</label> <input
											type="password" id="retypepassword" name="retypepassword"
											class="form-control input" /> <img
											src="${classpath }/frontend/img/icon/hide.png"
											class="eye-retypepassword"> <span class="form-message"></span>
									</div>
									<button type="submit" class="btn btn-primary btn-lg"
										style="font-size: 20px; width: 100%;">Đăng ký</button>
									<span class="d-block text-center my-4 text-muted">đã có tài khoản chưa? <a href="${classpath }/login" class="colorgreen">Đăng nhập</a>
									</span>
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
//Lấy các phần tử cần thiết từ DOM
let passwordInput = document.querySelector('#password');
let retypePasswordInput = document.querySelector('#retypepassword');
let eyePassword = document.querySelector('.eye-password');
let eyeRetypePassword = document.querySelector('.eye-retypepassword');

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
eyePassword.addEventListener('click', () => {
    togglePasswordVisibility(passwordInput, eyePassword);
});

// Lắng nghe sự kiện click vào biểu tượng mắt cho retype password
eyeRetypePassword.addEventListener('click', () => {
    togglePasswordVisibility(retypePasswordInput, eyeRetypePassword);
});

</script>
<script src="${classpath }/frontend/js/validator.js"></script>
<script>
// Mong muốn của chúng ta
Validator({
	form: '#register-form',
	errorSelector: '.form-message',
	rules: [
		Validator.isRequired('#name'),
		Validator.isRequired('#email'),
		Validator.isEmail('#email'),
		Validator.isRequired('#mobile'),
		Validator.isMobile('#mobile'),
		Validator.isRequired('#address'),
		Validator.isRequired('#username'),
		Validator.isRequired('#password'),
		Validator.minLength('#password', 3),
		Validator.isRequired('#retypepassword'),
		Validator.isConfirmed('#retypepassword', function(){
			return document.querySelector('#register-form #password').value;
		}, 'Mật khẩu nhập lại không chính xác'),
	]
});
</script>
</html>