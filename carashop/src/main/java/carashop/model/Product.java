package carashop.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import carashop.dto.EnumStatus;

@Entity
@Table(name = "tbl_product")
public class Product extends BaseModel {
	@Column(name = "name", length = 300, nullable = false)
	private String name;

	@Column(name = "avatar", length = 300, nullable = true)
	private String avatar;
	
	@Column(name = "product_quantity", nullable = true)
	private Integer productQuantity;

	@Column(name = "price", nullable = true)
	private BigDecimal price;

	@Column(name = "sale_price", nullable = true)
	private BigDecimal salePrice;
	
	@Column(name = "size", length = 50, nullable = true)
	private String size;

	@Column(name = "short_description", length = 500, nullable = true)
	private String shortDescription;

	@Column(name = "detail_description", nullable = true)
	private String detailDescription;

	@Column(name = "is_hot", nullable = true)
	private Boolean isHot = Boolean.FALSE;

	@Column(name = "seo", length = 1000, nullable = true)
	private String seo;

//	----------Mapping many-to-one: product-to-category----------
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id")
	private Category category;

	// -----------------Mapping many-to-one: tbl_product-to-tbl_user (for create
	// product)----------------------------
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "create_by")
	private User userCreateProduct;

	// ----------------Mapping many-to-one: tbl_product-to-tbl_user (for update
	// product)-------------------------------
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "update_by")
	private User userUpdateProduct;

	// -----------Mapping one-to-many: tbl_product-to-tbl_product_image
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "product")
	private Set<ProductImage> product_images = new HashSet<ProductImage>();

	// Methods add and remove elements in relational product list
	public void addRelationalProductImage(ProductImage product_image) {
		product_images.add(product_image);
		product_image.setProduct(this);
	}

	public void removeRelationalProductImage(ProductImage product_image) {
		product_images.remove(product_image);
		product_image.setProduct(null);
	}
	// --------------------------------------------------------------------------

	// -----------Mapping one-to-many: tbl_product-to-tbl_product_image
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "product")
	private Set<FavoriteProduct> favoriteProducts = new HashSet<FavoriteProduct>();

	// Methods add and remove elements in relational product list
	public void addRelationalFavoriteProduct(FavoriteProduct favoriteProduct) {
		favoriteProducts.add(favoriteProduct);
		favoriteProduct.setProduct(this);
	}

	public void removeRelationalFavoriteProduct(FavoriteProduct favoriteProduct) {
		favoriteProducts.remove(favoriteProduct);
		favoriteProduct.setProduct(null);
	}
	// --------------------------------------------------------------------------

	// -----------Mapping one-to-many: tbl_product-to-tbl_sale_order-product
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "product")
	private Set<SaleOrderProduct> saleOrderProducts = new HashSet<SaleOrderProduct>();

	// Methods add and remove elements in relational product list
	public void addRelationalSaleOrderProduct(SaleOrderProduct saleOrderProduct) {
		saleOrderProducts.add(saleOrderProduct);
		saleOrderProduct.setProduct(this);
	}

	public void removeRelationalSaleOrderProduct(SaleOrderProduct saleOrderProduct) {
		saleOrderProducts.remove(saleOrderProduct);
		saleOrderProduct.setProduct(null);
	}

	// -----------Mapping one-to-many: tbl_product-to-tbl_product_rating
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "product")
	private Set<ProductComment> productRatings = new HashSet<ProductComment>();

	// Methods add and remove elements in relational product list
	public void addRelationalProductRating(ProductComment productRating) {
		productRatings.add(productRating);
		productRating.setProduct(this);
	}

	public void removeRelationalProductRating(ProductComment productRating) {
		productRatings.remove(productRating);
		productRating.setProduct(null);
	}
//		// --------------------------------------------------------------------------

	public Product() {
		super();
	}

	public Product(Integer id, Date createDate, Date updateDate, EnumStatus status, String name, String avatar,
		int productQuantity, BigDecimal price, BigDecimal salePrice, String size, String shortDescription,
		String detailDescription, Boolean isHot, String seo, Category category, User userCreateProduct,
		User userUpdateProduct, Set<ProductImage> product_images, Set<FavoriteProduct> favoriteProducts,
		Set<SaleOrderProduct> saleOrderProducts, Set<ProductComment> productRatings) {
	super(id, createDate, updateDate, status);
	this.name = name;
	this.avatar = avatar;
	this.productQuantity = productQuantity;
	this.price = price;
	this.salePrice = salePrice;
	this.size = size;
	this.shortDescription = shortDescription;
	this.detailDescription = detailDescription;
	this.isHot = isHot;
	this.seo = seo;
	this.category = category;
	this.userCreateProduct = userCreateProduct;
	this.userUpdateProduct = userUpdateProduct;
	this.product_images = product_images;
	this.favoriteProducts = favoriteProducts;
	this.saleOrderProducts = saleOrderProducts;
	this.productRatings = productRatings;
}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	
	public Integer getProductQuantity() {
		return productQuantity;
	}

	public void setProductQuantity(Integer productQuantity) {
		this.productQuantity = productQuantity;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(BigDecimal salePrice) {
		this.salePrice = salePrice;
	}
	
	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getDetailDescription() {
		return detailDescription;
	}

	public void setDetailDescription(String detailDescription) {
		this.detailDescription = detailDescription;
	}

	public Boolean getIsHot() {
		return isHot;
	}

	public void setIsHot(Boolean isHot) {
		this.isHot = isHot;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public User getUserCreateProduct() {
		return userCreateProduct;
	}

	public void setUserCreateProduct(User userCreateProduct) {
		this.userCreateProduct = userCreateProduct;
	}

	public User getUserUpdateProduct() {
		return userUpdateProduct;
	}

	public void setUserUpdateProduct(User userUpdateProduct) {
		this.userUpdateProduct = userUpdateProduct;
	}

	public Set<ProductImage> getProduct_images() {
		return product_images;
	}

	public void setProduct_images(Set<ProductImage> product_images) {
		this.product_images = product_images;
	}

	public Set<FavoriteProduct> getFavoriteProducts() {
		return favoriteProducts;
	}

	public void setFavoriteProducts(Set<FavoriteProduct> favoriteProducts) {
		this.favoriteProducts = favoriteProducts;
	}

	public Set<SaleOrderProduct> getSaleOrderProducts() {
		return saleOrderProducts;
	}

	public void setSaleOrderProducts(Set<SaleOrderProduct> saleOrderProducts) {
		this.saleOrderProducts = saleOrderProducts;
	}

	public Set<ProductComment> getProductRatings() {
		return productRatings;
	}

	public void setProductRatings(Set<ProductComment> productRatings) {
		this.productRatings = productRatings;
	}
}
