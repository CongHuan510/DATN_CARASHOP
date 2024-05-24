package carashop.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import carashop.dto.EnumStatus;

@Entity
@Table(name = "tbl_product_comment")
public class ProductComment extends BaseModel {
	@Column(name = "product_rating", nullable = true)
	private int productRating;

	@Column(name = "comment", length = 1000, nullable = true)
	private String comment;

//	----------Mapping many-to-one: product_rating-to-product----------
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_id")
	private Product product;

//	----------Mapping many-to-one: product_rating-to-product----------
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private User user;

	public ProductComment() {
		super();
	}
	
	public ProductComment(Product product, User user) {
		this.product = product;
		this.user = user;
		this.setStatus(EnumStatus.INACTIVE);
		this.productRating = 0;
		this.comment = null;
	}

	public ProductComment(Integer id, Date createDate, Date updateDate, EnumStatus status, int productRating,
			String comment, Product product, User user) {
		super(id, createDate, updateDate, status);
		this.productRating = productRating;
		this.comment = comment;
		this.product = product;
		this.user = user;
	}

	public int getProductRating() {
		return productRating;
	}

	public void setProductRating(int productRating) {
		this.productRating = productRating;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
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
