<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet"
	href="${classpath }/backend/bootstrap/bootstrap.min.css">
<link href="${classpath }/backend/css/app.css" rel="stylesheet">
<link href="${classpath}/backend/css/simplePagination.css"
	rel="stylesheet">
<style>
	#zero_config td, #zero_config th {
		min-width: 100%;
		white-space: nowrap;
	}
	
	#zero_config {
		width: 100%;
	}
	
	.description-column {
		max-width: 200px; 
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	
	.description-column h2, .description-column h3, .description-column p {
		display: inline; 
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		margin: 0; 
	}
	
	.description-column p img {
		display: none;
	}
	
	@media ( min-width : 576px) {
		.modal-dialog {
			max-width: 1000px;
			margin: 1.75rem auto;
		}
	}
</style>