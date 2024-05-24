<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description"
	content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
<meta name="author" content="AdminKit">
<meta name="keywords"
	content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="shortcut icon"
	href="${classpath }/backend/img/icons/icon-48x48.png" />

<link rel="canonical"
	href="https://demo-basic.adminkit.io/pages-blank.html" />

<title>${title }</title>
<!-- variables -->
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
<!-- Custome css resource file -->
<jsp:include page="/WEB-INF/views/backend/layout/css.jsp"></jsp:include>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap"
	rel="stylesheet">


</head>

<body>
	<div class="wrapper">
		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/backend/layout/sidebar.jsp"></jsp:include>

		<div class="main">
			<jsp:include page="/WEB-INF/views/backend/layout/navbar.jsp"></jsp:include>

			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h1 mb-3" style="font-weight: 700;">Danh sách đơn
						hàng</h1>

					<div class="container-fluid">
						<!-- ============================================================== -->
						<!-- Start Page Content -->
						<!-- ============================================================== -->
						<!-- basic table -->
						<form action="${classpath }/admin/order/list" method="get">

							<div class="row">
								<div class="col-12">
									<div class="card">
										<div class="card-body">
											<div class="table-responsive">
												<div class="row">
													<div class="col-md-12 mb-3">
														<div class="form-group">
															<h3>Tổng số đơn hàng: ${saleOrderSearch.totalItems}</h3>
														</div>
													</div>
												</div>
												<!-- Tìm kiếm -->
												<div class="row">
													<div class="col-md-2">
														<div class="form-group mb-3">
															<select class="form-control" id="status" name="status">
																<option value="ALL">Tất cả đơn hàng</option>
																<option value="PENDING_PROCESSING"
																	<c:if test="${saleOrderSearch.status == 'PENDING_PROCESSING'}">selected</c:if>>Đơn
																	hàng chờ xử lý</option>
																<option value="PROCESSED"
																	<c:if test="${saleOrderSearch.status == 'PROCESSED'}">selected</c:if>>Đơn
																	hàng đã xử lý</option>
																<option value="ON_DELIVERY"
																	<c:if test="${saleOrderSearch.status == 'ON_DELIVERY'}">selected</c:if>>Đơn
																	hàng đã giao</option>
																<option value="DELIVERED"
																	<c:if test="${saleOrderSearch.status == 'DELIVERED'}">selected</c:if>>Đơn
																	hàng chưa giao</option>
															</select>
														</div>
													</div>

													<div class="col-md-2 mb-3">
														<input class="form-control" type="date" id="beginDate"
															name="beginDate" value="${saleOrderSearch.beginDate }" />
													</div>
													<div class="col-md-2 mb-3">
														<input class="form-control" type="date" id="endDate"
															name="endDate" value="${saleOrderSearch.endDate }" />
													</div>

													<div class="col-md-3 mb-3">
														<input type="text" class="form-control" id="keyword"
															name="keyword" placeholder="Tìm từ khóa"
															value="${saleOrderSearch.keyword }" />
													</div>

													<div class="col-md-1 mb-3">
														<button type="submit" id="btnSearch" name="btnSearch"
															class="btn btn-primary">Tìm kiếm</button>
													</div>
													<div class="col-md-1 mb-3">
														<input id="currentPage" name="currentPage"
															class="form-control"
															value="${saleOrderSearch.currentPage }" />
													</div>
												</div>
												<!-- Hết tìm kiếm -->

												<table id="zero_config"
													class="table table-striped table-bordered no-wrap">
													<thead>
														<tr align="center">
															<th scope="col">STT</th>
															<th scope="col">Số đơn hàng</th>
															<th scope="col">Tên khách hàng</th>
															<th scope="col">Số điện thoại</th>
															<th scope="col">Địa chỉ</th>
															<th scope="col">Thành tiền</th>
															<th scope="col">Người tạo</th>
															<!-- <th scope="col">Update by</th> -->
															<th scope="col">Ngày tạo</th>
															<th scope="col">Ngày giao hàng</th>
															<th scope="col">Ghi chú</th>
															<th scope="col">Hình thứ TT</th>
															<th scope="col">Trạng thái</th>
															<th scope="col">Hành động</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="saleOrder" items="${saleOrders }"
															varStatus="loop">
															<tr>
																<td align="center">${loop.index + 1 }</td>

																<td align="center">${saleOrder.code }</td>
																<td>${saleOrder.customerName }</td>
																<td align="center">${saleOrder.customerMobile }</td>
																<td>${saleOrder.customerAddress }</td>
																<td align="right"><fmt:formatNumber
																		value="${saleOrder.total}" pattern="#,##0₫" /></td>
																<td>${saleOrder.userCreateSaleOrder.username }</td>
																<%-- <td>${saleOrder.updateBy }</td> --%>
																<td><fmt:formatDate pattern="dd-MM-yyyy"
																		value="${saleOrder.createDate}" /></td>
																<td><fmt:formatDate pattern="dd-MM-yyyy"
																		value="${saleOrder.updateDate}" /></td>
																<td>${saleOrder.note }</td>
																<td><c:choose>
																		<c:when test="${saleOrder.paymentMethod }">
																		Thanh toán VNPAY
																	</c:when>
																		<c:otherwise>Thanh toán khi nhận hàng(COD)</c:otherwise>
																	</c:choose></td>
																<td><c:choose>
																		<c:when
																			test="${saleOrder.status == 'PENDING_PROCESSING'}">
																	        Chờ xác nhận
																	    </c:when>
																		<c:when test="${saleOrder.status == 'PROCESSED'}">
																	        Đã xác nhận
																	    </c:when>
																		<c:when test="${saleOrder.status == 'ON_DELIVERY'}">
																	        Đang giao hàng
																	    </c:when>
																		<c:when test="${saleOrder.status == 'DELIVERED'}">
																	        Đã giao hàng
																	    </c:when>
																		<c:when test="${saleOrder.status == 'UNPAID'}">
																	        Chưa thanh toán
																	    </c:when>
																		<c:when test="${saleOrder.status == 'PAID'}">
																	        Đã thanh toán
																	    </c:when>
																		<c:when test="${saleOrder.status == 'CANCELED'}">
																	        Hủy đơn hàng
																	    </c:when>
																		<c:otherwise>
																	        Trạng thái không xác định
																	    </c:otherwise>
																	</c:choose></td>

																<td><a
																	href="${classpath }/admin/order/detail/${saleOrder.id }"
																	role="button" class="btn btn-success">Chi tiết</a> <!-- Button trigger modal -->
																	<button type="button" class="btn btn-primary"
																		data-toggle="modal"
																		data-target="#staticBackdrop${loop.index}">
																		Sửa</button> <!-- Modal -->
																	<div class="modal fade"
																		id="staticBackdrop${loop.index}"
																		data-backdrop="static" data-keyboard="false"
																		tabindex="-1" aria-labelledby="staticBackdropLabel"
																		aria-hidden="true">
																		<div class="modal-dialog">
																			<div class="modal-content">
																				<div class="modal-header">
																					<h5 class="modal-title" id="staticBackdropLabel">Chi
																						tiết đơn hàng</h5>
																					<button type="button" class="close"
																						data-dismiss="modal" aria-label="Close">
																						<span aria-hidden="true">&times;</span>
																					</button>
																				</div>
																				<div class="modal-body">
																					<table id="zero_config"
																						class="table table-striped table-bordered no-wrap">
																						<thead>
																							<tr align="center">
																								<th scope="col">STT</th>
																								<th scope="col">Tên sản phẩm</th>
																								<th scope="col">Hình ảnh sản phẩm</th>
																								<th scope="col">Số lượng</th>
																								<th scope="col">Giá bán</th>
																								<th scope="col">Thành tiền</th>
																							</tr>
																						</thead>
																						<tbody>
																							<c:forEach var="item"
																								items="${orderProductMap[saleOrder.id]}"
																								varStatus="innerLoop">
																								<tr>
																									<td class="text-center">${innerLoop.index + 1 }</td>
																									<td>${item.product.name },<strong>${item.size}</strong></td>
																									<td class="text-center"><img width="40px"
																										height="40px"
																										src="${classpath }/FileUploads/${item.product.avatar }"
																										class="light-logo"></td>

																									<td class="text-right">${item.quantity}</td>
																									<td class="text-right"><c:choose>
																											<c:when
																												test="${not empty item.product.salePrice}">
																												<fmt:formatNumber
																													value="${item.product.salePrice}"
																													pattern="#,##0₫" />
																											</c:when>
																											<c:otherwise>
																												<fmt:formatNumber
																													value="${item.product.price}"
																													pattern="#,##0₫" />
																											</c:otherwise>
																										</c:choose></td>
																									<td class="text-right"><c:choose>
																											<c:when
																												test="${not empty item.product.salePrice}">
																												<fmt:formatNumber
																													value="${item.product.salePrice * item.quantity}"
																													pattern="#,##0₫" />
																											</c:when>
																											<c:otherwise>
																												<fmt:formatNumber
																													value="${item.product.price * item.quantity}"
																													pattern="#,##0₫" />
																											</c:otherwise>
																										</c:choose></td>
																								</tr>
																							</c:forEach>
																						</tbody>
																					</table>

																					<div class="text-right">
																						Tổng thành tiền:
																						<fmt:formatNumber value="${saleOrder.total}"
																							pattern="#,##0₫" />
																					</div>


																				</div>
																				<div class="modal-footer justify-content-start">
																					<c:choose>
																						<c:when
																							test="${saleOrder.status == 'PENDING_PROCESSING'}">
																							<a href="${classpath }/admin/order/status/${saleOrder.id }" 
																								role="button" class="btn btn-primary"
																								>Xác nhận</a>
																							<a
																								href="${classpath }/admin/order/delete/${saleOrder.id }"
																								role="button" class="btn btn-secondary">Hủy
																								đơn hàng</a>
																						</c:when>
																						<c:when test="${saleOrder.status == 'PROCESSED'}">
																					        <a href="${classpath }/admin/order/status/${saleOrder.id }" 
																								role="button" class="btn btn-primary"
																								>Giao hàng</a>
																							<a
																								href="${classpath }/admin/order/delete/${saleOrder.id }"
																								role="button" class="btn btn-secondary">Hủy
																								đơn hàng</a>
																					    </c:when>
																						<c:when
																							test="${saleOrder.status == 'ON_DELIVERY'}">
																					      <a href="${classpath }/admin/order/status/${saleOrder.id }" 
																								role="button" class="btn btn-primary"
																								>Giao hàng thành công</a>
																							<a
																								href="${classpath }/admin/order/delete/${saleOrder.id }"
																								role="button" class="btn btn-secondary">Hủy
																								đơn hàng</a>
																					    </c:when>
																						<c:when test="${saleOrder.status == 'DELIVERED'}">
																							 <a href="#" 
																								role="button" class="btn btn-secondary"
																								data-dismiss="modal">Trở lại</a>																		    
																					    </c:when>
																						<c:when test="${saleOrder.status == 'UNPAID'}">
																					        <a
																								href="${classpath }/admin/order/delete/${saleOrder.id }"
																								role="button" class="btn btn-secondary">Hủy
																								đơn hàng</a>
																					    </c:when>
																						<c:when test="${saleOrder.status == 'PAID'}">
																					         <a href="${classpath }/admin/order/status/${saleOrder.id }" 
																								role="button" class="btn btn-primary"
																								>Giao hàng</a>
																							<a
																								href="${classpath }/admin/order/delete/${saleOrder.id }"
																								role="button" class="btn btn-secondary">Hủy
																								đơn hàng</a>
																					    </c:when>
																						<c:when test="${saleOrder.status == 'CANCELED'}">
																					        <a href="#" 
																								role="button" class="btn btn-secondary"
																								data-dismiss="modal">Trở lại</a>
																					    </c:when>
																						<c:otherwise>
																					         <a href="#" 
																								role="button" class="btn btn-secondary"
																								data-dismiss="modal">Trở lại</a>
																					    </c:otherwise>
																					</c:choose>


																				</div>
																			</div>
																		</div>
																	</div> <a
																	href="${classpath }/admin/order/delete/${saleOrder.id }"
																	role="button" class="btn btn-secondary">Xóa</a></td>
															</tr>
														</c:forEach>
													</tbody>
												</table>

												<div class="row">
													<div class="col-md-6">
														<div class="form-group mb-4">
															<h3>
																Tổng thành tiền:
																<fmt:formatNumber value="${totalSales}" pattern="#,##0₫" />

															</h3>
														</div>
													</div>

													<div class="col-md-6">
														<!-- Phan trang -->
														<div class="pagination float-right">
															<div id="paging"></div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

						</form>
					</div>
				</div>
			</main>

			<!-- Footer -->
			<jsp:include page="/WEB-INF/views/backend/layout/footer.jsp"></jsp:include>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/backend/layout/js.jsp"></jsp:include>
	<!-- pagination -->
	<script type="text/javascript">
		$( document ).ready(function() {
			//Dat gia tri cua status ung voi dieu kien search truoc do
			//$("#status").val(${saleOrderSearch.status});
			//Dat gia tri cua order ung voi dieu kien search truoc do	
			//$("#keyword").val(${saleOrderSearch.keyword});
			
			
			$("#paging").pagination({
				currentPage: ${saleOrderSearch.currentPage}, //Trang hien tai
				items: ${saleOrderSearch.totalItems}, //Tong so san pham (total products)
				itemsOnPage: ${saleOrderSearch.sizeOfPage},
				cssStyle: 'light-theme',
				onPageClick: function(pageNumber, event) {
					$('#currentPage').val(pageNumber);
					$('#btnSearch').trigger('click');
				},
			});
		});
	</script>

</body>

</html>


