package carashop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_contact")
public class CustomerContact extends BaseModel {
	@Column(name = "name", length = 120, nullable = true)
	private String name;

	@Column(name = "mobile", length = 60, nullable = true)
	private String mobile;

	@Column(name = "email", length = 200, nullable = true)
	private String email;

	@Column(name = "address", length = 300, nullable = true)
	private String address;

	@Column(name = "message", length = 1200, nullable = true)
	private String message;

	// Mapping many-to-one: tbl_role-to-tbl_user (for create category)
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "create_by")
	private User userCreateCustomerContact;

	// Mapping many-to-one: tbl_role-to-tbl_user (for update category)
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "update_by")
	private User userUpdateCustomerContact;

	public CustomerContact() {
		super();
	}

	public CustomerContact(String name, String mobile, String email, String address, String message,
			User userCreateCustomerContact, User userUpdateCustomerContact) {
		super();
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.address = address;
		this.message = message;
		this.userCreateCustomerContact = userCreateCustomerContact;
		this.userUpdateCustomerContact = userUpdateCustomerContact;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public User getUserCreateCustomerContact() {
		return userCreateCustomerContact;
	}

	public void setUserCreateCustomerContact(User userCreateCustomerContact) {
		this.userCreateCustomerContact = userCreateCustomerContact;
	}

	public User getUserUpdateCustomerContact() {
		return userUpdateCustomerContact;
	}

	public void setUserUpdateCustomerContact(User userUpdateCustomerContact) {
		this.userUpdateCustomerContact = userUpdateCustomerContact;
	}
}
