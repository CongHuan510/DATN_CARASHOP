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

					<h1 class="h1 mb-3" style="font-weight: 700;">Chỉnh sửa tài
						khoản</h1>

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<sf:form class="form"
										action="${classpath }/admin/user/edit-save" method="post"
										modelAttribute="user" enctype="multipart/form-data">
										<div class="form-body">

											<sf:hidden path="id" />
											<!-- id > 0 => update -->

											<div class="row">
												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="username">Tên tài khoản</label>
														<sf:input path="username" type="text" class="form-control"
															id="username" name="username" placeholder="tên tài khoản"></sf:input>
													</div>
												</div>

												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="password">Mật khẩu</label>
														<sf:input path="password" type="passward"
															class="form-control" id="password" name="password"
															placeholder="mật khẩu"></sf:input>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="name">Họ và tên</label>
														<sf:input path="name" type="text" class="form-control"
															id="name" name="name" placeholder="họ và tên"></sf:input>
													</div>
												</div>

												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="mobile">Số điện thoại</label>
														<sf:input path="mobile" type="text" class="form-control"
															id="mobile" name="mobile" placeholder="số điện thoại"></sf:input>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="email">Email</label>
														<sf:input path="email" type="text" class="form-control"
															id="email" name="email" placeholder="email"></sf:input>
													</div>
												</div>

												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="address">Địa chỉ</label>
														<sf:input path="address" type="text" class="form-control"
															id="address" name="address" placeholder="địa chỉ"></sf:input>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="role">Người tạo</label>
														<sf:select path="userCreateUser.id" class="custom-select"
															id="userCreateUser">
															<sf:options items="${users }" itemValue="id"
																itemLabel="username"></sf:options>
														</sf:select>
													</div>
												</div>

												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="role">Người cập nhật</label>
														<sf:select path="userUpdateUser.id" class="custom-select"
															id="userUpdateUser">
															<sf:options items="${users }" itemValue="id"
																itemLabel="username"></sf:options>
														</sf:select>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="createdate">Ngày tạo</label>

														<sf:input path="createDate" class="form-control"
															type="date" id="createDate" name="createDate"></sf:input>
													</div>
												</div>

												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="updatedate">Ngày cập nhật</label>

														<sf:input path="updateDate" class="form-control"
															type="date" id="updateDate" name="updateDate"></sf:input>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<label for="description">Mô tả</label>
														<sf:textarea path="description" id="description"
															name="description" class="form-control" rows="3"
															placeholder="mô tả..."></sf:textarea>
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-2">
													<div class="form-group mb-4">
														<label for="status">Trạng thái:</label>
														<sf:select path="status" class="custom-select" id="status"
															name="status">
															<option value="ACTIVE"
																<c:if test="${user.status == 'ACTIVE'}">selected</c:if>>Kích hoạt</option>
															<option value="INACTIVE"
																<c:if test="${user.status == 'INACTIVE'}">selected</c:if>>Không kích hoạt</option>
														</sf:select>
													</div>
												</div>

											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<label for="avatarFile">Chọn ảnh đại diện</label> <input
															id="avatarFile" name="avatarFile" type="file"
															class="form-control-file" multiple="multiple">
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<a href="${classpath }/admin/user/list"
															class="btn btn-secondary active" role="button"
															aria-pressed="true"> Trở lại </a>
														<button type="submit" class="btn btn-primary">Cập
															nhật</button>
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
			</main>

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/backend/layout/footer.jsp"></jsp:include>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/backend/layout/js.jsp"></jsp:include>

</body>

</html>