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
<!-- Css -->
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
</head>
</head>

<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

	<section id="page-header">
		<div class="container">
			<h2>#Sản phẩm</h2>
			<p>Tiết kiệm thêm phiếu giảm giá chiều rộng và giảm giá tới 70%!</p>
		</div>
	</section>

	<section class="section-m1" style="margin-bottom: 0px !important;">
		<div class="container">
			<div class="row">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${classpath }/index">Trang chủ</a></li>
						<li class="breadcrumb-item active" aria-current="page">Yêu thích</li>
					</ol>
				</nav>
			</div>
		</div>
	</section>

	<section id="product1" class="section-p1">
		<div class="container ">
			<div class="row">
				<c:choose>
					<c:when test="${not empty favoriteProducts}">
						<div class="col-12">
							<h2>Sản phẩm yêu thích</h2>
						</div>
						<c:forEach items="${favoriteProducts}" var="f" varStatus="loop">
							<div id="favoriteProduct_${f.product.id}"
								class="col-12 col-sm-6 col-lg-4 col-xl-3 ">
								<div class="pro">
									<div class="pro-banner">
										<a class="pro-img"
											href="${classpath }/product-detail/${f.product.id}"><img
											src="${classpath }/FileUploads/${f.product.avatar }" alt=""></a>
										<div class="pro-actions">
											<a href="${classpath }/product-detail/${f.product.id}"
												class="action-btn" aria-label="Xem chi tiết"> <i
												class="bi bi-eye"></i>
											</a> <a onclick="removeFromFavorite(${f.product.id})"
												class="action-btn" aria-label="Bỏ yêu thích"> <i
												class="bi bi-suit-heart"></i>
											</a>
										</div>
									</div>
									<c:if test="${f.product.salePrice > 0}">
										<div class="sale-flash">
											<fmt:formatNumber value="${discounts[loop.index] * -1}"
												type="number" pattern="#,##0'%'" />
										</div>
									</c:if>
									<div class="des">
										<a href="${classpath }/product-detail/${f.product.id}">
											${f.product.name } </a>
											<div class="product-rating">
										<div class="star">
											<!-- Hiển thị các sao đã đánh giá -->
											<c:set var="aveRating" value="${averageRating[f.product.id]}" />
											<c:set var="fullStars" value="${aveRating / 2}" />
											<c:set var="fullStarsInt"
												value="${fullStars - fullStars % 1}" />
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
										<div class="rating-number">(${totalReviewsMap[f.product.id]} đánh giá)</div>
								</div>

										<div class="pro-price">
											<c:choose>
												<c:when test="${f.product.salePrice > 0}">
													<span class="new-price"><fmt:formatNumber
															value="${f.product.salePrice }" pattern="#,##0₫"/>
													</span>
													<span class="old-price"><fmt:formatNumber
															value="${f.product.price }" pattern="#,##0₫"/>
													</span>
												</c:when>
												<c:otherwise>
													<span class="default-price"><fmt:formatNumber
															value="${f.product.price }" pattern="#,##0₫"/>
													</span>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<%-- <a onclick="addToFavorite(${product.id})" class="heart"><i
														class="fa-solid fa-heart"></i></a>  --%>
									<c:set var="firstSize"
										value="${fn:split(f.product.size, ',')[0]}" />
									<a class="cart"
										onclick="addToCart(${f.product.id}, 1, '${f.product.name}', '${firstSize}')">
										<i class="fa-solid fa-cart-shopping"></i>
									</a>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="col-12">
							<div class="alert alert-warning margin-top-15 section"
								role="alert">${errorMessage }</div>
						</div>
					</c:otherwise>
				</c:choose>
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
							Nhận thông tin cập nhật qua Email về cửa hàng mới nhất của chúng tôi và 
							<span>ưu đãi đặc biệt.</span>
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
				quantity: _quantity,
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
	<!-- Remove favorite -->
	<script type="text/javascript">
		removeFromFavorite = function(_productId) {
		    //$ === jQuery
		    jQuery.ajax({
		        url: "/remove-from-favorite/" + _productId, // Chú ý vào đây, phần này phải là /remove-from-favorite/ thay vì /remove-from-favorite"/
		        type: "POST",
		        contentType: "application/json",
		        dataType: "json",
		        success: function(jsonResult) {
		            // Xóa sản phẩm yêu thích khỏi giao diện ngay sau khi xóa thành công
		            $("#favoriteProduct_" + _productId).remove(); // Sử dụng _productId thay vì productId
		            //alert(jsonResult.code + ": " + jsonResult.message);	 
		            $('.toast-body-success').html(jsonResult.message);
	                $('.toast-success').toast('show');
		            let totalFavorites = jsonResult.totalFavoriteProducts;
		            $("#totalFavoriteProductsId").html(totalFavorites); // Cập nhật số lượng sản phẩm yêu thích hiển thị trên giao diện
		        },
		        error: function(jqXhr, textStatus, errorMessage) {
		            //alert("Đã có lỗi xảy ra: " + errorMessage); 
		        	$('.toast-body-error').html('Đã có lỗi xảy ra: ' + errorMessage);
		            $('.toast-error').toast('show');
		        },
		    });
		}
	</script>
</body>
</html>