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
@Table(name = "tbl_news")
public class News extends BaseModel {

	@Column(name = "title", length = 300, nullable = true)
	private String title;

	@Column(name = "avatar", length = 300, nullable = true)
	private String avatar;

	@Column(name = "summary", length = 300, nullable = true)
	private String summary;

	@Column(name = "content", nullable = true)
	private String content;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "create_by")
	private User userCreateNews;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "update_by")
	private User userUpdateNews;

	public News() {
		super();
	}

	public News(Integer id, Date createDate, Date updateDate, EnumStatus status, String title, String avatar,
			String summary, String content, User userCreateNews, User userUpdateNews) {
		super(id, createDate, updateDate, status);
		this.title = title;
		this.avatar = avatar;
		this.summary = summary;
		this.content = content;
		this.userCreateNews = userCreateNews;
		this.userUpdateNews = userUpdateNews;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public User getUserCreateNews() {
		return userCreateNews;
	}

	public void setUserCreateNews(User userCreateNews) {
		this.userCreateNews = userCreateNews;
	}

	public User getUserUpdateNews() {
		return userUpdateNews;
	}

	public void setUserUpdateNews(User userUpdateNews) {
		this.userUpdateNews = userUpdateNews;
	}

	
}
