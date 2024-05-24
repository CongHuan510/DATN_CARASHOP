package carashop.controller.frontend;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import carashop.controller.BaseController;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.News;
import carashop.service.NewsService;

@Controller
public class ListNewsController extends BaseController implements Jw27Constants {
	
	@Autowired
	private NewsService newsService;
//	@RequestMapping(value = "/news", method = RequestMethod.GET)
//	public String news(final Model model, final HttpServletRequest request, final HttpServletResponse response)
//			throws IOException {
//		
//		List<News> news = newsService.findAllActive();
//		model.addAttribute("news", news);
//		
//		return "frontend/news";
//	}
	
	@RequestMapping(value = "/news", method = RequestMethod.GET)
	public String news(final Model model, HttpServletRequest request) {
		SearchModel newsSearch = new SearchModel();
		
		// Bat dau phan trang
		if (!StringUtils.isEmpty(request.getParameter("currentPage"))) { // Bam nut chuyen trang
			newsSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		} else {
			newsSearch.setCurrentPage(1); // lan dau truy cap luon hien thi trang 1
		}
		List<News> allNews = newsService.findAllActive();// Tim kiem
		List<News> news = new ArrayList<News>(); // DS sp can hien thi trang hien tai
		// Tong so trang theo tim kiem
		int totalPages = allNews.size() / SIZE_OF_NEWS;
		if (allNews.size() % SIZE_OF_NEWS > 0) {
			totalPages++;
		}
		// Neu tong so trang < trang hien tai (lai bam tim kiem)
		if (totalPages < newsSearch.getCurrentPage()) {
			newsSearch.setCurrentPage(1);
		}
		// Lay danh sach sp can hien thi trong 1 trang
		int firstIndex = (newsSearch.getCurrentPage() - 1) * SIZE_OF_NEWS; // vị trị dau 1 trang
		int index = firstIndex, count = 0;
		while (index < allNews.size() && count < SIZE_OF_NEWS) {
			news.add(allNews.get(index));
			index++;
			count++;
		}
		// Phan trang
		newsSearch.setSizeOfPage(SIZE_OF_NEWS); // So ban ghi tren 1 trang
		newsSearch.setTotalItems(allNews.size()); // Tong so san pham theo tim kiem

		model.addAttribute("news", news);
		model.addAttribute("newsSearch", newsSearch);
		return "frontend/news";
	}
		
	@RequestMapping(value = "/news-detail/{newsId}", method = RequestMethod.GET)
	public String productDetail(Model model, HttpServletRequest request, HttpServletResponse response,
			@PathVariable("newsId") int newsId) throws IOException {

		// Retrieve product details
		News news = newsService.getById(newsId);
		model.addAttribute("news", news);
		
		List<News> top3News = newsService.findTop3News();
		model.addAttribute("top3News", top3News);
		
		List<News> relatedNews = newsService.findAllOtherNews(newsId);
		model.addAttribute("relatedNews", relatedNews);
		
		return "frontend/news-detail";
	}
}
