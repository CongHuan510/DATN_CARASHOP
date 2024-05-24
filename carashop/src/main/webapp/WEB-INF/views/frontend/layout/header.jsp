<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<section id="header">
	<div class="container">
		<div class="row">
			<div class="col-3 col-lg-3">
				<a href="${classpath }/index"><img
					src="${classpath }/frontend/img/logo.png" class="logo" alt=""></a>
			</div>
			<div class="col-6 col-lg-6">
				<ul id="navbar">
					<li><a href="${classpath }/index">Trang chủ</a></li>
					<li class="parent toggle">
						<a href="${classpath }/product" id="products-link">Sản phẩm</a>
						<ul class="sub_navbar" id="products-menu">
							<c:forEach items="${categories}" var="category">
								<li><a href="${classpath }/product?categoryId=${category.id}">${category.name}</a></li>
							</c:forEach>
						</ul>
					</li>
					<li><a href="${classpath }/news">Tin tức</a></li>
					<li><a href="${classpath }/about">Về chúng tôi</a></li>
					<li><a href="${classpath }/contact">Liên hệ</a></li>	
					<a href="#" id="close" style="cursor: pointer !important;">
						<i class="fa-solid fa-xmark"></i>
					</a>	
				</ul>
				
			</div>
			<div class="col-3 col-lg-3 d-flex flex-row-reverse">
				<div id="mobile">
					<form method="get">
						<div class="lg-bag" id="searchToggle">
							<a href="#"> <i class="fa-solid fa-magnifying-glass"></i>
							</a>

							<div class="form-inline position-absolute">
								<input type="text" class="form-control" id="keyword"
									name="keyword" value="${keyword }" placeholder="tên sản phẩm" />
								<button type="submit" class="normal" >
									<i id="searchIcon" class="fa-solid fa-magnifying-glass"
										style="color: #ffffff; font-size: 20px;"></i>
								</button>

							</div>

						</div>
					</form>
					<div class="dropdown show">
						<a href="#" role="button" id="dropdownMenuLink"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fa-regular fa-user"></i>
						</a>
						<c:choose>
							<c:when test="${isLogined }">
								<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									<span class="dropdown-item">Xin chào, ${loginedUser.name }</span>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="${classpath}/profile">
										<i class="bi bi-person-circle"></i> Thông tin cá nhân
									</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="${classpath}/changepassword">
										<i class="fas fa-key"></i> Đổi mật khẩu	
									</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="${classpath}/manageorders">
										<i class="bi bi-bag-fill"></i> Đơn đặt hàng	
									</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="${classpath}/logout">
										<i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất	
									</a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									<a class="dropdown-item" href="${classpath }/login"> <i
										class="bi bi-person-circle"></i> Đăng nhập
									</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="${classpath }/signup"> <i
										class="bi bi-box-arrow-in-right"></i> Đăng ký
									</a>
								</div>
							</c:otherwise>


						</c:choose>
					</div>
					<div class="lg-bag">
						<a href="${classpath }/favorite"> <i class="fa-regular fa-heart"></i> 
						<span class="header__bottom-num" id="totalFavoriteProductsId">${totalFavoriteProducts }</span>
						</a>
					</div>
					<div class="lg-bag">
						<a href="${classpath }/cart-view"> <i class="bi bi-bag-check"></i>
							<span class="header__bottom-num" id="totalCartProductsId">${totalCartProducts }</span>
						</a>					
					</div>
					<div class="menubar" style="cursor: pointer;">
						<i id="bar" class="fas fa-outdent"></i>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
    // Lấy URL hiện tại
    var URL = window.location.href;
    // Lặp qua mỗi mục menu
    var menuItems = document.querySelectorAll("#navbar a");
    menuItems.forEach(function(item) {
        // Kiểm tra xem URL của mục menu có phù hợp với URL hiện tại không
        if (item.href === URL) {
            // Nếu phù hợp, thêm lớp 'active' vào mục menu
            item.classList.add("active");
        }
    });
</script>