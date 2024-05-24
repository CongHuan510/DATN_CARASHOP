<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
			<h2>#let's_talk</h2>
			<p>LEAVE A MESSAGE, We love to hear from you!</p>
		</div>
	</section>
	<section class="section-m1">
		<div class="container">
			<div class="row">
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="${classpath }/index">Home</a></li>
						<li class="breadcrumb-item active" aria-current="page">Contact</li>
					</ol>
				</nav>
			</div>
		</div>
	</section>
	<section id="contact-details" class="section-p1">
		<div class="container">
			<div class="row">
				<div class="col-12 col-md-6 details">
					<span>GET IN TOUCH</span>
					<h2>Visit one of our agency locations or contact us today</h2>
					<h3>Head Office</h3>
					<ul>
						<li><i class="fa-regular fa-map"></i>
							<p>56 Glassford Street Glasgow 61 1UL New York</p></li>
						<li><i class="fa-regular fa-envelope"></i>
							<p>contact@example.com</p></li>
						<li><i class="fa-solid fa-phone"></i>
							<p>+84 987 654 321</p></li>
						<li><i class="fa-regular fa-clock"></i>
							<p>Monday to Saturday: 9.00am to 16.00pm</p></li>
					</ul>
				</div>
				<div class="col-12 col-md-6 map">
					<iframe
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.834734318766!2d105.7733868!3d21.039297699999995!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313454b5534fb3bf%3A0x70d71b071349fa94!2sDevPro%20Education!5e0!3m2!1svi!2s!4v1705543282661!5m2!1svi!2s"
						width="600" height="450" style="border: 0;" allowfullscreen=""
						loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
				</div>
			</div>
		</div>
	</section>

	<section>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div id="form-details">
						<div class="col-12 col-md-6 col-lg-8">
							<form action="/contact-edit-save" method="post">
								<span>LEAVE A MESSAGE</span>
								<h2>We love to hear from you</h2>
								<input type="text" placeholder="Your name" id="txtName" name="txtName" value="${contact.txtName }"> 
								<input type="email" placeholder="Email" id="txtEmail" name="txtEmail" value="${contact.txtEmail }"> 
								<input type="text" placeholder="Your mobile" id="txtMobile" name="txtMobile" value="${contact.txtMobile }"> 
								<input type="text" placeholder="Your address" id="txtAddress" name="txtAddress" value="${contact.txtAddress }">
								<textarea cols="30" rows="10" placeholder="Your Message" id="txtMessage" name="txtMessage">${contact.txtMessage }</textarea>
								<button type="button" class="normal" onclick="_notification()">Save edit</button>
							</form>
						</div>

						<div class="col-12 col-md-6 col-lg-4 people">
							<div>
								<img src="${classpath }/frontend/img/people/1.png" alt="">
								<p>
									<span>John Doe</span> Senior Marketing Manager <br> Phone:
									+ 000 123 000 77 88 <br> Emial: contact@exmaple.com
								</p>
							</div>
							<div>
								<img src="${classpath }/frontend/img/people/2.png" alt="">
								<p>
									<span>Willam Smith</span> Senior Marketing Manager <br>
									Phone: + 000 123 000 77 88 <br> Emial: contact@exmaple.com
								</p>
							</div>
							<div>
								<img src="${classpath }/frontend/img/people/3.png" alt="">
								<p>
									<span>Emna Stone</span> Senior Marketing Manager <br>
									Phone: + 000 123 000 77 88 <br> Emial: contact@exmaple.com
								</p>
							</div>
						</div>
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
						<input type="text" placeholder="Yor email address">
						<button class="normal">Sign Up</button>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>
	
	<div style="cursor: pointer;" id="messeger">
        <div>
            <div style="display: flex; align-items: center;">
                <div
                    style="width: 60px; height: 60px; background-color: #0A7CFF; display: flex; justify-content: center; align-items: center; border-radius:60px">
                    <svg width="36" height="36" viewBox="0 0 36 36">
                        <path fill="white"
                            d="M1 17.99C1 8.51488 8.42339 1.5 18 1.5C27.5766 1.5 35 8.51488 35 17.99C35 27.4651 27.5766 34.48 18 34.48C16.2799 34.48 14.6296 34.2528 13.079 33.8264C12.7776 33.7435 12.4571 33.767 12.171 33.8933L8.79679 35.3828C7.91415 35.7724 6.91779 35.1446 6.88821 34.1803L6.79564 31.156C6.78425 30.7836 6.61663 30.4352 6.33893 30.1868C3.03116 27.2287 1 22.9461 1 17.99ZM12.7854 14.8897L7.79161 22.8124C7.31238 23.5727 8.24695 24.4295 8.96291 23.8862L14.327 19.8152C14.6899 19.5398 15.1913 19.5384 15.5557 19.8116L19.5276 22.7905C20.7193 23.6845 22.4204 23.3706 23.2148 22.1103L28.2085 14.1875C28.6877 13.4272 27.7531 12.5704 27.0371 13.1137L21.673 17.1847C21.3102 17.4601 20.8088 17.4616 20.4444 17.1882L16.4726 14.2094C15.2807 13.3155 13.5797 13.6293 12.7854 14.8897Z">
                        </path>
                    </svg></div>
            </div>
        </div>
    </div>

    <a id="scrollTop" onclick="scrollToTop()"><i class="fa-solid fa-chevron-up" style="color: #5d5c5c;"></i></a>

	<!-- Js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>
	
	<script type="text/javascript">
		function _notification() {
			//javascript object
			let data = {
				
				txtName : jQuery("#txtName").val(),
				txtEmail : jQuery("#txtEmail").val(), //Get by Id
				txtMobile : jQuery("#txtMobile").val(),
				txtAddress : jQuery("#txtAddress").val(),
				txtMessage : jQuery("#txtMessage").val(),
				
			};
			
			//$ === jQuery
			jQuery.ajax({
				url : "/contact-edit-save",
				type : "POST",
				contentType: "application/json",
				data : JSON.stringify(data),
				dataType : "json", //Kieu du lieu tra ve tu controller la json
				
				success : function(jsonResult) {
					alert(jsonResult.code + ": " + jsonResult.message);
					//$("#notification").html(jsonResult.message);
				},
				
				error : function(jqXhr, textStatus, errorMessage) {
					alert("An error occur");
				}
			});
		}
	</script>
</body>
</html>