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

	<section class="section-m1">
		<div class="container">
			<div class="row">
				<nav aria-label="breadcrumb">

					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${classpath}/index">Trang
								chủ</a></li>
						<li class="breadcrumb-item"><a href="${classpath}/product">Sản
								phẩm</a></li>
						<c:forEach items="${categories}" var="category">
							<c:if test="${productSearch.categoryId == category.id}">
								<li class="breadcrumb-item active" aria-current="page">${category.name}</li>
							</c:if>
						</c:forEach>
					</ol>

				</nav>
			</div>
		</div>
	</section>

	<section id="product1" style="text-align: left !important;">
		<sf:form id="productSearchForm" action="${classpath }/product"
			method="GET" modelAttribute="category" enctype="multipart/form-data">
			<div class="container">
				<div class="row">

					<div class="col-lg-9 order-lg-last">

						<div class="product1-content d-flex">
							<div class="product1-title col-md-6"
								style="padding-left: 0px !important;">
								<c:set var="categoryFound" value="false" />
								<c:forEach items="${categories}" var="category">
									<c:if test="${productSearch.categoryId == category.id}">
										<c:set var="categoryFound" value="true" />
										<h2>${category.name} </h2>
									</c:if>
								</c:forEach>

								<c:choose>
									<c:when test="${!categoryFound}">
										<h2>Tất cả sản phẩm</h2>
									</c:when>

								</c:choose>
							</div>

							<div>
								<input type="hidden" id="currentPage" name="currentPage"
									class="form-control" value="${productSearch.currentPage }">
							</div>

							<div
								class="product1-swap col-md-6 d-flex justify-content-end
                                align-items-end"
								style="padding-right: 0px;">
								<p style="margin-right: 10px;">Sắp xếp :</p>

								<select class="custom-select" style="width: 200px;"
									id="sortOption" name="sortOption">
									<option value="all" selected>Mặc định</option>
									<option value="nameASC"
										<c:if test="${productSearch.sortOption.equals('nameASC')}">selected</c:if>>Tên
										(A - Z)</option>
									<option value="nameDESC"
										<c:if test="${productSearch.sortOption.equals('nameDESC')}">selected</c:if>>Tên
										(Z - A)</option>
									<option value="priceASC"
										<c:if test="${productSearch.sortOption.equals('priceASC')}">selected</c:if>>Giá
										(Thấp > Cao)</option>
									<option value="priceDESC"
										<c:if test="${productSearch.sortOption.equals('priceDESC')}">selected</c:if>>Giá
										(Cao > Thấp)</option>
								</select>
							</div>
						</div>

						<div class="row">
							<c:choose>
								<c:when test="${empty products}">
									<div class="col-12 pt-3">

										<div class="alert alert-warning alert-dismissible fade show"
											role="alert">
											Không có sản phẩm nào trong danh mục này.
											<button type="button" class="close" data-dismiss="alert"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
									</div>
								</c:when>
								<c:otherwise>

									<c:forEach items="${products }" var="product" varStatus="loop">
										<div class="col-sm-6 col-lg-4 ">
											<div class="pro">
												<div class="pro-banner">
													<a class="pro-img"
														href="${classpath }/product-detail/${product.id}"><img
														src="${classpath }/FileUploads/${product.avatar }" alt=""></a>
													<div class="pro-actions">
														<a href="${classpath }/product-detail/${product.id}"
															class="action-btn" aria-label="Xem chi tiết"> <i
															class="bi bi-eye"></i>
														</a> <a onclick="addToFavorite(${product.id})"
															class="action-btn" aria-label="Thêm vào yêu thích"> <i
															class="bi bi-suit-heart"></i>
														</a>
													</div>
												</div>
												<c:if test="${product.salePrice > 0}">
													<div class="sale-flash">
														<fmt:formatNumber value="${discounts[loop.index] * -1}"
															type="number" pattern="#,##0'%'" />
													</div>
												</c:if>
												<div class="des">
													<%-- <div>${product.category.name}</div> --%>
													<a href="${classpath }/product-detail/${product.id}">
														${product.name } </a>
													<div class="product-rating">
														<div class="star">
															<!-- Hiển thị các sao đã đánh giá -->
															<c:set var="aveRating"
																value="${averageRating[product.id]}" />
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
												<c:set var="firstSize"
													value="${fn:split(product.size, ',')[0]}" />
												<a class="cart"
													onclick="addToCart(${product.id}, 1, '${product.name}', '${firstSize}')">
													<i class="fa-solid fa-cart-shopping"></i>
												</a>
											</div>
										</div>
									</c:forEach>

									<div class="col-12 mt-3 mb-3">
										<div class="pagination justify-content-center">
											<div id="paging"></div>
										</div>
									</div>

								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="col-lg-3 search_filter mb-5">
						<div class="sidebar mb-4">
							<h4 class="text-uppercasse title">Danh Mục</h4>
							<ul class="menu_sidebar">
								<c:forEach items="${categories}" var="category">
									<li><input type="checkbox" value="${category.id}"
										name="categoryId" id="category_${category.id}"
										<c:if test="${productSearch.categoryId == category.id}">checked</c:if>>
										<label for="category_${category.id}">${category.name}</label>
										<%-- <a href="${classpath }/product/${category.id}">${category.name}</a> --%>
									</li>
								</c:forEach>
							</ul>
						</div>
						<div class="sidebar mt-4 mb-4">
							<h4 class="text-uppercasse title">Lọc theo giá</h4>
							<!-- Các ô checkbox giá -->
							<ul class="menu_sidebar filter">
								<li><input type="checkbox" value="2" name="priceCheck"
									id="priceCheck2"
									<c:if test="${productSearch.priceCheck == 1}">checked</c:if>>
									<label for="priceCheck2">100.000₫ - 200.000₫</label></li>
								<li><input type="checkbox" value="3" name="priceCheck"
									id="priceCheck3"
									<c:if test="${productSearch.priceCheck == 2}">checked</c:if>>
									<label for="priceCheck3">200.000₫ - 300.000₫</label></li>
								<li><input type="checkbox" value="4" name="priceCheck"
									id="priceCheck4"
									<c:if test="${productSearch.priceCheck == 3}">checked</c:if>>
									<label for="priceCheck4">300.000₫ - 500.000₫</label></li>
								<li><input type="checkbox" value="5" name="priceCheck"
									id="priceCheck5"
									<c:if test="${productSearch.priceCheck == 4}">checked</c:if>>
									<label for="priceCheck5">500.000₫ - 1.000.000₫</label></li>
								<li><input type="checkbox" value="6" name="priceCheck"
									id="priceCheck6"
									<c:if test="${productSearch.priceCheck == 5}">checked</c:if>>
									<label for="priceCheck6">Giá trên 1.000.000₫</label></li>
							</ul>
						</div>
						<div class="sidebar mt-4 mb-4">
							<h4 class="text-uppercasse title">Lọc theo size</h4>
							<!-- Các ô checkbox giá -->
							<ul class="menu_sidebar filter">
								<li><input type="checkbox" value="M" name="sizeCheck"
									id="size_1"
									<c:if test="${productSearch.sizeCheck == 'M'}">checked</c:if>>
									<label for="size_1">M</label></li>
								<li><input type="checkbox" value="L" name="sizeCheck"
									id="size_2"
									<c:if test="${productSearch.sizeCheck == 'L'}">checked</c:if>>
									<label for="size_2">L</label></li>
								<li><input type="checkbox" value="XL" name="sizeCheck"
									id="size_3"
									<c:if test="${productSearch.sizeCheck == 'XL'}">checked</c:if>>
									<label for="size_3">XL</label></li>
								<li><input type="checkbox" value="XXL" name="sizeCheck"
									id="size_4"
									<c:if test="${productSearch.sizeCheck == 'XXL'}">checked</c:if>>
									<label for="size_4">XXL</label></li>
							</ul>
						</div>
						<button type="submit" class="normal">Lọc</button>
						<a href="${classpath }/product" class="normal" type="reset">Bỏ lọc</a>
						<div class="sidebar mt-4 mb-4">
							<h4 class="text-uppercasse title">
								<i class="fa-regular fa-clock"></i> Giờ cửa hàng
							</h4>
							<div class="line"></div>
							<ul class="worktime">
								<li>
									<p class="worktime-day">Thứ 2:</p> <span class="worktime-clock">8:00
										am - 6:00 pm</span>
								</li>
								<li>
									<p class="worktime-day">Thứ 3:</p> <span class="worktime-clock">8:00
										am - 6:00 pm</span>
								</li>
								<li>
									<p class="worktime-day">Thứ 4:</p> <span class="worktime-clock">8:00
										am - 6:00 pm</span>
								</li>
								<li>
									<p class="worktime-day">Thứ 5:</p> <span class="worktime-clock">8:00
										am - 6:00 pm</span>
								</li>
								<li>
									<p class="worktime-day">Thứ 6:</p> <span class="worktime-clock">8:00
										am - 6:00 pm</span>
								</li>

							</ul>
						</div>
					</div>

				</div>
			</div>
		</sf:form>
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
	<!-- Sort Select -->
	<script>
		$(document).ready(function() {
	    	$('#sortOption').change(function() {
	        	$('#productSearchForm').submit();
	    	});
		});
	</script>
	<!-- pagination -->
	<script type="text/javascript">
		$( document ).ready(function() {
			//$("#keyword").val(${productSearch.keyword}); 
			//$("#sortOption").val(${productSearch.sortOption});			
			$("#paging").pagination({
				currentPage: ${productSearch.currentPage}, //Trang hien tai
				items: ${productSearch.totalItems}, //Tong so san pham (total products)
				itemsOnPage: ${productSearch.sizeOfPage}, // số sản phẩm trên 1 trang
				cssStyle: 'light-theme',
				onPageClick: function(pageNumber, event) {
					$('#currentPage').val(pageNumber);
					$('#productSearchForm').submit();
				},
			});
		});
	</script>
	</body>
</html>