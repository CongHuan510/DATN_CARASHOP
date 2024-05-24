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

<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>

	<section id="page-header" class="news-header">
		<div class="container">
			<h2>Tin tức</h2>
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${classpath }/index">Trang
							chủ</a></li>
					<li class="breadcrumb-item active" aria-current="page">Chi
						tiết tin tức</li>
				</ol>
			</nav>
		</div>
	</section>

	<section class="section-m1">
		<div class="container">
			<div class="row">
				<div class="news_left_base col-lg-4 col-12 order-2 order-lg-1">
					<div class="news-latest">
						<h2>Tin tức mới nhất</h2>
						<div class="news_content">
						<c:forEach items="${top3News }" var="top3New">
							<div class="item clearfix">
								<div class="post-thumb">
									<a class="image-blog scale_hover"
										title="${top3New.title }"
											href="${classpath }/news-detail/${top3New.id}">
										<img class="img_blog lazyload loaded"
										src="${classpath }/FileUploads/${top3New.avatar }"
										alt="${top3New.title }">

									</a>
								</div>
								<div class="contentright">
									<h3>
										<a title="${top3New.title }"
											href="${classpath }/news-detail/${top3New.id}">
											${top3New.title }
										</a>
									</h3>
								</div>
							</div>
						</c:forEach>				
						</div>
					</div>
				</div>
				
					<div class="right-content col-lg-8 col-12 order-1 order-lg-2 ">
					<sf:form class="form" action="${classpath }/product-detail" method="get" modelAttribute="news" enctype="multipart/form-data">
					<sf:hidden path="id" />
						<div class="article-details clearfix">
							<h1 class="article-title">${news.title}</h1>
							<div class="posts">
								<div class="time-post f">
									<i class="bi bi-clock"></i> 
									<fmt:formatDate value="${news.createDate}" pattern="dd 'Tháng' MM yyyy" />
								</div>

							</div>
							<div class="rte">
								<p>${news.summary }</p>
								${news.content }	
							</div>

							<div class="news-related">
								<h2 class="title-module-lq">
									<a href="/bat-kip-xu-huong" title="Xem thêm"> &gt;&gt;&gt;
										Xem thêm</a>
								</h2>
								<div class="list-news related-news">
									<ul>
										<c:forEach items="${relatedNews }" var="relatedNew">
											<li>
											<h3>
												<a title="${relatedNew.title }"
											href="${classpath }/news-detail/${relatedNew.id}">${relatedNew.title }</a>
											</h3>
										</li>
										</c:forEach>		
									</ul>
								</div>
							</div>

						</div>
						</sf:form>
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
	<!-- Js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>
</body>
</html>