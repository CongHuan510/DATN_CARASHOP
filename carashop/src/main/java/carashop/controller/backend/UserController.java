package carashop.controller.backend;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import carashop.controller.BaseController;
import carashop.dto.EnumStatus;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.Role;
import carashop.model.User;
import carashop.service.RoleService;
import carashop.service.UserService;

@Controller
@RequestMapping("/admin/user/")
public class UserController extends BaseController implements Jw27Constants {
	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;
	
	// -------------------------LIST USER ------------------------------
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(final Model model, HttpServletRequest request) {

		SearchModel userSearch = new SearchModel();
		// Tim theo status
		userSearch.setStatus("ALL"); // input: ALL
		String status = request.getParameter("status"); // lấy value từ view
		if (!StringUtils.isEmpty(status)) { // Neu co chon status
			userSearch.setStatus(status);
		}
		// Tim theo key
		userSearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if (!StringUtils.isEmpty(keyword)) {
			userSearch.setKeyword(keyword);
		}
		// Kiem tra tieu chi tim kiem theo (createDate) tu ngay ... den ngay ...
		String beginDate = null;
		String endDate = null;
		if (!StringUtils.isEmpty(request.getParameter("beginDate"))
				&& !StringUtils.isEmpty(request.getParameter("endDate"))) {
			beginDate = request.getParameter("beginDate");
			endDate = request.getParameter("endDate");
		}
		userSearch.setBeginDate(beginDate);
		userSearch.setEndDate(endDate);

		// Bat dau phan trang
		if (!StringUtils.isEmpty(request.getParameter("currentPage"))) { // Bam nut chuyen trang
			userSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		} else {
			userSearch.setCurrentPage(1); // lan dau truy cap luon hien thi trang 1
		}
		List<User> allUsers = userService.searchUser(userSearch);// Tim kiem
		List<User> users = new ArrayList<User>(); // DS sp can hien thi trang hien tai
		// Tong so trang theo tim kiem
		int totalPages = allUsers.size() / SIZE_OF_PAGE;
		if (allUsers.size() % SIZE_OF_PAGE > 0) {
			totalPages++;
		}
		// Neu tong so trang < trang hien tai (lai bam tim kiem)
		if (totalPages < userSearch.getCurrentPage()) {
			userSearch.setCurrentPage(1);
		}
		// Lay danh sach sp can hien thi trong 1 trang
		int firstIndex = (userSearch.getCurrentPage() - 1) * SIZE_OF_PAGE; // vị trị dau 1 trang
		int index = firstIndex, count = 0;
		while (index < allUsers.size() && count < SIZE_OF_PAGE) {
			users.add(allUsers.get(index));
			index++;
			count++;
		}
		// Phan trang
		userSearch.setSizeOfPage(SIZE_OF_PAGE); // So ban ghi tren 1 trang
		userSearch.setTotalItems(allUsers.size()); // Tong so san pham theo tim kiem

		model.addAttribute("users", users);
		model.addAttribute("userSearch", userSearch);
		return "backend/user-list";
	}
	// ADD USER
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String add(final Model model) {

		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		List<Role> roles = roleService.findAll();
		model.addAttribute("roles", roles);

		User user = new User();
		user.setCreateDate(new Date());

		model.addAttribute("user", user);
		return "backend/user-add";
	}
	// ADD-SAVE USER
	@RequestMapping(value = "add-save", method = RequestMethod.POST)
	public String userAddSave(final Model model, HttpServletRequest request, @ModelAttribute("user") User user,
			@RequestParam("avatarFile") MultipartFile avatarFile) throws IOException {

		// Lấy ra role.id
		int roleId = Integer.parseInt(request.getParameter("roleId"));
		Role role = roleService.getRoleById(roleId);
		// Thêm quyền cho người dùng dựa trên đối tượng Role đã lấy được
		user.addRelationalUserRole(role);
		user.setPassword(new BCryptPasswordEncoder(4).encode(user.getPassword()));
		userService.saveAddUser(user, avatarFile);
		return "redirect:/admin/user/add";
	}
	// DETAIL USER
	@RequestMapping(value = "detail/{userId}", method = RequestMethod.GET)
	public String detail(final Model model, @PathVariable("userId") int userId) {

		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		// Lấy user trong DB bằng Id
		User user = userService.getById(userId);
		model.addAttribute("user", user);

		return "backend/user-detail";

	}
	// EDIT USER
	@RequestMapping(value = "edit/{userId}", method = RequestMethod.GET)
	public String edit(final Model model, @PathVariable("userId") int userId) {

		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		// Lấy category trong DB bằng Id
		User user = userService.getById(userId);
		user.setUpdateDate(new Date());
		model.addAttribute("user", user);
		return "backend/user-edit";
	}

	// SAVE EDIT CATEGORY
	@RequestMapping(value = "edit-save", method = RequestMethod.POST)
	public String editSave(final Model model, @ModelAttribute("user") User user,
			@RequestParam("avatarFile") MultipartFile avatarFile) throws IOException {

		userService.saveEditUser(user, avatarFile);
		return "redirect:/admin/user/list";
	}

	// DELETE CATEGORY
//			@RequestMapping(value = "delete/{userId}", method = RequestMethod.GET)
//			//Cách đẩy 1 dữ liệu sang view
//			public String delete(final Model model,
//					@PathVariable("userId") int userId) {
//				
//				User user = userService.getById(userId);
//				userService.deleteUser(user);
//				return "redirect:/admin/user/list";
//			}

	// TH: inactive
	@RequestMapping(value = "delete/{userId}", method = RequestMethod.GET)
	public String delete(final Model model, @PathVariable("userId") int userId) {
		// Lấy category trong DB bằng Id
		User user = userService.getById(userId);
		user.setStatus(EnumStatus.INACTIVE);
		userService.inactiveUser(user);

		return "redirect:/admin/user/list";
	}
}
