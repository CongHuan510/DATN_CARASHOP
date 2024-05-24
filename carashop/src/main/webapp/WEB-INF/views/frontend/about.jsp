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
	
	<section id="page-header" class="about-header">
        <div class="container">
            <h2>#KnowUs</h2>
            <p>Lorem ipsum dolor sit amet consectetur</p>
        </div>
    </section>

    <section id="about-head" class="section-p1">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6 mb-4">
                    <img src="${Classpath }/frontend/img/about/a6.jpg" alt="">
                </div>
                <div class="col-md-6">
                    <h2>Who We Are?</h2>
                    <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                        Distinctio magni commodi hic optio at esse aut facere,
                        nulla tenetur! Ipsa enim corrupti nulla nemo iure,
                        voluptatum neque est exercitationem sunt!</p>
                    <abbr title="">Create stunning images with as much or as little control as you
                        like thanks to a choice of Basic and Creative modes.</abbr>
                    <br><br>
                    <marquee bgcolor="#ccc" loop="-1" scrollamount="5" width="100%">
                        Create stynning images with as much or as little control
                        as you like thanks to a choice of Basic and Creative modes.
                    </marquee>
                </div>
            </div>
        </div>
    </section>

    <section id="about-app" class="section-p1">
        <div class="container">
            <h1>Dowload Our <a href="#">App</a> </h1>
            <div class="video">
                <video autoplay muted loop src="${Classpath }/frontend/img/about/1.mp4"></video>
            </div>
        </div>
    </section>
	
	<section class="section-p1">
		<div class="container">
			<div id="feature" class="row slide-img">
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f1.png" alt="">
						<h6>Free Shipping</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f2.png" alt="">
						<h6>Online Order</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f3.png" alt="">
						<h6>Save Money</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f4.png" alt="">
						<h6>Promotions</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f5.png" alt="">
						<h6>Happy Sell</h6>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fe-box">
						<img src="${classpath }/frontend/img/features/f6.png" alt="">
						<h6>F24/7 Support</h6>
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
						<h4>Sign Up For newsletter</h4>
						<p>
							Get E-mail updates about our latest shop and <span>special
								offers.</span>
						</p>
					</div>

				</div>
				<div class="col-md-6">

					<div class="form">
						<input type="text" placeholder="Your email address">
						<button class="normal">Sign Up</button>
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