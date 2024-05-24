package carashop.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import carashop.dto.EnumStatus;

@Entity
@Table(name = "tbl_favorite_product")
public class FavoriteProduct extends BaseModel {
	
//	----------Mapping many-to-one: favoriteProduct-to-product----------
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_id")
	private Product product;
	
//	----------Mapping many-to-one: favoriteProduct-to-user----------
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private User user;
	
	public FavoriteProduct() {
		super();
	}

	public FavoriteProduct(Integer id, Date createDate, Date updateDate, EnumStatus status, Product product, User user) {
		super(id, createDate, updateDate, status);
		this.product = product;
		this.user = user;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}
