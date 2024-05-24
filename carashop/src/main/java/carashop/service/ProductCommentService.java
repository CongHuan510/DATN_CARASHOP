package carashop.service;

import java.util.List;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import carashop.dto.SearchModel;
import carashop.model.ProductComment;

@Service
public class ProductCommentService extends BaseService<ProductComment> {

	@Override
	public Class<ProductComment> clazz() {
		return ProductComment.class;
	}

	public List<ProductComment> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_product_comment WHERE status = 'ACTIVE'");
	}

	public List<ProductComment> findByUserIdAndProductId(int productId, int userId) {
		return super.executeNativeSql(
				"SELECT * FROM tbl_product_comment WHERE product_id = " + productId + " AND user_id = " + userId);
	}

	@Transactional
	public void deleteProductCommentById(int id) {
		super.deleteById(id);
	}

	@Transactional
	public void inactiveProductComment(ProductComment productComment) {
		super.saveOrUpdate(productComment);
	}

	public List<ProductComment> findAllReviewsByProductId(int productId) {
		String sql = "SELECT * FROM tbl_product_comment WHERE (product_rating != 0 OR comment is not null) AND  status = 'ACTIVE' AND product_id = "
				+ productId;
		return super.executeNativeSql(sql);
	}

	// Tính sao trung bình
	public double CalAverageByProductId(int productId) {
		List<ProductComment> comments = findAllReviewsByProductId(productId);
		// Kiểm tra nếu danh sách đánh giá là null hoặc rỗng, trả về giá trị mặc định
		// ngay từ đầu
		if (comments == null || comments.isEmpty()) {
			return 0;
		}

		double totalRating = 0.0;
		int numberOfComments = 0;
		for (ProductComment comment : comments) {
			totalRating += comment.getProductRating();
			numberOfComments++;
		}
		return totalRating / numberOfComments;
	}

	// -----------------------------searchComment----------------------------
	public List<ProductComment> searchComment(SearchModel commentSearch) {
		// Tao cau lenh sql;
		String sql = "SELECT * FROM tbl_product_comment pc Where 1=1";
		
		// Tim kiem voi status
		if (!"ALL".equals(commentSearch.getStatus())) { // Có chọn Active/Inactive
			String status = commentSearch.getStatus();
			sql += " AND pc.status = '" + status + "'";
		}

		// Tim kiem voi keyword
		if (!StringUtils.isEmpty(commentSearch.getKeyword())) {
			String keyword = commentSearch.getKeyword().toLowerCase();

			sql += " AND (LOWER(pc.comment) like '%" + keyword + "%')";
		}

		// Tim kiem voi ngay thang
		if (!StringUtils.isEmpty(commentSearch.getBeginDate()) && !StringUtils.isEmpty(commentSearch.getEndDate())) {
			String beginDate = commentSearch.getBeginDate();
			String endDate = commentSearch.getEndDate();

			sql += " AND pc.create_date BETWEEN '" + beginDate + "' AND '" + endDate + "'";
		}
		sql += " ORDER BY pc.create_date DESC";
		return super.executeNativeSql(sql);
	}

	public boolean hasUserReviewedProduct(int productId, int userId) {
		// Lấy ra danh sách đánh giá của người dùng cho sản phẩm có id là productId
		List<ProductComment> userComments = findByUserIdAndProductId(productId, userId);
		if (userComments != null && !userComments.isEmpty()) {
			return true;
		} else {
			return false;
		}
	}

	public ProductComment findPendingReviewByUserIdAndProductId(int productId, int userId) {
		String sql = "SELECT * FROM tbl_product_comment WHERE product_id = " + productId + " AND user_id = " + userId
				+ " AND product_rating = 0 AND comment IS NULL";
		List<ProductComment> pendingReviews = super.executeNativeSql(sql);
		if (!pendingReviews.isEmpty()) {
			return pendingReviews.get(0);
		}
		return null;
	}
}
