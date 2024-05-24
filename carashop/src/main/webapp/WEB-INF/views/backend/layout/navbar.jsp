<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand navbar-light navbar-bg">
	<a class="sidebar-toggle js-sidebar-toggle"> <i
		class="hamburger align-self-center"></i>
	</a>

	<div class="navbar-collapse collapse">
		<ul class="navbar-nav navbar-align">
			
			
			<li class="nav-item dropdown"><a
				class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#"
				data-bs-toggle="dropdown"> <i class="align-middle"
					data-feather="settings"></i>
			</a> <a class="nav-link dropdown-toggle d-none d-sm-inline-block"
				href="#" data-bs-toggle="dropdown"> <img
					src="${classpath }/FileUploads/${loginedUser.avatar }"
					class="avatar img-fluid rounded me-1"/> 
					<span>Xin chào, </span>
					<span class="text-dark">${loginedUser.name }</span>
			</a>
				<div class="dropdown-menu dropdown-menu-end">
					<a class="dropdown-item" href="pages-profile.html"><i
						class="align-middle me-1" data-feather="user"></i> Hồ sơ</a> <a
						class="dropdown-item" href="#"><i class="align-middle me-1"
						data-feather="pie-chart"></i> phân tích</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="index.html"><i
						class="align-middle me-1" data-feather="settings"></i> Cài đặt &amp;
						Sự riêng tư</a> <a class="dropdown-item" href="#"><i
						class="align-middle me-1" data-feather="help-circle"></i> Trung tâm trợ giúp</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="${classpath}/logout"><i class="align-middle"
					data-feather="log-out"></i> Đăng xuất</a>
				</div></li>
		</ul>
	</div>
</nav>