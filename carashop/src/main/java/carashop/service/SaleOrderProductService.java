package carashop.service;

import java.math.BigDecimal;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import carashop.model.Product;
import carashop.model.ProductComment;
import carashop.model.SaleOrderProduct;
import carashop.model.User;


@Service
public class SaleOrderProductService extends BaseService<SaleOrderProduct>{

	@Override
	public Class<SaleOrderProduct> clazz(){
		return SaleOrderProduct.class;
	}
	
	@Transactional
	public SaleOrderProduct saveOrderProduct(SaleOrderProduct saleOrderProduct) {
		return super.saveOrUpdate(saleOrderProduct);
	}
	
	public List<SaleOrderProduct> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_sale_order_product WHERE status = 'ACTIVE'");
	}
	
	public List<SaleOrderProduct> getProductsByOrderId(int orderId) {
		return super.executeNativeSql("SELECT * FROM tbl_sale_order_product WHERE sale_order_id = " + orderId);
	}

	@Transactional
	public void deleteSaleOrderProductId(int id) {
		super.deleteById(id);
	}

	@Transactional
	public void inactiveSaleOrderProduct(SaleOrderProduct saleOrderProduct) {
		super.saveOrUpdate(saleOrderProduct);
	}
	
	//Lay san pham trong don hang
	public List<SaleOrderProduct> findAllProductInOrder(int saleOrderId) {
		String sql = "SELECT * FROM tbl_sale_order_product WHERE sale_order_id = '" + saleOrderId + "'";
		return super.executeNativeSql(sql);
	}
	
	 // Phương thức tính tổng doanh thu của một đơn hàng
    @Transactional
    public BigDecimal calculateOrderTotal(int orderId) {
        // Lấy danh sách sản phẩm trong đơn hàng
        List<SaleOrderProduct> productsInOrder = findAllProductInOrder(orderId);

        // Khởi tạo biến để lưu tổng doanh thu
        BigDecimal total = BigDecimal.ZERO;

        // Duyệt qua danh sách sản phẩm và tính tổng doanh thu
        for (SaleOrderProduct product : productsInOrder) {
            // Lấy giá tiền của sản phẩm và số lượng
            BigDecimal price = product.getProduct().getPrice();
            int quantity = product.getQuantity();

            // Tính tổng giá tiền của sản phẩm
            BigDecimal productTotal = price.multiply(BigDecimal.valueOf(quantity));

            // Cộng tổng giá tiền của sản phẩm vào tổng doanh thu của đơn hàng
            total = total.add(productTotal);
        }

        return total;
    }
    
    
    
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Product> findTopSellingProducts() {
        // Triển khai truy vấn SQL để lấy ra các sản phẩm bán chạy nhất
        String sql = "SELECT p.id, p.name, p.avatar, SUM(sop.quantity) AS quantity " +
                     "FROM tbl_sale_order_product sop " +
                     "JOIN tbl_product p ON sop.product_id = p.id " +
                     "GROUP BY p.id " +
                     "ORDER BY quantity DESC LIMIT 5";

        // Thực thi truy vấn và chuyển đổi kết quả thành danh sách các đối tượng Product
        List<Product> topSellingProducts = jdbcTemplate.query(sql, (rs, rowNum) -> {
            Product product = new Product();
            // Điền thông tin sản phẩm từ ResultSet vào đối tượng Product
            product.setId(rs.getInt("id"));
            product.setName(rs.getString("name"));
            product.setAvatar(rs.getString("avatar"));
            // Điền tổng số lượng bán được vào thuộc tính tùy chỉnh hoặc setter của Product
            product.setProductQuantity(rs.getInt("quantity"));
            // Điền các trường thông tin khác tùy thuộc vào cấu trúc của bảng Product trong cơ sở dữ liệu của bạn
            return product;
        });

        return topSellingProducts;
    }
  
    @Autowired
    private ProductCommentService productCommentService;
    
    public boolean hasPurchasedProduct(int productId) {
    	Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;
			int userId =  user.getId();
			
			List<ProductComment> productComments = productCommentService.findByUserIdAndProductId(productId, userId);
			for (ProductComment productComment : productComments) {
				if (productComment.getProductRating() == 0 && productComment.getComment() == null) {
					return true;
				} 
			} 
			return false;						
		}
		return false;
    }
}
