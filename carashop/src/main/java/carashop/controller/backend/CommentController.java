package carashop.controller.backend;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import carashop.controller.BaseController;
import carashop.dto.EnumStatus;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.ProductComment;
import carashop.service.ProductCommentService;

@Controller
@RequestMapping("/admin/comment/")
public class CommentController extends BaseController implements Jw27Constants {

	@Autowired
	private ProductCommentService productCommentService;

	// -------------------------LIST COMMENT ------------------------------
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(final Model model, final HttpServletRequest request) {

		SearchModel commentSearch = new SearchModel();
		// Tìm theo status
		commentSearch.setStatus("ALL");
		String status = request.getParameter("status");
		if (!StringUtils.isEmpty(status)) {
			commentSearch.setStatus(status);
		}
		// Tìm theo key
		commentSearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if (!StringUtils.isEmpty(keyword)) {
			commentSearch.setKeyword(keyword);
		}
		// Tìm theo từ khoảng [] ngày
		String beginDate = null;
		String endDate = null;
		if (!StringUtils.isEmpty(request.getParameter("beginDate"))
				&& !StringUtils.isEmpty(request.getParameter("endDate"))) {
			beginDate = request.getParameter("beginDate");
			endDate = request.getParameter("endDate");
		}
		commentSearch.setBeginDate(beginDate);
		commentSearch.setEndDate(endDate);
		// Bat dau phan trang
		if (!StringUtils.isEmpty(request.getParameter("currentPage"))) { // Bam nut chuyen trang
			commentSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		} else {
			commentSearch.setCurrentPage(1); // lan dau truy cap luon hien thi trang 1
		}
		List<ProductComment> allComments = productCommentService.searchComment(commentSearch);// Tim																								// kiem
		List<ProductComment> comments = new ArrayList<ProductComment>(); // DS sp can hien thi trang hien tai
		// Tong so trang theo tim kiem
		int totalPages = allComments.size() / SIZE_OF_PAGE;
		if (allComments.size() % SIZE_OF_PAGE > 0) {
			totalPages++;
		}
		// Neu tong so trang < trang hien tai (lai bam tim kiem)
		if (totalPages < commentSearch.getCurrentPage()) {
			commentSearch.setCurrentPage(1);
		}
		// Lay danh sach sp can hien thi trong 1 trang
		int firstIndex = (commentSearch.getCurrentPage() - 1) * SIZE_OF_PAGE; // vị trị dau 1 trang
		int index = firstIndex, count = 0;
		while (index < allComments.size() && count < SIZE_OF_PAGE) {
			comments.add(allComments.get(index));
			index++;
			count++;
		}
		// Phan trang
		commentSearch.setSizeOfPage(SIZE_OF_PAGE); // So ban ghi tren 1 trang
		commentSearch.setTotalItems(allComments.size()); // Tong so san pham theo tim kiem
		model.addAttribute("commentSearch", commentSearch);
		model.addAttribute("comments", comments);
		return "backend/comment-list";
	}

	// DELETE COMMENT
	@RequestMapping(value = "/delete/{commentId}", method = RequestMethod.GET)
	// Cách đẩy 1 dữ liệu sang view
	public String delete(final Model model, @PathVariable("commentId") int commentId) {
		// Lấy category trong DB bằng Id
		ProductComment productComment = productCommentService.getById(commentId);
		productComment.setStatus(EnumStatus.INACTIVE);
		productCommentService.inactiveProductComment(productComment);
		return "redirect:/admin/comment/list";
	}
}
