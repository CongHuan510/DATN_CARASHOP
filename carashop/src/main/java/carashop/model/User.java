package carashop.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import carashop.dto.EnumStatus;

@Entity
@Table(name = "tbl_user")
public class User extends BaseModel implements UserDetails {
	@Column(name = "username", length = 120, nullable = false)
	private String username;

	@Column(name = "password", length = 120, nullable = false)
	private String password;

	@Column(name = "name", length = 120, nullable = true)
	private String name;

	@Column(name = "email", length = 200, nullable = true)
	private String email;

	@Column(name = "mobile", length = 60, nullable = true)
	private String mobile;

	@Column(name = "address", length = 300, nullable = true)
	private String address;

	@Column(name = "avatar", length = 300, nullable = true)
	private String avatar;

	@Column(name = "description", length = 500, nullable = true)
	private String description;

//	Mapping many-to-many: tbl_user -to- tbl_role
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "users")
	private List<Role> roles = new ArrayList<Role>();

	// Add and remove elements out of relational user-role list
	public void addRelationalUserRole(Role role) {
		role.getUsers().add(this);
		roles.add(role);
	}

	public void removeRelationalUserRole(Role role) {
		role.getUsers().remove(this);
		roles.remove(role);
	}

	// ----------Mapping one-to-many: tbl_category-to-tbl_product----------
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	private Set<SaleOrder> saleOrders = new HashSet<SaleOrder>();

	public void addRelationalSaleOrder(SaleOrder saleOrder) {
		if (saleOrder != null) {
			saleOrders.add(saleOrder);
			saleOrder.setUser(this);
		}
	}

	public void removeRelationalSaleOrder(SaleOrder saleOrder) {
		saleOrders.remove(saleOrder);
		saleOrder.setUser(null);
	}
	// --------------------------------------------------------------------------

	// -----------Mapping one-to-many: tbl_product-to-tbl_product_image
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	private Set<FavoriteProduct> favoriteProducts = new HashSet<FavoriteProduct>();

	public void addRelationalFavoriteProduct(FavoriteProduct favoriteProduct) {
		favoriteProducts.add(favoriteProduct);
		favoriteProduct.setUser(this);
	}

	public void removeRelationalFavoriteProduct(FavoriteProduct favoriteProduct) {
		favoriteProducts.remove(favoriteProduct);
		favoriteProduct.setUser(null);
	}
	// --------------------------------------------------------------------------

	// Mapping one-to-many: tbl_user-to-tbl_category (user create category)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userCreateCategory")
	private Set<Category> userCreateCategories = new HashSet<Category>();

	public void addRelationalUserCreateCategory(Category category) {
		userCreateCategories.add(category);
		category.setUserCreateCategory(this);
	}

	public void removeRelationalUserCreateCategory(Category category) {
		userCreateCategories.remove(category);
		category.setUserCreateCategory(null);
	}

	// Mapping one-to-many: tbl_user-to-tbl_category (user update category)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userUpdateCategory")
	private Set<Category> userUpdateCategories = new HashSet<Category>();

	public void addRelationalUserUpdateCategory(Category category) {
		userUpdateCategories.add(category);
		category.setUserUpdateCategory(this);
	}

	public void removeRelationalUserUpdateCategory(Category category) {
		userUpdateCategories.remove(category);
		category.setUserUpdateCategory(null);
	}

	// -------------------------Mapping one-to-many: tbl_user-to-tbl_product (user
	// create product)-------------------------------
	//
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userCreateProduct")
	private Set<Product> userCreateProducts = new HashSet<Product>();

	public void addRelationalUserCreateProduct(Product product) {
		userCreateProducts.add(product);
		product.setUserCreateProduct(this);
	}

	public void removeRelationalUserCreateProduct(Product product) {
		userCreateProducts.remove(product);
		product.setUserCreateProduct(null);
	}

	// Mapping one-to-many: tbl_user-to-tbl_product (user update product)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userUpdateProduct")
	private Set<Product> userUpdateProducts = new HashSet<Product>();

	public void addRelationalUserUpdateProduct(Product product) {
		userUpdateProducts.add(product);
		product.setUserUpdateProduct(this);
	}

	public void removeRelationalUserUpdateProduct(Product product) {
		userUpdateProducts.remove(product);
		product.setUserUpdateProduct(null);
	}

	// -------------------------Mapping one-to-many: tbl_user-to-tbl_sale-order
	// (user create product)-------------------------------
	//
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userCreateSaleOrder")
	private Set<SaleOrder> userCreateSaleOrders = new HashSet<SaleOrder>();

	public void addRelationalUserCreateSaleOrder(SaleOrder saleOrder) {
		userCreateSaleOrders.add(saleOrder);
		saleOrder.setUserCreateSaleOrder(this);
	}

	public void removeRelationalUserCreateSaleOrder(SaleOrder saleOrder) {
		userCreateSaleOrders.remove(saleOrder);
		saleOrder.setUserCreateSaleOrder(null);
	}

	// Mapping one-to-many: tbl_user-to-tbl_product (user update product)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userUpdateSaleOrder")
	private Set<SaleOrder> userUpdateSaleOrders = new HashSet<SaleOrder>();

	public void addRelationalUserUpdateSaleOrder(SaleOrder saleOrder) {
		userUpdateSaleOrders.add(saleOrder);
		saleOrder.setUserUpdateSaleOrder(this);
	}

	public void removeRelationalUserUpdateSaleOrder(SaleOrder saleOrder) {
		userUpdateSaleOrders.remove(saleOrder);
		saleOrder.setUserUpdateSaleOrder(null);
	}

	// Mapping one-to-many: tbl_user-to-tbl_category (user create category)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userCreateCustomerContact")
	private Set<CustomerContact> userCreateCustomerContacts = new HashSet<CustomerContact>();

	public void addRelationalUserCreateCustomerContact(CustomerContact customerContact) {
		userCreateCustomerContacts.add(customerContact);
		customerContact.setUserCreateCustomerContact(this);
	}

	public void removeRelationalUserCreateCustomerContact(CustomerContact customerContact) {
		userCreateCustomerContacts.remove(customerContact);
		customerContact.setUserCreateCustomerContact(null);
	}

	// Mapping one-to-many: tbl_user-to-tbl_category (user update category)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userUpdateCustomerContact")
	private Set<CustomerContact> userUpdateCustomerContacts = new HashSet<CustomerContact>();

	public void addRelationalUserUpdateCustomerContact(CustomerContact customerContact) {
		userUpdateCustomerContacts.add(customerContact);
		customerContact.setUserUpdateCustomerContact(this);
	}

	public void removeRelationalUserUpdateCustomerContact(CustomerContact customerContact) {
		userUpdateCustomerContacts.remove(customerContact);
		customerContact.setUserUpdateCustomerContact(null);
	}

	// -----------Mapping one-to-many: tbl_user-to-tbl_product_rating
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	private Set<ProductComment> productRatings = new HashSet<ProductComment>();

	// Methods add and remove elements in relational product list
	public void addRelationalProductRating(ProductComment productRating) {
		productRatings.add(productRating);
		productRating.setUser(this);
		;
	}

	public void removeRelationalProductRating(ProductComment productRating) {
		productRatings.remove(productRating);
		productRating.setUser(null);
	}

	// Mapping one-to-many: tbl_user-to-tbl_category (user create category)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userCreateNews")
	private Set<News> userCreateNews = new HashSet<News>();

	public void addRelationalUserCreateNews(News news) {
		userCreateNews.add(news);
		news.setUserCreateNews(this);
	}

	public void removeRelationalUserCreateNews(News news) {
		userCreateNews.remove(news);
		news.setUserCreateNews(null);
	}

	// Mapping one-to-many: tbl_user-to-tbl_category (user update category)
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userUpdateNews")
	private Set<News> userUpdateNews = new HashSet<News>();

	public void addRelationalUserUpdateNews(News news) {
		userUpdateNews.add(news);
		news.setUserUpdateNews(this);
	}

	public void removeRelationalUserUpdateNews(News news) {
		userUpdateNews.remove(news);
		news.setUserUpdateNews(null);
	}

	// Mapping many-to-one: tbl_category-to-tbl_user (for create category)
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "create_by")
	private User userCreateUser;

	// Mapping many-to-one: tbl_category-to-tbl_user (for update category)
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "update_by")
	private User userUpdateUser;

	public User() {
		super();
	}

	public User(Integer id, Date createDate, Date updateDate, EnumStatus status, String username, String password,
			String name, String email, String mobile, String address, String avatar, String description,
			List<Role> roles, Set<SaleOrder> saleOrders, Set<FavoriteProduct> favoriteProducts,
			Set<Category> userCreateCategories, Set<Category> userUpdateCategories, Set<Product> userCreateProducts,
			Set<Product> userUpdateProducts, Set<SaleOrder> userCreateSaleOrders, Set<SaleOrder> userUpdateSaleOrders,
			Set<CustomerContact> userCreateCustomerContacts, Set<CustomerContact> userUpdateCustomerContacts,
			Set<ProductComment> productRatings, Set<News> userCreateNews, Set<News> userUpdateNews, User userCreateUser,
			User userUpdateUser) {
		super(id, createDate, updateDate, status);
		this.username = username;
		this.password = password;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.address = address;
		this.avatar = avatar;
		this.description = description;
		this.roles = roles;
		this.saleOrders = saleOrders;
		this.favoriteProducts = favoriteProducts;
		this.userCreateCategories = userCreateCategories;
		this.userUpdateCategories = userUpdateCategories;
		this.userCreateProducts = userCreateProducts;
		this.userUpdateProducts = userUpdateProducts;
		this.userCreateSaleOrders = userCreateSaleOrders;
		this.userUpdateSaleOrders = userUpdateSaleOrders;
		this.userCreateCustomerContacts = userCreateCustomerContacts;
		this.userUpdateCustomerContacts = userUpdateCustomerContacts;
		this.productRatings = productRatings;
		this.userCreateNews = userCreateNews;
		this.userUpdateNews = userUpdateNews;
		this.userCreateUser = userCreateUser;
		this.userUpdateUser = userUpdateUser;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public Set<SaleOrder> getSaleOrders() {
		return saleOrders;
	}

	public void setSaleOrders(Set<SaleOrder> saleOrders) {
		this.saleOrders = saleOrders;
	}

	public Set<Category> getUserCreateCategories() {
		return userCreateCategories;
	}

	public void setUserCreateCategories(Set<Category> userCreateCategories) {
		this.userCreateCategories = userCreateCategories;
	}

	public Set<Category> getUserUpdateCategories() {
		return userUpdateCategories;
	}

	public void setUserUpdateCategories(Set<Category> userUpdateCategories) {
		this.userUpdateCategories = userUpdateCategories;
	}

	public Set<Product> getUserCreateProducts() {
		return userCreateProducts;
	}

	public void setUserCreateProducts(Set<Product> userCreateProducts) {
		this.userCreateProducts = userCreateProducts;
	}

	public Set<Product> getUserUpdateProducts() {
		return userUpdateProducts;
	}

	public void setUserUpdateProducts(Set<Product> userUpdateProducts) {
		this.userUpdateProducts = userUpdateProducts;
	}

	public Set<SaleOrder> getUserCreateSaleOrders() {
		return userCreateSaleOrders;
	}

	public void setUserCreateSaleOrders(Set<SaleOrder> userCreateSaleOrders) {
		this.userCreateSaleOrders = userCreateSaleOrders;
	}

	public Set<SaleOrder> getUserUpdateSaleOrders() {
		return userUpdateSaleOrders;
	}

	public void setUserUpdateSaleOrders(Set<SaleOrder> userUpdateSaleOrders) {
		this.userUpdateSaleOrders = userUpdateSaleOrders;
	}

	public User getUserCreateUser() {
		return userCreateUser;
	}

	public void setUserCreateUser(User userCreateUser) {
		this.userCreateUser = userCreateUser;
	}

	public User getUserUpdateUser() {
		return userUpdateUser;
	}

	public void setUserUpdateUser(User userUpdateUser) {
		this.userUpdateUser = userUpdateUser;
	}

	public Set<CustomerContact> getUserCreateCustomerContacts() {
		return userCreateCustomerContacts;
	}

	public void setUserCreateCustomerContacts(Set<CustomerContact> userCreateCustomerContacts) {
		this.userCreateCustomerContacts = userCreateCustomerContacts;
	}

	public Set<CustomerContact> getUserUpdateCustomerContacts() {
		return userUpdateCustomerContacts;
	}

	public void setUserUpdateCustomerContacts(Set<CustomerContact> userUpdateCustomerContacts) {
		this.userUpdateCustomerContacts = userUpdateCustomerContacts;
	}

	public Set<FavoriteProduct> getFavoriteProducts() {
		return favoriteProducts;
	}

	public void setFavoriteProducts(Set<FavoriteProduct> favoriteProducts) {
		this.favoriteProducts = favoriteProducts;
	}

	public Set<ProductComment> getProductRatings() {
		return productRatings;
	}

	public void setProductRatings(Set<ProductComment> productRatings) {
		this.productRatings = productRatings;
	}

	public Set<News> getUserCreateNews() {
		return userCreateNews;
	}

	public void setUserCreateNews(Set<News> userCreateNews) {
		this.userCreateNews = userCreateNews;
	}

	public Set<News> getUserUpdateNews() {
		return userUpdateNews;
	}

	public void setUserUpdateNews(Set<News> userUpdateNews) {
		this.userUpdateNews = userUpdateNews;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return this.roles;
	}

	@Override
	public boolean isAccountNonExpired() { // tài khoản chưa hết hạn
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() { // không bị khóa
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() { // thông tin xác thực chưa hết hạn
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() { // được kích hoạt
		// TODO Auto-generated method stub
		return true;
	}
}
