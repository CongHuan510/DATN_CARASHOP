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


</head>

<body>
	<div class="wrapper">
		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/backend/layout/sidebar.jsp"></jsp:include>

		<div class="main">
			<jsp:include page="/WEB-INF/views/backend/layout/navbar.jsp"></jsp:include>

			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h1 mb-3" style="font-weight: 700;">Danh sách sản
						phẩm</h1>

					<div class="container-fluid">
						<!-- ============================================================== -->
						<!-- Start Page Content -->
						<!-- ============================================================== -->
						<!-- basic table -->
						<div class="row">
							<div class="col-12">
								<div class="card">

									<div class="card-body">
										<form action="${classpath }/admin/product/list" method="get">
											<div class="table-responsive">

												<div class="row">
													<div class="col-md-2">
														<div class="form-group mb-4">
															<a href="${classpath }/admin/product/add" role="button"
																class="btn btn-primary">Thêm mới</a>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group mb-4">
															<h3>Tổng số sản phẩm: ${productSearch.totalItems}</h3>
														</div>
													</div>

													<div class="col-md-6">
														<div class="form-group mb-4">
															<label>Trang hiện tại</label> <input id="currentPage"
																name="currentPage" class="form-control"
																value="${productSearch.currentPage }" />
														</div>
													</div>

												</div>
												<!-- Tìm kiếm -->
												<div class="row">
													<div class="col-md-2">
														<div class="form-group mb-4">		
															<select class="form-control" id="status" name="status">
																<option value="ALL">Tất cả sản phẩm</option>
																<option value="ACTIVE" <c:if test="${productSearch.status == 'ACTIVE' }">selected</c:if>>Kích hoạt</option>
																<option value="INACTIVE" <c:if test="${productSearch.status == 'INACTIVE' }">selected</c:if>>Không kích hoạt</option>
															</select>
														</div>
													</div>

													<div class="col-md-2 mb-3">
														<select class="form-control" id="categoryId"
															name="categoryId" style="margin-right: 10px;">
															<option value="0">Chọn danh mục</option>
															<c:forEach items="${categories }" var="category">
																<option value="${category.id }" <c:if test="${category.id eq productSearch.categoryId}">selected</c:if>>${category.name }</option>
															</c:forEach>
														</select>
													</div>

													<div class="col-md-2 mb-3">
														<input class="form-control" type="date" id="beginDate"
															name="beginDate" value="${productSearch.beginDate }" />
													</div>
													<div class="col-md-2 mb-3">
														<input class="form-control" type="date" id="endDate"
															name="endDate" value="${productSearch.endDate }" />
													</div>

													<div class="col-md-3 mb-3">
														<input type="text" class="form-control" id="keyword"
															name="keyword" placeholder="Tìm từ khóa" value="${productSearch.keyword }" />
													</div>

													<div class="col-md-1 mb-3" style="padding-left: 0px;">
														<button type="submit" id="btnSearch" name="btnSearch"
															class="btn btn-primary">Tìm kiếm</button>
													</div>
												</div>
												<!-- Hết tìm kiếm -->
												<table id="zero_config"
													class="table table-striped table-bordered no-wrap">
													<thead>
														<tr align="center">
															<th scope="col">STT</th>
															<th scope="col">Mã sản phẩm</th>
															<th scope="col">Tên danh mục</th>
															<th scope="col">Tên sản phẩm</th>
															<th scope="col">Số lượng</th>
															<th scope="col">Giá bán</th>
															<th scope="col">Giá giảm</th>
															<th scope="col">Kích cỡ</th>
															<th scope="col">Hình đại diện sản phẩm</th>
															<th scope="col">Mô tả ngắn</th>
															<th scope="col">Mô tả chi tiết</th>
															<th scope="col">Người tạo</th>
															<th scope="col">Người cập nhật</th>
															<th scope="col">Ngày tạo</th>
															<th scope="col">Ngày cập nhật</th>
															<th scope="col">Trạng thái</th>
															<th scope="col">Là nổi bật</th>
															<th scope="col">Hành động</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="product" items="${products }"
															varStatus="loop">
															<tr>
																<td>${loop.index + 1 }</td>
																<td>${product.id }</td>
																<td>${product.category.name }</td>
																<td>${product.name }</td>
																<td align="right">${product.productQuantity }</td>
																<td align="right"><fmt:formatNumber
																		value="${product.price}" pattern="#,##0₫" /></td>
																<td align="right"><fmt:formatNumber
																		value="${product.salePrice}" pattern="#,##0₫" /></td>
																<td>${product.size }</td>
																<td><img width="40px" height="40px"
																	src="${classpath }/FileUploads/${product.avatar }"
																	class="light-logo"></td>

																<td class="description-column">${product.shortDescription }</td>
																<td class="description-column">${product.detailDescription }</td>
																<td>${product.userCreateProduct.username }</td>
																<td>${product.userUpdateProduct.username }</td>

																<td><fmt:formatDate value="${product.createDate }"
																		pattern="dd-MM-yyyy" /></td>
																<td><fmt:formatDate value="${product.updateDate }"
																		pattern="dd-MM-yyyy" /></td>

																<td><span id="_product_status_${product.id }">
																		<c:choose>
																			<c:when test="${product.status == 'ACTIVE' }">
																				<span>Kích hoạt</span>
																			</c:when>
																			<c:otherwise>
																				<span>Không kích hoạt</span>
																			</c:otherwise>
																		</c:choose>
																</span></td>
																<td><span id="_product_isHot_${product.id }">
																		<c:choose>
																			<c:when test="${product.isHot }">
																				<span>Có</span>
																			</c:when>
																			<c:otherwise>
																				<span>Không</span>
																			</c:otherwise>
																		</c:choose>
																</span></td>
																<td><a
																	href="${classpath }/admin/product/detail/${product.id }"
																	role="button" class="btn btn-success">Chi tiết</a> <a
																	href="${classpath }/admin/product/edit/${product.id }"
																	role="button" class="btn btn-primary">Sửa</a> <a
																	href="${classpath }/admin/product/delete/${product.id }"
																	role="button" class="btn btn-secondary">Xóa</a></td>
															</tr>
														</c:forEach>
													</tbody>
												</table>

												<div class="row">
													<div class="col-md-6">
														<div class="form-group mb-4">
															<a href="${classpath }/admin/product/add" role="button"
																class="btn btn-primary">Thêm mới</a>
														</div>
													</div>

													<div class="col-md-6">
														<div class="pagination float-right">
															<div id="paging"></div>
														</div>
													</div>
												</div>
											</div>
										</form>
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
	<!-- pagination -->
	<script type="text/javascript">
		$( document ).ready(function() {
			//Dat gia tri cua status ung voi dieu kien search truoc do
			//$("#status").val(${productSearch.status});
			//Dat gia tri cua category ung voi dieu kien search truoc do
			$("#categoryId").val(${productSearch.categoryId});
			
			//Dat gia tri cua category ung voi dieu kien search truoc do
			//$("#keyword").val(${productSearch.keyword});
			
			$("#paging").pagination({
				currentPage: ${productSearch.currentPage}, //Trang hien tai
				items: ${productSearch.totalItems}, //Tong so san pham (total products)
				itemsOnPage: ${productSearch.sizeOfPage},
				cssStyle: 'light-theme',
				onPageClick: function(pageNumber, event) {
					event.preventDefault();
					$('#currentPage').val(pageNumber);
					$('#btnSearch').trigger('click');
					return false;
				},
			});
		});
	</script>

</body>

</html>