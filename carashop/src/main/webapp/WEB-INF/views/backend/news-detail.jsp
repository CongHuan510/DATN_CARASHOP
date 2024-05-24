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

					<h1 class="h1 mb-3" style="font-weight: 700;">Chi tiết tin tức</h1>

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<sf:form class="form" action="${classpath }/admin/news/detail"
										method="get" modelAttribute="news"
										enctype="multipart/form-data">
										<div class="form-body">

											<sf:hidden path="id" />
											<!-- id > 0 => update -->

											<div class="row">
												<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="name">Tiêu đề</label>
															<sf:input path="title" type="text" class="form-control"
																id="title" name="title" placeholder="tiêu đề"></sf:input>
														</div>
													</div>
													
													<div class="col-md-6">
														<div class="form-group mb-4">
															<label for="summary">Sơ lược</label>
															<sf:input path="summary" type="text" class="form-control"
																id="summary" name="summary" placeholder="sơ lược"></sf:input>
														</div>
													</div>
											</div>

											<div class="row">
													<div class="col-md-12">
														<div class="form-group mb-4">
															<label for="content">Nội dung</label>
															<sf:textarea path="content"
																id="content" name="content"
																class="form-control" rows="3"
																placeholder="nội dung..."></sf:textarea>
																<script
															src="https://cdn.tiny.cloud/1/88ep7y8fyla5766jwnlteaiax66wxn7khb3yljln9yiftcec/tinymce/7/tinymce.min.js"
															referrerpolicy="origin"></script>

														<!-- Place the following <script> and <textarea> tags your HTML's <body> -->
														<script>
															tinymce.init({
																		selector : '#content',
																		plugins : 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount linkchecker',
																		toolbar : 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
																	});
														</script>
														</div>
													</div>
												</div>
					
											<div class="row">
												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="role">Người tạo</label>
														<sf:select path="userCreateNews.id" class="custom-select"
															id="createBy">
															<sf:options items="${users }" itemValue="id"
																itemLabel="username"></sf:options>
														</sf:select>
													</div>
												</div>

												<div class="col-md-6">
													<div class="form-group mb-4">
														<label for="role">Người cập nhật</label>
														<sf:select path="userUpdateNews.id" class="custom-select"
															id="updateBy">
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
												<div class="col-md-2">
													<div class="form-group mb-4">
														<label for="status">Trạng thái:</label>
														<sf:select path="status" class="custom-select" id="status"
															name="status">
															<option value="ACTIVE"
																<c:if test="${news.status == 'ACTIVE'}">selected</c:if>>Kích hoạt</option>
															<option value="INACTIVE"
																<c:if test="${news.status == 'INACTIVE'}">selected</c:if>>Không kích hoạt</option>
														</sf:select>	
													</div>
												</div>

											</div>

											<div class="row">
												<div class="col-md-4">
													<div class="form-group mb-4">
														<p>Hình ảnh đại diện</p>
														<img width="250px" height="250px"
															src="${classpath }/FileUploads/${news.avatar }">
													</div>
												</div>
											</div>

											<div class="row">
												<div class="col-md-12">
													<div class="form-group mb-4">
														<a href="${classpath }/admin/news/list"
															class="btn btn-secondary active" role="button"
															aria-pressed="true">Trở lại</a>
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
	<!-- Js -->
	<jsp:include page="/WEB-INF/views/backend/layout/js.jsp"></jsp:include>

</body>
</html>