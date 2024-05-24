<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${SuperAdmin}">
		<nav id="sidebar" class="sidebar js-sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="${classpath}/admin/home"> <span
					class="align-middle">SuperAdmin CaraShop</span>
				</a>
				
				<div class="sidebar-user pt-2 pb-2 pl-4 pr-4 ">
					<div class="d-flex justify-content-center">
						<div class="flex-shrink-0">
							<img src="${classpath }/FileUploads/${loginedUser.avatar }" class="avatar img-fluid rounded me-1">
						</div>
						<div class="flex-grow-1 ps-2">
							<div class="sidebar-user-title text-white" >
								${loginedUser.username }
							</div>		
							<div class="sidebar-user-subtitle ">${loginedUser.name }</div>
						</div>
					</div>
				</div>

				<ul class="sidebar-nav">
					<li class="sidebar-header">Quản trị hệ thống</li>

					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/home"> <i class="align-middle"
							data-feather="sliders"></i> <span class="align-middle">Thống
								kê</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/category/list"> <i
							class="align-middle" data-feather="tag"></i> <span
							class="align-middle">Quản lý danh mục</span>
					</a></li>

					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/product/list"> <i class="align-middle"
							data-feather="book"></i> <span
							class="align-middle">Quản lý sản phẩm</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/user/list"> <i class="align-middle"
							data-feather="book"></i> <span class="align-middle">Quản
								lý tài khoản</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/role/list"> <i class="align-middle"
							data-feather="book"></i> <span class="align-middle">Quản
								lý quyền</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/order/list"> <i class="align-middle"
							data-feather="book"></i> <span class="align-middle">Quản
								lý đơn hàng</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/news/list"> <i class="align-middle"
							data-feather="book"></i> <span class="align-middle">Quản
								lý tin tức</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/customer-contact"> <i
							class="align-middle" data-feather="message-square"></i> <span
							class="align-middle">Quản lý liên hệ</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/comment/list"> <i
							class="align-middle" data-feather="message-circle"></i> <span
							class="align-middle">Quản lý đánh giá</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/logout"> <i class="align-middle"
							data-feather="log-out"></i> <span class="align-middle">Đăng
								xuất</span>
					</a></li>

				</ul>
			</div>
		</nav>
	</c:when>
	<c:otherwise>
		<nav id="sidebar" class="sidebar js-sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="${classpath}/admin/home"> <span
					class="align-middle">Admin CaraShop</span>
				</a>
				
				<div class="sidebar-user pt-2 pb-2 pl-4 pr-4 ">
					<div class="d-flex justify-content-center">
						<div class="flex-shrink-0">
							<img src="${classpath }/FileUploads/${loginedUser.avatar }" class="avatar img-fluid rounded me-1">
						</div>
						<div class="flex-grow-1 ps-2">
							<div class="sidebar-user-title text-white" >
								${loginedUser.username }
							</div>		
							<div class="sidebar-user-subtitle ">${loginedUser.name }</div>
						</div>
					</div>
				</div>

				<ul class="sidebar-nav">
					<li class="sidebar-header">Quản trị hệ thống</li>

					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/home"> <i class="align-middle"
							data-feather="sliders"></i> <span class="align-middle">Thống
								kê</span>
					</a></li>			
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/user/list"> <i class="align-middle"
							data-feather="book"></i> <span class="align-middle">Quản
								lý tài khoản</span>
					</a></li>
					
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/order/list"> <i class="align-middle"
							data-feather="book"></i> <span class="align-middle">Quản
								lý đơn hàng</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/customer-contact"> <i
							class="align-middle" data-feather="message-circle"></i> <span
							class="align-middle">Quản lý liên hệ</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/admin/comment/list"> <i
							class="align-middle" data-feather="message-circle"></i> <span
							class="align-middle">Quản lý đánh giá</span>
					</a></li>
					<li class="sidebar-item"><a class="sidebar-link"
						href="${classpath}/logout"> <i class="align-middle"
							data-feather="log-out"></i> <span class="align-middle">Đăng
								xuất</span>
					</a></li>

				</ul>
			</div>
		</nav>
	</c:otherwise>
</c:choose>