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
	
	<section id="page-header" class="blog-header">
        <div class="container">
            <h2>#readmore</h2>
            <p>Read all case studies about our products!</p>
        </div>
    </section>

    <section id="blog">
        <div class="container">
            <div class="row blog-box align-items-center">
                <div class="blog-img col-sm-6 mb-4">
                    <img src="${Classpath }/frontend/img/blog/b1.jpg" alt="">
                </div>
                <div class="blog-details col-sm-6">
                    <h4>The Cotton-Jersey Zip-Up Hoodie</h4>
                    <p>
                        Kickstarter man braid godard coloring book.
                        Raclette waistcoat selfies yr wolf chartreuse
                        hexagon irony, godard...
                    </p>
                    <a href="#">Continue reading</a>
                </div>
                <h1>13/01</h1>  
            </div>
            <div class="row blog-box align-items-center">
                <div class="blog-img col-sm-6 mb-4">
                    <img src="${Classpath }/frontend/img/blog/b2.jpg" alt="">
                </div>
                <div class="blog-details col-sm-6">
                    <h4>How to Style a Quiff</h4>
                    <p>
                        Kickstarter man braid godard coloring book.
                        Raclette waistcoat selfies yr wolf chartreuse
                        hexagon irony, godard...
                    </p>
                    <a href="#">Continue reading</a>
                </div>
                <h1>13/04</h1>  
            </div>
            <div class="row blog-box align-items-center">
                <div class="blog-img col-sm-6 mb-4">
                    <img src="${Classpath }/frontend/img/blog/b3.jpg" alt="">
                </div>
                <div class="blog-details col-sm-6">
                    <h4>Must-Have Skater Girl Items</h4>
                    <p>
                        Kickstarter man braid godard coloring book.
                        Raclette waistcoat selfies yr wolf chartreuse
                        hexagon irony, godard...
                    </p>
                    <a href="#">Continue reading</a>
                </div>
                <h1>12/01</h1>  
            </div>
            <div class="row blog-box align-items-center">
                <div class="blog-img col-sm-6 mb-4">
                    <img src="${Classpath }/frontend/img/blog/b4.jpg" alt="">
                </div>
                <div class="blog-details col-sm-6">
                    <h4>Runway-Inspired Trends</h4>
                    <p>
                        Kickstarter man braid godard coloring book.
                        Raclette waistcoat selfies yr wolf chartreuse
                        hexagon irony, godard...
                    </p>
                    <a href="#">Continue reading</a>
                </div>
                <h1>16/01</h1>  
            </div>
            <div class="row blog-box align-items-center">
                <div class="blog-img col-sm-6  mb-4">
                    <img src="${Classpath }/frontend/img/blog/b6.jpg" alt="">
                </div>
                <div class="blog-details col-sm-6">
                    <h4>AW20 Menswear Trends</h4>
                    <p>
                        Kickstarter man braid godard coloring book.
                        Raclette waistcoat selfies yr wolf chartreuse
                        hexagon irony, godard...
                    </p>
                    <a href="#">Continue reading</a>
                </div>
                <h1>10/03</h1>  
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