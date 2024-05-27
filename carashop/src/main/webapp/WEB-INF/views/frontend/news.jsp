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
<!-- Css -->
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
</head>

<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

	<section id="page-header" class="news-header">
		<div class="container">
			<h2>Tin tức</h2>

		</div>
	</section>

	<section class="section-m1" style="margin-bottom: 0px !important;">
		<div class="container">
			<div class="row">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${classpath }/index">Trang
								chủ</a></li>
						<li class="breadcrumb-item active" aria-current="page">Tin
							tức</li>
					</ol>
				</nav>
			</div>
		</div>
	</section>

	<section class="section-p1">
		<form id="news" action="${classpath }/news" method="get">
			<div>
				<input type="hidden" id="currentPage" name="currentPage"
					class="form-control" value="${newsSearch.currentPage }">
			</div>
			<div class="container">
				<div class="row">
					<c:forEach items="${news }" var="item" varStatus="loop">
						<div class="col-12 col-md-6 col-lg-6 col-xl-4">
							<div class="item-news">
								<div class="block-thumb">
									<a class="thumb" href="${classpath }/news-detail/${item.id}"
										title="${item.title}"> <img width="512" height="385"
										class="lazyload loaded"
										src="${classpath }/FileUploads/${item.avatar }"
										alt="${item.title}">
									</a>
									<div class="info">
										<h3>
											<a class="line-clamp line-clamp-1"
												href="${classpath }/news-detail/${item.id}"
												title="${item.title}"> ${item.title} </a>
										</h3>
										<p class="justify line-clamp line-clamp-3">${item.summary}</p>
										<a class="see" href="${classpath }/news-detail/${item.id}"
											title="Xem thêm"> <span><i class="bi bi-plus-lg"></i></span>
											Xem thêm
										</a>

									</div>

									<div class="time-post">
										<fmt:formatDate value="${item.createDate}"
											pattern="'Ngày' dd, 'Tháng' MM, yyyy" />
									</div>
								</div>

							</div>
						</div>
					</c:forEach>
					<div class="col-12 mt-3 mb-3">
						<div class="pagination justify-content-center">
							<div id="paging"></div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</section>

	<section id="newsletter" class="section-p1 section-m1">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<div class="newstext">
						<h4>Đăng ký để nhận Bản Tin</h4>
						<p>
							Nhận thông tin cập nhật qua Email về cửa hàng mới nhất của chúng
							tôi và <span>ưu đãi đặc biệt.</span>
						</p>
					</div>

				</div>
				<div class="col-md-6">

					<div class="form">
						<input type="text" placeholder="Địa chỉ email của bạn">
						<button class="normal">Đăng ký</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>
	<!-- Js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>
	<!-- pagination -->
	<script type="text/javascript">
		$( document ).ready(function() {		
			$("#paging").pagination({
				currentPage: ${newsSearch.currentPage}, //Trang hien tai
				items: ${newsSearch.totalItems}, //Tong so san pham (total products)
				itemsOnPage: ${newsSearch.sizeOfPage}, // số sản phẩm trên 1 trang
				cssStyle: 'light-theme',
				onPageClick: function(pageNumber, event) {
					event.preventDefault();
					$('#currentPage').val(pageNumber);
					$('#news').submit();
				},
			});
		});
	</script>
</body>
</html>