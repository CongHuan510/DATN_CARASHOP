package carashop.dto;

public class Customer {
	
	private String txtName;
	private String txtEmail;
	private String txtMobile;
	private String txtAddress;
	private String txtNote;
	
	public Customer() {
		super();
	}

	public Customer(String txtName, String txtEmail, String txtMobile, String txtAddress, String txtNote) {
		super();
		this.txtName = txtName;
		this.txtEmail = txtEmail;
		this.txtMobile = txtMobile;
		this.txtAddress = txtAddress;
		this.txtNote = txtNote;
	}

	public String getTxtName() {
		return txtName;
	}

	public void setTxtName(String txtName) {
		this.txtName = txtName;
	}

	public String getTxtEmail() {
		return txtEmail;
	}

	public void setTxtEmail(String txtEmail) {
		this.txtEmail = txtEmail;
	}

	public String getTxtMobile() {
		return txtMobile;
	}

	public void setTxtMobile(String txtMobile) {
		this.txtMobile = txtMobile;
	}

	public String getTxtAddress() {
		return txtAddress;
	}

	public void setTxtAddress(String txtAddress) {
		this.txtAddress = txtAddress;
	}

	public String getTxtNote() {
		return txtNote;
	}

	public void setTxtNote(String txtNote) {
		this.txtNote = txtNote;
	}
}
