package carashop.service;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import carashop.dto.EnumStatus;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.Product;
import carashop.model.ProductImage;

@Service
public class ProductService extends BaseService<Product> implements Jw27Constants {
	@Override
	public Class<Product> clazz() {
		return Product.class;
	}

	public List<Product> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_product WHERE status = 'ACTIVE'");
	}
	
	// Lấy ra danh sách sản phẩm với category tương ứng
	public List<Product> findAllProductByCategory(int categoryId, int productId) {
		return super.executeNativeSql("SELECT * FROM tbl_product WHERE status = 'ACTIVE' AND id != " + productId + " AND category_id = " + categoryId);
	}
	
	// Lấy ra danh sách sản phẩm với is_hot true
	public List<Product> findAllActiveAndIsHot() {
		return super.executeNativeSql("SELECT * FROM tbl_product WHERE status = 'ACTIVE' AND is_hot = 1");
	}
	
	// Lấy ra danh sách 8 sản phẩm mới nhất
	public List<Product> findTop8ProductNew() {
	    return super.executeNativeSql("SELECT * FROM tbl_product WHERE status = 'ACTIVE' ORDER BY create_date DESC LIMIT 8");
	}


	// Phương thức kiểm tra (1) file có được upload hay không?
	public boolean isUploadFile(MultipartFile file) {
		// file null hoặc tên file rỗng
		if (file == null || file.getOriginalFilename().isEmpty()) {
			return false; // Không upload
		}
		return true; // Có upload
	}

	// Phương thức kiểm tra (2) danh sách file có upload file nào không?
	public boolean isUploadFiles(MultipartFile[] file) {
		// không có file nào được upload
		if (file == null || file.length == 0) {
			return false; // Không upload file
		}
		return true; // Có upload it nhất 1 file
	}

	// --------------------------Save add new product to database--------------------------------
	@Transactional
	public Product saveAddProduct(Product product, MultipartFile avatarFile, MultipartFile[] imageFiles)
			throws IOException {
		// Lưu avatar vào file
		if (isUploadFile(avatarFile)) {
			// Lưu file vào thư mục Product/Avatar
			String path = FOLDER_UPLOAD + "Product/Avatar/" + avatarFile.getOriginalFilename();
			File file = new File(path);
			avatarFile.transferTo(file);
			// Lưu đường dẫn vào bảng tbl_product
			product.setAvatar("Product/Avatar/" + avatarFile.getOriginalFilename());
		}

		// Lưu images vào file
		if (isUploadFiles(imageFiles)) { // Có upload danh sách ảnh
			// Duyệt danh sách file images
			for (MultipartFile imageFile : imageFiles) {
				if (isUploadFile(imageFile)) { // File có upload
					// Lưu file vào thư mục Product/Image/
					String path = FOLDER_UPLOAD + "Product/Image/" + imageFile.getOriginalFilename();
					File file = new File(path);
					imageFile.transferTo(file);

					// Lưu file vào thư mục Product/image
					ProductImage product_image = new ProductImage();
					product_image.setTitle(imageFile.getOriginalFilename());
					product_image.setPath("Product/Image/" + imageFile.getOriginalFilename());
					product_image.setStatus(EnumStatus.ACTIVE);
					product_image.setCreateDate(new Date());

					// Lưu đường dẫn ảnh sang bảng tbl_product_image
					product.addRelationalProductImage(product_image);
				}
			}
		}

		return super.saveOrUpdate(product);
	}

	// Save edit product
	@Transactional
	public Product saveEditProduct(Product product, MultipartFile avatarFile, MultipartFile[] imageFiles)
			throws IOException {
		// Lay produc trong db
		Product dbProduct = super.getById(product.getId());
		// Luu avatar file moi neu nguoi dung co upload avatar
		if (isUploadFile(avatarFile)) { // Co upload file avatar

			// Xoa avatar cu (Xoa file avatar)
			String path = FOLDER_UPLOAD + dbProduct.getAvatar();
			File file = new File(path);
			file.delete();

			// Lưu file avatar mới vào thư mực Product/Avatar
			path = FOLDER_UPLOAD + "Product/Avatar/" + avatarFile.getOriginalFilename();
			file = new File(path);
			avatarFile.transferTo(file);
			// Lưu đường dẫn của avatar mới vào bảng tbl_product
			product.setAvatar("Product/Avatar/" + avatarFile.getOriginalFilename());
		} else { // Người dùng không upload avatar file
			// giữ nguyên avatar cũ
			product.setAvatar(dbProduct.getAvatar());
		}
		// Luu images file
		if (isUploadFiles(imageFiles)) { // Có upload danh sách ảnh
			// Duyệt qua danh sách file images
			for (MultipartFile imageFile : imageFiles) {
				if (isUploadFile(imageFile)) { // FIle có upload
					// Lưu file vào thư mục Product/Image

					String path = FOLDER_UPLOAD + "Product/Image/" + imageFile.getOriginalFilename();
					File file = new File(path);
					imageFile.transferTo(file);

					// Lưu đường dẫn vào tbl_product_image
					ProductImage product_image = new ProductImage();
					product_image.setTitle(imageFile.getOriginalFilename());
					product_image.setPath("Product/Image/" + imageFile.getOriginalFilename());
					product_image.setStatus(EnumStatus.ACTIVE);
					product_image.setCreateDate(new Date());

					// Lưu (đối tượng product image) đường dẫn ảnh sang bảng tbl_product_image
					product.addRelationalProductImage(product_image);
				}
			}
		}
		return super.saveOrUpdate(product);
	}

	//-----------------------DELETE PRODUCT-----------------------
	@Autowired
	private ProductImageService product_imageService;

	@Transactional
	public void deleteProduct(Product product) {
		// +Lay danh sach anh cua product ttrong tbl_product_image
		String sql = "select * from tbl_product_image where product_id = " + product.getId();
		List<ProductImage> product_images = product_imageService.executeNativeSql(sql);
		// Xoa lan luot cac anh cua product trong Product/image và
		// Xoa lan luot cac duong dan cua anh trong tbl_product_image
		for (ProductImage product_image : product_images) {
			// Xóa file trong thư mục Product image trước
			String path = FOLDER_UPLOAD + product_image.getPath();
			File file = new File(path);
			file.delete();
			// Xoa ban ghi thong tin anh trong tbl_product_image
			//product.removeRelationalProductImage(product_image);
		}

		// Xoa file avatar trong thu muc Product/Avatar
		String path = FOLDER_UPLOAD + product.getAvatar();
		File file = new File(path);
		file.delete();

		super.delete(product);
	}

	@Transactional
	public void deleteProductById(int id) {
		super.deleteById(id);
	}

	@Transactional
	public void inactiveProduct(Product product) {
		super.saveOrUpdate(product);
	}

	// -----------------------------searchProduct----------------------------
	public List<Product> searchProduct(SearchModel productSearch) {
		// Tao cau lenh sql;
		String sql = "SELECT * FROM tbl_product p WHERE 1=1";

		// Tim kiem voi status
		if (!"ALL".equals(productSearch.getStatus())) { // Có chọn Active/Inactive
			String status = productSearch.getStatus();
			sql += " AND p.status = '" + status + "'";
		}

		// Tim kiem voi status
		if (productSearch.getCategoryId() != 0) {
			sql += " AND p.category_id=" + productSearch.getCategoryId();
		}

		// Tim kiem voi keyword
		if (!StringUtils.isEmpty(productSearch.getKeyword())) {
			String keyword = productSearch.getKeyword().toLowerCase();

			sql += " AND (LOWER(p.name) like '%" + keyword + "%'" + " OR LOWER(p.short_description) like '%" + keyword
					+ "%'" + " OR LOWER(p.seo) like '%" + keyword + "%')";
		}

		// Tim kiem voi ngay thang
		if (!StringUtils.isEmpty(productSearch.getBeginDate()) && !StringUtils.isEmpty(productSearch.getEndDate())) {
			String beginDate = productSearch.getBeginDate();
			String endDate = productSearch.getEndDate();

			sql += " AND p.create_date BETWEEN '" + beginDate + "' AND '" + endDate + "'";
		}
		
		sql += " ORDER BY p.create_date DESC";
		return super.executeNativeSql(sql);
	}

	// -----------------------------searchProduct----------------------------
	public List<Product> searchListProduct(SearchModel productSearch) {
		// Tao cau lenh sql;
		String sql = "SELECT * FROM tbl_product p WHERE 1=1 AND p.status = 'ACTIVE'";

		// Tim kiem voi status
		if (productSearch.getCategoryId() != 0) {
			sql += " AND p.category_id=" + productSearch.getCategoryId();
		}

		// Tim kiem voi keyword
		if (!StringUtils.isEmpty(productSearch.getKeyword())) {
			String keyword = productSearch.getKeyword().toLowerCase();

			sql += " AND (LOWER(p.name) like '%" + keyword + "%')";
		}

		// Checkbox giá từ minPrice đến maxPrice
		if (productSearch.getPriceCheck() != 0) {
			switch (productSearch.getPriceCheck()) {
			case 1:
				sql += " AND p.price BETWEEN 100000 AND 200000";
				break;
			case 2:
				sql += " AND p.price BETWEEN 200000 AND 300000";
				break;
			case 3:
				sql += " AND p.price BETWEEN 300000 AND 500000";
				break;
			case 4:
				sql += " AND p.price BETWEEN 500000 AND 1000000";
				break;
			case 5:
				sql += " AND p.price >= 1000000";
				break;
			default:
				break;
			}
		}

		// Lọc theo size tìm trong sql
		if (productSearch.getSizeCheck() != null && !StringUtils.isEmpty(productSearch.getSizeCheck())) {
			switch (productSearch.getSizeCheck()) {
			case "M":
				sql += " AND p.size LIKE '%M%'";
				break;
			case "L":
				sql += " AND p.size LIKE '%L%'";
				break;
			case "XL":
				sql += " AND p.size LIKE '%XL%'";
				break;
			case "XXL":
				sql += " AND p.size LIKE '%XXL%'";
				break;
			default:
				break;
			}
		}

		// Sắp xếp sản phẩm theo tùy chọn
		if (productSearch.getSortOption() != null && !productSearch.getSortOption().isEmpty()) {
		    switch (productSearch.getSortOption()) {
		        case "nameASC": // Sắp xếp theo tên tăng dần
		            sql += " ORDER BY LOWER(p.name) COLLATE utf8mb4_unicode_ci ASC";
		            break;
		        case "nameDESC": // Sắp xếp theo tên giảm dần
		            sql += " ORDER BY LOWER(p.name) COLLATE utf8mb4_unicode_ci DESC";
		            break;
		        case "priceASC": // Sắp xếp theo giá tăng dần
		            sql += " ORDER BY p.price ASC";
		            break;
		        case "priceDESC": // Sắp xếp theo giá giảm dần
		            sql += " ORDER BY p.price DESC";
		            break;
		        default:
		            sql += " ORDER BY p.create_date DESC"; // Điều kiện mặc định
		            break;
		    }
		} else {
		    sql += " ORDER BY p.create_date DESC";
		}
		return super.executeNativeSql(sql);
	}
	
	// Lấy ra danh sách kích cỡ từ product
	public List<String> getSizesForProduct(int productId) {
		String sql = "SELECT size FROM tbl_product WHERE id = :productId";
		Query query = entityManager.createNativeQuery(sql);
		query.setParameter("productId", productId);
		@SuppressWarnings("unchecked")
		List<String> sizes = query.getResultList();
		return sizes;
	}
}
