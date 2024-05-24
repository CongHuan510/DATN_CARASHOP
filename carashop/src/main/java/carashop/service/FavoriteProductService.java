package carashop.service;

import java.util.List;

import javax.persistence.Query;
import javax.transaction.Transactional;
import org.springframework.stereotype.Service;
import carashop.model.FavoriteProduct;

@Service
public class FavoriteProductService extends BaseService<FavoriteProduct> {
	@Override
	public Class<FavoriteProduct> clazz() {
		return FavoriteProduct.class;
	}

	public List<FavoriteProduct> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_favorite_product");
	}

	@Transactional
	public void deleteFavoriteProductById(int id) {
		super.deleteById(id);
	}

	
	public void inactiveFavoriteProduct(FavoriteProduct favoriteProduct) {
		super.saveOrUpdate(favoriteProduct);
	}

	
	public int countTotalFavoriteProductsByUserId(int userId) {
	    Query query = entityManager.createNativeQuery("SELECT COUNT(*) FROM tbl_favorite_product WHERE user_id = :userId");
	    query.setParameter("userId", userId);
	    Number count = (Number) query.getSingleResult();
	    return count.intValue();
	}

	public List<FavoriteProduct> getFavoriteProductsByUserId(int userId) {
		return super.executeNativeSql("SELECT * FROM tbl_favorite_product WHERE user_id = " + userId);
	}
	
	public FavoriteProduct getByProductId(int productId) {
        Query query = entityManager.createNativeQuery("SELECT * FROM tbl_favorite_product WHERE product_id = :productId", FavoriteProduct.class);
        query.setParameter("productId", productId);
        @SuppressWarnings("unchecked")
        List<FavoriteProduct> resultList = query.getResultList();
        if (!resultList.isEmpty()) {
            return resultList.get(0);
        }
        return null;
    }
	
	public boolean isProductInFavorites(int productId, int userId) {
	    // Kiểm tra xem sản phẩm có trong danh sách yêu thích của người dùng không
	    FavoriteProduct favoriteProduct = getByProductIdAndUserId(productId, userId);
	    return favoriteProduct != null;
	}

	public FavoriteProduct getByProductIdAndUserId(int productId, int userId) {
	    // Truy vấn cơ sở dữ liệu để lấy FavoriteProduct dựa trên productId và userId
	    Query query = entityManager.createNativeQuery("SELECT * FROM tbl_favorite_product WHERE product_id = :productId AND user_id = :userId", FavoriteProduct.class);
	    query.setParameter("productId", productId);
	    query.setParameter("userId", userId);
	    @SuppressWarnings("unchecked")
	    List<FavoriteProduct> resultList = query.getResultList();
	    if (!resultList.isEmpty()) {
	        return resultList.get(0);
	    }
	    return null;
	}
}
