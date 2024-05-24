package carashop.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.News;


@Service
public class NewsService extends BaseService<News> implements Jw27Constants  {
	@Override
	public Class<News> clazz(){
		return News.class;
	}
	
	public List<News> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_news WHERE status = 'ACTIVE'");
	}
	
	public List<News> findAllOtherNews(int newsId) {
		return super.executeNativeSql("SELECT * FROM tbl_news WHERE status = 'ACTIVE' AND id != " + newsId);
	}
	
	public List<News> findTop3News() {
		String sql = "SELECT * FROM tbl_news "
				+ "WHERE status = 'ACTIVE' "
				+ "ORDER BY create_date DESC "
				+ "LIMIT 3";
		return super.executeNativeSql(sql);
	}

	public News getUserById(int newsId) {
		return super.getById(newsId);
	}
	
	// Hiển thị 3 bài viết mới nhất theo thời gian

	// Phương thức kiểm tra (1) file có được upload hay không?
	public boolean isUploadFile(MultipartFile file) {
		// file null hoặc tên file rỗng
		if (file == null || file.getOriginalFilename().isEmpty()) {
			return false; // Không upload
		}
		return true; // Có upload
	}

	// --------------------------Save new news to
	// database--------------------------------
	@Transactional
	public News saveAddNews(News news, MultipartFile avatarFile) throws IOException {
		// Lưu avatar vào file
		if (isUploadFile(avatarFile)) {
			// Lưu file vào thư mục User/Avatar
			String path = FOLDER_UPLOAD + "News/Avatar/" + avatarFile.getOriginalFilename();
			File file = new File(path);
			avatarFile.transferTo(file);
			// Lưu đường dẫn vào bảng tbl_user
			news.setAvatar("News/Avatar/" + avatarFile.getOriginalFilename());
		}
		return super.saveOrUpdate(news);
	}

	// Save edit news
	@Transactional
	public News saveEditNews(News news, MultipartFile avatarFile) throws IOException {
		// Lay produc trong db
		News dbNews = super.getById(news.getId());
		// Luu avatar file moi neu nguoi dung co upload avatar
		if (isUploadFile(avatarFile)) { // Co upload file avatar

			// Xoa avatar cu (Xoa file avatar)
			String path = FOLDER_UPLOAD + dbNews.getAvatar();
			File file = new File(path);
			file.delete();

			// Lưu file avatar mới vào thư mực User/Avatar
			path = FOLDER_UPLOAD + "News/Avatar/" + avatarFile.getOriginalFilename();
			file = new File(path);
			avatarFile.transferTo(file);
			// Lưu đường dẫn của avatar mới vào bảng tbl_user
			news.setAvatar("News/Avatar/" + avatarFile.getOriginalFilename());
		} else { // Người dùng không upload avatar file
			// giữ nguyên avatar cũ
			news.setAvatar(dbNews.getAvatar());
		}
		return super.saveOrUpdate(news);
	}

	
	// Delete News
	@Transactional
	public void deleteNews(News news) {
		// Xoa file avatar trong thu muc News/Avatar
		String path = FOLDER_UPLOAD + news.getAvatar();
		File file = new File(path);
		file.delete();
		super.delete(news);
	}
	
	@Transactional
	public void deleteNewsById(int id) {
		super.deleteById(id);
	}

	@Transactional
	public void inactiveNews(News news) {
		super.saveOrUpdate(news);
	}

	// -----------------------------searchCategory----------------------------
	public List<News> searchNews(SearchModel newsSearch) {
		// Tao cau lenh sql;
		String sql = "SELECT * FROM tbl_news n WHERE 1=1";

		// Tim kiem voi status
		if (!"ALL".equals(newsSearch.getStatus())) { // Có chọn Active/Inactive
			String status = newsSearch.getStatus();
			sql += " AND n.status = '" + status + "'";
		}

		// Tim kiem voi keyword
		if (!StringUtils.isEmpty(newsSearch.getKeyword())) {
			String keyword = newsSearch.getKeyword().toLowerCase();

			sql += " AND (LOWER(n.title) like '%" + keyword + "%'" + " OR LOWER(n.summary) like '%" + keyword + "%'"
					+ " OR LOWER(n.content) like '%" + keyword + "%')";
		}

		// Tim kiem voi ngay thang
		if (!StringUtils.isEmpty(newsSearch.getBeginDate()) && !StringUtils.isEmpty(newsSearch.getEndDate())) {
			String beginDate = newsSearch.getBeginDate();
			String endDate = newsSearch.getEndDate();

			sql += " AND n.create_date BETWEEN '" + beginDate + "' AND '" + endDate + "'";
		}
		
		sql += " ORDER BY n.create_date DESC";
		return super.executeNativeSql(sql);
	}
}
