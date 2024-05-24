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

<!-- variables -->
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
<!-- Css -->
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
</head>
<body>

	<section class="payment-return">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-12 col-md-6 text-center">
					<c:choose>
						<c:when test="${result == 1}">
							<i class="fa-solid fa-circle-check fa-3x"></i>
							<p>${message}</p>
							<p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi.</p>
							<a href="${classpath}/index" class="btn btn-primary">Quay lại
								trang chủ</a>
						</c:when>
						<c:when test="${result == 0}">
							<i class="fa-solid fa-circle-xmark fa-3x"></i>
							<p>${message}</p>
							<p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi.</p>
							<a href="${classpath}/index" class="btn btn-danger">Quay lại
								trang chủ</a>
						</c:when>
						<c:otherwise>
							<i class="fa-solid fa-triangle-exclamation fa-3x"></i>
							<p>${message}</p>
							<p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi.</p>
							<a href="${classpath}/index" class="btn btn-dark">Quay lại
								trang chủ</a>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
		</div>
	</section>
</body>
</html>