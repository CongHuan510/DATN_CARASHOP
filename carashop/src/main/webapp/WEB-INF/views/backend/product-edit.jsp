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

					<h1 class="h1 mb-3" style="font-weight: 700;">Chỉnh sửa sản phẩm</h1>

					<div class="container-fluid">
						<!-- ============================================================== -->
						<!-- Start Page Content -->
						<!-- ============================================================== -->
						<div class="row">
							<div class="col-12">
								<div class="card">
									<div class="card-body">
										<sf:form class="form"
											action="${classpath }/admin/product/edit-save" method="post"
											modelAttribute="product" enctype="multipart/form-data">

											<div class="form-body">

												<sf:hidden path="id" />
												<!-- id > 0 -> Edit -->

												<div class="row">
													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="category">Chọn danh mục</label>
															<sf:select path="category.id" class="form-control"
																id="category">
																<sf:options items="${categories }" itemValue="id"
																	itemLabel="name"></sf:options>
															</sf:select>
														</div>
													</div>
													
													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="name">Tên sản phẩm</label>
															<sf:input path="name" type="text" class="form-control"
																id="name" name="name" placeholder="tên sản phẩm"></sf:input>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="productQuantity">Số lượng nhập</label>
															<sf:input path="productQuantity" type="number" class="form-control"
																id="productQuantity" name="productQuantity" placeholder="số lượng sản phẩm"></sf:input>
														</div>
													</div>

													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="size">Kích cỡ</label>
															<sf:input path="size" type="text" id="size" name="size"
																class="form-control" placeholder="kích cỡ"></sf:input>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="price">Giá bán</label>
															<sf:input path="price" type="number" autocomplete="off"
																id="price" name="price" class="form-control"
																placeholder="giá bán"></sf:input>
														</div>
													</div>

													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="salePrice">Giá giảm</label>
															<sf:input path="salePrice" type="number"
																autocomplete="off" id="salePrice" name="salePrice"
																class="form-control" placeholder="giá giảm"></sf:input>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="create">Người tạo</label>
															<sf:select path="userCreateProduct.id"
																class="custom-select" id="createBy">
																<sf:options items="${users }" itemValue="id"
																	itemLabel="username"></sf:options>
															</sf:select>
														</div>
													</div>

													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="update">Người cập nhật</label>
															<sf:select path="userUpdateProduct.id"
																class="custom-select" id="updateBy">
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
															<label for="updatedate">Ngày cập nhật</label>

															<sf:input path="updateDate" class="form-control"
																type="date" id="updateDate" name="updateDate"></sf:input>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<label for="description">Mô tả ngắn</label>
															<sf:textarea path="shortDescription"
																id="shortDescription" name="shortDescription"
																class="form-control" rows="3"
																placeholder="mô tả ngắn..."></sf:textarea>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<label for="detailDescription">Mô tả chi tiết</label>
															<sf:textarea path="detailDescription"
																id="detailDescription" name="detailDescription"
																class="form-control" rows="3"
																placeholder="mô tả chi tiết..."></sf:textarea>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-2">
														<div class="form-group mb-4">
															<label for="isHot">&nbsp;&nbsp;&nbsp;&nbsp;</label>
															<sf:checkbox path="isHot" class="form-check-input"
																id="isHot" name="isHot"></sf:checkbox>
															<label for="isHot">Là sản phẩm nổi bật?</label>

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
																	<c:if test="${product.status == 'ACTIVE'}">selected</c:if>>Kích hoạt</option>
																<option value="INACTIVE"
																	<c:if test="${product.status == 'INACTIVE'}">selected</c:if>>Không kích hoạt</option>
															</sf:select>

														</div>
													</div>
												</div>
	
												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<label for="avatarFile">Chọn hình đại diện sản phẩm</label> <input
																id="avatarFile" name="avatarFile" type="file"
																class="form-control-file" multiple="multiple">
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<label for="image">Chọn hình ảnh sản phẩm</label> <input
																id="imageFiles" name="imageFiles" type="file"
																class="form-control-file" multiple="multiple">
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<label for="image">Chọn hình ảnh sản phẩm</label> <input
																id="imageFiles" name="imageFiles" type="file"
																class="form-control-file" multiple="multiple">
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<label for="image">Chọn hình ảnh sản phẩm</label> <input
																id="imageFiles" name="imageFiles" type="file"
																class="form-control-file" multiple="multiple">
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<label for="image">Chọn hình ảnh sản phẩm</label> <input
																id="imageFiles" name="imageFiles" type="file"
																class="form-control-file" multiple="multiple">
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<a href="${classpath }/admin/product/list"
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
<script
		src="https://cdn.tiny.cloud/1/88ep7y8fyla5766jwnlteaiax66wxn7khb3yljln9yiftcec/tinymce/7/tinymce.min.js"
		referrerpolicy="origin"></script>
	<!-- Place the following <script> and <textarea> tags your HTML's <body> -->
	<script>
		tinymce.init({
					selector : '#detailDescription',
					plugins : 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount linkchecker',
					toolbar : 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
				});
	</script>
</body>

</html>