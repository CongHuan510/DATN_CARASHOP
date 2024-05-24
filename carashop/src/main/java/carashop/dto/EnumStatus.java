package carashop.dto;

public enum EnumStatus {
	ACTIVE, // Kích hoạt
	INACTIVE, // Không kích hoạt
	PENDING_PROCESSING, // Chờ xác nhận
    PROCESSED, // Đã xác nhận
    ON_DELIVERY, // Đang giao hàng
    DELIVERED, // Đã giao hàng
    UNPAID, // Chưa thanh toán
    PAID, // Đã thanh toán
    CANCELED // Hủy đơn hàng
}
