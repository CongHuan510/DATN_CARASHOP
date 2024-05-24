// Slick banner
$('.slide-img').slick({
		slidesToShow : 5,
		slidesToScroll : 1,
		autoplay : true,
		autoplaySpeed : 5000,
		prevArrow : '<button type="button" class="slick-prevt btn-custom-prev"><i class="fa-solid fa-chevron-left"></i></button>',
		nextArrow : '<button type="button"class="slick-nextt btn-custom-next"><i class="fa-solid fa-chevron-right"></i></button>',
		responsive : [ {
			breakpoint : 992,
			settings : {
				slidesToShow : 3,
				slidesToScroll : 3
			}
		}, 
		{
			breakpoint : 576,
			settings : {
				slidesToShow : 2,
				slidesToScroll : 2
			}
		}, 
		{
			breakpoint : 375,
			settings : {
				slidesToShow : 1,
				slidesToScroll : 1
			}
		} 
		]
});

// Slick các sản phẩm nổi bật
	$('.autoplay').on('init', function(event, slick){
		$('.slick-prev').hide(); // Ẩn nút prev khi slick carousel được khởi tạo
	});

	$('.autoplay').on('afterChange', function(event, slick, currentSlide, nextSlide){
		if (currentSlide === 0) {
			$('.slick-prev').hide(); // Nếu là slide đầu tiên, ẩn nút prev
		} else {
			$('.slick-prev').show(); // Nếu không phải slide đầu tiên, hiển thị nút prev
		}

		if (currentSlide >= slick.slideCount - slick.options.slidesToShow) {
			$('.slick-next').hide(); // Nếu là slide cuối cùng, ẩn nút next
		} else {
			$('.slick-next').show(); // Nếu không phải slide cuối cùng, hiển thị nút next
		}
	});

// Slick chi  tiết sản phẩm
	$('.autoplay').slick({
		slidesToShow: 4,
		slidesToScroll: 4,
		prevArrow: '<button type="button" class="slick-prev btn-custom-prev"><i class="fa-solid fa-chevron-left"></i></button>',
		nextArrow: '<button type="button"class="slick-next btn-custom-next"><i class="fa-solid fa-chevron-right"></i></button>',
		responsive : [ {
			breakpoint : 992,
			settings : {
				slidesToShow : 2,
				slidesToScroll : 2
			}
		}, 
		{
			breakpoint : 576,
			settings : {
				slidesToShow : 1,
				slidesToScroll : 1
			}
		}, 
		]
	});
	
	$('.slider-for').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
        asNavFor: '.slider-nav'
    });
    $('.slider-nav').slick({
        slidesToShow: 3,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 1000,
        asNavFor: '.slider-for',
        focusOnSelect: true,
        prevArrow: '<button type="button" class="slick-prev btn-custom-prev"><i class="fa-solid fa-chevron-left"></i></button>',
        nextArrow: '<button type="button" class="slick-next btn-custom-next"><i class="fa-solid fa-chevron-right"></i></button>',
    });