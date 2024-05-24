package carashop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import carashop.model.ProductImage;

@Service
public class ProductImageService extends BaseService<ProductImage> {
	@Override
	public Class<ProductImage> clazz(){
		return ProductImage.class;
	}
	
	public List<ProductImage> getProductImagesByProductIdImages(int productId) {
		String sql = "SELECT * FROM tbl_product_image WHERE product_id=" + productId;
		return super.executeNativeSql(sql);
	}
}
