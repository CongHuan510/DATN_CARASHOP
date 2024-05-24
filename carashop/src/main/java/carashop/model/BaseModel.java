package carashop.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import org.springframework.format.annotation.DateTimeFormat;

import carashop.dto.EnumStatus;

@MappedSuperclass  
public abstract class BaseModel {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd") // Format kiểu đữ liệu
	@Column(name = "create_date", nullable = true)
	private Date createDate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "update_date", nullable = true)
	private Date updateDate;
	
	@Column(name = "status", nullable = true)
	@Enumerated(EnumType.STRING)
	private EnumStatus status;

	public BaseModel() {
		super();
	}

	public BaseModel(Integer id, Date createDate, Date updateDate, EnumStatus status) {
		super();
		this.id = id;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.status = status;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public EnumStatus getStatus() {
		return status;
	}

	public void setStatus(EnumStatus status) {
		this.status = status;
	}	
}
