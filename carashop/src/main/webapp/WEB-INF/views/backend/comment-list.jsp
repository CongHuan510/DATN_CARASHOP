<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />

</head>

<body>
	<div class="wrapper">
		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/backend/layout/sidebar.jsp"></jsp:include>

		<div class="main">
			<jsp:include page="/WEB-INF/views/backend/layout/navbar.jsp"></jsp:include>

			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h1 mb-3" style="font-weight: 700;">Danh sách đánh giá</h1>

					<div class="container-fluid">
						<!-- ============================================================== -->
						<!-- Start Page Content -->
						<!-- ============================================================== -->
						<!-- basic table -->
						<form action="${classpath }/admin/comment/list" method="get">

							<div class="row">
								<div class="col-12">
									<div class="card">
										<div class="card-body">
											<div class="table-responsive">

												<div class="row">
													<div class="col-md-12 mb-3">
														<div class="form-group">
															<h3>Tổng số đánh giá: ${commentSearch.totalItems}</h3>
														</div>
													</div>
												</div>
												<!-- Tìm kiếm -->
												<div class="row">
													<div class="col-md-2 mb-3">
														<div class="form-group">
															<select class="form-control" id="status" name="status">
																<option value="ALL">Tất cả đánh giá</option>
																<option value="ACTIVE" <c:if test="${commentSearch.status == 'ACTIVE' }">selected</c:if>>Kích hoạt</option>
																<option value="INACTIVE" <c:if test="${commentSearch.status == 'INACTIVE' }">selected</c:if>>Không kích hoạt</option>
															</select>
														</div>
													</div>
													<div class="col-md-2 mb-3">
														<input class="form-control" type="date" id="beginDate"
															name="beginDate" value="${commentSearch.beginDate }" />
													</div>
													<div class="col-md-2 mb-3">
														<input class="form-control" type="date" id="endDate"
															name="endDate" value="${commentSearch.endDate }" />
													</div>
													<div class="col-md-3 mb-3">
														<input type="text" class="form-control" id="keyword"
															name="keyword" placeholder="Tìm từ khóa" value="${commentSearch.keyword }" />
													</div>
													<div class="col-md-1 mb-3">
														<button type="submit" id="btnSearch" name="btnSearch"
															class="btn btn-primary">Tìm kiếm</button>
													</div>
													<div class="col-md-1 mb-3">
														<input id="currentPage" name="currentPage"
															class="form-control"
															value="${commentSearch.currentPage }" />
													</div>
												</div>
												<!-- Hết tìm kiếm -->

												<table id="zero_config"
													class="table table-striped table-bordered no-wrap">
													<thead>
														<tr align="center">
															<th scope="col">STT</th>
															<th scope="col">Tên khách hàng</th>
															<th scope="col">Hình ảnh sản phẩm</th>
															<th scope="col">Tên sản phẩm</th>
															<th scope="col">Số sao</th>
															<th scope="col">Nội dung đánh giá</th>
															<th scope="col">Ngày tạo</th>
															<th scope="col">Trạng thái</th>
															<th scope="col">Hành động</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="comment" items="${comments }"
															varStatus="loop">
															<tr>
																<td align="center">${loop.index + 1 }</td>
																<td>${comment.user.name }</td>
																<td align="center"><img width="40px" height="40px"
																	src="${classpath }/FileUploads/${comment.product.avatar }"
																	class="light-logo"></td>
																<td>${comment.product.name }</td>
																<td>
																	<!-- Hiển thị các sao đã đánh giá --> <c:set
																		var="fullStars" value="${comment.productRating / 2}" />
																	<c:set var="fullStarsInt"
																		value="${fullStars - fullStars % 1}" /> <c:set
																		var="hasHalfStar" value="${fullStars % 1 != 0}" /> <c:forEach
																		var="i" begin="1" end="${fullStarsInt}">
																		<i class="fas fa-star" style="color: #ffb800;"></i>
																	</c:forEach> <c:if test="${hasHalfStar}">
																		<i class="fas fa-star-half-alt"
																			style="color: #ffb800;"></i>
																	</c:if> <c:forEach var="i"
																		begin="${fullStarsInt + (hasHalfStar ? 1 : 0)}"
																		end="4">
																		<i class="fas fa-star" style="color: #ccc;"></i>
																	</c:forEach>
																</td>
																<td>${comment.comment }</td>
																<td><fmt:formatDate value="${comment.createDate }"
																		pattern="dd-MM-yyyy" /></td>
																<td><c:choose>
																		<c:when test="${comment.status == 'ACTIVE' }">Kích hoạt</c:when>
																		<c:otherwise>Không kích hoạt</c:otherwise>
																	</c:choose></td>
																<td><a
																	href="${classpath }/admin/comment/delete/${comment.id }"
																	role="button" class="btn btn-secondary">Xóa</a></td>
															</tr>
														</c:forEach>
													</tbody>
												</table>

												<div class="row">
													<div class="col-md-12">
														<!-- Phan trang -->
														<div class="pagination justify-content-center">
															<div id="paging"></div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</main>
			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/backend/layout/footer.jsp"></jsp:include>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/backend/layout/js.jsp"></jsp:include>
	<!-- pagination -->
	<script type="text/javascript">
		$( document ).ready(function() {
			//Dat gia tri cua status ung voi dieu kien search truoc do
			//$("#status").val(${commentSearch.status});
			//Dat gia tri cua order ung voi dieu kien search truoc do	
			//$("#keyword").val(${saleOrderSearch.keyword});
		
			$("#paging").pagination({
				currentPage: ${commentSearch.currentPage}, //Trang hien tai
				items: ${commentSearch.totalItems}, //Tong so san pham (total products)
				itemsOnPage: ${commentSearch.sizeOfPage},
				cssStyle: 'light-theme',
				onPageClick: function(pageNumber, event) {
					$('#currentPage').val(pageNumber);
					$('#btnSearch').trigger('click');
				},
			});
		});
	</script>
</body>
</html>


