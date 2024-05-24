//HEADER
// Script for navigation bar
const bar = document.getElementById('bar');
const close = document.getElementById('close')
const nav = document.getElementById('navbar');

if (bar) {
	bar.addEventListener('click', () => {
		nav.classList.add('active')
	})
}

if (close) {
	close.addEventListener('click', () => {
		nav.classList.remove('active')
	})
}
//END
// Hover active color
document.addEventListener("DOMContentLoaded", function() {
	var links = document.querySelectorAll('.menu_sidebar li a');

	links.forEach(function(link) {
		link.addEventListener('click', function(event) {
			// Loại bỏ lớp 'active' từ tất cả các liên kết
			links.forEach(function(item) {
				item.classList.remove('active');
			});
			// Thêm lớp 'active' cho liên kết được nhấp vào
			this.classList.add('active');
		});
	});
});
//END
// Bật form tìm kiếm
document.addEventListener('DOMContentLoaded', function() {
	var searchToggle = document.getElementById('searchToggle');
	var formInline = document.querySelector('.form-inline');

	// Toggle visibility on hover
	searchToggle.addEventListener('mouseenter', function() {
		formInline.style.display = 'flex';
	});

	// Hide on mouse leave
	searchToggle.addEventListener('mouseleave', function() {
		formInline.style.display = 'none';
	});

	searchToggle.addEventListener('click', function(e) {
		// Kiểm tra nếu formInline đang hiển thị thì không chặn sự kiện
		if (formInline.style.display === 'none') {
			e.preventDefault();
		}
	});
});
//END
document.addEventListener('DOMContentLoaded', function() {
	// Select all input elements within the form-block
	var inputs = document.querySelectorAll('.contents .form-group input');
	// Add event listener for each input element
	inputs.forEach(function(input) {
		input.addEventListener('input', function() {
			// Check if the input has a value
			if (input.value.trim() !== '') {
				input.parentNode.classList.add('field--not-empty');
			} else {
				input.parentNode.classList.remove('field--not-empty');
			}
		});
	});
});
// đóng mở menu sản phẩm ở responsive
document.addEventListener("DOMContentLoaded", function() {
	var productsLink = document.getElementById("products-link");
	var productsMenu = document.getElementById("products-menu");

	productsLink.addEventListener("click", function(event) {
		// Ngăn chặn hành vi mặc định của liên kết
		event.preventDefault();
		// Kiểm tra xem menu đã mở hay chưa
		var isMenuOpen = productsMenu.classList.contains("show");
		// Toggle hiệu ứng mở hoặc đóng menu sản phẩm
		productsMenu.classList.toggle("show");
		// Nếu menu chưa mở, chuyển hướng đến trang mới sau khi hiển thị menu
		if (!isMenuOpen) {
			window.location.href = productsLink.href;
		}
	});
});
//END



//FOOTER
// Cuộn trang 
const btnScrollToTop = document.getElementById('scrollTop');
const docEl = document.documentElement;
let isScrolling = false;
function scrollToTop() {
	if (!isScrolling) {
		isScrolling = true;
		const scrollToTal = docEl.scrollHeight - docEl.clientHeight;
		const scrollInterval = setInterval(() => {
			if (docEl.scrollTop > 0) {
				docEl.scrollTop -= 20; // Điều chỉnh giá trị này để thay đổi tốc độ cuộn
			} else {
				clearInterval(scrollInterval);
				isScrolling = false;
			}
		}, 5); // Điều chỉnh giá trị này để thay đổi tốc độ cuộn
	}
}

document.addEventListener('scroll', () => {
	const scrollToTotal = docEl.scrollHeight - docEl.clientHeight;

	if ((docEl.scrollTop / scrollToTotal) >= 0.4) {
		btnScrollToTop.style.opacity = '1'; // Khi nút cần được hiển thị, đặt opacity thành 1
		btnScrollToTop.style.transform = 'translateY(0)'; // Đặt transform về 0 để hiển thị nút lên trên
	} else {
		btnScrollToTop.style.opacity = '0'; // Khi nút không cần hiển thị, đặt opacity thành 0
		btnScrollToTop.style.transform = 'translateY(100px)'; // Đặt transform để nút di chuyển xuống
	}
});
btnScrollToTop.addEventListener('click', scrollToTop);
//END