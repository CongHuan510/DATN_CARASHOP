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
import carashop.model.Category;
import carashop.model.User;
import carashop.service.CategoryService;
import carashop.service.UserService;

@Controller
@RequestMapping("/admin/category/")
public class CategoryController extends BaseController implements Jw27Constants {
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	public UserService userService;
	
	// -------------------------LIST CATEGORY ------------------------------
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(final Model model, HttpServletRequest request) {
		SearchModel categorySearch = new SearchModel();
		// Tim theo status
		categorySearch.setStatus("ALL"); // input: ALL
		String status = request.getParameter("status"); // lấy value từ view
		if (!StringUtils.isEmpty(status)) { // Neu co chon status
			categorySearch.setStatus(status);
		}
		// Tim theo key
		categorySearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if (!StringUtils.isEmpty(keyword)) {
			categorySearch.setKeyword(keyword);
		}
		// Kiem tra tieu chi tim kiem theo (createDate) tu ngay ... den ngay ...
		String beginDate = null;
		String endDate = null;
		if (!StringUtils.isEmpty(request.getParameter("beginDate"))
				&& !StringUtils.isEmpty(request.getParameter("endDate"))) {
			beginDate = request.getParameter("beginDate");
			endDate = request.getParameter("endDate");
		}
		categorySearch.setBeginDate(beginDate);
		categorySearch.setEndDate(endDate);
		// Bat dau phan trang
		if (!StringUtils.isEmpty(request.getParameter("currentPage"))) { // Bam nut chuyen trang
			categorySearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		} else {
			categorySearch.setCurrentPage(1); // lan dau truy cap luon hien thi trang 1
		}
		List<Category> allCategories = categoryService.searchCategory(categorySearch);// Tim kiem
		List<Category> categories = new ArrayList<Category>(); // DS sp can hien thi trang hien tai
		// Tong so trang theo tim kiem
		int totalPages = allCategories.size() / SIZE_OF_PAGE;
		if (allCategories.size() % SIZE_OF_PAGE > 0) {
			totalPages++;
		}
		// Neu tong so trang < trang hien tai (lai bam tim kiem)
		if (totalPages < categorySearch.getCurrentPage()) {
			categorySearch.setCurrentPage(1);
		}
		// Lay danh sach sp can hien thi trong 1 trang
		int firstIndex = (categorySearch.getCurrentPage() - 1) * SIZE_OF_PAGE; // vị trị dau 1 trang
		int index = firstIndex, count = 0;
		while (index < allCategories.size() && count < SIZE_OF_PAGE) {
			categories.add(allCategories.get(index));
			index++;
			count++;
		}
		// Phan trang
		categorySearch.setSizeOfPage(SIZE_OF_PAGE); // So ban ghi tren 1 trang
		categorySearch.setTotalItems(allCategories.size()); // Tong so san pham theo tim kiem

		model.addAttribute("categories", categories);
		model.addAttribute("categorySearch", categorySearch);
		return "backend/category-list";
	}
	// ADD CATEGORY
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String add(final Model model) {
		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		Category category = new Category();
		category.setCreateDate(new Date());
		
		model.addAttribute("category", category);
		return "backend/category-add";
	}
	// ADD-SAVE CATEGORY
	@RequestMapping(value = "add-save", method = RequestMethod.POST)
	public String addSave(final Model model, @ModelAttribute("category") Category category) {
		categoryService.saveOrUpdate(category);
		return "redirect:/admin/category/add";
	}
	// DETAIL CATEGORY
	@RequestMapping(value = "detail/{categoryId}", method = RequestMethod.GET)
	public String detail(final Model model, @PathVariable("categoryId") int categoryId) {
		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		// Lấy category trong DB bằng Id
		Category category = categoryService.getById(categoryId);
		model.addAttribute("category", category);
		return "backend/category-detail";

	}

	// // EDIT CATEGORY
	@RequestMapping(value = "edit/{categoryId}", method = RequestMethod.GET)
	public String edit(final Model model, @PathVariable("categoryId") int categoryId) {
		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		// Lấy category trong DB bằng Id
		Category category = categoryService.getById(categoryId);
		model.addAttribute("category", category);
		return "backend/category-edit";
	}

	// EDIT-SAVE CATEGORY
	@RequestMapping(value = "edit-save", method = RequestMethod.POST)
	public String editSave(final Model model, @ModelAttribute("category") Category category) {
		categoryService.saveOrUpdate(category);
		return "redirect:/admin/category/list";
	}

	// DELETE CATEGORY
//	@RequestMapping(value = "delete/{categoryId}", method = RequestMethod.GET)
//	public String delete(final Model model,
//		@PathVariable("categoryId") int categoryId) {	
//		categoryService.deleteCategoryById(categoryId);
//			return "redirect:/admin/category/list";
//	}

	// TH: inactive
	@RequestMapping(value = "delete/{categoryId}", method = RequestMethod.GET)
	public String delete(final Model model, @PathVariable("categoryId") int categoryId) {
		// Lấy category trong DB bằng Id
		Category category = categoryService.getById(categoryId);
		category.setStatus(EnumStatus.INACTIVE);
		
		categoryService.inactiveCategory(category);
		return "redirect:/admin/category/list";
	}
}
