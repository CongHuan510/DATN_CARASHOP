package carashop.controller.backend;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import carashop.controller.BaseController;
import carashop.dto.EnumStatus;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.News;
import carashop.model.User;
import carashop.service.NewsService;
import carashop.service.UserService;

@Controller
@RequestMapping("/admin/news/")
public class NewsController extends BaseController implements Jw27Constants {

	@Autowired
	private NewsService newsService;

	@Autowired
	private UserService userService;

	// -------------------------LIST NEWS ------------------------------
//	@RequestMapping(value = "list", method = RequestMethod.GET)
//	public String list(final Model model) {
//		List<News> news = newsService.findAll();
//		// List<Product> products = productService.findAllActive();
//		model.addAttribute("news", news);
//		return "backend/news-list";
//	}

	// -------------------------LIST CATEGORY ------------------------------
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(final Model model, HttpServletRequest request) {
		SearchModel newsSearch = new SearchModel();
		// Tim theo status
		newsSearch.setStatus("ALL"); // input: ALL
		String status = request.getParameter("status"); // lấy value từ view
		if (!StringUtils.isEmpty(status)) { // Neu co chon status
			newsSearch.setStatus(status);
		}
		// Tim theo key
		newsSearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if (!StringUtils.isEmpty(keyword)) {
			newsSearch.setKeyword(keyword);
		}
		// Kiem tra tieu chi tim kiem theo (createDate) tu ngay ... den ngay ...
		String beginDate = null;
		String endDate = null;
		if (!StringUtils.isEmpty(request.getParameter("beginDate"))
				&& !StringUtils.isEmpty(request.getParameter("endDate"))) {
			beginDate = request.getParameter("beginDate");
			endDate = request.getParameter("endDate");
		}
		newsSearch.setBeginDate(beginDate);
		newsSearch.setEndDate(endDate);
		// Bat dau phan trang
		if (!StringUtils.isEmpty(request.getParameter("currentPage"))) { // Bam nut chuyen trang
			newsSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		} else {
			newsSearch.setCurrentPage(1); // lan dau truy cap luon hien thi trang 1
		}
		List<News> allNews = newsService.searchNews(newsSearch);// Tim kiem
		List<News> news = new ArrayList<News>(); // DS sp can hien thi trang hien tai
		// Tong so trang theo tim kiem
		int totalPages = allNews.size() / SIZE_OF_PAGE;
		if (allNews.size() % SIZE_OF_PAGE > 0) {
			totalPages++;
		}
		// Neu tong so trang < trang hien tai (lai bam tim kiem)
		if (totalPages < newsSearch.getCurrentPage()) {
			newsSearch.setCurrentPage(1);
		}
		// Lay danh sach sp can hien thi trong 1 trang
		int firstIndex = (newsSearch.getCurrentPage() - 1) * SIZE_OF_PAGE; // vị trị dau 1 trang
		int index = firstIndex, count = 0;
		while (index < allNews.size() && count < SIZE_OF_PAGE) {
			news.add(allNews.get(index));
			index++;
			count++;
		}
		// Phan trang
		newsSearch.setSizeOfPage(SIZE_OF_PAGE); // So ban ghi tren 1 trang
		newsSearch.setTotalItems(allNews.size()); // Tong so san pham theo tim kiem

		model.addAttribute("news", news);
		model.addAttribute("newsSearch", newsSearch);
		return "backend/news-list";
	}

	// ADD NEWS
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String add(final Model model) {

		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		News news = new News();
		news.setCreateDate(new Date());

		model.addAttribute("news", news);
		return "backend/news-add";
	}

	// ADD-SAVE NEWS
	@RequestMapping(value = "add-save", method = RequestMethod.POST)
	public String newsAddSave(final Model model, @ModelAttribute("news") News news,
			@RequestParam("avatarFile") MultipartFile avatarFile,
			@RequestParam("imageFiles") MultipartFile[] imageFiles) throws IOException {

		newsService.saveAddNews(news, avatarFile);
		return "redirect:/admin/news/add";
	}

	// DETAIL NEWS
	@RequestMapping(value = "detail/{newsId}", method = RequestMethod.GET)
	public String detail(final Model model, @PathVariable("newsId") int newsId) {

		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		// Lấy news trong DB bằng Id
		News news = newsService.getById(newsId);
		model.addAttribute("news", news);
		return "backend/news-detail";
	}

	// EDIT NEWS
	@RequestMapping(value = "edit/{newsId}", method = RequestMethod.GET)
	public String edit(final Model model, @PathVariable("newsId") int newsId) {

		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		// Lấy product trong DB bằng Id
		News news = newsService.getById(newsId);
		news.setUpdateDate(new Date());
		model.addAttribute("news", news);
		return "backend/news-edit";
	}

	// SAVE EDIT NEWS
	@RequestMapping(value = "edit-save", method = RequestMethod.POST)
	public String editSave(final Model model, @ModelAttribute("news") News news,
			@RequestParam("avatarFile") MultipartFile avatarFile) throws IOException {

		newsService.saveEditNews(news, avatarFile);
		return "redirect:/admin/news/list";
	}

	// INACTIVE NEWS
	@RequestMapping(value = "delete/{newsId}", method = RequestMethod.GET)
	public String delete(final Model model, @PathVariable("newsId") int newsId) {
		// Lấy category trong DB bằng Id
		News news = newsService.getById(newsId);
		news.setStatus(EnumStatus.INACTIVE);
		newsService.inactiveNews(news);
		// productService.saveOrUpdate(product);
		return "redirect:/admin/news/list";
	}
}
