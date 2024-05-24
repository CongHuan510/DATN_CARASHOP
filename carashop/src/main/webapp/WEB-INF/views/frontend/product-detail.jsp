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
	<!-- Toast -->
	<jsp:include page="/WEB-INF/views/frontend/layout/toast.jsp"></jsp:include>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

	<section class="section-m1" style="margin-bottom: 0px;">
		<div class="container">
			<div class="row">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${classpath }/index">Trang
								chủ</a></li>
						<li class="breadcrumb-item"><a href="${classpath }/product">Sản
								phẩm</a></li>
						<li class="breadcrumb-item"><a
							href="${classpath }/product?categoryId=${categoryId}">${categoryName }</a></li>
						<li class="breadcrumb-item active" aria-current="page">${product.name}</li>
					</ol>
				</nav>
			</div>
		</div>
	</section>

	<section id="prodetails">
		<div class="container">
			<div class="section_product-detail">
				<form action="${classpath }/product-detail" method="get">
					<div class="row mb-4">
						<div class="col-12 col-lg-5 single-pro-image">
							<div class="slider slider-for">
								<c:forEach items="${productImages }" var="productImage">
									<div>
										<img src="${classpath }/FileUploads/${productImage.path }"
											width="100%">
									</div>
								</c:forEach>
							</div>
							<div class="slider slider-nav">
								<c:forEach items="${productImages }" var="productImage">
									<div>
										<img src="${classpath }/FileUploads/${productImage.path }">
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="col-12 col-lg-7 single-pro-details">
							<h4 class="product-title">${product.name }</h4>
							<div class="inventory-quantity">
								<p class="detail-category">
									Loại: <span>${product.category.name }</span>
								</p>
								<p class="status-quantity">
									Tình trạng:
									<c:choose>
										<c:when test="${inventoryQuantity > 0}">
											<span>Còn hàng</span>
										</c:when>
										<c:otherwise>
											<span>Hết hàng</span>
										</c:otherwise>
									</c:choose>
								</p>
							</div>

							<div class="product-rating">
								<div class="star">
									<!-- Hiển thị các sao đã đánh giá -->
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
							<div class="detail-price">
								<c:choose>
									<c:when test="${product.salePrice > 0}">
										<span class="new-price"> $ <fmt:formatNumber
												value="${product.salePrice }" pattern="#,##0₫" />
										</span>
										<span class="old-price"> $ <fmt:formatNumber
												value="${product.price }" pattern="#,##0₫" />
										</span>
										<span class="save-price"> <fmt:formatNumber
												value="${discounts[loop.index]}" type="number"
												pattern="#,##0'%'" />
										</span>
									</c:when>
									<c:otherwise>
										<span class="default-price"> $ <fmt:formatNumber
												value="${product.price }" pattern="#,##0₫" />
										</span>
									</c:otherwise>
								</c:choose>
							</div>
							<h4 class="pt-3">Thông tin sản phẩm</h4>
							<p class="short-description">${product.shortDescription }</p>
							<ul class="product-list">
								<li class="list-item d-flex align-items-center"><i
									class="fa-solid fa-crown"></i> Bảo hành thương hiệu Al Jazeera
									1 năm</li>
								<li class="list-item d-flex align-items-center"><i
									class="fa-solid fa-rotate"></i> Chính sách hoàn trả trong 30
									ngày</li>
								<li class="list-item d-flex align-items-center"><i
									class="fa-regular fa-credit-card"></i> Tiền mặt khi giao hàng
									có sẵn</li>
							</ul>
							<div class="detail-size d-flex align-items-center">
								<div>
									<p class="details-size-title">
										Size: <span></span>
									</p>
								</div>

								<div>
									<!-- Button trigger modal -->
									<a role="button" class="size-button"
										data-toggle="modal" data-target="#exampleModal">
										Hướng dẫn chọn size</a>

									<!-- Modal -->
									<div class="modal fade" id="exampleModal" tabindex="-1"
										aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="exampleModalLabel">Chọn cỡ size của bạn</h5>
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
												</div>
												<div class="modal-body">
													<p style="text-align: center;"><img alt="chọn size" src="//bizweb.dktcdn.net/100/491/897/files/ao-somi-784bed513c634373862666a1.png?v=1694097281346"></p>
													<div class="bangsize-des">97% khách hàng của chúng tôi đã chọn đúng size theo bảng này</div>
												</div>	
											</div>
										</div>
									</div>

								</div>

							</div>
							<div class="size-list">
								<c:forEach var="size" items="${sizes}" varStatus="loop">
									<c:forEach var="individualSize" items="${fn:split(size, ',')}"
										varStatus="innerLoop">
										<label class="option-select__item option-size">
											<div class="option-select__inner">
												<input type="radio" name="size" value="${individualSize}"
													<c:if test="${loop.index eq 0 and innerLoop.index eq 0}">checked</c:if>>
												<span class="checkmark">${individualSize}</span>
											</div>
										</label>
									</c:forEach>
								</c:forEach>
							</div>

							<div class="detail-action">
								<input type="number" name="quantity" id="quantity" value="1"
									min="1"> <a class="normal"
									onclick="addToCart(${product.id }, '${product.name }')">
									Thêm vào giỏ </a> <a onclick="addToFavorite(${product.id})"
									class="details-action-btn"> <i class="bi bi-suit-heart"></i>
								</a>
							</div>

						</div>
					</div>
				</form>

				<div class="detail-tab">
					<nav>
						<div class="nav nav-tabs" id="nav-tab" role="tablist">
							<a class="nav-item nav-link active" id="nav-comment-tab"
								data-toggle="tab" href="#nav-comment" role="tab"
								aria-controls="nav-comment" aria-selected="true">Đánh
								giá(${totalReviews })</a> <a class="nav-item nav-link"
								id="nav-detail-info-tab" data-toggle="tab"
								href="#nav-detail-des" role="tab" aria-controls="nav-detail-des"
								aria-selected="false">Mô tả chi tiết</a>
						</div>
					</nav>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show pt-3 active" id="nav-comment"
							role="tabpanel" aria-labelledby="nav-comment-tab">
							<div class="reviews-container mb-5">
								<form id="paginationForm"
									action="${classpath}/product-detail/${product.id}" method="get">
									<input type="hidden" id="currentPage" name="currentPage"
										class="form-control" value="${commentSearch.currentPage}">
									<c:choose>
										<c:when test="${not empty productComments}">
											<c:forEach items="${productComments}" var="pr"
												varStatus="loop">
												<div class="review-single">
													<div>
														<c:if test="${not empty pr.user.avatar}">
															<img src="${classpath}/FileUploads/${pr.user.avatar}"
																class="review-img">
														</c:if>
														<c:if test="${empty pr.user.avatar}">
															<span class="review-icon "> <svg
																	viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
               	 											<circle fill="none" stroke="#999"
																		stroke-width="1.1" cx="9.9" cy="6.4" r="4.4"></circle>
                											<path fill="none" stroke="#999"
																		stroke-width="1.1"
																		d="M1.5,19 C2.3,14.5 5.8,11.2 10,11.2 C14.2,11.2 17.7,14.6 18.5,19.2"></path>
            											</svg>
															</span>
														</c:if>
														<h4 class="review-title">${pr.user.name}</h4>
													</div>

													<div class="review-data">
														<div class="review-rating">
															<!-- Hiển thị các sao đã đánh giá -->
															<c:set var="fullStars" value="${pr.productRating / 2}" />
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
														<%-- <input type="hidden" name="selectedSize" id="selectedSize">			
														<p class="review-articles">Mặt hàng: ${selectedSize}</p> --%>
														<p class="review-description">${pr.comment}</p>
														<span class="review-date"><fmt:formatDate
																value="${pr.createDate }" pattern="dd-MM-yyyy" /></span>
													</div>
												</div>
											</c:forEach>
											<div class="text-center mt-3 mb-3">
												<!-- Phan trang -->
												<div class="pagination justify-content-center">
													<div id="paging"></div>
												</div>
											</div>

										</c:when>
										<c:otherwise>
											<!-- Hiển thị thông báo nếu không có sản phẩm -->
											<div class="alert alert-warning alert-dismissible fade show"
												role="alert">
												Không có đánh giá nào cho sản phẩm này.
												<button type="button" class="close" data-dismiss="alert"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
										</c:otherwise>
									</c:choose>
								</form>

							</div>
							<c:if test="${hasPurchased}">
								<div class="review-form">
									<h4>Thêm bài đánh giá</h4>
									<form action="${classpath}/review-save" method="post">
										<div class="rate-product">
											<input type="radio" name="rate" value="10" /> <input
												type="radio" name="rate" value="9" /> <input type="radio"
												name="rate" value="8" /> <input type="radio" name="rate"
												value="7" /> <input type="radio" name="rate" value="6" />
											<input type="radio" name="rate" value="5" /> <input
												type="radio" name="rate" value="4" /> <input type="radio"
												name="rate" value="3" /> <input type="radio" name="rate"
												value="2" /> <input type="radio" name="rate" value="1" />
										</div>

										<input type="hidden" name="productId" value="${product.id}">

										<div class="row">
											<div class="col-md-12 mb-3">
												<textarea id="comment" name="comment"
													class="form-control textarea" placeholder="Viết đánh giá"></textarea>
											</div>
										</div>

										<div class="form-btn">
											<button type="submit" class="normal">Gửi đánh giá</button>
										</div>
									</form>
								</div>
							</c:if>
						</div>
						<div class="tab-pane fade pt-3" id="nav-detail-des"
							role="tabpanel" aria-labelledby="nav-detail-info-tab">
							<c:choose>
										<c:when test="${not empty product.detailDescription}">
											${product.detailDescription }
										</c:when>
										<c:otherwise>
										<div class="alert alert-warning alert-dismissible fade show"
												role="alert">
												Thông tin chi tiết sản phẩm đang được cập nhật.
												<button type="button" class="close" data-dismiss="alert"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
										</c:otherwise>
										</c:choose>
							
							</div>


					</div>
				</div>
			</div>

		</div>
	</section>

	<section id="product1" class="section-p1">
		<div class="container">
			
				<h2>Sản phẩm liên quan</h2>
				<div class="row autoplay">
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
									<fmt:formatNumber value="${discounts[loop.index] * -1}"
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
											<span class="new-price"> $ <fmt:formatNumber
													value="${product.salePrice }" pattern="#,##0₫" />
											</span>
											<span class="old-price"> $ <fmt:formatNumber
													value="${product.price }" pattern="#,##0₫" />
											</span>
										</c:when>
										<c:otherwise>
											<span class="default-price"> $ <fmt:formatNumber
													value="${product.price }" pattern="#,##0₫" />
											</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<%-- <a onclick="addToFavorite(${product.id})" class="heart"><i
														class="fa-solid fa-heart"></i></a>  --%>
							<a class="cart"
								onclick="addToCart(${product.id}, 1, '${product.name }')"> <i
								class="fa-solid fa-cart-shopping"></i>
							</a>
						</div>
					</div>
</c:forEach>
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

	<!-- Js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>

	<!-- Add to cart -->
	<script type="text/javascript">
		addToCart = function(_productId, _productName ) {
			//alert("Thêm "  + _quantity + " sản phẩm '" + _productName + "' vào giỏ hàng ");
			let _size = $("input[name='size']:checked").val();
			let data = {
				productId : _productId, //lay theo id
				quantity : jQuery("#quantity").val(),
				productName: _productName,
				size: _size, 
			};

			//$ === jQuery
			jQuery.ajax({
				url : "/add-to-cart",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json", //Kieu du lieu tra ve tu controller la json

				success : function(jsonResult) {
					//alert(jsonResult.code + ": " + jsonResult.message);
					// Hiển thị toast khi thành công
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
	<!-- pagination -->
	<script type="text/javascript">
		$( document ).ready(function() {
			$("#paging").pagination({
				currentPage: ${commentSearch.currentPage}, //Trang hien tai
				items: ${commentSearch.totalItems}, //Tong so san pham (total products)
				itemsOnPage: ${commentSearch.sizeOfPage},
				cssStyle: 'light-theme',
				onPageClick: function(pageNumber, event) {
					event.preventDefault();
					$('#currentPage').val(pageNumber);
				     // Sử dụng URL phân trang được truyền từ controller
	                window.location.href = "${paginationUrl}" + pageNumber;	
				},
			});
		});
	</script>
</body>

</html>