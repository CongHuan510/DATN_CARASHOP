<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

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
							<li class="breadcrumb-item active" aria-current="page">Thông tin cá nhân</li>
						</ol>
					</nav>
				</div>
				<sf:form class="form" action="${classpath }/profile/edit-save"
					method="post" modelAttribute="currentUser"
					enctype="multipart/form-data">
					<sf:hidden path="id" />
					<!-- id > 0 => update -->
					<div class="row justify-content-center ">
						<div class="col-lg-3 mb-5">
							<div class="mt-5 row justify-content-center">

								<div class="col-md-12 profile-img">
									<label for="avatarFile" class="upload-btn"> <input
										id="avatarFile" name="avatarFile" type="file"
										class="form-control-file" onchange="previewImage(this);"
										multiple="multiple" hidden="true"> <i
										class="fa-solid fa-camera"></i> 
										<img id="preview" src="${classpath }/FileUploads/${currentUser.avatar }">
									</label>
								</div>
								<div class="col-md-12 text-center mt-2 mb-2">
									<div class="profile-name">${currentUser.username }</div>
								</div>
								<div class="col-md-12 text-center text-nowrap">
									<div class="profile-email">${currentUser.email }</div>
								</div>
							</div>
						</div>
						<div class="col-12 col-lg-5 col-xl-4">
							<div class="wrap">

								<div class="form-password">
									<div class="mb-4 text-center">
										<h3>Thông tin cá nhân</h3>
									</div>
									<c:if test="${not empty message }">
										<div class="alert alert-success" role="alert">${message }</div>
									</c:if>
									<div class="form-group first">
										<label for="name">Họ và tên</label>
										<sf:input path="name" type="text" class="form-control"
											id="name" name="name"></sf:input>
									</div>

									<div class="form-group">
										<label for="email">Email</label>
										<sf:input path="email" type="text" class="form-control"
											id="email" name="email"></sf:input>
									</div>

									<div class="form-group">
										<label for="mobile">Số điện thoại</label>
										<sf:input path="mobile" type="text" class="form-control"
											id="mobile" name="mobile"></sf:input>
									</div>
									<div class="form-group last mb-4">
										<label for="address">Địa chỉ</label>
										<sf:input path="address" type="text" class="form-control"
											id="address" name="address"></sf:input>
									</div>
									<button type="submit"
										class="col-12 btn btn-pill text-white btn-block btn-primary">Lưu</button>
								</div>
							</div>
						</div>
					</div>
				</sf:form>
			</div>
		</div>
	</main>
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>
	<!-- Js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>
	<script type="text/javascript">
	    function previewImage(input) {
	        var preview = document.getElementById('preview');
	        var file = input.files[0];
	        var reader = new FileReader();
	
	        reader.onloadend = function () {
	            preview.src = reader.result;
	            preview.style.display = 'block'; // Hiển thị hình ảnh
	        }
	
	        if (file) {
	            reader.readAsDataURL(file); // Đọc dữ liệu của hình ảnh như một URL
	        } else {
	            // Nếu không có hình ảnh mới được chọn, giữ nguyên ảnh hiện tại
	            if (preview.src.indexOf('default-avatar.webp') === -1) {
	                preview.src = '${classpath}/FileUploads/${currentUser.avatar}';
	                preview.style.display = 'block'; // Hiển thị hình ảnh
	            }
	        }
	    }
	</script>
</body>
</html>