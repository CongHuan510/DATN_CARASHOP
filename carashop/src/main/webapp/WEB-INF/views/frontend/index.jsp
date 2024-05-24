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

	<section id="hero">
		<div class="container">
			<h4>Ưu đãi trao đổi</h4>
			<h2>Ưu đãi siêu giá trị</h2>
			<h1>Trên tất cả các sản phẩm</h1>
			<p>Tiết kiệm thêm phiếu giảm giá chiều rộng và giảm giá tới 70%!</p>
			<button>Mua ngay</button>
		</div>
	</section>

	<section class="section-p1">
		<div class="container">
			<div id="feature" class="row slide-img">
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f1.png" alt="">
						<h6>Miễn phí vận chuyển</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f2.png" alt="">
						<h6>Đặt hàng trực tuyến</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f3.png" alt="">
						<h6>Tiết kiệm tiền</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f4.png" alt="">
						<h6>Khuyến mãi</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f5.png" alt="">
						<h6>Bán vui vẻ</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f6.png" alt="">
						<h6>Hỗ trợ 24/7</h6>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="product1" class="section-p1">
		<div class="container ">
			<h2>Sản phẩm nổi bật</h2>
			<div class="row autoplay">
				<c:forEach items="${isHotProducts }" var="product" varStatus="loop">
					<div class="col-12 col-sm-6 col-lg-4 col-xl-3 ">
						<div class="pro">
							<div class="pro-banner">
								<a class="pro-img"
									href="${classpath }/product-detail/${product.id}"><img
									src="${classpath }/FileUploads/${product.avatar }" alt=""></a>
								<div class="pro-actions">
									<a href="${classpath }/product-detail/${product.id}"
										class="action-btn" aria-label="Xem chi tiết"> <i
										class="bi bi-eye"></i>
									</a> <a onclick="addToFavorite(${product.id})" class="action-btn"
										aria-label="Thêm vào yêu thích"> <i
										class="bi bi-suit-heart"></i>
									</a>
								</div>
							</div>
							<c:if test="${product.salePrice > 0}">
								<div class="sale-flash">
									<fmt:formatNumber
										value="${discountsForHotProducts[loop.index] * -1}"
										type="number" pattern="#,##0'%'" />
								</div>
							</c:if>
							<div class="des">
								<a href="${classpath }/product-detail/${product.id}">
									${product.name } </a>
								<div class="product-rating">
									<div class="star">
										<!-- Hiển thị các sao đã đánh giá -->
										<c:set var="aveRating" value="${averageRating[product.id]}" />
										<c:set var="fullStars" value="${aveRating / 2}" />
										<c:set var="fullStarsInt" value="${fullStars - fullStars % 1}" />
										<c:set var="hasHalfStar" value="${fullStars % 1 != 0}" />

										<c:forEach var="i" begin="1" end="${fullStarsInt}">
											<i class="fas fa-star" style="color: #ffb800;"></i>
										</c:forEach>

										<c:if test="${hasHalfStar}">
											<i class="fas fa-star-half-alt" style="color: #ffb800;"></i>
										</c:if>

										<c:forEach var="i"
											begin="${fullStarsInt + (hasHalfStar ? 1 : 0)}" end="4">
											<i class="fas fa-star" style="color: #ccc;"></i>
										</c:forEach>
									</div>
									<div class="rating-number">(${totalReviewsMap[product.id]}
										đánh giá)</div>
								</div>
								<div class="pro-price">
									<c:choose>
										<c:when test="${product.salePrice > 0}">
											<span class="new-price"><fmt:formatNumber
													value="${product.salePrice}" pattern="#,##0₫" /> </span>
											<span class="old-price"><fmt:formatNumber
													value="${product.price}" pattern="#,##0₫" /> </span>
										</c:when>
										<c:otherwise>
											<span class="default-price"><fmt:formatNumber
													value="${product.price}" pattern="#,##0₫" /> </span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<c:set var="firstSize" value="${fn:split(product.size, ',')[0]}" />
							<a class="cart"
								onclick="addToCart(${product.id}, 1, '${product.name}', '${firstSize}')">
								<i class="fa-solid fa-cart-shopping"></i>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<section id="banner" class="section-m1">
		<div class="container">
			<h4>Dịch vụ sửa chữa</h4>
			<h2>
				Giảm đến <span>70%</span> - Tất cả áo phông và phụ kiện
			</h2>
			<button class="normal">Tìm hiểu thêm</button>
		</div>
	</section>

	<section id="product1" class="section-p1">
		<!-- Danh mục sản phẩm -->
		<div class="container">
			<div class="row">
				<div class="col-md-1">
					<input type="hidden" id="currentPage" name="currentPage"
						class="form-control" value="${productSearch.currentPage }">
				</div>
			</div>
			<h2>Sản phẩm mới nhất</h2>
			<div class="row">
				<c:forEach items="${products }" var="product" varStatus="loop">
					<div class="col-12 col-sm-6 col-lg-4 col-xl-3 ">
						<div class="pro">
							<div class="pro-banner">
								<a class="pro-img"
									href="${classpath }/product-detail/${product.id}"><img
									src="${classpath }/FileUploads/${product.avatar }" alt=""></a>
								<div class="pro-actions">
									<a href="${classpath }/product-detail/${product.id}"
										class="action-btn" aria-label="Xem chi tiết"> <i
										class="bi bi-eye"></i>
									</a> <a onclick="addToFavorite(${product.id})" class="action-btn"
										aria-label="Thêm vào yêu thích"> <i
										class="bi bi-suit-heart"></i>
									</a>
								</div>
							</div>
							<c:if test="${product.salePrice > 0}">
								<div class="sale-flash">
									<fmt:formatNumber
										value="${discountsForAllProducts[loop.index] * -1}"
										type="number" pattern="#,##0'%'" />
								</div>
							</c:if>
							<div class="des">
								<a href="${classpath }/product-detail/${product.id}">
									${product.name } </a>
								<div class="product-rating">
									<div class="star">
										<!-- Hiển thị các sao đã đánh giá -->
										<c:set var="aveRating" value="${averageRating[product.id]}" />
										<c:set var="fullStars" value="${aveRating / 2}" />
										<c:set var="fullStarsInt" value="${fullStars - fullStars % 1}" />
										<c:set var="hasHalfStar" value="${fullStars % 1 != 0}" />

										<c:forEach var="i" begin="1" end="${fullStarsInt}">
											<i class="fas fa-star" style="color: #ffb800;"></i>
										</c:forEach>

										<c:if test="${hasHalfStar}">
											<i class="fas fa-star-half-alt" style="color: #ffb800;"></i>
										</c:if>

										<c:forEach var="i"
											begin="${fullStarsInt + (hasHalfStar ? 1 : 0)}" end="4">
											<i class="fas fa-star" style="color: #ccc;"></i>
										</c:forEach>
									</div>

									<div class="rating-number">(${totalReviewsMap[product.id]}
										đánh giá)</div>

								</div>
								<div class="pro-price">
									<c:choose>
										<c:when test="${product.salePrice > 0}">
											<span class="new-price"><fmt:formatNumber
													value="${product.salePrice}" pattern="#,##0₫" /> </span>
											<span class="old-price"><fmt:formatNumber
													value="${product.price}" pattern="#,##0₫" /> </span>
										</c:when>
										<c:otherwise>
											<span class="default-price"><fmt:formatNumber
													value="${product.price}" pattern="#,##0₫" /> </span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<%-- <a onclick="addToFavorite(${product.id})" class="heart"><i
														class="fa-solid fa-heart"></i></a>  --%>
							<c:set var="firstSize" value="${fn:split(product.size, ',')[0]}" />
							<a class="cart"
								onclick="addToCart(${product.id}, 1, '${product.name}', '${firstSize}')">
								<i class="fa-solid fa-cart-shopping"></i>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- <div class="row mt-3">
						<div class="col-12">
							<div class="pagination justify-content-center">
								<div id="paging"></div>
							</div>
						</div>
					</div> -->
		</div>
	</section>

	<section id="sm-banner" class="section-p1">
		<div class="container">
			<div class="row">
				<div class="col-md-6 ">
					<div class="banner-box">
						<h4>giao dịch điên rồ</h4>
						<h2>mua 1 tặng 1</h2>
						<span>Chiếc váy cổ điển đẹp nhất đang được giảm giá tại
							cara</span>
						<button class="white">Tìm hiểu thêm</button>
					</div>
				</div>
				<div class="col-md-6 matop20">
					<div class="banner-box banner-box2">
						<h4>xuân/hè</h4>
						<h2>mùa sắp tới</h2>
						<span>Chiếc váy cổ điển đẹp nhất đang được giảm giá tại
							cara</span>
						<button class="white">Bộ sưu tập</button>
					</div>
				</div>

			</div>
		</div>
	</section>

	<section id="banner3">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<div class="banner-box">
						<h2>BÁN THEO MÙA</h2>
						<h3>Bộ sưu tập mùa đông - GIẢM GIÁ 50%</h3>
					</div>
				</div>
				<div class="col-md-4">
					<div class="banner-box banner-box2">
						<h2>BỘ SƯU TẬP MỚI</h2>
						<h3>Xuân / Hè 2024</h3>
					</div>
				</div>
				<div class="col-md-4">
					<div class="banner-box banner-box3">
						<h2>ÁO THUN</h2>
						<h3>Bản in hợp thời trang mới</h3>
					</div>
				</div>
			</div>
		</div>
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
	<!-- Toast -->
	<jsp:include page="/WEB-INF/views/frontend/layout/toast.jsp"></jsp:include>
	<!-- Js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>
	<!-- Add to cart -->
	<script type="text/javascript">
		addToCart = function(_productId, _quantity, _productName, _size) {		
			//alert("Thêm "  + _quantity + " sản phẩm '" + _productName + "' vào giỏ hàng ");	
			let data = {
				productId: _productId, //lay theo id
				quantity: _quantity, //
				productName: _productName,
				size: _size, 
			};
				
			//$ === jQuery
			jQuery.ajax({
				url : "/add-to-cart",
				type : "POST",
				contentType: "application/json",
				data : JSON.stringify(data),
				dataType : "json", //Kieu du lieu tra ve tu controller la json
				
				success : function(jsonResult) {
				    //alert(jsonResult.code + ": " + jsonResult.message); 
				     if (jsonResult.errorMessage) {
		                $('.toast-body-error').html(jsonResult.errorMessage);
		                $('.toast-error').toast('show');
		            } else {
					    $('.toast-body-success').html(jsonResult.message);
		                $('.toast-success').toast('show');
					    let totalProducts = jsonResult.totalCartProducts;
					    $("#totalCartProductsId").html(totalProducts);
		            }
				},

				error : function(jqXhr, textStatus, errorMessage) {
					var response = JSON.parse(jqXhr.responseText);
					var errorMessage = response.errorMessage;
					$('.toast-body-error').html(errorMessage);
					$('.toast-error').toast('show');
				},
			});
		}
	</script>
	<!-- Add to favorite -->
	<script type="text/javascript">
		addToFavorite = function(_productId) {
		    // lấy đối tượng từ Product 
		    //$ === jQuery
		    jQuery.ajax({
		        url: "/add-to-favorite/" + _productId,
		        type: "POST",
		        contentType: "application/json",
		        dataType: "json",
		        success: function(jsonResult) {
		            if (jsonResult.errorMessage) {
		                $('.toast-body-error').html(jsonResult.errorMessage);
		                $('.toast-error').toast('show');
		            } else {
		                $('.toast-body-success').html(jsonResult.message);
		                $('.toast-success').toast('show');
		                let totalFavorites = jsonResult.totalFavoriteProducts;
		                $("#totalFavoriteProductsId").html(totalFavorites);
		            }
		        },
		        error: function(jqXhr, textStatus, errorMessage) {
		            $('.toast-body-error').html('Đã có lỗi xảy ra: ' + errorMessage);
		            $('.toast-error').toast('show');
		        },
		    });
		}
	</script>
</body>
</html>