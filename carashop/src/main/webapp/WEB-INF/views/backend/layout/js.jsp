<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- All Jquery -->

<script src="${classpath }/backend/js/jquery.min.js"></script>
<script src="${classpath }/backend/js/popper.min.js"></script>
<script src="${classpath }/backend/bootstrap/bootstrap.min.js"></script>
<script src="${classpath }/backend/js/app.js"></script>
<script src="${classpath }/backend/js/custom.min.js"></script>
<script src="${classpath }/backend/js/jquery.simplePagination.js"></script>

<script>
	function setActiveMenu() {
		var currentUrl = window.location.href;
		var sidebarItems = document.querySelectorAll(".sidebar-item");

		sidebarItems.forEach(function(item) {
			var link = item.querySelector(".sidebar-link");

			if (currentUrl.includes(link.getAttribute("href"))) {
				item.classList.add("active");
			} else {
				item.classList.remove("active");
			}
		});
	}

	document.addEventListener("DOMContentLoaded", function() {
		setActiveMenu();
	});

	// Gọi setActiveMenu() sau mỗi lần thực hiện tìm kiếm
	document.getElementById("btnSearch").addEventListener("click", function() {
		setActiveMenu();
	});
</script>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		var ctx = document.getElementById("chartjs-dashboard-revenue")
				.getContext("2d");
		var gradient = ctx.createLinearGradient(0, 0, 0, 225);
		gradient.addColorStop(0, "rgba(215, 227, 244, 1)");
		gradient.addColorStop(1, "rgba(215, 227, 244, 0)");

		var dashboardRevenue =
<%=request.getAttribute("dashboardRevenue")%>
	;
		// Line chart
		new Chart(document.getElementById("chartjs-dashboard-revenue"), {
			type : "line",
			data : {
				labels : [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
						"Aug", "Sep", "Oct", "Nov", "Dec" ],
				datasets : [ {
					label : "Tổng (₫)",
					fill : true,
					backgroundColor : gradient,
					borderColor : window.theme.primary,
					data : dashboardRevenue
				} ]
			},
			options : {
				maintainAspectRatio : false,
				legend : {
					display : false
				},
				tooltips : {
					intersect : false
				},
				hover : {
					intersect : true
				},
				plugins : {
					filler : {
						propagate : false
					}
				},
				scales : {
					xAxes : [ {
						reverse : true,
						gridLines : {
							color : "rgba(0,0,0,0.0)"
						}
					} ],
					yAxes : [ {
						ticks : {
							stepSize : 50000, // Bước giữa các mốc giá trị trên trục Y
							maxTicksLimit : 4, // Giới hạn số lượng mốc hiển thị trên trục Y
							callback : function(value, index, values) {
								return value.toLocaleString() + '₫'; // Định dạng mốc giá trị hiển thị
							}		
						},
						display : true,
						borderDash : [ 3, 3 ],
						gridLines : {
							color : "rgba(0,0,0,0.0)"
						}
					} ]
				}
			}
		});
	});
</script>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		var ctx = document.getElementById("chartjs-dashboard-order")
				.getContext("2d");
		var gradient = ctx.createLinearGradient(0, 0, 0, 225);
		gradient.addColorStop(0, "rgba(215, 227, 244, 1)");
		gradient.addColorStop(1, "rgba(215, 227, 244, 0)");

		var dashboardOrder =
<%=request.getAttribute("dashboardOrder")%>
	;
		// Line chart
		new Chart(document.getElementById("chartjs-dashboard-order"), {
			type : "line",
			data : {
				labels : [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
						"Aug", "Sep", "Oct", "Nov", "Dec" ],
				datasets : [ {
					label : "Tổng",
					fill : true,
					backgroundColor : gradient,
					borderColor : window.theme.primary,
					data : dashboardOrder
				} ]
			},
			options : {
				maintainAspectRatio : false,
				legend : {
					display : false
				},
				tooltips : {
					intersect : false
				},
				hover : {
					intersect : true
				},
				plugins : {
					filler : {
						propagate : false
					}
				},
				scales : {
					xAxes : [ {
						reverse : true,
						gridLines : {
							color : "rgba(0,0,0,0.0)"
						}
					} ],
					yAxes : [ {
						ticks : {
							stepSize : 1000
						},
						display : true,
						borderDash : [ 3, 3 ],
						gridLines : {
							color : "rgba(0,0,0,0.0)"
						}
					} ]
				}
			}
		});
	});
</script>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		var ctx = document.getElementById("chartjs-dashboard-product")
				.getContext("2d");
		var gradient = ctx.createLinearGradient(0, 0, 0, 225);
		gradient.addColorStop(0, "rgba(215, 227, 244, 1)");
		gradient.addColorStop(1, "rgba(215, 227, 244, 0)");

		var dashboardProduct =
<%=request.getAttribute("dashboardProduct")%>
	;
		// Line chart
		new Chart(document.getElementById("chartjs-dashboard-product"), {
			type : "line",
			data : {
				labels : [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
						"Aug", "Sep", "Oct", "Nov", "Dec" ],
				datasets : [ {
					label : "Tổng",
					fill : true,
					backgroundColor : gradient,
					borderColor : window.theme.primary,
					data : dashboardProduct
				} ]
			},
			options : {
				maintainAspectRatio : false,
				legend : {
					display : false
				},
				tooltips : {
					intersect : false
				},
				hover : {
					intersect : true
				},
				plugins : {
					filler : {
						propagate : false
					}
				},
				scales : {
					xAxes : [ {
						reverse : true,
						gridLines : {
							color : "rgba(0,0,0,0.0)"
						}
					} ],
					yAxes : [ {
						ticks : {
							stepSize : 1000
						},
						display : true,
						borderDash : [ 3, 3 ],
						gridLines : {
							color : "rgba(0,0,0,0.0)"
						}
					} ]
				}
			}
		});
	});
</script>




