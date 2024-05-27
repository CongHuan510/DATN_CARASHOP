package carashop.service;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import carashop.dto.SearchModel;
import carashop.model.SaleOrder;
import carashop.model.User;

@Service
public class SaleOrderService extends BaseService<SaleOrder> {

	@Autowired
	private UserService userService;

	@Override
	public Class<SaleOrder> clazz() {
		return SaleOrder.class;
	}

	@Transactional
	public void inactiveSaleOrder(SaleOrder saleOrder) {
		super.saveOrUpdate(saleOrder);
	}

	@Transactional
	public SaleOrder saveOrder(SaleOrder saleOrder) {
		// Kiểm tra và thiết lập giá trị cho trường user trước khi lưu
		if (saleOrder.getUser() == null && saleOrder.getUserCreateSaleOrder() != null) {
			// Lấy thông tin người dùng từ UserService (hoặc từ nguồn dữ liệu phù hợp)
			User user = userService.getById(saleOrder.getUserCreateSaleOrder().getId());
			// Thiết lập giá trị user cho saleOrder
			saleOrder.setUser(user);
		}
		return super.saveOrUpdate(saleOrder);
	}

	public List<SaleOrder> findAll() {
		return super.executeNativeSql("SELECT * FROM tbl_sale_order");
	}

	public List<SaleOrder> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_sale_order WHERE status= 'ACTIVE' ");
	}

	public List<SaleOrder> getOrdersByUserId(int userId) {
		return super.executeNativeSql("SELECT * FROM tbl_sale_order WHERE user_id = " + userId + " ORDER BY tbl_sale_order.create_date DESC");
	}
	
	@Transactional
	public void deleteSaleOrderById(int id) {
		super.deleteById(id);
	}

	// -----------Search Sale Order------------
	public List<SaleOrder> searchOrder(SearchModel orderSearch) {
		// Tao cau lenh sql
		String sql = "SELECT * FROM tbl_sale_order s WHERE 1=1";

		// Tim kiem voi status
		if (!"ALL".equals(orderSearch.getStatus())) { // Có chọn Active/Inactive
			String status = orderSearch.getStatus();
			sql += " AND s.status = '" + status + "'";
		}

		// Tim kiem voi keyword
		if (!StringUtils.isEmpty(orderSearch.getKeyword())) {
			String keyword = orderSearch.getKeyword().toLowerCase();

			sql += " AND (s.code LIKE '%" + keyword + "%'" + " OR LOWER(s.customer_name) LIKE '%" + keyword + "%'"
					+ " OR LOWER(s.customer_address) LIKE '%" + keyword + "%')";
		}

		// Tim kiem voi ngay thang
		if (!StringUtils.isEmpty(orderSearch.getBeginDate()) && !StringUtils.isEmpty(orderSearch.getEndDate())) {
			String beginDate = orderSearch.getBeginDate();
			String endDate = orderSearch.getEndDate();

			sql += " AND s.create_date BETWEEN '" + beginDate + "' AND '" + endDate + "'";
		}
		sql += " ORDER BY s.create_date DESC";
		return super.executeNativeSql(sql);
	}

	public List<BigDecimal> getMoneyByMonths(int year) {
		List<BigDecimal> dashboardRevenue = new ArrayList<>();

		for (int i = 1; i <= 12; i++) {
			BigDecimal revenue = (BigDecimal) entityManager.createNativeQuery(
					"SELECT COALESCE(SUM(total), 0) FROM tbl_sale_order WHERE status='DELIVERED' AND  YEAR(create_date) = :year AND MONTH(create_date) = :month")
					.setParameter("year", year).setParameter("month", i).getSingleResult();
			dashboardRevenue.add(revenue);
		}
		return dashboardRevenue;
	}

	// Hàm trả về list số lượng các đơn hàng trong năm hiện tại theo tháng
	public List<BigInteger> getOrderByMonths(int year) {
		List<BigInteger> dashboardOrder = new ArrayList<>();

		for (int i = 1; i <= 12; i++) {
			BigInteger orderCount = (BigInteger) entityManager.createNativeQuery(
					"SELECT COUNT(*) FROM tbl_sale_order WHERE status='DELIVERED' AND YEAR(create_date) = :year AND MONTH(create_date) = :month")
					.setParameter("year", year).setParameter("month", i).getSingleResult();
			dashboardOrder.add(orderCount);
		}
		return dashboardOrder;
	}

	// Hàm trả về list số lượng các sản phẩm đã bán trong năm hiện tại theo tháng
	public List<BigDecimal> getProductByMonths(int year) {
	    List<BigDecimal> dashboardProduct = new ArrayList<>();

	    for (int i = 1; i <= 12; i++) {
	        BigDecimal productCount = (BigDecimal) entityManager.createNativeQuery(
	            "SELECT COALESCE(SUM(sop.quantity), 0) " +
	            "FROM tbl_sale_order so " +
	            "JOIN tbl_sale_order_product sop ON so.id = sop.sale_order_id " +
	            "WHERE so.status = 'DELIVERED' AND YEAR(so.create_date) = :year AND MONTH(so.create_date) = :month")
	            .setParameter("year", year).setParameter("month", i).getSingleResult();
	        dashboardProduct.add(productCount);
	    }
	    return dashboardProduct;
	}


}
