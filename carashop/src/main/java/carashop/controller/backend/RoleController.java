package carashop.controller.backend;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import carashop.controller.BaseController;
import carashop.dto.EnumStatus;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.Role;
import carashop.model.User;
import carashop.service.RoleService;
import carashop.service.UserService;

@Controller
@RequestMapping("/admin/role/")
public class RoleController extends BaseController implements Jw27Constants {
	@Autowired
	private RoleService roleService;

	@Autowired
	private UserService userService;

	// -------------------------LIST CATEGORY ------------------------------
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(final Model model, HttpServletRequest request) {

		SearchModel roleSearch = new SearchModel();
		// Tim theo status
		roleSearch.setStatus("ALL"); // input: ALL
		String status = request.getParameter("status"); // lấy value từ view
		if (!StringUtils.isEmpty(status)) { // Neu co chon status
			roleSearch.setStatus(status);
		}
		// Tim theo key
		roleSearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if (!StringUtils.isEmpty(keyword)) {
			roleSearch.setKeyword(keyword);
		}
		// Kiem tra tieu chi tim kiem theo (createDate) tu ngay ... den ngay ...
		String beginDate = null;
		String endDate = null;
		if (!StringUtils.isEmpty(request.getParameter("beginDate"))
				&& !StringUtils.isEmpty(request.getParameter("endDate"))) {
			beginDate = request.getParameter("beginDate");
			endDate = request.getParameter("endDate");
		}
		roleSearch.setBeginDate(beginDate);
		roleSearch.setEndDate(endDate);
		// Bat dau phan trang
		if (!StringUtils.isEmpty(request.getParameter("currentPage"))) { // Bam nut chuyen trang
			roleSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		} else {
			roleSearch.setCurrentPage(1); // lan dau truy cap luon hien thi trang 1
		}
		List<Role> allRoles = roleService.searchRole(roleSearch);// Tim kiem
		List<Role> roles = new ArrayList<Role>(); // DS sp can hien thi trang hien tai
		// Tong so trang theo tim kiem
		int totalPages = allRoles.size() / SIZE_OF_PAGE;
		if (allRoles.size() % SIZE_OF_PAGE > 0) {
			totalPages++;
		}
		// Neu tong so trang < trang hien tai (lai bam tim kiem)
		if (totalPages < roleSearch.getCurrentPage()) {
			roleSearch.setCurrentPage(1);
		}
		// Lay danh sach sp can hien thi trong 1 trang
		int firstIndex = (roleSearch.getCurrentPage() - 1) * SIZE_OF_PAGE; // vị trị dau 1 trang
		int index = firstIndex, count = 0;
		while (index < allRoles.size() && count < SIZE_OF_PAGE) {
			roles.add(allRoles.get(index));
			index++;
			count++;
		}
		// Phan trang
		roleSearch.setSizeOfPage(SIZE_OF_PAGE); // So ban ghi tren 1 trang
		roleSearch.setTotalItems(allRoles.size()); // Tong so san pham theo tim kiem

		model.addAttribute("roles", roles);
		model.addAttribute("roleSearch", roleSearch);
		return "backend/role-list";
	}

	// ADD ROLE
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String add(final Model model) {

		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		Role role = new Role();
		role.setCreateDate(new Date());

		model.addAttribute("role", role);
		return "backend/role-add";
	}

	// ADD-SAVE ROLE
	@RequestMapping(value = "add-save", method = RequestMethod.POST)
	public String addSave(final Model model, @ModelAttribute("role") Role role) {

		roleService.saveOrUpdate(role);
		return "redirect:/admin/role/add";
	}

	// DETAIL CATEGORY
	@RequestMapping(value = "detail/{roleId}", method = RequestMethod.GET)
	public String detail(final Model model, @PathVariable("roleId") int roleId) {

		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		// Lấy Role trong DB bằng Id
		Role role = roleService.getById(roleId);
		model.addAttribute("role", role);
		
		return "backend/role-detail";
	}
	// EDIT ROLE
	@RequestMapping(value = "edit/{roleId}", method = RequestMethod.GET)
	public String edit(final Model model, @PathVariable("roleId") int roleId) {

		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		// Lấy Role trong DB bằng Id
		Role role = roleService.getById(roleId);
		model.addAttribute("role", role);
		
		return "backend/role-edit";
	}

	// SAVE EDIT ROLE
	@RequestMapping(value = "edit-save", method = RequestMethod.POST)
	// Cách đẩy 1 dữ liệu sang view
	public String editSave(final Model model, @ModelAttribute("role") Role role) {

		roleService.saveOrUpdate(role);
		return "redirect:/admin/role/list";
	}

	// DELETE Role
//	@RequestMapping(value = "delete/{roleId}", method = RequestMethod.GET)
//	//Cách đẩy 1 dữ liệu sang view
//	public String delete(final Model model,
//			@PathVariable("roleId") int roleId) {
//		
//		roleService.deleteroleById(roleId);
//		return "redirect:/admin/role/list";
//	}

	// TH: inactive
	@RequestMapping(value = "delete/{roleId}", method = RequestMethod.GET)
	public String delete(final Model model, @PathVariable("roleId") int roleId) {
		// Lấy Role trong DB bằng Id
		Role role = roleService.getById(roleId);
		role.setStatus(EnumStatus.INACTIVE);
		roleService.inactiveRole(role);

		return "redirect:/admin/role/list";
	}
}
