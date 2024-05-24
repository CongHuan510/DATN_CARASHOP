package carashop.service;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.User;

@Service
public class UserService extends BaseService<User> implements Jw27Constants {

	@Override
	public Class<User> clazz() {
		return User.class;
	}

	public List<User> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_user WHERE status = 'ACTIVE'");
	}

	public List<User> findAllGuestUsers() {
		String sql = "SELECT u.* FROM tbl_user u " + "JOIN tbl_user_role ur ON u.id = ur.user_id "
				+ "JOIN tbl_role r ON ur.role_id = r.id " + "WHERE u.status = 'ACTIVE' AND r.name = 'GUEST'";
		return super.executeNativeSql(sql);
	}

	public User getUserById(int userId) {
		return super.getById(userId);
	}

	// Phương thức kiểm tra (1) file có được upload hay không?
	public boolean isUploadFile(MultipartFile file) {
		// file null hoặc tên file rỗng
		if (file == null || file.getOriginalFilename().isEmpty()) {
			return false; // Không upload
		}
		return true; // Có upload
	}

	// --------------------------Save new user to
	// database--------------------------------
	@Transactional
	public User saveAddUser(User user, MultipartFile avatarFile) throws IOException {
		// Lưu avatar vào file
		if (isUploadFile(avatarFile)) {
			// Lưu file vào thư mục User/Avatar
			String path = FOLDER_UPLOAD + "User/Avatar/" + avatarFile.getOriginalFilename();
			File file = new File(path);
			avatarFile.transferTo(file);
			// Lưu đường dẫn vào bảng tbl_user
			user.setAvatar("User/Avatar/" + avatarFile.getOriginalFilename());
		}
		return super.saveOrUpdate(user);
	}

	// EDIT SAVE USER
	@Transactional
	public User saveEditUser(User user, MultipartFile avatarFile) throws IOException {
		// Lay produc trong db
		User dbUser = super.getById(user.getId());
		// Luu avatar file moi neu nguoi dung co upload avatar
		if (isUploadFile(avatarFile)) { // Co upload file avatar

			// Xoa avatar cu (Xoa file avatar)
			String path = FOLDER_UPLOAD + dbUser.getAvatar();
			File file = new File(path);
			file.delete();

			// Lưu file avatar mới vào thư mực User/Avatar
			path = FOLDER_UPLOAD + "User/Avatar/" + avatarFile.getOriginalFilename();
			file = new File(path);
			avatarFile.transferTo(file);
			// Lưu đường dẫn của avatar mới vào bảng tbl_user
			user.setAvatar("User/Avatar/" + avatarFile.getOriginalFilename());
		} else { // Người dùng không upload avatar file
			// giữ nguyên avatar cũ
			user.setAvatar(dbUser.getAvatar());
		}
		return super.saveOrUpdate(user);
	}

	// Giữ nguyên mật khẩu của người dùng trong cơ sở dữ liệu
//    user.setPassword(dbUser.getPassword());
//    user.setUsername(dbUser.getUsername());
//    user.setCreateDate(dbUser.getCreateDate());
//    user.setUpdateDate(dbUser.getUpdateDate());
//    user.setDescription(dbUser.getDescription());
//    user.setUserCreateUser(dbUser.getUserCreateUser());
//    user.setUserUpdateUser(dbUser.getUserUpdateUser());
	@Transactional
	public User saveProfile(User user, MultipartFile avatarFile) throws IOException {
		// Lay produc trong db
		User dbUser = super.getById(user.getId());
		user.setPassword(dbUser.getPassword());
		user.setUsername(dbUser.getUsername());
		user.setDescription(dbUser.getDescription());
		// Lấy giá trị ban đầu của các trường create_date và update_date
		Date createDate = dbUser.getCreateDate();
		Date updateDate = dbUser.getUpdateDate();
		// Thiết lập lại các trường create_date và update_date với giá trị ban đầu
		user.setCreateDate(createDate);
		user.setUpdateDate(updateDate);

		user.setUserCreateUser(dbUser.getUserCreateUser());
		user.setUserUpdateUser(dbUser.getUserUpdateUser());
		// Luu avatar file moi neu nguoi dung co upload avatar
		if (isUploadFile(avatarFile)) { // Co upload file avatar

			// Xoa avatar cu (Xoa file avatar)
			String path = FOLDER_UPLOAD + dbUser.getAvatar();
			File file = new File(path);
			file.delete();

			// Lưu file avatar mới vào thư mực User/Avatar
			path = FOLDER_UPLOAD + "User/Avatar/" + avatarFile.getOriginalFilename();
			file = new File(path);
			avatarFile.transferTo(file);
			// Lưu đường dẫn của avatar mới vào bảng tbl_user
			user.setAvatar("User/Avatar/" + avatarFile.getOriginalFilename());
			return super.saveOrUpdate(user);
		} else { // Người dùng không upload avatar file
			// giữ nguyên avatar cũ
			user.setAvatar(dbUser.getAvatar());

			return super.saveOrUpdate(user);
		}
	}

	// Delete USER
	@Transactional
	public void deleteUser(User user) {
		// Xoa file avatar trong thu muc Product/Avatar
		String path = FOLDER_UPLOAD + user.getAvatar();
		File file = new File(path);
		file.delete();
		super.delete(user);
	}

	@Transactional
	public void inactiveUser(User user) {
		super.saveOrUpdate(user);
	}

	// -----------------------------searchUser----------------------------
	public List<User> searchUser(SearchModel userSearch) {
		// Tao cau lenh sql;
		String sql = "SELECT * FROM tbl_user u WHERE 1=1";

		// Tim kiem voi status
		if (!"ALL".equals(userSearch.getStatus())) { // Có chọn Active/Inactive
			String status = userSearch.getStatus();
			sql += " AND u.status = '" + status + "'";
		}

		// Tim kiem voi keyword
		if (!StringUtils.isEmpty(userSearch.getKeyword())) {
			String keyword = userSearch.getKeyword().toLowerCase();

			sql += " AND (LOWER(u.username) like '%" + keyword + "%'" + " OR LOWER(u.name) like '%" + keyword + "%'"
					+ " OR LOWER(u.email) like '%" + keyword + "%'" + " OR LOWER(u.address) like '%" + keyword + "%'"
					+ " OR LOWER(u.description) like '%" + keyword + "%')";
		}

		// Tim kiem voi ngay thang
		if (!StringUtils.isEmpty(userSearch.getBeginDate()) && !StringUtils.isEmpty(userSearch.getEndDate())) {
			String beginDate = userSearch.getBeginDate();
			String endDate = userSearch.getEndDate();

			sql += " AND u.create_date BETWEEN '" + beginDate + "' AND '" + endDate + "'";
		}
		sql += " ORDER BY u.create_date DESC";
		return super.executeNativeSql(sql);
	}
}
